local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdvancedSpawnerUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local isPC = UIS.MouseEnabled
local uiScale = isPC and 1.15 or 1

local discordBlack = Color3.fromRGB(33, 34, 38)
local lavender = Color3.fromRGB(0, 0, 0)
local darkLavender = Color3.fromRGB(0, 0, 0)
local headerColor = Color3.fromRGB(47, 49, 54)
local textColor = Color3.fromRGB(220, 220, 220)

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 80*uiScale, 0, 25*uiScale)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Close/Open"
toggleButton.Font = Enum.Font.SourceSans
toggleButton.TextSize = 14
toggleButton.BackgroundColor3 = discordBlack
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.BorderSizePixel = 1
toggleButton.BorderColor3 = Color3.fromRGB(80, 80, 80)
toggleButton.Parent = screenGui
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280*uiScale, 0, 200*uiScale)
mainFrame.Position = UDim2.new(0.5, -140*uiScale, 0.5, -100*uiScale)
mainFrame.BackgroundColor3 = discordBlack
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

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

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = headerColor
header.BorderSizePixel = 1
header.BorderColor3 = Color3.fromRGB(80, 80, 80)
header.Parent = mainFrame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

local versionText = Instance.new("TextLabel")
versionText.Text = "v3.0.0"
versionText.Size = UDim2.new(0, 40, 0, 12)
versionText.Position = UDim2.new(0, 5, 0, 5)
versionText.Font = Enum.Font.SourceSans
versionText.TextSize = 10
versionText.TextColor3 = textColor
versionText.BackgroundTransparency = 1
versionText.TextXAlignment = Enum.TextXAlignment.Left
versionText.Parent = header

local title = Instance.new("TextLabel")
title.Text = "PET/SEED/EGG SPAWNER"
title.Size = UDim2.new(1, -10, 0, 20)
title.Position = UDim2.new(0, 5, 0, 5)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextColor3 = textColor
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = header

local credit = Instance.new("TextLabel")
credit.Text = "by @zenxq | API by darkiedarkie"
credit.Size = UDim2.new(1, -10, 0, 12)
credit.Position = UDim2.new(0, 5, 0, 22)
credit.Font = Enum.Font.SourceSans
credit.TextSize = 10
credit.TextColor3 = textColor
credit.BackgroundTransparency = 1
credit.TextXAlignment = Enum.TextXAlignment.Center
credit.Parent = header

local tabBackground = Instance.new("Frame")
tabBackground.Size = UDim2.new(1, 0, 0, 20)
tabBackground.Position = UDim2.new(0, 0, 0, 35)
tabBackground.BackgroundColor3 = headerColor
tabBackground.BorderSizePixel = 1
tabBackground.BorderColor3 = Color3.fromRGB(80, 80, 80)
tabBackground.Parent = header
Instance.new("UICorner", tabBackground).CornerRadius = UDim.new(0, 4)

local function makeTab(name, pos)
    local b = Instance.new("TextButton")
    b.Text = name
    b.Size = UDim2.new(0.33, -2, 1, 0)
    b.Position = UDim2.new(pos, 0, 0, 0)
    b.Font = Enum.Font.SourceSansBold
    b.TextColor3 = textColor
    b.TextSize = 14
    b.BackgroundColor3 = (name == "PET") and darkLavender or headerColor
    b.BorderSizePixel = 1
    b.BorderColor3 = Color3.fromRGB(80, 80, 80)
    b.Parent = tabBackground
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 0)
    
    b.MouseEnter:Connect(function()
        if b.BackgroundColor3 ~= darkLavender then
            b.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        end
    end)
    
    b.MouseLeave:Connect(function()
        if b.BackgroundColor3 ~= darkLavender then
            b.BackgroundColor3 = headerColor
        end
    end)
    
    return b
end

