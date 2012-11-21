local trinkets = {}
local events = CreateFrame("Frame")
function events:ADDON_LOADED(addonName)
    if addonName ~= "Blizzard_ArenaUI" then
        return
    end
        ArenaEnemyFrame1:ClearAllPoints()
        ArenaEnemyFrame1:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -300, -260)		
        ArenaEnemyFrame1.SetPoint = function() end
		ArenaEnemyFrame1:SetScale(1.2)
		ArenaEnemyFrame1.SetScale = function() end
        ArenaEnemyFrame2:ClearAllPoints()
        ArenaEnemyFrame2:SetPoint("BOTTOMLEFT", ArenaEnemyFrame1, "BOTTOMLEFT", 0, -50)
        ArenaEnemyFrame2.SetPoint = function() end
		ArenaEnemyFrame2:SetScale(1.2)
		ArenaEnemyFrame2.SetScale = function() end
        ArenaEnemyFrame3:ClearAllPoints()
        ArenaEnemyFrame3:SetPoint("BOTTOMLEFT", ArenaEnemyFrame1, "BOTTOMLEFT", 0, -100)
        ArenaEnemyFrame3.SetPoint = function() end
		ArenaEnemyFrame3:SetScale(1.2)
		ArenaEnemyFrame3.SetScale = function() end		
    local arenaFrame, trinket
    for i = 1, MAX_ARENA_ENEMIES do
	    arenaFrame = "ArenaEnemyFrame"..i
        trinket = CreateFrame("Cooldown", arenaFrame.."Trinket", ArenaEnemyFrames)
        trinket:SetPoint("TOPRIGHT", arenaFrame, 30, -6)
        trinket:SetSize(24, 24)
        trinket.icon = trinket:CreateTexture(nil, "BACKGROUND")
        trinket.icon:SetAllPoints()
        trinket.icon:SetTexture("Interface\\Icons\\inv_jewelry_trinketpvp_01")
        trinket:Hide()
        trinkets["arena"..i] = trinket
    end
    self:UnregisterEvent("ADDON_LOADED")
end
function events:UNIT_SPELLCAST_SUCCEEDED(unitID, spell, rank, lineID, spellID)
    if not trinkets[unitID] then
        return
    end
    if spellID == 59752 or spellID == 42292 then
        CooldownFrame_SetTimer(trinkets[unitID], GetTime(), 120, 1)
        SendChatMessage("Trinket used by: "..GetUnitName(unitID, true), "PARTY")
    elseif spellID == 7744 then
        CooldownFrame_SetTimer(trinkets[unitID], GetTime(), 45, 1)
        SendChatMessage("WotF used by: "..GetUnitName(unitID, true), "PARTY")
    end
end
function events:PLAYER_ENTERING_WORLD()
    local _, instanceType = IsInInstance()
    if instanceType == "arena" then
        self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    elseif self:IsEventRegistered("UNIT_SPELLCAST_SUCCEEDED") then
        self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
        for _, trinket in pairs(trinkets) do
            trinket:SetCooldown(0, 0)
            trinket:Hide()
        end
    end
end
SLASH_TESTAEF1 = "/testaef"
SlashCmdList["TESTAEF"] = function(msg, editBox)
    if not IsAddOnLoaded("Blizzard_ArenaUI") then
        LoadAddOn("Blizzard_ArenaUI")
    end
    ArenaEnemyFrames:Show()
    local arenaFrame
    for i = 1, 3 do
        arenaFrame = _G["ArenaEnemyFrame"..i]		
        arenaFrame.classPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
        arenaFrame.classPortrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS["WARRIOR"]))
        arenaFrame.name:SetText("Dispelme")
        arenaFrame:Show()        		
        CooldownFrame_SetTimer(trinkets["arena"..i], GetTime(), 120, 1)		
    end
end
events:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_ENTERING_WORLD")

