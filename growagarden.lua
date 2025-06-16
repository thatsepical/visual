local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "PetSpawnerUI"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 260)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Name = "MainFrame"

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Dragging fix
local dragging, dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- PET and SEED tabs
local tabPet = Instance.new("TextButton", frame)
tabPet.Text = "PET"
tabPet.Size = UDim2.new(0.5, 0, 0, 30)
tabPet.Position = UDim2.new(0, 0, 0, 0)
tabPet.BackgroundTransparency = 1
tabPet.TextColor3 = Color3.new(1, 1, 1)
tabPet.Font = Enum.Font.SourceSans
tabPet.TextSize = 24

local tabSeed = Instance.new("TextButton", frame)
tabSeed.Text = "SEED"
tabSeed.Size = UDim2.new(0.5, 0, 0, 30)
tabSeed.Position = UDim2.new(0.5, 0, 0, 0)
tabSeed.BackgroundTransparency = 1
tabSeed.TextColor3 = Color3.new(1, 1, 1)
tabSeed.Font = Enum.Font.SourceSans
tabSeed.TextSize = 24

-- Close Button
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSans
closeBtn.TextSize = 18
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

-- Floating open button
local floatBtn = Instance.new("TextButton", screenGui)
floatBtn.Size = UDim2.new(0, 120, 0, 30)
floatBtn.Position = UDim2.new(0, 10, 1, -50)
floatBtn.Text = "Open Pet UI"
floatBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
floatBtn.TextColor3 = Color3.new(1, 1, 1)
floatBtn.Visible = false
floatBtn.Font = Enum.Font.SourceSans
floatBtn.TextSize = 16
Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(0, 10)

closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	floatBtn.Visible = true
end)

floatBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	floatBtn.Visible = false
end)

-- PET container
local petContainer = Instance.new("Frame", frame)
petContainer.Size = UDim2.new(1, 0, 1, -40)
petContainer.Position = UDim2.new(0, 0, 0, 35)
petContainer.BackgroundTransparency = 1

-- Pet Name
local nameBox = Instance.new("TextBox", petContainer)
nameBox.Size = UDim2.new(0.9, 0, 0, 30)
nameBox.Position = UDim2.new(0.05, 0, 0.02, 0)
nameBox.PlaceholderText = "Pet Name"
nameBox.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
nameBox.PlaceholderColor3 = Color3.new(1, 1, 1)
nameBox.TextColor3 = Color3.new(1, 1, 1)
nameBox.Font = Enum.Font.SourceSans
nameBox.TextSize = 18
Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0, 6)

-- Weight
local weightBox = Instance.new("TextBox", petContainer)
weightBox.Size = UDim2.new(0.42, 0, 0, 30)
weightBox.Position = UDim2.new(0.05, 0, 0.22, 0)
weightBox.PlaceholderText = "Weight"
weightBox.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
weightBox.PlaceholderColor3 = Color3.new(1, 1, 1)
weightBox.TextColor3 = Color3.new(1, 1, 1)
weightBox.Font = Enum.Font.SourceSans
weightBox.TextSize = 18
Instance.new("UICorner", weightBox).CornerRadius = UDim.new(0, 6)

-- Age
local ageBox = Instance.new("TextBox", petContainer)
ageBox.Size = UDim2.new(0.42, 0, 0, 30)
ageBox.Position = UDim2.new(0.53, 0, 0.22, 0)
ageBox.PlaceholderText = "Age"
ageBox.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
ageBox.PlaceholderColor3 = Color3.new(1, 1, 1)
ageBox.TextColor3 = Color3.new(1, 1, 1)
ageBox.Font = Enum.Font.SourceSans
ageBox.TextSize = 18
Instance.new("UICorner", ageBox).CornerRadius = UDim.new(0, 6)

-- Only allow numbers
for _, box in ipairs({weightBox, ageBox}) do
	box:GetPropertyChangedSignal("Text"):Connect(function()
		box.Text = box.Text:gsub("%D", "")
	end)
end

-- SPAWN Button
local spawnBtn = Instance.new("TextButton", petContainer)
spawnBtn.Text = "SPAWN PET"
spawnBtn.Size = UDim2.new(0.9, 0, 0, 30)
spawnBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
spawnBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
spawnBtn.TextColor3 = Color3.new(1, 1, 1)
spawnBtn.Font = Enum.Font.SourceSans
spawnBtn.TextSize = 18
Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 8)

-- DUPE Button
local dupeBtn = Instance.new("TextButton", petContainer)
dupeBtn.Text = "DUPE PET"
dupeBtn.Size = UDim2.new(0.9, 0, 0, 30)
dupeBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
dupeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dupeBtn.TextColor3 = Color3.new(1, 1, 1)
dupeBtn.Font = Enum.Font.SourceSans
dupeBtn.TextSize = 18
Instance.new("UICorner", dupeBtn).CornerRadius = UDim.new(0, 8)

dupeBtn.MouseButton1Click:Connect(function()
	local char = player.Character
	if not char then return end

	local held = char:FindFirstChildOfClass("Tool")
	if not held then warn("No tool held"); return end

	local clone = held:Clone()
	clone.Parent = backpack

	task.wait(0.1)
	player.Character.Humanoid:EquipTool(clone)

	-- Optional: Play animation if found
	local handle = clone:FindFirstChild("Handle")
	if handle then
		local anim = handle:FindFirstChildWhichIsA("Animation")
		if anim then
			local animator = handle:FindFirstChildWhichIsA("Animator") or Instance.new("AnimationController", handle)
			local track = animator:LoadAnimation(anim)
			track:Play()
		end
	end
end)

-- SEED container (blank for now)
local seedContainer = Instance.new("Frame", frame)
seedContainer.Size = petContainer.Size
seedContainer.Position = petContainer.Position
seedContainer.BackgroundTransparency = 1
seedContainer.Visible = false

-- Tab Switching
tabPet.MouseButton1Click:Connect(function()
	petContainer.Visible = true
	seedContainer.Visible = false
end)

tabSeed.MouseButton1Click:Connect(function()
	petContainer.Visible = false
	seedContainer.Visible = true
end)
