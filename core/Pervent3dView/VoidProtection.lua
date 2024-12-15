local player = game.Players.LocalPlayer
local character

local function onCharacterAdded(char)
	character = char
	
	-- Wait for the Humanoid to load.
	local humanoid = character:WaitForChild("Humanoid")
	
	-- Make health effectively infinite so the player never loses health.
	humanoid.MaxHealth = math.huge
	humanoid.Health = math.huge
	
	-- Keep resetting health just in case something tries to damage the player.
	humanoid.HealthChanged:Connect(function()
		humanoid.Health = humanoid.MaxHealth
	end)

	-- Continuously check if the player falls below a threshold (e.g., -100).
	while character.Parent do
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if rootPart and rootPart.Position.Y < -100 then
			-- Teleport them to a safe location. Customize this position as needed.
			rootPart.CFrame = CFrame.new(0, 10, 0)
		end
		task.wait(0.1)
	end
end

-- Connect the function to CharacterAdded to handle respawns.
player.CharacterAdded:Connect(onCharacterAdded)

-- If the character already exists, run the function immediately.
if player.Character then
	onCharacterAdded(player.Character)
end
