-- Author: @Jumpathy
-- Name: network.lua
-- Description: Remote event wrapper for readability

local network = {};
local blank = function() end
local events = script.Parent:WaitForChild("events");

local new = function(class,name)
	local object = Instance.new(class);
	object.Parent = events;
	object.Name = name;
	return object;
end

local get = function(name)
	return events:WaitForChild(name,12)
end

-- Server:

function network:newEvent(name,callback)
	new("RemoteEvent",name).OnServerEvent:Connect(callback or blank);
end

function network:newFunction(name,callback)
	new("RemoteFunction",name).OnServerInvoke = callback or blank;
end

function network:fireClients(name,clients,...)
	local event = get(name);
	if(clients == "all") then
		event:FireAllClients(...);
	else
		for _,client in pairs(clients) do
			if(typeof(client) == "table") then
				client = client.player
			end
			if(client) then
				event:FireClient(client,...);
			end
		end
	end
end

-- Client:

network.onClientEvent = function(name,callback)
	return get(name).OnClientEvent:Connect(callback);
end

function network:invoke(name,...)
	return get(name):InvokeServer(...);
end

function network:fire(name,...)
	get(name):FireServer(...);
end

return network;