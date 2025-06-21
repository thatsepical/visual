local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/DeltaGay/femboy/refs/heads/main/GardenSpawner.lua", true))()

local availablePets = Spawner.GetPets()
local availableSeeds = Spawner.GetSeeds()

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "AdvancedSpawnerUI"
screenGui.ResetOnSpawn = false

local isPC = UIS.MouseEnabled
local uiScale = isPC and 1.15 or 1

local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 80 * uiScale, 0, 25 * uiScale)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Toggle UI"
toggleButton.Font = Enum.Font.SourceSans
toggleButton.TextSize = 14
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 250 * uiScale, 0, 280 * uiScale)
mainFrame.Position = UDim2.new(0.5, -125 * uiScale, 0.5, -140 * uiScale)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Visible = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                connection:Disconnect()
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input == dragInput or input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

local versionText = Instance.new("TextLabel", header)
versionText.Text = "v1.5.0"
versionText.Size = UDim2.new(0, 40, 0, 12)
versionText.Position = UDim2.new(0, 5, 0, 5)
versionText.Font = Enum.Font.SourceSans
versionText.TextSize = 10
versionText.TextColor3 = Color3.new(0.8, 0.8, 0.8)
versionText.BackgroundTransparency = 1
versionText.TextXAlignment = Enum.TextXAlignment.Left

local title = Instance.new("TextLabel", header)
title.Text = "PET/SEED/EGG SPAWNER"
title.Size = UDim2.new(1, -10, 0, 20)
title.Position = UDim2.new(0, 5, 0, 5)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Center

local credit = Instance.new("TextLabel", header)
credit.Text = "by @zenxq"
credit.Size = UDim2.new(1, -10, 0, 12)
credit.Position = UDim2.new(0, 5, 0, 22)
credit.Font = Enum.Font.SourceSans
credit.TextSize = 10
credit.TextColor3 = Color3.new(0.8, 0.8, 0.8)
credit.BackgroundTransparency = 1
credit.TextXAlignment = Enum.TextXAlignment.Center

local tabBackground = Instance.new("Frame", header)
tabBackground.Size = UDim2.new(1, 0, 0, 20)
tabBackground.Position = UDim2.new(0, 0, 0, 35)
tabBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabBackground.BorderSizePixel = 0
Instance.new("UICorner", tabBackground).CornerRadius = UDim.new(0, 4)

local petTab = Instance.new("TextButton", tabBackground)
petTab.Text = "PET"
petTab.Size = UDim2.new(0.33, -2, 1, 0)
petTab.Position = UDim2.new(0, 0, 0, 0)
petTab.Font = Enum.Font.SourceSans
petTab.TextColor3 = Color3.new(1, 1, 1)
petTab.TextSize = 14
petTab.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
petTab.BorderSizePixel = 0
Instance.new("UICorner", petTab).CornerRadius = UDim.new(0, 4)

local seedTab = Instance.new("TextButton", tabBackground)
seedTab.Text = "SEED"
seedTab.Size = UDim2.new(0.33, -2, 1, 0)
seedTab.Position = UDim2.new(0.33, 0, 0, 0)
seedTab.Font = Enum.Font.SourceSans
seedTab.TextColor3 = Color3.new(1, 1, 1)
seedTab.TextSize = 14
seedTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
seedTab.BorderSizePixel = 0
Instance.new("UICorner", seedTab).CornerRadius = UDim.new(0, 4)

local eggTab = Instance.new("TextButton", tabBackground)
eggTab.Text = "EGG"
eggTab.Size = UDim2.new(0.33, -2, 1, 0)
eggTab.Position = UDim2.new(0.66, 0, 0, 0)
eggTab.Font = Enum.Font.SourceSans
eggTab.TextColor3 = Color3.new(1, 1, 1)
eggTab.TextSize = 14
eggTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
eggTab.BorderSizePixel = 0
Instance.new("UICorner", eggTab).CornerRadius = UDim.new(0, 4)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSans
closeBtn.TextSize = 16
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local petTabFrame = Instance.new("Frame", mainFrame)
petTabFrame.Position = UDim2.new(0, 0, 0, 55)
petTabFrame.Size = UDim2.new(1, 0, 1, -55)
petTabFrame.BackgroundTransparency = 1

