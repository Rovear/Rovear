-- WallpaperManager ModuleScript

local WallpaperManager = {}

-- Fallback images (replace with valid asset IDs)
local FallbackImages = {
    "rbxassetid://12345678", -- Replace with your actual image asset IDs
    "rbxassetid://23456789",
    "rbxassetid://34567890",
    "rbxassetid://45678901"
}

-- Current wallpaper ID and darkening factor
local currentWallpaperId = FallbackImages[1]
local darkeningFactor = 0 -- 0 = no darkening, 1 = completely black

-- Function to validate a wallpaper ID
local function isValidWallpaper(id)
    local success = pcall(function()
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Image = "rbxassetid://" .. tostring(id)
    end)
    return success
end

-- Updates the GUI with the current wallpaper and darkening factor
local function updateGUI()
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local gui = playerGui:FindFirstChild("WallgroundGui")

    if gui then
        local wallpaper = gui:FindFirstChild("Wallpaper")
        local darkOverlay = gui:FindFirstChild("DarkOverlay")

        if wallpaper then
            wallpaper.Image = currentWallpaperId
        else
            warn("[WallpaperManager] Wallpaper ImageLabel not found.")
        end

        if darkOverlay then
            darkOverlay.BackgroundTransparency = 1 - darkeningFactor
        else
            warn("[WallpaperManager] DarkOverlay Frame not found.")
        end
    else
        warn("[WallpaperManager] WallgroundGui not found.")
    end
end

-- Initializes the wallpaper system at startup
function WallpaperManager.Initialize()
    -- Set a random fallback image as the initial wallpaper
    currentWallpaperId = FallbackImages[math.random(1, #FallbackImages)]
    updateGUI()
end

-- Sets the wallpaper
function WallpaperManager.SetWallpaper(wallpaperId)
    if isValidWallpaper(wallpaperId) then
        currentWallpaperId = "rbxassetid://" .. tostring(wallpaperId)
    else
        -- Fallback to a random image
        currentWallpaperId = FallbackImages[math.random(1, #FallbackImages)]
        warn("[WallpaperManager] Invalid wallpaper ID. Using fallback.")
    end

    updateGUI()
end

-- Sets the darkening factor (0 to 1)
function WallpaperManager.SetDarkening(factor)
    darkeningFactor = math.clamp(factor, 0, 1)
    updateGUI()
end

-- Gets the current wallpaper ID
function WallpaperManager.GetWallpaper()
    return currentWallpaperId
end

-- Gets the current darkening factor
function WallpaperManager.GetDarkening()
    return darkeningFactor
end

return WallpaperManager
