-- Access PlayerGui (where GUI elements are cloned to at runtime)
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 5) -- Timeout added for safety

if not playerGui then
	error("PlayerGui not found! Script terminated.")
end

local screenGui = playerGui:WaitForChild("ScreenGui", 5)
if not screenGui then
	error("ScreenGui not found! Script terminated.")
end

-- Define the image IDs for each note
local imageIds = {
	"rbxassetid://98414606871978", -- Image for Note1
	"rbxassetid://99284842825850", -- Image for Note2
	"rbxassetid://99284842825850", -- Image for Note3
	"rbxassetid://98414606871978"  -- Image for Note4
}

-- Loop through the notes and assign images
for i, assetId in ipairs(imageIds) do
	local noteName = "Note" .. i
	local imageLabel = screenGui:FindFirstChild(noteName)

	if imageLabel and imageLabel:IsA("ImageLabel") then
		-- Assign the image
		imageLabel.Image = assetId
		print(noteName .. " set to image ID:", assetId)
	else
		warn("Could not find or is not an ImageLabel:", noteName)
	end
end
