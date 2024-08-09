local studioService = game:GetService("StudioService")
local file = studioService:PromptImportFile({"rbxmx"})
local httpService = game:GetService("HttpService")

if file then
	local content = file:GetBinaryContents()
	local compressed = require(6598757206).compress(content)
	
	local encode = function(toPost)
		local post = ""
		for key,value in pairs(toPost) do
			post = post .. key .. "=" .. httpService:UrlEncode(value) .. "&"
		end
		return post:sub(1,#post-1)
	end

	local request = function(url,parameters)
		local success,response = pcall(function()
			return httpService:RequestAsync({
				["Url"] = url,
				["Method"] = "POST",
				["Body"] = encode(parameters),
				["Headers"] = {
					["Content-Type"] = "application/x-www-form-urlencoded"
				}
			})
		end)
		if success and response then
			return true,response.Body
		else
			return false,response
		end
	end
	
	local success,response = request("https://pst.innomi.net/paste/new",{
		["text"] = compressed,
		["lang"] = "text",
		["expire"] = "-1",
		["passowrd"]="",
		["title"]=""
	})
	if success and response then
		local match = response:match("/paste/[%w]+")
		print("https://pst.innomi.net" .. match .. "/raw")
	else
		warn(response)
	end
end