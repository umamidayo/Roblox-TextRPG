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

-- Data --

local RemoteEvent = Framework_Client.RemoteEvent

-- Module Functions --

function module.EncounterEvent()
	local encounterTypes = {
		Events.Encounter.Location,
		Events.Encounter.Enemy,
		Events.Encounter.Objects,
		Events.Encounter.Friendly,
	}
	
	local search
	local encounterSubtype = {}
	local encounters = {}
	local encounter
	
	search = encounterTypes[math.random(1, #encounterTypes)]
	
	for i,v in pairs(search) do
		if type(v) == "string" then
			table.insert(encounters, v)
		else
			table.insert(encounterSubtype, v)
		end
	end

	search = encounterSubtype[math.random(1, #encounterSubtype)]

	for i,v in pairs(search) do
		if type(v) == "string" then
			table.insert(encounters, v)
		end
	end

	encounter = encounters[math.random(1, #encounters)]
	
	return encounter
end

function module.GetAttribute()
	local attributes = {
		Events.Attributes.Descriptive,
	}
	
	local search = attributes[math.random(1, #attributes)]
	local attributeTypes = {}
	local attributeSubtypes = {}
	local attribute

	for i,v in pairs(search) do
		if type(v) == "string" then
			table.insert(attributes, v)
		else
			table.insert(attributeTypes, v)
		end
		
	end
	
	search = attributeTypes[math.random(1, #attributeTypes)]
	
	
	for i,v in pairs(search) do
		if type(v) == "string" then
			table.insert(attributeSubtypes, v)
		end
	end
	
	attribute = attributeSubtypes[math.random(1, #attributeSubtypes)]
	
	return attribute
end

return module
