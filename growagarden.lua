local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "ZenqPetSpawner"
screenGui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Close button
local toggleButton = Instance.new("TextButton", frame)
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(1, -35, 0, 5)
toggleButton.Text = "X"
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)

-- Re-open button
local reopenButton = Instance.new("TextButton", screenGui)
reopenButton.Size = UDim2.new(0, 120, 0, 30)
reopenButton.Position = UDim2.new(0, 10, 1, -40)
reopenButton.Text = "Open Pet UI"
reopenButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
reopenButton.TextColor3 = Color3.new(1, 1, 1)
reopenButton.Visible = false
Instance.new("UICorner", reopenButton).CornerRadius = UDim.new(0, 8)

toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    reopenButton.Visible = true
end)

reopenButton.MouseButton1Click:Connect(function()
    frame.Visible = true
    reopenButton.Visible = false
end)

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "zenxq pet spawner"
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSans
title.TextSize = 22

-- Labels
local petLabel = Instance.new("TextLabel", frame)
petLabel.Text = "Pet"
petLabel.Position = UDim2.new(0.1, 0, 0.2, 0)
petLabel.Size = UDim2.new(0, 50, 0, 30)
petLabel.BackgroundTransparency = 1
petLabel.TextColor3 = Color3.new(1, 1, 1)

local seedLabel = Instance.new("TextLabel", frame)
seedLabel.Text = "Seed"
seedLabel.Position = UDim2.new(0.65, 0, 0.2, 0)
seedLabel.Size = UDim2.new(0, 50, 0, 30)
seedLabel.BackgroundTransparency = 1
seedLabel.TextColor3 = Color3.new(1, 1, 1)

-- Weight / Age boxes
local weightBox = Instance.new("TextBox", frame)
weightBox.Size = UDim2.new(0, 100, 0, 30)
weightBox.Position = UDim2.new(0.05, 0, 0.35, 0)
weightBox.PlaceholderText = "Weight"
weightBox.Text = ""
weightBox.ClearTextOnFocus = false
Instance.new("UICorner", weightBox).CornerRadius = UDim.new(0, 6)

local ageBox = Instance.new("TextBox", frame)
ageBox.Size = UDim2.new(0, 100, 0, 30)
ageBox.Position = UDim2.new(0.6, 0, 0.35, 0)
ageBox.PlaceholderText = "Age"
ageBox.Text = ""
ageBox.ClearTextOnFocus = false
Instance.new("UICorner", ageBox).CornerRadius = UDim.new(0, 6)

local function numericOnly(box)
    box:GetPropertyChangedSignal("Text"):Connect(function()
        if box.Text:match("%D") then
            box.Text = box.Text:gsub("%D", "")
        end
    end)
end
numericOnly(weightBox)
numericOnly(ageBox)

-- Spawn Button
local spawnButton = Instance.new("TextButton", frame)
spawnButton.Text = "SPAWN PET"
spawnButton.Size = UDim2.new(0.8, 0, 0, 30)
spawnButton.Position = UDim2.new(0.1, 0, 0.6, 0)
spawnButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
spawnButton.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", spawnButton).CornerRadius = UDim.new(0, 8)

spawnButton.MouseButton1Click:Connect(function()
    print("Spawning pet with weight:", weightBox.Text, "age:", ageBox.Text)
end)

-- Dupe Button
local dupeButton = Instance.new("TextButton", frame)
dupeButton.Text = "DUPE PET"
dupeButton.Size = UDim2.new(0.8, 0, 0, 30)
dupeButton.Position = UDim2.new(0.1, 0, 0.75, 0)
dupeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dupeButton.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", dupeButton).CornerRadius = UDim.new(0, 8)

local knownPets = { "Bee", "Slime", "Chick", "Bat", "Pupper" }

dupeButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if not character then return end

    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return end

    local isPet = false
    for _, petName in ipairs(knownPets) do
        if tool.Name:lower():find(petName:lower()) then
            isPet = true
            break
        end
    end

    if isPet then
        local clone = tool:Clone()
        clone.Parent = backpack

        local handle = clone:FindFirstChild("Handle")
        if handle then
            local animator = handle:FindFirstChildWhichIsA("Animator") or handle:FindFirstChildWhichIsA("AnimationController")
            if animator then
                local animation = handle:FindFirstChildWhichIsA("Animation")
                if animation then
                    local track = animator:LoadAnimation(animation)
                    track:Play()
                end
            end
        end
    else
        warn("Held item is not a recognized pet.")
    end
end)
