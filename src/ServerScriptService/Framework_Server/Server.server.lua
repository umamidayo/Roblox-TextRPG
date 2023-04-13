-- Services --

local ReplicatedStorage = game.ReplicatedStorage
local ServerScriptService = game.ServerScriptService

-- Directories --

local Framework_Server = ServerScriptService.Framework_Server
local Framework_Client = ServerScriptService.Framework_Client

-- Modules --

local Config = require(Framework_Server.Config)
local ServerFunctions = require(Framework_Server.ServerFunctions)

-- Data --

local RemoteEvent = Framework_Client.RemoteEvent

-- Connections --

local PlayerConnected = game.Players.PlayerAdded:Connect(function(player)
	ServerFunctions.PlayerInitialize(player)
end)

local PlayerResponse = RemoteEvent.OnServerEvent:Connect(function(player, data)
	ServerFunctions.HandleResponse(player, data)
end)

-- Main --

ServerFunctions.Initialize()