local petTab = makeTab("PET", 0.00)
local seedTab = makeTab("SEED", 0.33)
local eggTab = makeTab("EGG", 0.66)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSans
closeBtn.TextSize = 16
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = textColor
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local petTabFrame = Instance.new("Frame")
local seedTabFrame = Instance.new("Frame")
local eggTabFrame = Instance.new("Frame")

for _, f in ipairs({petTabFrame, seedTabFrame, eggTabFrame}) do
    f.Position = UDim2.new(0, 0, 0, 55)
    f.Size = UDim2.new(1, 0, 1, -55)
    f.BackgroundTransparency = 1
    f.Parent = mainFrame
end

seedTabFrame.Visible = false
eggTabFrame.Visible = false

-- Dropdown for pets
local petDropdown = Instance.new("Frame")
petDropdown.Name = "PetDropdown"
petDropdown.Size = UDim2.new(0.9, 0, 0, 25)
petDropdown.Position = UDim2.new(0.05, 0, 0.05, 0)
petDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
petDropdown.BorderSizePixel = 1
petDropdown.BorderColor3 = Color3.fromRGB(80, 80, 80)
petDropdown.Parent = petTabFrame
Instance.new("UICorner", petDropdown).CornerRadius = UDim.new(0, 5)

local petDropdownButton = Instance.new("TextButton")
petDropdownButton.Name = "DropdownButton"
petDropdownButton.Size = UDim2.new(1, 0, 1, 0)
petDropdownButton.Text = "Select Pet"
petDropdownButton.Font = Enum.Font.SourceSans
petDropdownButton.TextSize = 14
petDropdownButton.TextColor3 = textColor
petDropdownButton.BackgroundTransparency = 1
petDropdownButton.Parent = petDropdown

local petDropdownList = Instance.new("ScrollingFrame")
petDropdownList.Name = "DropdownList"
petDropdownList.Size = UDim2.new(1, 0, 0, 100)
petDropdownList.Position = UDim2.new(0, 0, 1, 0)
petDropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
petDropdownList.BorderSizePixel = 0
petDropdownList.Visible = false
petDropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
petDropdownList.ScrollBarThickness = 5
petDropdownList.Parent = petDropdown

local petDropdownLayout = Instance.new("UIListLayout")
petDropdownLayout.Parent = petDropdownList

-- Dropdown for seeds
local seedDropdown = Instance.new("Frame")
seedDropdown.Name = "SeedDropdown"
seedDropdown.Size = UDim2.new(0.9, 0, 0, 25)
seedDropdown.Position = UDim2.new(0.05, 0, 0.05, 0)
seedDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
seedDropdown.BorderSizePixel = 1
seedDropdown.BorderColor3 = Color3.fromRGB(80, 80, 80)
seedDropdown.Parent = seedTabFrame
Instance.new("UICorner", seedDropdown).CornerRadius = UDim.new(0, 5)

local seedDropdownButton = Instance.new("TextButton")
seedDropdownButton.Name = "DropdownButton"
seedDropdownButton.Size = UDim2.new(1, 0, 1, 0)
seedDropdownButton.Text = "Select Seed"
seedDropdownButton.Font = Enum.Font.SourceSans
seedDropdownButton.TextSize = 14
seedDropdownButton.TextColor3 = textColor
seedDropdownButton.BackgroundTransparency = 1
seedDropdownButton.Parent = seedDropdown

local seedDropdownList = Instance.new("ScrollingFrame")
seedDropdownList.Name = "DropdownList"
seedDropdownList.Size = UDim2.new(1, 0, 0, 100)
seedDropdownList.Position = UDim2.new(0, 0, 1, 0)
seedDropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
seedDropdownList.BorderSizePixel = 0
seedDropdownList.Visible = false
seedDropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
seedDropdownList.ScrollBarThickness = 5
seedDropdownList.Parent = seedDropdown

local seedDropdownLayout = Instance.new("UIListLayout")
seedDropdownLayout.Parent = seedDropdownList

