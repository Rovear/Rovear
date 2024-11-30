local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Set the camera to a scriptable mode.
camera.CameraType = Enum.CameraType.Scriptable

-- Move the camera to a position far from the playable area.
camera.CFrame = CFrame.new(0, 1000, 0)
