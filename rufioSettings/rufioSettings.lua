LARGE_NUMBER_SEPERATOR = ","
--[[ Options ]]
local SellGreyCrap = true           -- Sell all grey items to vendor automatically.
local HideHotKeys = false           -- Hiding hotkey and macro text true/false
local HideClock = false              -- Hides Bliizard Clock

--[[ Hiding Hotkey and Macrotext ]]
if (HideHotKeys == true) then
local format = string.format;
local match = string.match;
local upper = strupper;
local _G = getfenv(0);
local f = {"ActionButton%d", "MultiBarBottomLeftButton%d", "MultiBarBottomRightButton%d", "MultiBarRightButton%d",
			"MultiBarLeftButton%d", "BonusActionButton%d"}
do
	for k, v in pairs(f) do
		for i = 1, 12 do
			local str = format(v, i);
			_G[str.."HotKey"].Show = function() end;
			_G[str.."Name"].Show = function() end;
			_G[str.."Name"]:Hide();
		end
	end
end
end


--[[ Auto sell crap - stolen from tekJunkSeller ]]
local function OnEvent()
	for bag=0,4 do
		for slot=0,GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link and select(3, GetItemInfo(link)) == 0 then
				ShowMerchantSellCursor(1)
				UseContainerItem(bag, slot)
			end
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", OnEvent)

if MerchantFrame:IsVisible() then OnEvent() end

--[[ iRepair -- VARIABLES CAN BE CHANGED AS YOU WANT ]]--
local 	iRepair_Chatter 	= true
local 	iRepair_GRF		= true
local 	iRepair_ROGR		= false

--[[ AUTO REPAIR SERVICES ]]--
local iRepair = CreateFrame("Frame", "iRepair")
	iRepair:RegisterEvent("MERCHANT_SHOW")
	iRepair:SetScript("OnEvent", function()
	local cost = GetRepairAllCost()
	local function iRepair_Guild()
		if iRepair_Chatter then
			print(" Guild Bank Auto Repair for: ".. GetCoinTextureString(cost) )
		end
		RepairAllItems(1)
	end
	local function iRepair_Self()
		if iRepair_Chatter then
			print(" Auto Repair Service You payed: ".. GetCoinTextureString(cost) )
		end
		RepairAllItems()
	end
	if IsModifierKeyDown() then
		return
	elseif CanMerchantRepair() and cost ~= 0 then
		if iRepair_GRF and CanGuildBankRepair() and cost <= GetGuildBankMoney() and (cost <= GetGuildBankWithdrawMoney() or GetGuildBankWithdrawMoney() == -1) then
			if iRepair_ROGR and GetNumRaidMembers() ~= 0 then
				iRepair_Guild()
			elseif not iRepair_ROGR then
				iRepair_Guild()
			elseif cost <= GetMoney() then
				iRepair_Self()
			else
				print(" Not enough Guild Funds to Auto Repair, Please Try Manually.")
			end
		elseif cost <= GetMoney() then
			iRepair_Self()
		else
			print(" Darn you don't have enough cash to Auto Repair. You need "..GetCoinTextureString(cost).." total to repair." )
		end
	end
end)

--[[ Some slash commands ]]
SlashCmdList["FRAME"] = function() print(GetMouseFocus():GetName()) end
SLASH_FRAME1 = "/frame"

SlashCmdList["GETPARENT"] = function() print(GetMouseFocus():GetParent():GetName()) end
SLASH_GETPARENT1 = "/gp"
SLASH_GETPARENT2 = "/parent"

SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

SlashCmdList["RCSLASH"] = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"

SlashCmdList["TICKET"] = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/gm"

--[[ Hiding the Clock]]
if (HideClock == true) then
local name, addon = ...
local event1, event2 = "ADDON_LOADED", "PLAYER_ENTERING_WORLD"
local frame = CreateFrame("Frame")
frame:RegisterEvent(event1)
frame:RegisterEvent(event2)
frame:SetScript("OnEvent", function(self, event, arg1)

	if((event == event2 and name == arg1) or (event==event1)) then
		self:UnregisterEvent(event)
		LoadAddOn("Blizzard_TimeManager")
		TimeManagerClockButton:SetScript("OnUpdate", nil)
		TimeManagerClockButton:SetScript("OnEvent", nil)
		TimeManagerClockButton:SetScript("OnShow", function(self) 
			self:Hide()
		end)
		TimeManagerClockButton:Hide()
		if(event == event1) then
			self:RegisterEvent(event)
		end
	end
end)
end

--[[ MoveQuestObjectiveFrame by XsR ]]
local _G = _G  
  
local pos = { a1 = "TOPLEFT", a2 = "TOPLEFT", af = "UIParent", x = 80, y = -160 }
local watchframeheight = 450
    
local function rQWFM_Tooltip(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:Hide()
end

local function init()
    
    --make the quest watchframe movable
    local wf = _G['WatchFrame']
    wf:SetClampedToScreen(false)
    wf:SetMovable(1)
    wf:SetUserPlaced(true)
    wf:ClearAllPoints()	
    wf.ClearAllPoints = function() end
    wf:SetPoint(pos.a1,pos.af,pos.a2,pos.x,pos.y)
    wf.SetPoint = function() end
    wf:SetHeight(watchframeheight)  
        
    local wfh = _G['WatchFrameHeader']
    wfh:EnableMouse(true)
    wfh:RegisterForDrag("LeftButton")
    wfh:SetHitRectInsets(-15, -15, -5, -5)
    wfh:SetScript("OnDragStart", function(s) 
      local f = s:GetParent()
      f:StartMoving()
    end)
    wfh:SetScript("OnDragStop", function(s) 
      local f = s:GetParent()
      f:StopMovingOrSizing()
    end)
    wfh:SetScript("OnEnter", function(s) 
      rQWFM_Tooltip(s) 
    end)
    wfh:SetScript("OnLeave", function(s) 
      GameTooltip:Hide() 
    end)

end

local a = CreateFrame("Frame")

  a:SetScript("OnEvent", function(self, event)
    if(event=="PLAYER_LOGIN") then
      init()
    end
  end)
  
  a:RegisterEvent("PLAYER_LOGIN")
  
