local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

-- GUI Setup
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "PetSpawnerUI"
screenGui.ResetOnSpawn = false

-- Toggle Button to reopen UI
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 100, 0, 35)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Open UI"
toggleButton.Font = Enum.Font.SourceSans
toggleButton.TextSize = 18
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)

-- Main UI Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 340)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

-- Draggable logic
local dragging, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

-- Show UI when toggle is clicked
toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

-- Tab Buttons
local petTab = Instance.new("TextButton", header)
petTab.Text = "PET"
petTab.Size = UDim2.new(0.5, 0, 1, 0)
petTab.Font = Enum.Font.SourceSans
petTab.TextColor3 = Color3.new(1, 1, 1)
petTab.TextSize = 20
petTab.BackgroundTransparency = 1

local seedTab = Instance.new("TextButton", header)
seedTab.Text = "SEED"
seedTab.Size = UDim2.new(0.5, 0, 1, 0)
seedTab.Position = UDim2.new(0.5, 0, 0, 0)
seedTab.Font = Enum.Font.SourceSans
seedTab.TextColor3 = Color3.new(1, 1, 1)
seedTab.TextSize = 20
seedTab.BackgroundTransparency = 1

-- Close Button
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSans
closeBtn.TextSize = 18
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

-- Tab Frames
local petTabFrame = Instance.new("Frame", mainFrame)
petTabFrame.Position = UDim2.new(0, 0, 0, 40)
petTabFrame.Size = UDim2.new(1, 0, 1, -40)
petTabFrame.BackgroundTransparency = 1

local seedTabFrame = petTabFrame:Clone()
seedTabFrame.Parent = mainFrame
seedTabFrame.Visible = false

-- Helper: Create TextBox
local function createTextBox(parent, placeholder, position)
	local box = Instance.new("TextBox", parent)
	box.Size = UDim2.new(0.9, 0, 0, 30)
	box.Position = position
	box.PlaceholderText = placeholder
	box.Text = ""
	box.Font = Enum.Font.SourceSans
	box.TextSize = 18
	box.TextColor3 = Color3.new(1, 1, 1)
	box.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
	box.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
	return box
end

-- PET Tab UI
local petNameBox = createTextBox(petTabFrame, "Pet Name", UDim2.new(0.05, 0, 0.05, 0))
local weightBox = createTextBox(petTabFrame, "Weight", UDim2.new(0.05, 0, 0.2, 0))
local ageBox = createTextBox(petTabFrame, "Age", UDim2.new(0.05, 0, 0.35, 0))

for _, box in pairs({weightBox, ageBox}) do
	box:GetPropertyChangedSignal("Text"):Connect(function()
		box.Text = box.Text:gsub("%D", "")
	end)
end

-- Helper: Create Button
local function createButton(parent, text, posY)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, posY, 0)
	btn.Text = text
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 18
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	return btn
end

local spawnBtn = createButton(petTabFrame, "SPAWN PET", 0.55)
local dupeBtn = createButton(petTabFrame, "DUPE PET", 0.7)

-- SEED Tab content
local seedLabel = Instance.new("TextLabel", seedTabFrame)
seedLabel.Size = UDim2.new(1, 0, 0, 30)
seedLabel.Position = UDim2.new(0, 0, 0.1, 0)
seedLabel.Text = "Seed tab content coming soon..."
seedLabel.Font = Enum.Font.SourceSans
seedLabel.TextSize = 18
seedLabel.TextColor3 = Color3.new(1, 1, 1)
seedLabel.BackgroundTransparency = 1

-- Tab Switching
petTab.MouseButton1Click:Connect(function()
	petTabFrame.Visible = true
	seedTabFrame.Visible = false
end)

seedTab.MouseButton1Click:Connect(function()
	petTabFrame.Visible = false
	seedTabFrame.Visible = true
end)

-- Close
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- Spawn Pet Placeholder
spawnBtn.MouseButton1Click:Connect(function()
	print("Spawned:", petNameBox.Text, "Weight:", weightBox.Text, "Age:", ageBox.Text)
end)

-- Dupe Logic (works if holding a valid Tool)
dupeBtn.MouseButton1Click:Connect(function()
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    local char = player.Character or player.CharacterAdded:Wait()
    
    if not char then return end
    
    -- Find equipped pet
    local tool = char:FindFirstChildOfClass("Tool") or backpack:FindFirstChildOfClass("Tool")
    if not tool then
        warn("No pet found equipped or in backpack")
        return
    end

    -- Create enhanced clone
    local fakeClone = tool:Clone()
    
    -- Remove ONLY placement/functional scripts
    for _,v in pairs(fakeClone:GetDescendants()) do
        if v:IsA("Script") or v:IsA("LocalScript") then
            -- Keep animation and tool grip scripts
            if not (v.Name:match("Animate")) 
               and not (v.Name:match("Animation"))
               and not (v.Name:match("Grip")) then
                v:Destroy()
            end
        end
    end

    -- Configure for holding animations
    fakeClone.Enabled = true
    fakeClone.ManualActivationOnly = false
    fakeClone.RequiresHandle = true
    
    -- Disable placement functionality
    if fakeClone:FindFirstChild("CanBeDropped") then
        fakeClone.CanBeDropped = false
    end
    
    -- Special handling for Humanoid pets
    if fakeClone:FindFirstChildOfClass("Humanoid") then
        -- Ensure animations will play
        local animate = fakeClone:FindFirstChild("Animate") or Instance.new("Script")
        animate.Name = "Animate"
        animate.Parent = fakeClone
    end

    -- Maintain original appearance
    fakeClone.Name = tool.Name
    fakeClone.Parent = backpack

    -- Equip automatically (optional)
    task.wait(0.2)
    if char:FindFirstChildOfClass("Humanoid") then
        char.Humanoid:EquipTool(fakeClone)
    end
    
    print("Created holdable animated duplicate of: "..tool.Name)
end)