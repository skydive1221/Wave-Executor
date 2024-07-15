-- Author: @Jumpathy
-- Name: permission.lua
-- Description: Ranks :sunglo:

local groupService = game:GetService("GroupService")
local players = game:GetService("Players")

local cache = {}

function cache.new(callback)
	local newCache = {internal = {}}

	function newCache.fetch(id,...)
		if(not newCache.internal[id]) then
			newCache.internal[id] = callback(id,...)
		end
		return newCache.internal[id]
	end

	return newCache
end

local groupDataCache = cache.new(function(id)
	return groupService:GetGroupInfoAsync(id)
end)

local groupsIn = cache.new(function(userId)
	local data,ret = groupService:GetGroupsAsync(userId),{}
	for _,group in pairs(data) do
		ret[group.Id] = group
	end
	return ret
end)

local getGameOwner = function()
	if(game.CreatorType == Enum.CreatorType.Group) then
		return groupDataCache.fetch(game.CreatorId)["Owner"]["Id"]
	else
		return game.CreatorId
	end
end

return function(config)
	local permission = {}
	local hasGamepass = require(script.Parent:WaitForChild("services"):WaitForChild("marketplace"))(permission)

	local gameOwner = getGameOwner()
	local configuration = config.Permissions
	local ranks = configuration.Ranks
	local groups = configuration.Groups
	local passes = configuration.Gamepasses
	local maxTags = config.ChatTags.MaxAmountTags or math.huge

	local highestRank = 0
	for rank,name in pairs(ranks) do
		if(rank > highestRank) then
			highestRank = rank
		end
	end

	local hasGroups = false
	for _,group in pairs(groups) do
		hasGroups = true
		break
	end

	local get = function(name)
		for key,val in pairs(ranks) do
			if(val == name) then
				return key
			end
		end
	end

	local permissionToNumber = function(perm)
		return((type(perm) == "number" and perm or get(perm)))
	end

	local getGroupPermission = function(userId)
		if(hasGroups) then
			local userGroups = groupsIn.fetch(userId)
			local max
			for groupId,data in pairs(userGroups) do
				if(not groups[groupId]) then
					userGroups[groupId] = nil
				else
					local highestRank
					local currentMax
					for rank,toAssign in pairs(groups[groupId]) do
						if(data.Rank >= rank and data.Rank > (highestRank or 0)) then
							currentMax = permissionToNumber(toAssign)
							highestRank = rank
						end
					end
					if((currentMax or -1) > (max or 0)) then
						max = currentMax
					end
				end
			end
			return max
		else
			return {}
		end
	end

	local getPassPerms = function(userId)
		local max
		for gamepassId,assign in pairs(passes) do
			if(hasGamepass(userId,gamepassId)) then
				local currentMax = permissionToNumber(assign)
				if(currentMax > (max or 0)) then
					max = currentMax
				end
			end
		end
		return max
	end

	local getUserPerms = function(userId)
		return permissionToNumber(configuration.Users[userId])
	end

	function permission:get(userId)
		local player = players:GetPlayerByUserId(userId)
		local hasPremium = (player and (player.MembershipType == Enum.MembershipType.Premium) or false)
		local highestPermissionViaGroup = getGroupPermission(userId)
		local highestPermissionViaPass = getPassPerms(userId)
		local highestPermissionViaUser = getUserPerms(userId)
		local premiumPermission = permissionToNumber(configuration.RobloxPremium)
		local toSort = {1}
		
		if(userId == gameOwner) then
			table.insert(toSort,highestRank)
		elseif(highestPermissionViaGroup) then
			table.insert(toSort,highestPermissionViaGroup)
		end
		if(hasPremium) then
			table.insert(toSort,premiumPermission)
		end
		if(highestPermissionViaUser) then
			table.insert(toSort,highestPermissionViaUser)
		end
		if(highestPermissionViaPass) then
			table.insert(toSort,highestPermissionViaPass)
		end
		table.sort(toSort)
		local toReturn = toSort[#toSort] or 0
		toSort = nil
		if(player) then
			if(player:GetAttribute("Permission") ~= toReturn) then
				permission:setNameColor(player,toReturn)
				permission:setTextColor(player,toReturn)
			end
			player:SetAttribute("Permission",toReturn)
		end
		return toReturn
	end

	function permission:canUse(flag,id)
		return(permission:get(id) >= (permissionToNumber(flag) or (highestRank + 1)))
	end

	function permission:tonumber(flag)
		return permissionToNumber(flag) or (highestRank + 1)
	end
	
	function permission:getUserTags(player)
		local rank,tags = permission:get(player.UserId),{}
		local toSearch = config.ChatTags.Users[player.Name] or config.ChatTags.Users[player.UserId]
		for _,tag in pairs(toSearch or {}) do
			table.insert(tags,{
				text = tag.Text,
				color = tag.Color,
				priority = tag.Priority or 3,
				image = tag.Image
			})
		end
		for cr,list in pairs(config.ChatTags.Ranks) do
			if(rank >= cr) then
				for _,tag in pairs(config.ChatTags.Ranks[cr]) do
					table.insert(tags,{
						text = tag.Text,
						color = tag.Color,
						priority = tag.Priority or 3,
						image = tag.Image
					})
				end
			end
		end
		table.sort(tags,function(a,b)
			return(a.priority > b.priority)
		end)
		if(#tags > maxTags) then
			local newTagsList = {}
			for i = 1,maxTags do
				table.insert(newTagsList,tags[i])
			end
			tags = newTagsList
		end
		return tags
	end
	
	function permission:setTextColor(player,rank)
		local color = config.TextColors or {["Ranks"] = {},["Users"] = {}}
		local rankColor,userColor = color["Ranks"][rank],(color.Users[player.Name] or color.Users[player.UserId])
		if(userColor) then
			player:SetAttribute("ChatColor",userColor)
		elseif(rankColor) then
			player:SetAttribute("ChatColor",rankColor)
		end
	end
	
	local setColor = function(player,color)
		player:SetAttribute("NameColor",color)
		player:SetAttribute("DisplayNameColor",color)
	end

	function permission:setNameColor(player,rank)
		local rankColor,userColor = config.NameColors.Ranks[rank],(config.NameColors.Users[player.Name] or config.NameColors.Users[player.UserId])
		if(rankColor) then
			setColor(player,rankColor)
		elseif(userColor) then
			setColor(player,userColor)
		end
	end
	
	function permission:resolve(num)
		return permissionToNumber(num)
	end
	
	return permission
end