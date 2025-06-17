-- Grow a Garden Ultimate Pet Spawner
local player = game:GetService("Players").LocalPlayer
local backpack = player:WaitForChild("Backpack")
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

-- GUI Setup
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "PetSpawnerUI"
screenGui.ResetOnSpawn = false

-- Toggle Button
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

-- Draggable UI
local dragging, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 65)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

-- Title
local title = Instance.new("TextLabel", header)
title.Text = "PET SPAWNER"
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 5)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1

-- Credit
local credit = Instance.new("TextLabel", header)
credit.Text = "by @zenxq"
credit.Size = UDim2.new(1, 0, 0, 15)
credit.Position = UDim2.new(0, 0, 0, 30)
credit.Font = Enum.Font.SourceSans
credit.TextSize = 12
credit.TextColor3 = Color3.new(0.8, 0.8, 0.8)
credit.BackgroundTransparency = 1

-- Tab Buttons
local petTab = Instance.new("TextButton", header)
petTab.Text = "PET"
petTab.Size = UDim2.new(0.5, 0, 0, 30)
petTab.Position = UDim2.new(0, 0, 0, 45)
petTab.Font = Enum.Font.SourceSans
petTab.TextColor3 = Color3.new(1, 1, 1)
petTab.TextSize = 20
petTab.BackgroundTransparency = 1

local seedTab = Instance.new("TextButton", header)
seedTab.Text = "SEED"
seedTab.Size = UDim2.new(0.5, 0, 0, 30)
seedTab.Position = UDim2.new(0.5, 0, 0, 45)
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
petTabFrame.Position = UDim2.new(0, 0, 0, 65)
petTabFrame.Size = UDim2.new(1, 0, 1, -65)
petTabFrame.BackgroundTransparency = 1

local seedTabFrame = petTabFrame:Clone()
seedTabFrame.Parent = mainFrame
seedTabFrame.Visible = false

-- TextBox Helper
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

-- Input Fields
local petNameBox = createTextBox(petTabFrame, "Pet Name", UDim2.new(0.05, 0, 0.05, 0))
local weightBox = createTextBox(petTabFrame, "Weight", UDim2.new(0.05, 0, 0.2, 0))
local ageBox = createTextBox(petTabFrame, "Age", UDim2.new(0.05, 0, 0.35, 0))

-- Number Validation
local function validateDecimalInput(textBox)
    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        local newText = textBox.Text:gsub("[^%d.]", "")
        local decimalCount = select(2, newText:gsub("%.", ""))
        if decimalCount > 1 then
            local parts = {}
            for part in newText:gmatch("[^.]+") do
                table.insert(parts, part)
            end
            newText = parts[1].."."..(parts[2] or "")
        end
        if newText:sub(1,1) == "." then
            newText = "0"..newText
        end
        textBox.Text = newText
    end)
end

validateDecimalInput(weightBox)
validateDecimalInput(ageBox)

-- Button Helper
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

-- Seed Tab
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

-- Close UI
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- PET SPAWNING SYSTEM
local petDatabase = {
    GoldenLab = "GoldenLabPet", Dog = "DogModel", Bunny = "BunnyPet", 
    BlackBunny = "BlackBunnyPet", Chicken = "ChickenPet", Cat = "CatModel", 
    OrangeTabby = "OrangeTabbyCat", Deer = "DeerPet", SpottedDeer = "SpottedDeerPet", 
    Pig = "PigPet", Monkey = "MonkeyPet", SilverMonkey = "SilverMonkeyPet", 
    Rooster = "RoosterPet", Cow = "CowPet", SeaOtter = "SeaOtterPet", 
    Turtle = "TurtlePet", PolarBear = "PolarBearPet", Panda = "PandaPet", 
    Snail = "SnailPet", GiantAnt = "GiantAntPet", Caterpillar = "CaterpillarPet", 
    PrayingMantis = "PrayingMantisPet", Dragonfly = "DragonflyPet", 
    Raccoon = "RaccoonPet", Hedgehog = "HedgehogPet", Frog = "FrogPet", 
    EchoFrog = "EchoFrogPet", Owl = "OwlPet", NightOwl = "NightOwlPet", 
    Kiwi = "KiwiPet", BloodHedgehog = "BloodHedgehogPet", Mole = "MolePet",
    DiscoBee = "DiscoBeePet", Butterfly = "ButterflyPet", 
    QueenBee = "QueenBeePet", BloodOwl = "BloodOwlPet"
}

