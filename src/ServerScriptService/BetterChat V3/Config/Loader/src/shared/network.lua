-- Author: @Jumpathy
-- Name: network.lua
-- Description: Remote event wrapper for readability

local network = {};
local blank = function() end
local events = script.Parent:WaitForChild("events");
local inDebug = false
local logs = {}

local new = function(class,name)
	local object = Instance.new(class);
	object.Parent = events;
	object.Name = name;
	return object;
end

local get = function(name)
	return events:WaitForChild(name,12)
end

local log = function(event,data)
	logs[event.Name] = logs[event.Name] or {}
	table.insert(logs[event.Name],data)
end

-- Server:

local formatTime = function()
	local time = os.time()
	local milliseconds = math.floor((os.clock() % 1) * 1000)
	return os.date("%H:%M:%S", time) .. string.format(".%03d", milliseconds)
end

function network:newEvent(name,callback,bypass)
	if inDebug and not bypass then
		local event = new("RemoteEvent",name)
		event.OnServerEvent:Connect(function(...)
			local data = {
				on = formatTime(),
				sent = {...},
				identifier = game:GetService("HttpService"):GenerateGUID()
			}
			log(event,data);
			network:fireClients("logUpdated","all",event,data);
			(callback or blank)(...);
		end)
	else
		new("RemoteEvent",name).OnServerEvent:Connect(callback or blank);
	end
end

function network:newFunction(name,callback)
	if inDebug then
		local event = new("RemoteFunction",name)
		event.OnServerInvoke = function(...)
			local response = {(callback or blank)(...)}
			local data = {
				on = formatTime(),
				sent = {
					{
						request = {...},
						response = response
					}
				},
				identifier = game:GetService("HttpService"):GenerateGUID()
			}
			log(event,data);
			network:fireClients("logUpdated","all",event,data);
			return unpack(response)
		end
	else
		new("RemoteFunction",name).OnServerInvoke = callback or blank;
	end
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
	get(name).OnClientEvent:Connect(callback)
end

function network:invoke(name,...)
	return get(name):InvokeServer(...);
end

function network:fire(name,...)
	get(name):FireServer(...);
end

function network:setup(debugMode)
	inDebug = debugMode
	if inDebug then
		warn("[BetterChat]: Debug mode enabled, memory usage will go up as a result")
		warn("[BetterChat]: Debug mode will expose all calls to the server for the chat to all clients, your messages will not be private.")
		network:newFunction("getEventLogs",function(player,event)
			return logs[event.Name] or {}
		end,true)
		network:newEvent("logUpdated",nil,true)
	end
	return network
end

return network;