DRt={{96294,339,16689,102359,128405,50245,4167,90327,54706,122,33395,116706,114404,115197,64695,63685,107566},{108194,91800,91797,22570,9005,5211,102795,117526,24394,90337,50519,44572,118271,119392,119381,122242,120086,853,119072,105593,1833,408,118905,30283,103131,20549},{91644,50541,117368,64044,51722,118093,676},{2637,99,1499,19386,118,113724,115078,105421,20066,9484,1776,6770,51514,107079},{1513,10326,8122,113792,2094,118699,5484,6358,115268,5246},{81261,34490,55021,102051,116709,31935,15487,703,24259,115782,6552,129597}} 
drx=86;drs=24;dp="RIGHT";dre="COMBAT_LOG_EVENT_UNFILTERED"drp="PLAYER_ENTERING_WORLD"dra="ARENA_OPPONENT_UPDATE"LoadAddOn("Blizzard_ArenaUI")function gaef(f,n)return _G["ArenaEnemyFrame"..n.."HealthBar"]end 
function rDR(f)f.e=1;f.t:SetTexture(nil)f.c:Hide()end function sDR(f)f.e=f.e+1;f.c:Show()end function gDRt(i,j)return _G["drc"..i..":"..j]end function runDR(f,n)CooldownFrame_SetTimer(f.c,GetTime(),18,1)eDR(f,n)sDR(f)oDR(n)end 
function eDR(f,n)local t=1;f:SetScript("OnUpdate",function(s,e)t=t+e;if(t>=18)then f:SetScript("OnUpdate",nil)rDR(f)oDR(n)end end)end function cDR(f,n,s)if f.e<4 then local _,_,t=GetSpellInfo(s)f.t:SetTexture(t)runDR(f,n)end end 
function oDR(n)local r=1;for j in ipairs(DRt)do local f=gDRt(n,j)f:SetPoint(dp,gaef(f,n),dp,drx+(r-1)*25,-2)r=r+1;end end function uDR(n,s)for i,t in ipairs(DRt)do for _,j in ipairs(t)do if s==j then cDR(gDRt(n,i),n,s)end end end end 
function DRc(i,j)local f=CreateFrame("Frame",nil,UIParent)f:SetSize(drs,drs)f.t=f:CreateTexture(nil,"BORDER")f.t:SetAllPoints(true)f.c=CreateFrame("Cooldown",nil,f)f.c:SetAllPoints(f)f.e=1 return f end 
function clDR(_,e,_,_,_,_,_,d,_,_,_,s)if(e=="SPELL_AURA_REMOVED" or e=="SPELL_AURA_REFRESH")then for i=1,5 do local ag=UnitGUID("arena"..i)if(ag ~= nil and d==ag)then uDR(i,s)end end end end 
function iDRt(o,m)for i=1,m do for j in ipairs(DRt)do local f=gDRt(i,j)rDR(f)if o then f:Show()end end end end for i=1,5 do for j in ipairs(DRt)do _G["drc"..i..":"..j]=DRc(i,j)end end 
dt=CreateFrame("Frame")dt:SetScript("OnEvent",function(_,e,...)if e==dre then clDR(...)elseif e==dra then iDRt(1,GetNumArenaOpponents())else iDRt(nil,5)end end)dt:RegisterEvent(dra)dt:RegisterEvent(drp)dt:RegisterEvent(dre)

local f = CreateFrame("Frame")
local function Update(self, event, ...)
	
	local pvpType = GetZonePVPInfo()	
		f:UnregisterEvent("ZONE_CHANGED_NEW_AREA")	
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then		
		local timestamp, eventType, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, _, spellID, spellName, _, extraskillID, extraSkillName = ...
		if eventType == "SPELL_INTERRUPT" and sourceName == UnitName("player") then
			SendChatMessage("Interrupted -> "..GetSpellLink(extraskillID).."!", "PARTY")
		end
	end
end
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:SetScript("OnEvent", Update)

local function Update(self, event, ...)
	if event == "UNIT_SPELLCAST_SUCCEEDED" then
		local unit, spellName, spellrank, spelline, spellID = ...
		if GetZonePVPInfo() == "arena" then
			if UnitIsEnemy("player", unit) and (spellID == 80167 or spellID == 94468 or spellID == 43183 or spellID == 57073 or spellName == "Trinken") then
				SendChatMessage(UnitName(unit).." is drinking.", "PARTY")
			end
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
f:SetScript("OnEvent", Update)