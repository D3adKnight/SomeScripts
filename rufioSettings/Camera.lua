local f = CreateFrame("Frame")
f:SetScript("OnEvent", function()
	SetCVar("cameraDistanceMax", 50)
	SetCVar("CameraDistanceMaxFactor", 3.4)
end)
f:RegisterEvent("PLAYER_ENTERING_WORLD")