-- Dropdown for eggs
local eggDropdown = Instance.new("Frame")
eggDropdown.Name = "EggDropdown"
eggDropdown.Size = UDim2.new(0.9, 0, 0, 25)
eggDropdown.Position = UDim2.new(0.05, 0, 0.05, 0)
eggDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
eggDropdown.BorderSizePixel = 1
eggDropdown.BorderColor3 = Color3.fromRGB(80, 80, 80)
eggDropdown.Parent = eggTabFrame
Instance.new("UICorner", eggDropdown).CornerRadius = UDim.new(0, 5)

local eggDropdownButton = Instance.new("TextButton")
eggDropdownButton.Name = "DropdownButton"
eggDropdownButton.Size = UDim2.new(1, 0, 1, 0)
eggDropdownButton.Text = "Select Egg"
eggDropdownButton.Font = Enum.Font.SourceSans
eggDropdownButton.TextSize = 14
eggDropdownButton.TextColor3 = textColor
eggDropdownButton.BackgroundTransparency = 1
eggDropdownButton.Parent = eggDropdown

local eggDropdownList = Instance.new("ScrollingFrame")
eggDropdownList.Name = "DropdownList"
eggDropdownList.Size = UDim2.new(1, 0, 0, 100)
eggDropdownList.Position = UDim2.new(0, 0, 1, 0)
eggDropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
eggDropdownList.BorderSizePixel = 0
eggDropdownList.Visible = false
eggDropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
eggDropdownList.ScrollBarThickness = 5
eggDropdownList.Parent = eggDropdown

local eggDropdownLayout = Instance.new("UIListLayout")
eggDropdownLayout.Parent = eggDropdownList

local function createDropdownOption(parent, text, callback)
    local option = Instance.new("TextButton")
    option.Text = text
    option.Size = UDim2.new(1, 0, 0, 25)
    option.Font = Enum.Font.SourceSans
    option.TextSize = 14
    option.TextColor3 = textColor
    option.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    option.BorderSizePixel = 0
    option.Parent = parent
    
    option.MouseEnter:Connect(function()
        option.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
    end)
    
    option.MouseLeave:Connect(function()
        option.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end)
    
    option.MouseButton1Click:Connect(function()
        callback(text)
        parent.Parent.Visible = false
    end)
    
    return option
end