local seedTabFrame = Instance.new("Frame", mainFrame)
seedTabFrame.Position = UDim2.new(0, 0, 0, 55)
seedTabFrame.Size = UDim2.new(1, 0, 1, -55)
seedTabFrame.BackgroundTransparency = 1
seedTabFrame.Visible = false

local eggTabFrame = Instance.new("Frame", mainFrame)
eggTabFrame.Position = UDim2.new(0, 0, 0, 55)
eggTabFrame.Size = UDim2.new(1, 0, 1, -55)
eggTabFrame.BackgroundTransparency = 1
eggTabFrame.Visible = false

local function createTextBox(parent, placeholder, position)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(0.9, 0, 0, 25)
    box.Position = position
    box.PlaceholderText = placeholder
    box.Text = ""
    box.Font = Enum.Font.SourceSans
    box.TextSize = 14
    box.TextColor3 = Color3.new(1, 1, 1)
    box.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
    box.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    return box
end

local petNameBox = createTextBox(petTabFrame, "Pet Name", UDim2.new(0.05, 0, 0.05, 0))
local weightBox = createTextBox(petTabFrame, "Weight", UDim2.new(0.05, 0, 0.25, 0))
local ageBox = createTextBox(petTabFrame, "Age", UDim2.new(0.05, 0, 0.45, 0))

local seedNameBox = createTextBox(seedTabFrame, "Seed Name", UDim2.new(0.05, 0, 0.05, 0))
local amountBox = createTextBox(seedTabFrame, "Amount", UDim2.new(0.05, 0, 0.25, 0))

local eggNameBox = createTextBox(eggTabFrame, "Egg Name", UDim2.new(0.05, 0, 0.05, 0))
local spinBox = createTextBox(eggTabFrame, "Plant to Spin", UDim2.new(0.05, 0, 0.25, 0))

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
validateDecimalInput(amountBox)

local function createButton(parent, text, posY)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 25)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.Text = text
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local spawnBtn = createButton(petTabFrame, "SPAWN PET", 0.65)
local spawnSeedBtn = createButton(seedTabFrame, "SPAWN SEED", 0.45)
local spawnEggBtn = createButton(eggTabFrame, "SPAWN EGG", 0.45)
local spinBtn = createButton(eggTabFrame, "SPIN PLANT", 0.65)

local function spawnPet()
    local petName = petNameBox.Text
    local weight = tonumber(weightBox.Text) or 1
    local age = tonumber(ageBox.Text) or 1
    
    if petName == "" then return end
    
    Spawner.SpawnPet(petName, weight, age)
end

local function spawnSeed()
    local seedName = seedNameBox.Text
    local amount = tonumber(amountBox.Text) or 1
    
    if seedName == "" then return end
    
    Spawner.SpawnSeed(seedName, amount)
end

local function spawnEgg()
    local eggName = eggNameBox.Text
    if eggName == "" then return end
    
    Spawner.SpawnEgg(eggName)
end

local function spinPlant()
    local plantName = spinBox.Text
    if plantName == "" then return end
    
    Spawner.Spin(plantName)
end

spawnBtn.MouseButton1Click:Connect(spawnPet)
spawnSeedBtn.MouseButton1Click:Connect(spawnSeed)
spawnEggBtn.MouseButton1Click:Connect(spawnEgg)
spinBtn.MouseButton1Click:Connect(spinPlant)

local function switchToTab(tab)
    petTabFrame.Visible = (tab == "pet")
    seedTabFrame.Visible = (tab == "seed")
    eggTabFrame.Visible = (tab == "egg")
    
    petTab.BackgroundColor3 = (tab == "pet") and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
    seedTab.BackgroundColor3 = (tab == "seed") and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
    eggTab.BackgroundColor3 = (tab == "egg") and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
end

petTab.MouseButton1Click:Connect(function()
    switchToTab("pet")
end)

seedTab.MouseButton1Click:Connect(function()
    switchToTab("seed")
end)

eggTab.MouseButton1Click:Connect(function()
    switchToTab("egg")
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

switchToTab("pet")