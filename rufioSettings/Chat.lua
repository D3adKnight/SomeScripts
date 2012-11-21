--[[ Disable ProfanityFilter ]]
local frame = CreateFrame("FRAME", "DisableProfanityFilter")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
local function eventHandler(self, event, ...)
	
	SetCVar( "profanityFilter", 0)
	BNSetMatureLanguageFilter(false)
	
end
frame:SetScript("OnEvent", eventHandler)

-- [[ Chat ]]
CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0;
CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0;

local clickFunction = function(self) self:GetParent():ScrollToBottom() self:Hide() end;

local function hide(self)
	self:Hide();
end

-- Editbox
local function CleanEditBox(f)
	local chat = f:GetName()
	local editbox = _G[chat..'EditBox']
--[[
	local a, b, c = select(6, editbox:GetRegions())
	a:SetAlpha(0)
	b:SetAlpha(0)
	c:SetAlpha(0)
]]	
	editbox:ClearAllPoints()
	editbox:SetPoint('BOTTOMLEFT', _G.ChatFrame1, 'TOPLEFT', 0, 20)
	editbox:SetPoint('BOTTOMRIGHT', _G.ChatFrame1, 'TOPRIGHT', 0, 20)
	editbox:SetAltArrowKeyMode(false)
		
end

DEFAULT_CHATFRAME_ALPHA = 0 

-- Shorten Channel Names
CHAT_FLAG_AFK = '[AFK] '
CHAT_FLAG_DND = '[DND] '
CHAT_FLAG_GM = '[GM] '

CHAT_SAY_GET = '%s:\32'
CHAT_YELL_GET = '%s:\32'

CHAT_WHISPER_GET = '[from] %s:\32'
CHAT_WHISPER_INFORM_GET = '[to] %s:\32'

CHAT_BN_WHISPER_GET = '[from] %s:\32'
CHAT_BN_WHISPER_INFORM_GET = '[to] %s:\32'

CHAT_GUILD_GET = '[|Hchannel:Guild|hG|h] %s:\32'
CHAT_OFFICER_GET = '[|Hchannel:o|hO|h] %s:\32'

CHAT_PARTY_GET = '[|Hchannel:party|hP|h] %s:\32'
CHAT_PARTY_LEADER_GET = '[|Hchannel:party|hPL|h] %s:\32'
CHAT_PARTY_GUIDE_GET = '[|Hchannel:party|hDG|h] %s:\32'
CHAT_MONSTER_PARTY_GET = '[|Hchannel:raid|hR|h] %s:\32'

CHAT_RAID_GET = '[|Hchannel:raid|hR|h] %s:\32'
CHAT_RAID_WARNING_GET = '[RW!] %s:\32'
CHAT_RAID_LEADER_GET = '[|Hchannel:raid|hL|h] %s:\32'

CHAT_BATTLEGROUND_GET = '[|Hchannel:Battleground|hBG|h] %s:\32'
CHAT_BATTLEGROUND_LEADER_GET = '[|Hchannel:Battleground|hBL|h] %s:\32'

CHAT_YOU_CHANGED_NOTICE_BN = '# |Hchannel:%d|h%s|h'
CHAT_YOU_JOINED_NOTICE_BN = '+ |Hchannel:%d|h%s|h'
CHAT_YOU_LEFT_NOTICE_BN = '- |Hchannel:%d|h%s|h'
CHAT_SUSPENDED_NOTICE_BN = '- |Hchannel:%d|h%s|h'

-- Sticky Channels
ChatTypeInfo.BATTLEGROUND.sticky = 1
ChatTypeInfo.BATTLEGROUND_LEADER.sticky = 1
ChatTypeInfo.CHANNEL.sticky = 1
ChatTypeInfo.GUILD.sticky = 1
ChatTypeInfo.OFFICER.sticky = 1
ChatTypeInfo.PARTY.sticky = 1
ChatTypeInfo.RAID.sticky = 1
ChatTypeInfo.SAY.sticky = 1

local function CleanChat(f)
	f:SetClampRectInsets(0, 0, 0, 0);
	local ff = _G[f:GetName() .. "ButtonFrame"];
	ff:Hide();
	ff:SetScript("OnShow", hide);
	
	CleanEditBox(f)

	local bt = CreateFrame("Button", nil, f);
	bt:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollEnd-Up]]);
	bt:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollEnd-Down]]);
	bt:SetDisabledTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollEnd-Disabled]]);
	bt:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
	bt:SetWidth(25);
	bt:SetHeight(25);
	bt:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0);
	bt:SetScript("OnClick", clickFunction);
	bt:Hide();
	f.downButton = bt;
	
	f.isSkinned = true
end

ChatFrameMenuButton:Hide();
ChatFrameMenuButton:SetScript("OnShow", hide);
FriendsMicroButton:Hide();
FriendsMicroButton:SetScript("OnShow", hide);

for i = 1, NUM_CHAT_WINDOWS do
	local f = _G["ChatFrame" .. i];
	CleanChat(f);
end

hooksecurefunc("FloatingChatFrame_OnMouseScroll", function(self)
	if self:GetCurrentScroll() ~= 0 then
		self.downButton:Show();
	else
		self.downButton:Hide();
	end
end)

-- from Tukui
local function SetupTempChat()
	local frame = FCF_GetCurrentChatFrame()
		
	-- fuck this pet battle window, really... do people really need this shit?
	if _G[frame:GetName().."Tab"]:GetText():match(PET_BATTLE_COMBAT_LOG) then
		FCF_Close(frame)
		return
	end

	-- do a check if we already did a skinning earlier for this temp chat frame
	if frame.isSkinned then return end
	
	-- style it
	CleanChat(frame)
end
hooksecurefunc("FCF_OpenTemporaryWindow", SetupTempChat)

--URL Copy
local color = "C0C0C0"
local pattern = "[wWhH][wWtT][wWtT][\46pP]%S+[^%p%s]"

function string.color(text, color)
	return "|cff"..color..text.."|r"
end

function string.link(text, type, value, color)
	return "|H"..type..":"..tostring(value).."|h"..tostring(text):color(color or "ffffff").."|h"
end

StaticPopupDialogs["LINKME"] = {
	text = "URL COPY",
	button2 = CANCEL,
	hasEditBox = true,
    editBoxWidth = 400,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	whileDead = 1,
	maxLetters = 255,
}

local function f(url)
	return string.link("["..url.."]", "url", url, color)
end

local function hook(self, text, ...)
	self:f(text:gsub(pattern, f), ...)
end

function LinkMeURL()
	for i = 1, NUM_CHAT_WINDOWS do
		if ( i ~= 2 ) then
			local lframe = _G["ChatFrame"..i]
			lframe.f = lframe.AddMessage
			lframe.AddMessage = hook
		end
	end
end
LinkMeURL()

local ur = ChatFrame_OnHyperlinkShow
function ChatFrame_OnHyperlinkShow(self, link, text, button)
	local type, value = link:match("(%a+):(.+)")
	if ( type == "url" ) then
		local dialog = StaticPopup_Show("LINKME")
		local editbox1 = _G[dialog:GetName().."EditBox"]  
		editbox1:SetText(value)
		editbox1:SetFocus()
		editbox1:HighlightText()
		local button = _G[dialog:GetName().."Button2"]
            
		button:ClearAllPoints()
           
		button:SetPoint("CENTER", editbox1, "CENTER", 0, -30)
	else
		ur(self, link, text, button)
	end
end