local function loadPetAnimations(pet)
    local animFolder = game:GetService("ReplicatedStorage"):FindFirstChild("PetAnimations")
    if animFolder then
        local petAnims = animFolder:FindFirstChild(pet.Name) or animFolder:FindFirstChild(pet:GetAttribute("BasePet"))
        if petAnims then
            local animator = pet:FindFirstChildOfClass("Humanoid") or pet:FindFirstChildOfClass("Animator")
            if animator then
                for _, anim in pairs(petAnims:GetChildren()) do
                    if anim:IsA("Animation") then
                        local track = animator:LoadAnimation(anim)
                        if anim.Name == "IdleAnimation" then
                            track.Looped = true
                            track:Play()
                        end
                    end
                end
            end
        end
    end
end

local function spawnGardenPet(petType, weight, age)
    local modelName = petDatabase[petType]
    if not modelName then return warn("Pet not in database") end
    
    local petModel
    for _, location in pairs({
        game:GetService("ReplicatedStorage").Pets,
        game:GetService("ReplicatedStorage").SpecialPets,
        workspace.LivePets
    }) do
        if location and location:FindFirstChild(modelName) then
            petModel = location:FindFirstChild(modelName)
            break
        end
    end

    if petModel then
        local newPet = petModel:Clone()
        newPet.Name = petType
        newPet:SetAttribute("IsPlayerPet", true)
        
        local config = Instance.new("Folder")
        config.Name = "Configuration"
        
        local weightVal = Instance.new("NumberValue")
        weightVal.Name = "Weight"
        weightVal.Value = math.clamp(tonumber(weight) or 10, 1, 1000)
        weightVal.Parent = config
        
        local ageVal = Instance.new("NumberValue")
        ageVal.Name = "Age"
        ageVal.Value = math.clamp(tonumber(age) or 100, 1, 1000)
        ageVal.Parent = config
        
        config.Parent = newPet
        
        loadPetAnimations(newPet)
        newPet.Parent = backpack
        
        task.wait(0.3)
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character.Humanoid:EquipTool(newPet)
        end
        
        return newPet
    else
        warn("Model not found: "..modelName)
        return nil
    end
end

-- Spawn Button
spawnBtn.MouseButton1Click:Connect(function()
    local input = string.lower(petNameBox.Text)
    local petType
    
    for name in pairs(petDatabase) do
        if string.find(input, string.lower(name)) then
            petType = name
            break
        end
    end

    if petType then
        spawnGardenPet(petType, weightBox.Text, ageBox.Text)
    else
        local petList = {}
        for pet in pairs(petDatabase) do
            table.insert(petList, pet)
        end
        warn("Available pets: "..table.concat(petList, ", "))
    end
end)

-- Duplication Button
dupeBtn.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local tool = char:FindFirstChildOfClass("Tool") or backpack:FindFirstChildOfClass("Tool")
    
    if tool then
        local fakeClone = tool:Clone()
        
        for _,v in pairs(fakeClone:GetDescendants()) do
            if v:IsA("Script") or v:IsA("LocalScript") then
                if not (v.Name:match("Animate")) 
                   and not (v.Name:match("Animation"))
                   and not (v.Name:match("Animator"))
                   and not (v.Name:match("Grip"))
                   and not (v.Name:match("Control"))
                   and not (v.Name:match("Motor")) then
                    v:Destroy()
                end
            end
        end

        if fakeClone:FindFirstChildOfClass("Humanoid") then
            local humanoid = fakeClone:FindFirstChildOfClass("Humanoid")
            if not humanoid:FindFirstChildOfClass("Animator") then
                Instance.new("Animator").Parent = humanoid
            end
            
            local originalHumanoid = tool:FindFirstChildOfClass("Humanoid")
            if originalHumanoid and originalHumanoid:FindFirstChildOfClass("Animator") then
                for _,track in pairs(originalHumanoid.Animator:GetPlayingAnimationTracks()) do
                    humanoid.Animator:LoadAnimation(track.Animation):Play()
                end
            end
        else
            local animateScript = tool:FindFirstChild("Animate") 
            if animateScript then
                animateScript:Clone().Parent = fakeClone
            end
            
            for _,anim in pairs(tool:GetDescendants()) do
                if anim:IsA("Animation") then
                    anim:Clone().Parent = fakeClone
                end
            end
        end

        fakeClone.Enabled = true
        fakeClone.ManualActivationOnly = false
        fakeClone.RequiresHandle = true
        
        if fakeClone:FindFirstChild("CanBeDropped") then
            fakeClone.CanBeDropped = false
        end
        
        fakeClone.Name = tool.Name
        fakeClone.Parent = backpack

        task.wait(0.2)
        if char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid:EquipTool(fakeClone)
        end
    else
        warn("No pet equipped to duplicate")
    end
end)