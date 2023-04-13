-- Services --

local ReplicatedStorage = game.ReplicatedStorage
local UserInputService = game.UserInputService

-- Directories --

local Framework_Client = ReplicatedStorage:WaitForChild("Framework_Client")

-- Modules --

local ClientFunctions = require(Framework_Client:WaitForChild("ClientFunctions"))

-- Data --

local RemoteEvent = Framework_Client:WaitForChild("RemoteEvent")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Gui --

local Main = playerGui:WaitForChild("Main")
local Logs = Main:WaitForChild("LogFrame"):WaitForChild("Logs")
local TextBox = Main:WaitForChild("TextBox")

-- Connections --

RemoteEvent.OnClientEvent:Connect(function(event, data)
	ClientFunctions.HandleEvent(event, data)
end)

TextBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		ClientFunctions.ProcessResponse(TextBox)
	end
end)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.Return then
			if TextBox:IsFocused() == false then
				TextBox:CaptureFocus()
			end
		end
	end
end)