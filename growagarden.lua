-- FIXED Dragging + TextBox Label Issues

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
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Dragging variables
local dragging, dragInput, dragStart, startPos

local function startDrag(input)
	dragging = true
	dragStart = input.Position
	startPos = frame.Position
end

local function updateDrag(input)
	if dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end

-- Enable dragging on entire frame (and children)
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		startDrag(input)
	end
end)

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(updateDrag)

-- PET and SEED tabs
local tabPet = Instance.new("TextButton", frame)
tabPet.Text = "PET"
tabPet.Size = UDim2.new(0.5, 0, 0, 30)
tabPet.Position = UDim2.new(0, 0, 0, 0)
tabPet.BackgroundTransparency = 1
tabPet.TextColor3 = Color3.new(1, 1, 1)
tabPet.Font = Enum.Font.SourceSans
tabPet.TextSize = 24

local tabSeed = tabPet:Clone()
tabSeed.Text = "SEED"
tabSeed.Position = UDim2.new(0.5, 0, 0, 0)
tabSeed.Parent = frame

-- Close button
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSans
closeBtn.TextSize = 18
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

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

-- Containers
local petContainer = Instance.new("Frame", frame)
petContainer.Size = UDim2.new(1, 0, 1, -40)
petContainer.Position = UDim2.new(0, 0, 0, 35)
petContainer.BackgroundTransparency = 1

local seedContainer = petContainer:Clone()
seedContainer.Visible = false
seedContainer.Parent = frame

-- Pet Name Box
local function makeTextBox(parent, placeholder, pos)
	local box = Instance.new("TextBox", parent)
	box.Size = UDim2.new(0.9, 0, 0, 30)
	box.Position = pos
	box.PlaceholderText = placeholder
	box.Text = ""
	box.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
	box.PlaceholderColor3 = Color3.new(1, 1, 1)
	box.TextColor3 = Color3.new(1, 1, 1)
	box.Font = Enum.Font.SourceSans
	box.TextSize = 18
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
	return box
end

local nameBox = makeTextBox(petContainer, "Pet Name", UDim2.new(0.05, 0, 0.02, 0))
local weightBox = makeTextBox(petContainer, "Weight", UDim2.new(0.05, 0, 0.22, 0))
weightBox.Size = UDim2.new(0.42, 0, 0, 30)
local ageBox = makeTextBox(petContainer, "Age", UDim2.new(0.53, 0, 0.22, 0))
ageBox.Size = UDim2.new(0.42, 0, 0, 30)

for _, box in ipairs({weightBox, ageBox}) do
	box:GetPropertyChangedSignal("Text"):Connect(function()
		box.Text = box.Text:gsub("%D", "")
	end)
end

-- Spawn and Dupe Buttons
local function makeBtn(text, posY, parent)
	local btn = Instance.new("TextButton", parent)
	btn.Text = text
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, posY, 0)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 18
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	return btn
end

local spawnBtn = makeBtn("SPAWN PET", 0.45, petContainer)
local dupeBtn = makeBtn("DUPE PET", 0.65, petContainer)

-- Tab switching
tabPet.MouseButton1Click:Connect(function()
	petContainer.Visible = true
	seedContainer.Visible = false
end)
tabSeed.MouseButton1Click:Connect(function()
	petContainer.Visible = false
	seedContainer.Visible = true
end)

-- Dupe tool you’re holding
dupeBtn.MouseButton1Click:Connect(function()
	local char = player.Character
	if not char then return end
	local held = char:FindFirstChildOfClass("Tool")
	if not held then warn("No tool held"); return end

	local clone = held:Clone()
	clone.Parent = backpack

	task.wait(0.1)
	player.Character.Humanoid:EquipTool(clone)
end)
