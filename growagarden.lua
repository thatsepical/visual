local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

-- GUI Setup
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "PetSpawnerUI"
screenGui.ResetOnSpawn = false

-- [Previous toggle button and main frame code remains exactly the same until the header section]

-- Header with new title design
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 65)  -- Slightly taller to accommodate both lines
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

-- Main Title "PET/SEED SPAWNER"
local title = Instance.new("TextLabel", header)
title.Text = "PET/SEED SPAWNER"
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 5)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1

-- Credit "by @zenxq" (smaller text)
local credit = Instance.new("TextLabel", header)
credit.Text = "by @zenxq"
credit.Size = UDim2.new(1, 0, 0, 15)
credit.Position = UDim2.new(0, 0, 0, 30)
credit.Font = Enum.Font.SourceSans
credit.TextSize = 12  -- Smaller size
credit.TextColor3 = Color3.new(0.8, 0.8, 0.8)  -- Slightly dimmer
credit.BackgroundTransparency = 1

-- Tab Buttons (positioned below title)
local petTab = Instance.new("TextButton", header)
petTab.Text = "PET"
petTab.Size = UDim2.new(0.5, 0, 0, 30)
petTab.Position = UDim2.new(0, 0, 0, 30)
petTab.Font = Enum.Font.SourceSans
petTab.TextColor3 = Color3.new(1, 1, 1)
petTab.TextSize = 20
petTab.BackgroundTransparency = 1

local seedTab = Instance.new("TextButton", header)
seedTab.Text = "SEED"
seedTab.Size = UDim2.new(0.5, 0, 0, 30)
seedTab.Position = UDim2.new(0.5, 0, 0, 30)
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

-- Tab Frames (adjusted position for larger header)
local petTabFrame = Instance.new("Frame", mainFrame)
petTabFrame.Position = UDim2.new(0, 0, 0, 60)
petTabFrame.Size = UDim2.new(1, 0, 1, -60)
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

-- Decimal number validation
local function validateDecimalInput(textBox)
    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        -- Allow numbers and single decimal point
        local newText = textBox.Text:gsub("[^%d.]", "")
        
        -- Ensure only one decimal point exists
        local decimalCount = select(2, newText:gsub("%.", ""))
        if decimalCount > 1 then
            -- If multiple decimals, keep only the first one
            local parts = {}
            for part in newText:gmatch("[^.]+") do
                table.insert(parts, part)
            end
            newText = parts[1].."."..(parts[2] or "")
        end
        
        -- Don't allow decimal point at start
        if newText:sub(1,1) == "." then
            newText = "0"..newText
        end
        
        textBox.Text = newText
    end)
end

-- Apply decimal validation
validateDecimalInput(weightBox)
validateDecimalInput(ageBox)

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

-- Enhanced Dupe Logic with Animation Preservation
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

    -- Create perfect clone with animations
    local fakeClone = tool:Clone()
    
    -- Remove ONLY unwanted functionality scripts
    for _,v in pairs(fakeClone:GetDescendants()) do
        if v:IsA("Script") or v:IsA("LocalScript") then
            -- Preserve all animation-related scripts
            if not (v.Name:match("Animate")) 
               and not (v.Name:match("Animation"))
               and not (v.Name:match("Animator"))
               and not (v.Name:match("Grip"))
               and not (v.Name:match("Control")) then
                v:Destroy()
            end
        end
    end

    -- Special handling for different pet types
    if fakeClone:FindFirstChildOfClass("Humanoid") then
        -- For humanoid pets (rigged models)
        local humanoid = fakeClone:FindFirstChildOfClass("Humanoid")
        
        -- Ensure Animator exists
        if not humanoid:FindFirstChildOfClass("Animator") then
            Instance.new("Animator").Parent = humanoid
        end
        
        -- Copy all animation tracks from original
        local originalHumanoid = tool:FindFirstChildOfClass("Humanoid")
        if originalHumanoid and originalHumanoid:FindFirstChildOfClass("Animator") then
            for _,track in pairs(originalHumanoid.Animator:GetPlayingAnimationTracks()) do
                humanoid.Animator:LoadAnimation(track.Animation):Play()
            end
        end
    else
        -- For non-humanoid pets (regular tools with animations)
        local animateScript = fakeClone:FindFirstChild("Animate") or tool:FindFirstChild("Animate")
        if animateScript then
            animateScript:Clone().Parent = fakeClone
        end
    end

    -- Configure for proper holding
    fakeClone.Enabled = true
    fakeClone.ManualActivationOnly = false
    fakeClone.RequiresHandle = true
    
    -- Disable unwanted functionality
    if fakeClone:FindFirstChild("CanBeDropped") then
        fakeClone.CanBeDropped = false
    end
    
    -- Maintain original appearance
    fakeClone.Name = tool.Name
    fakeClone.Parent = backpack

    -- Auto-equip the duplicate
    task.wait(0.2)
    if char:FindFirstChildOfClass("Humanoid") then
        char.Humanoid:EquipTool(fakeClone)
        
        -- Force animations to play
        task.wait(0.1)
        if fakeClone:FindFirstChildOfClass("Humanoid") then
            for _,track in pairs(fakeClone.Humanoid.Animator:GetPlayingAnimationTracks()) do
                track:Play()
            end
        end
    end
    
    print("Created animated duplicate of: "..tool.Name)
end)