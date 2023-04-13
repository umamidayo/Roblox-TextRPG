local module = {}

-- Services --

local ReplicatedStorage = game.ReplicatedStorage
local ServerScriptService = game.ServerScriptService

-- Directories --

local Framework_Server = ServerScriptService.Framework_Server
local Framework_Client = ServerScriptService.Framework_Client

-- Modules --

local TextColors = require(Framework_Client.TextColors)
local Config = require(Framework_Server.Config)
local Events = require(Framework_Server.Events)
local EventFunctions = require(Framework_Server.EventFunctions)

-- Data --

local RemoteEvent = Framework_Client.RemoteEvent
local Started = {}
local Rerolled = {}
local Story = {}

-- Module Functions --

function module.Initialize()
	Framework_Client.Parent = ReplicatedStorage
end

function module.PlayerInitialize(player)
	local Main = Framework_Client.Main:Clone()
	Main.Parent = player.PlayerGui
	Main.Client.Disabled = false
	
	local data = {
		message = "Welcome to Text RPG Simulator",
		textColor = TextColors.DisclaimerColor,
	}
	
	module.AddEvent(player, data)
	
	task.wait(1)
	
	data = {
		message = "Type 'start' to begin the game.",
		textColor = TextColors.DisclaimerColor,
	}
	
	module.AddEvent(player, data)
end

function module.HandleResponse(player, data)
	if data["message"] then
		print(player.Name .. " responded with: " .. data["message"])
		
		if string.find(string.lower(data["message"]), "start")  then
			if Started[player] == true then return end
			Started[player] = true
			Rerolled[player] = true
			module.GenerateStory(player)
		elseif string.find(string.lower(data["message"]), "reroll") then
			if Started[player] ~= true then return end
			Rerolled[player] = true
			module.GenerateStory(player)
		elseif  string.find(string.lower(data["message"]), "continue") then
			if Started[player] ~= true then return end
			if Rerolled[player] ~= true then return end
			Rerolled[player] = false
			CreateEvent(player, "encounter")
		elseif  string.find(string.lower(data["message"]), "encounter") then
			if Started[player] ~= true then return end
			if Rerolled[player] == true then return end
			CreateEvent(player, "encounter")
		else
			local data = {
				["message"] = "Nothing happened.",
				["textColor"] = TextColors.StoryColor
			}

			module.AddEvent(player, data)
		end
	end
end

function module.AddEvent(player, data)
	RemoteEvent:FireClient(player, "event", data)
end

function CreateEvent(player, event)
	if event == "encounter" then
		local encounter = EventFunctions.EncounterEvent()
		local attribute = EventFunctions.GetAttribute()
		
		local data = {
			["message"] = "You encountered a " .. attribute .. " " .. encounter
		}
		
		module.AddEvent(player, data)
		
		local data = {
			["message"] = "Type 'encounter' for another encounter.",
			["textColor"] = TextColors.StoryColor
		}

		module.AddEvent(player, data)
	end
end

function module.GenerateStory(player)
	local data = {
		["message"] = "Randomly generating a story, please wait...",
		["textColor"] = TextColors.DisclaimerColor
	}

	module.AddEvent(player, data)

	task.wait(3)
	
	Story[player] = {
		["characterName"] = nil,
		["settingName"] = nil,
		["jobName"] = nil,
	}
	
	local characterNames = {
		Config.CharacterNames.Masculine,
		Config.CharacterNames.Feminine
	}
	
	local settingTypes = {
		Config.SettingNames.Future,
		Config.SettingNames.Fantasy,
		Config.SettingNames.Present
	}
	
	local jobTypes = {
		Config.JobNames.Other,
		Config.JobNames.Combat,
		Config.JobNames.Regular,
		Config.JobNames.Influencer
	}
	
	local genderNames = characterNames[math.random(1, #characterNames)]
	local settingType = settingTypes[math.random(1, #settingTypes)]
	local jobNames = jobTypes[math.random(1, #jobTypes)]
	
	Story[player]["characterName"] = genderNames[(math.random(1, #genderNames))]
	Story[player]["settingName"] = settingType[(math.random(1, #settingType))]
	Story[player]["jobName"] = jobNames[(math.random(1, #jobNames))]
	
	RemoteEvent:FireClient(player, "story", Story[player])
end

return module
