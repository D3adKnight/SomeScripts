
    --[[ SetPoints ]]
--~     PlayerFrame:ClearAllPoints()
--~     PlayerFrame:SetPoint("CENTER", -165, -140)
--~     PlayerFrame.SetPoint = function() end -- TAINT
--~      
--~     TargetFrame:ClearAllPoints()
--~     TargetFrame:SetPoint("CENTER", 165, -140)
--~     --TargetFrame.SetPoint = function() end -- TAINT
--~      
    TargetFrameToT:ClearAllPoints()
    TargetFrameToT:SetPoint("LEFT", TargetFrame, "TOP", -15, -1)
    --TargetFrameToT.SetPoint = function() end -- TAINT
     
    TargetFrameToTTextureFrameName:ClearAllPoints()
    TargetFrameToTTextureFrameName:SetPoint("LEFT", TargetFrameToT, "TOP", -1, -8)
    --TargetFrameToTTextureFrameName.SetPoint = function() end -- TAINT
     
    FocusFrameToT:SetPoint("BOTTOMRIGHT", -35, -13)
     
    PartyMemberFrame1:ClearAllPoints()
    PartyMemberFrame1:SetPoint("TOPLEFT", 255, -275)
     
    Boss1TargetFrame:ClearAllPoints()
    Boss1TargetFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -140, -230)
    --Boss1TargetFrame.SetPoint = function() end -- TAINT
     
    --TargetFrameSpellBar:ClearAllPoints()
    --TargetFrameSpellBar:SetPoint("CENTER", -120, 65)
    --TargetFrameSpellBar.SetPoint = function() end -- TAINT
     
    --[[ Scaling ]]
    PlayerFrame:SetScale("1.2")
    TargetFrame:SetScale("1.2")
	FocusFrame:SetScale("1.2")
    for i = 1, 4 do
        _G["PartyMemberFrame"..i]:SetScale("1.3")
    end
    Boss1TargetFrame:SetScale("1.3")
    Boss2TargetFrame:SetScale("1.3")
    Boss3TargetFrame:SetScale("1.3")
    --TargetFrameSpellBar:SetScale("1.4")
    --ComboFrame:SetScale("1.3")
    
    FocusFrameSpellBar.timer = FocusFrameSpellBar:CreateFontString(nil)
    FocusFrameSpellBar.timer:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE")
    FocusFrameSpellBar.timer:SetPoint("RIGHT", FocusFrameSpellBar, "RIGHT", 24, 0)
    FocusFrameSpellBar.update = 0.1
     
    hooksecurefunc("CastingBarFrame_OnUpdate", function(self, elapsed)
        if not self.timer then return end
        if self.update and self.update < elapsed then
            if self.casting then
                self.timer:SetText(format("%.1f", max(self.maxValue - self.value, 0)))
            elseif self.channeling then
                self.timer:SetText(format("%.1f", max(self.value, 0)))
            else
                self.timer:SetText("")
            end
            self.update = 0.1
        else
            self.update = self.update - elapsed
        end
    end)

    --[[ Focus Castbar ]]
    FocusFrameSpellBar:SetScale("1.6")
    FocusFrameSpellBar:ClearAllPoints()
    FocusFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", 0, 150)
    FocusFrameSpellBar.SetPoint = function() end -- TAINT
     
    FocusFrameSpellBar:SetStatusBarColor(0,0.45,0.9)
    FocusFrameSpellBar.SetStatusBarColor = function() end -- TAINT
     
    --[[ Runebar ]]
    RuneFrame:ClearAllPoints()
    RuneFrame:SetPoint("CENTER",UIParent,"CENTER",0,-130)
    --RuneFrame.SetPoint = function() end -- TAINT
     
    for i=1,6 do
        _G["RuneButtonIndividual"..i]:SetScale("1.4")
        _G["RuneButtonIndividual"..i]:ClearAllPoints()
    end
     
    RuneButtonIndividual3:SetPoint("CENTER",-12,0)
    RuneButtonIndividual4:SetPoint("CENTER",12,0)
    RuneButtonIndividual2:SetPoint("RIGHT",RuneButtonIndividual3,"LEFT",-4,8)
    RuneButtonIndividual1:SetPoint("RIGHT",RuneButtonIndividual2,"LEFT",-4,8)
    RuneButtonIndividual5:SetPoint("LEFT",RuneButtonIndividual4,"RIGHT",4,8)
    RuneButtonIndividual6:SetPoint("LEFT",RuneButtonIndividual5,"RIGHT",4,8)
     
    --[[ hiding pvp icon ]]
    PlayerPVPIcon:SetAlpha(0)
    TargetFrameTextureFramePVPIcon:SetAlpha(0)