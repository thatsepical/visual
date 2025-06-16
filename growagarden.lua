local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetSpawnerUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 320)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Top Bar (for dragging)
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topBar.BorderSizePixel = 0
topBar.Parent = frame
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Text = "zenxq pet spawner"
title.Font = Enum.Font.SourceSans
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 1, 0)
title.Parent = topBar

-- Drag support (mouse and touch)
local dragging = false
local dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function beginDrag(input)
	dragging = true
	dragStart = input.Position
	startPos = frame.Position

	input.Changed:Connect(function()
		if input.UserInputState == Enum.UserInputState.End then
			dragging = false
		end
	end)
end

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		beginDrag(input)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		update(input)
	end
end)

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 2)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSans
closeBtn.TextSize = 18
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.Parent = topBar

local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 120, 0, 35)
floatBtn.Position = UDim2.new(0, 10, 1, -50)
floatBtn.Text = "Open Pet UI"
floatBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
floatBtn.TextColor3 = Color3.new(1, 1, 1)
floatBtn.Visible = false
floatBtn.Font = Enum.Font.SourceSans
floatBtn.TextSize = 16
Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(0, 10)
floatBtn.Parent = screenGui

closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	floatBtn.Visible = true
end)

floatBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	floatBtn.Visible = false
end)

-- Content Area
local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 1, -35)
content.Position = UDim2.new(0, 0, 0, 35)
content.BackgroundTransparency = 1
content.Parent = frame

-- Function to make input boxes
local function makeTextBox(parent, placeholder, pos)
	local box = Instance.new("TextBox")
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
	box.Parent = parent
	return box
end

local petNameBox = makeTextBox(content, "Pet Name", UDim2.new(0.05, 0, 0.02, 0))
local weightBox = makeTextBox(content, "Weight", UDim2.new(0.05, 0, 0.22, 0))
local ageBox = makeTextBox(content, "Age", UDim2.new(0.05, 0, 0.42, 0))

-- Only allow numbers for weight/age
for _, box in ipairs({ weightBox, ageBox }) do
	box:GetPropertyChangedSignal("Text"):Connect(function()
		box.Text = box.Text:gsub("%D", "")
	end)
end

-- Buttons
local function makeBtn(text, posY, parent)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, posY, 0)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 18
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	btn.Parent = parent
	return btn
end

local spawnBtn = makeBtn("SPAWN PET", 0.65, content)
local dupeBtn = makeBtn("DUPE PET", 0.82, content)

-- Known pet list (can expand)
local knownPets = { "Bee", "Slime", "Chick", "Bat", "Pupper" }

-- Dupe logic
dupeBtn.MouseButton1Click:Connect(function()
	local char = player.Character
	if not char then return end

	local held = char:FindFirstChildOfClass("Tool")
	if not held then
		warn("No tool held.")
		return
	end

	local valid = false
	for _, name in ipairs(knownPets) do
		if held.Name:lower():find(name:lower()) then
			valid = true
			break
		end
	end

	if not valid then
		warn("That tool is not a supported pet.")
		return
	end

	local clone = held:Clone()
	clone.Parent = backpack

	local handle = clone:FindFirstChild("Handle")
	if handle then
		local anim = handle:FindFirstChildWhichIsA("Animation")
		if anim then
			local controller = Instance.new("AnimationController", handle)
			controller.Name = "Animator"
			local animator = Instance.new("Animator", controller)
			local track = animator:LoadAnimation(anim)
			track:Play()
		end
	end

	task.wait(0.1)
	player.Character.Humanoid:EquipTool(clone)
end)

spawnBtn.MouseButton1Click:Connect(function()
	print("Spawning", petNameBox.Text, "Weight:", weightBox.Text, "Age:", ageBox.Text)
end)
