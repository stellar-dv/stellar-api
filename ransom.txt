
-- example_script.lua

local function displayText()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Create a ScreenGui if it doesn't exist
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = playerGui

    -- Create a TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0, 200, 0, 50) -- Size of the label
    textLabel.Position = UDim2.new(0.5, -100, 0.5, -25) -- Center of the screen
    textLabel.Text = "Hello, Roblox!"
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
    textLabel.BackgroundTransparency = 0.5 -- Slightly transparent
    textLabel.Parent = screenGui
end

-- Call the function to display the text
displayText()
