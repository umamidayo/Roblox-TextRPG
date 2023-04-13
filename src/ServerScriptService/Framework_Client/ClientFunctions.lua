local module = {}

-- Services --

local ReplicatedStorage = game.ReplicatedStorage

-- Directories --

local Framework_Client = ReplicatedStorage:WaitForChild("Framework_Client")

-- Modules --

local TextColors = require(Framework_Client:WaitForChild("TextColors"))

-- Data --

local RemoteEvent = Framework_Client:WaitForChild("RemoteEvent")
local Event = Framework_Client:WaitForChild("Event")
local player = game.Players.LocalPlayer
local logs = player.PlayerGui.Main.LogFrame.Logs
local story = {
	["characterName"] = nil,
	["settingName"] = nil,
	["jobName"] = nil
}

-- Module Functions --

function module.AddEvent(data)
	local NewEvent = Event:Clone()
	
	if data["textColor"] then
		NewEvent.TextColor3 = data["textColor"]
	else
		NewEvent.TextColor3 = TextColors.StoryColor
	end
	
	if data["message"] then
		NewEvent.Text = data["message"]
		NewEvent.Parent = logs
	end
	
	logs.CanvasPosition = Vector2.new(0, logs.AbsoluteCanvasSize.Y)
end

function module.HandleEvent(event, data)
	if event == "event" then
		module.AddEvent(data)
		
	elseif event == "story" then
		story["characterName"] = data["characterName"]
		story["settingName"] = data["settingName"]
		story["jobName"] = data["jobName"]
		
		local data = {
			["message"] = "Your name is '" .. story["characterName"] .. "'."
		}
		module.AddEvent(data)

		local data = {
			["message"] = "Your current occupation is '" .. story["jobName"] .. "'."
		}
		module.AddEvent(data)
		
		local data = {
			["message"] = "You awaken in a place called '" .. story["settingName"] .. "'."
		}
		module.AddEvent(data)
		
		local data = {
			["message"] = "To continue, type 'continue'. Otherwise, type 'reroll' to get a different story."
		}
		module.AddEvent(data)
		
	end
end

function module.ProcessResponse(textbox)
	if textbox.Text ~= "" or string.len(textbox.Text) >= 2 then
		local data = {
			message = textbox.Text,
			textColor = TextColors.PlayerColor
		}
		
		RemoteEvent:FireServer(data)
		
		data["message"] = "You typed '" .. data["message"] .. "'"
		module.AddEvent(data)
	end
	
	textbox.Text = ""
end

return module