-- Populate dropdowns with available items
local function populateDropdowns()
    -- Pets
    local pets = Spawner.GetPets()
    for _, pet in ipairs(pets) do
        createDropdownOption(petDropdownList, pet, function(selected)
            petDropdownButton.Text = selected
        end)
    end
    petDropdownList.CanvasSize = UDim2.new(0, 0, 0, #pets * 25)
    
    -- Seeds
    local seeds = Spawner.GetSeeds()
    for _, seed in ipairs(seeds) do
        createDropdownOption(seedDropdownList, seed, function(selected)
            seedDropdownButton.Text = selected
        end)
    end
    seedDropdownList.CanvasSize = UDim2.new(0, 0, 0, #seeds * 25)
    
    -- Eggs
    local eggs = Spawner.GetEggs()
    for _, egg in ipairs(eggs) do
        createDropdownOption(eggDropdownList, egg, function(selected)
            eggDropdownButton.Text = selected
        end)
    end
    eggDropdownList.CanvasSize = UDim2.new(0, 0, 0, #eggs * 25)
end

-- Toggle dropdown visibility
petDropdownButton.MouseButton1Click:Connect(function()
    petDropdownList.Visible = not petDropdownList.Visible
    seedDropdownList.Visible = false
    eggDropdownList.Visible = false
end)

seedDropdownButton.MouseButton1Click:Connect(function()
    seedDropdownList.Visible = not seedDropdownList.Visible
    petDropdownList.Visible = false
    eggDropdownList.Visible = false
end)

eggDropdownButton.MouseButton1Click:Connect(function()
    eggDropdownList.Visible = not eggDropdownList.Visible
    petDropdownList.Visible = false
    seedDropdownList.Visible = false
end)

-- Close dropdowns when clicking elsewhere
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = input.Position
        local petAbsPos = petDropdown.AbsolutePosition
        local petAbsSize = petDropdown.AbsoluteSize
        
        if not (mousePos.X >= petAbsPos.X and mousePos.X <= petAbsPos.X + petAbsSize.X and
               mousePos.Y >= petAbsPos.Y and mousePos.Y <= petAbsPos.Y + petAbsSize.Y + (petDropdownList.Visible and petDropdownList.AbsoluteSize.Y or 0)) then
            petDropdownList.Visible = false
        end
        
        local seedAbsPos = seedDropdown.AbsolutePosition
        local seedAbsSize = seedDropdown.AbsoluteSize
        
        if not (mousePos.X >= seedAbsPos.X and mousePos.X <= seedAbsPos.X + seedAbsSize.X and
               mousePos.Y >= seedAbsPos.Y and mousePos.Y <= seedAbsPos.Y + seedAbsSize.Y + (seedDropdownList.Visible and seedDropdownList.AbsoluteSize.Y or 0)) then
            seedDropdownList.Visible = false
        end
        
        local eggAbsPos = eggDropdown.AbsolutePosition
        local eggAbsSize = eggDropdown.AbsoluteSize
        
        if not (mousePos.X >= eggAbsPos.X and mousePos.X <= eggAbsPos.X + eggAbsSize.X and
               mousePos.Y >= eggAbsPos.Y and mousePos.Y <= eggAbsPos.Y + eggAbsSize.Y + (eggDropdownList.Visible and eggDropdownList.AbsoluteSize.Y or 0)) then
            eggDropdownList.Visible = false
        end
    end
end)

local weightBox = createTextBox(petTabFrame, "Weight", UDim2.new(0.05, 0, 0.18, 0))
local ageBox = createTextBox(petTabFrame, "Age", UDim2.new(0.05, 0, 0.31, 0))
local amountBox = createTextBox(seedTabFrame, "Amount", UDim2.new(0.05, 0, 0.18, 0))
local spinBox = createTextBox(eggTabFrame, "Plant to Spin", UDim2.new(0.05, 0, 0.18, 0))

local function validateDecimal(box)
    box:GetPropertyChangedSignal("Text"):Connect(function()
        local t = box.Text:gsub("[^%d.]", "")
        if select(2, t:gsub("%.", "")) > 1 then
            local p1, p2 = t:match("([^%.]+)%.?(.*)")
            t = p1.."."..p2
        end
        if t:sub(1,1) == "." then t = "0"..t end
        if t ~= box.Text then box.Text = t end
    end)
end

for _, b in ipairs({weightBox, ageBox, amountBox}) do 
    validateDecimal(b) 
end

local function createButton(parent, label, posY, width)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(width or 0.9, 0, 0, 25)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.Text = label
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = lavender
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(80, 80, 80)
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = darkLavender
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = lavender
    end)
    
    return btn
end

local function createLoadingBar(parent, buttonYPosition)
    local loadingBarBg = Instance.new("Frame")
    loadingBarBg.Name = "LoadingBarBg"
    loadingBarBg.Size = UDim2.new(0.9, 0, 0, 20)
    loadingBarBg.Position = UDim2.new(0.05, 0, buttonYPosition, 0)
    loadingBarBg.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    loadingBarBg.BorderSizePixel = 1
    loadingBarBg.BorderColor3 = Color3.fromRGB(80, 80, 80)
    loadingBarBg.Visible = false
    loadingBarBg.Parent = parent

    local loadingBar = Instance.new("Frame")
    loadingBar.Name = "LoadingBar"
    loadingBar.Size = UDim2.new(0, 0, 1, 0)
    loadingBar.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
    loadingBar.BorderSizePixel = 0
    loadingBar.Parent = loadingBarBg

    local loadingPercent = Instance.new("TextLabel")
    loadingPercent.Name = "LoadingPercent"
    loadingPercent.Size = UDim2.new(1, 0, 1, 0)
    loadingPercent.Font = Enum.Font.SourceSansBold
    loadingPercent.TextSize = 12
    loadingPercent.TextColor3 = Color3.new(1,1,1)
    loadingPercent.BackgroundTransparency = 1
    loadingPercent.Text = "0%"
    loadingPercent.Parent = loadingBarBg

    local loadingText = Instance.new("TextLabel")
    loadingText.Name = "LoadingText"
    loadingText.Size = UDim2.new(0.9, 0, 0, 40)
    loadingText.Position = UDim2.new(0.05, 0, buttonYPosition + 0.18, 0)
    loadingText.Font = Enum.Font.SourceSans
    loadingText.TextSize = 12
    loadingText.TextColor3 = textColor
    loadingText.BackgroundTransparency = 1
    loadingText.TextXAlignment = Enum.TextXAlignment.Left
    loadingText.TextYAlignment = Enum.TextYAlignment.Top
    loadingText.TextWrapped = true
    loadingText.TextScaled = false
    loadingText.AutomaticSize = Enum.AutomaticSize.Y
    loadingText.Visible = false
    loadingText.Parent = parent

    return loadingText, loadingBarBg, loadingBar, loadingPercent
end

local petLoadingText, petLoadingBarBg, petLoadingBar, petLoadingPercent = createLoadingBar(petTabFrame, 0.60)
local seedLoadingText, seedLoadingBarBg, seedLoadingBar, seedLoadingPercent = createLoadingBar(seedTabFrame, 0.40)
local eggLoadingText, eggLoadingBarBg, eggLoadingBar, eggLoadingPercent = createLoadingBar(eggTabFrame, 0.40)

local spawnBtn = createButton(petTabFrame, "SPAWN", 0.60, 0.44)
local duplicateBtn = createButton(petTabFrame, "DUPE", 0.60, 0.44)
duplicateBtn.Position = UDim2.new(0.51, 0, 0.60, 0)
local spawnSeedBtn = createButton(seedTabFrame, "SPAWN SEED", 0.40)
local spawnEggBtn = createButton(eggTabFrame, "SPAWN EGG", 0.40)
local spinBtn = createButton(eggTabFrame, "SPIN PLANT", 0.60)

local function showNotification(message)
    local notification = Instance.new("Frame")
    notification.Name = "SpawnNotification"
    notification.Size = UDim2.new(0, 250, 0, 60)
    notification.Position = UDim2.new(1, -260, 1, -70)
    notification.BackgroundColor3 = headerColor
    notification.BorderSizePixel = 1
    notification.BorderColor3 = Color3.fromRGB(80, 80, 80)
    notification.Parent = screenGui
    Instance.new("UICorner", notification).CornerRadius = UDim.new(0, 8)
    
    local notificationText = Instance.new("TextLabel")
    notificationText.Text = message
    notificationText.Size = UDim2.new(1, -10, 1, -10)
    notificationText.Position = UDim2.new(0, 5, 0, 5)
    notificationText.Font = Enum.Font.SourceSans
    notificationText.TextSize = 14
    notificationText.TextColor3 = textColor
    notificationText.BackgroundTransparency = 1
    notificationText.TextWrapped = true
    notificationText.Parent = notification
    
    notification.Position = UDim2.new(1, 300, 1, -70)
    notification:TweenPosition(
        UDim2.new(1, -260, 1, -70),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.3,
        true
    )
    
    task.delay(3, function()
        notification:TweenPosition(
            UDim2.new(1, 300, 1, -70),
            Enum.EasingDirection.In,
            Enum.EasingStyle.Quad,
            0.3,
            true,
            function()
                notification:Destroy()
            end
        )
    end)
end

local function startLoading(loadingText, loadingBarBg, loadingBar, loadingPercent, name, weight, age, category, isDuplicate)
    if category == "PET" then
        spawnBtn.Visible = false
        duplicateBtn.Visible = false
    elseif category == "SEED" then
        spawnSeedBtn.Visible = false
    elseif category == "EGG" then