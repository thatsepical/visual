local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "ZenqPetSpawner"
screenGui.ResetOnSpawn = false

-- Main UI Frame (Smaller)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "zenxq pet spawner"
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSans
title.TextSize = 20

-- Close Button
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

-- Floating Reopen Button
local floatBtn = Instance.new("TextButton", screenGui)
floatBtn.Size = UDim2.new(0, 120, 0, 30)
floatBtn.Position = UDim2.new(0, 10, 1, -50)
floatBtn.Text = "Open Pet UI"
floatBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
floatBtn.TextColor3 = Color3.new(1, 1, 1)
floatBtn.Visible = false
Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(0, 10)

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    floatBtn.Visible = true
end)

floatBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    floatBtn.Visible = false
end)

-- Labels and Inputs
local petLabel = Instance.new("TextLabel", frame)
petLabel.Text = "Pet"
petLabel.Position = UDim2.new(0.1, 0, 0.2, 0)
petLabel.Size = UDim2.new(0, 50, 0, 20)
petLabel.BackgroundTransparency = 1
petLabel.TextColor3 = Color3.new(1, 1, 1)

local seedLabel = Instance.new("TextLabel", frame)
seedLabel.Text = "Seed"
seedLabel.Position = UDim2.new(0.6, 0, 0.2, 0)
seedLabel.Size = UDim2.new(0, 50, 0, 20)
seedLabel.BackgroundTransparency = 1
seedLabel.TextColor3 = Color3.new(1, 1, 1)

local weightBox = Instance.new("TextBox", frame)
weightBox.Size = UDim2.new(0, 90, 0, 25)
weightBox.Position = UDim2.new(0.05, 0, 0.35, 0)
weightBox.PlaceholderText = "Weight"
weightBox.Text = ""
Instance.new("UICorner", weightBox).CornerRadius = UDim.new(0, 6)

local ageBox = Instance.new("TextBox", frame)
ageBox.Size = UDim2.new(0, 90, 0, 25)
ageBox.Position = UDim2.new(0.55, 0, 0.35, 0)
ageBox.PlaceholderText = "Age"
ageBox.Text = ""
Instance.new("UICorner", ageBox).CornerRadius = UDim.new(0, 6)

local function numericOnly(box)
    box:GetPropertyChangedSignal("Text"):Connect(function()
        box.Text = box.Text:gsub("%D", "")
    end)
end
numericOnly(weightBox)
numericOnly(ageBox)

-- Spawn Button
local spawnBtn = Instance.new("TextButton", frame)
spawnBtn.Text = "SPAWN PET"
spawnBtn.Size = UDim2.new(0.8, 0, 0, 30)
spawnBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
spawnBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
spawnBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 8)

spawnBtn.MouseButton1Click:Connect(function()
    print("Spawning pet with weight:", weightBox.Text, "age:", ageBox.Text)
end)

-- Dupe Button
local dupeBtn = Instance.new("TextButton", frame)
dupeBtn.Text = "DUPE PET"
dupeBtn.Size = UDim2.new(0.8, 0, 0, 30)
dupeBtn.Position = UDim2.new(0.1, 0, 0.78, 0)
dupeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dupeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", dupeBtn).CornerRadius = UDim.new(0, 8)

local knownPets = { "Bee", "Slime", "Chick", "Bat", "Pupper" }

dupeBtn.MouseButton1Click:Connect(function()
    local character = player.Character
    if not character then return end

    local held = character:FindFirstChildOfClass("Tool")
    if not held then return end

    local isPet = false
    for _, name in ipairs(knownPets) do
        if held.Name:lower():find(name:lower()) then
            isPet = true
            break
        end
    end

    if isPet then
        local clone = held:Clone()
        clone.Parent = backpack

        local handle = clone:FindFirstChild("Handle")
        if handle then
            local animator = handle:FindFirstChildWhichIsA("Animator") or handle:FindFirstChildWhichIsA("AnimationController")
            if not animator then
                animator = Instance.new("AnimationController")
                animator.Name = "Animator"
                animator.Parent = handle
            end

            local anim = handle:FindFirstChildWhichIsA("Animation")
            if anim then
                local track = animator:LoadAnimation(anim)
                track:Play()
            end
        end
    else
        warn("That item is not a supported pet.")
    end
end)
