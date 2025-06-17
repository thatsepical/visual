local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.ResetOnSpawn = false
screenGui.Name = "PetSeedUI"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

-- Mobile dragging support
local UIS = game:GetService("UserInputService")
local dragging = false
local dragInput, dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

local categories = Instance.new("Frame", mainFrame)
categories.Size = UDim2.new(1, 0, 0, 50)
categories.BackgroundTransparency = 1

local petTab = Instance.new("TextButton", categories)
petTab.Size = UDim2.new(0.5, 0, 1, 0)
petTab.Text = "PET"
petTab.Font = Enum.Font.SourceSans
petTab.TextColor3 = Color3.new(1, 1, 1)
petTab.TextScaled = true
petTab.BackgroundTransparency = 1

local seedTab = Instance.new("TextButton", categories)
seedTab.Size = UDim2.new(0.5, 0, 1, 0)
seedTab.Position = UDim2.new(0.5, 0, 0, 0)
seedTab.Text = "SEED"
seedTab.Font = Enum.Font.SourceSans
seedTab.TextColor3 = Color3.new(1, 1, 1)
seedTab.TextScaled = true
seedTab.BackgroundTransparency = 1

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -45, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSans
closeButton.TextScaled = true

local function toggleUI()
	mainFrame.Visible = not mainFrame.Visible
end

closeButton.MouseButton1Click:Connect(toggleUI)

local toggleKey = Enum.KeyCode.RightShift
UIS.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == toggleKey then
		toggleUI()
	end
end)

-- PET TAB CONTENT
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, 0, 1, -50)
contentFrame.Position = UDim2.new(0, 0, 0, 50)
contentFrame.BackgroundTransparency = 1

local petName = Instance.new("TextBox", contentFrame)
petName.PlaceholderText = "Pet Name"
petName.Size = UDim2.new(0.9, 0, 0, 50)
petName.Position = UDim2.new(0.05, 0, 0.05, 0)
petName.Font = Enum.Font.SourceSans
petName.TextScaled = true
petName.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
petName.TextColor3 = Color3.new(1, 1, 1)

local weight = Instance.new("TextBox", contentFrame)
weight.PlaceholderText = "Weight"
weight.Size = UDim2.new(0.4, 0, 0, 50)
weight.Position = UDim2.new(0.05, 0, 0.2, 0)
weight.Font = Enum.Font.SourceSans
weight.TextScaled = true
weight.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
weight.TextColor3 = Color3.new(1, 1, 1)

local age = Instance.new("TextBox", contentFrame)
age.PlaceholderText = "Age"
age.Size = UDim2.new(0.4, 0, 0, 50)
age.Position = UDim2.new(0.55, 0, 0.2, 0)
age.Font = Enum.Font.SourceSans
age.TextScaled = true
age.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
age.TextColor3 = Color3.new(1, 1, 1)

local spawnBtn = Instance.new("TextButton", contentFrame)
spawnBtn.Text = "SPAWN PET"
spawnBtn.Size = UDim2.new(0.9, 0, 0, 50)
spawnBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
spawnBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
spawnBtn.TextColor3 = Color3.new(1, 1, 1)
spawnBtn.Font = Enum.Font.SourceSans
spawnBtn.TextScaled = true

spawnBtn.MouseButton1Click:Connect(function()
	local petNameValue = petName.Text
	if petNameValue ~= "" then
		local petTool = backpack:FindFirstChild(petNameValue)
		if petTool and petTool:IsA("Tool") then
			player.Character.Humanoid:EquipTool(petTool)
			print("✔ Spawned:", petNameValue)
		else
			warn("⚠ Pet tool not found in backpack!")
		end
	end
end)

local dupeBtn = Instance.new("TextButton", contentFrame)
dupeBtn.Text = "DUPE PET"
dupeBtn.Size = UDim2.new(0.9, 0, 0, 50)
dupeBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
dupeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dupeBtn.TextColor3 = Color3.new(1, 1, 1)
dupeBtn.Font = Enum.Font.SourceSans
dupeBtn.TextScaled = true

dupeBtn.MouseButton1Click:Connect(function()
	local function findPetTool()
		local validNames = { "Bee", "Slime", "Chick", "Bat", "Pupper" }
		for _, container in ipairs({ player.Character, backpack }) do
			for _, item in ipairs(container:GetChildren()) do
				if item:IsA("Tool") then
					for _, petName in ipairs(validNames) do
						if item.Name:lower():find(petName:lower()) then
							return item
						end
					end
				end
			end
		end
		return nil
	end

	local petTool = findPetTool()
	if petTool then
		local clone = petTool:Clone()
		clone.Parent = backpack
		print("✔ Duplicated:", clone.Name)
	else
		warn("⚠ No pet tool found to duplicate.")
	end
end)
