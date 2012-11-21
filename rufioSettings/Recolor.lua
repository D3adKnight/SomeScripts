	------------------------------------------------------------
--	FacePaint ~ paints the default interface (w/<3) ~ by Aprikot
	------------------------------------------------------------
	
--	Config
	------
	local class = false  	-- applies player class color scheme (ignores topcolor)
	local gradient = false	-- false applies one solid color (class color if class = true, topcolor if not)
	local topcolor = {  	-- top gradient color (rgb)
		r = 0.3,
		g = 0.3,
		b = 0.3,
	}
	local bottomcolor = {	-- bottom gradient color (rgb)
		r = 0.5,
		g = 0.5,
		b = 0.5,
	}
	local topalpha = 1.0	-- top gradient alpha (global if gradient = false)
	local bottomalpha = 1.0	-- bottom gradient alpha (not used if gradient = false)	
	
	-- Load TimeManager (to color the clock button later)
	if not IsAddOnLoaded("Blizzard_TimeManager") then
		LoadAddOn("Blizzard_TimeManager")
	end
	
--	Objects to paint
	----------------
	local objects = {
	
		-- Rune Bar
		RuneButtonIndividual1:GetRegions(),
		RuneButtonIndividual1Border:GetRegions(),	
		RuneButtonIndividual2:GetRegions(),
		RuneButtonIndividual2Border:GetRegions(),
		RuneButtonIndividual3:GetRegions(),
		RuneButtonIndividual3Border:GetRegions(),
		RuneButtonIndividual4:GetRegions(),
		RuneButtonIndividual4Border:GetRegions(),
		RuneButtonIndividual5:GetRegions(),
		RuneButtonIndividual5Border:GetRegions(),
		RuneButtonIndividual6:GetRegions(),
		RuneButtonIndividual6Border:GetRegions(),

		-- Unit frames
		PlayerFrameTexture,
        select(2, PlayerFrameAlternateManaBar:GetRegions()),
		TargetFrameTextureFrameTexture,
		FocusFrameTextureFrameTexture,
		TargetFrameToTTextureFrameTexture,
		FocusFrameToTTextureFrameTexture,
		PetFrameTexture,
        PartyMemberFrame1Texture,
        PartyMemberFrame2Texture,
        PartyMemberFrame3Texture,
        PartyMemberFrame4Texture,
        
        PartyMemberFrame1PetFrameTexture,
        PartyMemberFrame2PetFrameTexture,
        PartyMemberFrame3PetFrameTexture,
        PartyMemberFrame4PetFrameTexture,
        
        CompactRaidGroup1BorderFrame,
        CompactRaidGroup2BorderFrame,
        CompactRaidGroup3BorderFrame,
        CompactRaidGroup4BorderFrame,
        CompactRaidGroup5BorderFrame,
        CompactRaidGroup6BorderFrame,
        CompactRaidGroup7BorderFrame,
        CompactRaidGroup8BorderFrame,
        
        CompactRaidFrameContainerBorderFrameBorderBottom,
        CompactRaidFrameContainerBorderFrameBorderBottomLeft,
        CompactRaidFrameContainerBorderFrameBorderBottomRight,
        CompactRaidFrameContainerBorderFrameBorderLeft,
        CompactRaidFrameContainerBorderFrameBorderRight,
        CompactRaidFrameContainerBorderFrameBorderTop,
        CompactRaidFrameContainerBorderFrameBorderTopLeft,
        CompactRaidFrameContainerBorderFrameBorderTopRight,

        -- RaidFrameManager
        CompactRaidFrameManagerToggleButton:GetRegions(),
        CompactRaidFrameManagerBg,
        CompactRaidFrameManagerBorderBottom,
        CompactRaidFrameManagerBorderBottomLeft,
        CompactRaidFrameManagerBorderBottomRight,
        CompactRaidFrameManagerBorderRight,
        CompactRaidFrameManagerBorderTopLeft,
        CompactRaidFrameManagerBorderTopRight,
        CompactRaidFrameManagerBorderTop,
		
		-- Minimap
        MiniMapBattlefieldBorder,
        MiniMapLFGFrameBorder,
		MinimapBackdrop,
		MinimapBorder,
		MiniMapMailBorder,
		MiniMapTrackingButtonBorder,
		MinimapBorderTop,
		MinimapZoneTextButton,
		MiniMapWorldMapButton,
		MiniMapWorldMapButton,
		MiniMapWorldIcon,
		MinimapZoomIn:GetRegions(),
		select(3, MinimapZoomIn:GetRegions()),
		MinimapZoomOut:GetRegions(),
		select(3, MinimapZoomOut:GetRegions()),
		TimeManagerClockButton:GetRegions(),
		MiniMapWorldMapButton:GetRegions(),
		select(6, GameTimeFrame:GetRegions()),
		
		-- Action bars
--~ 		ReputationWatchBarTexture0,
--~ 		ReputationWatchBarTexture1,
--~ 		ReputationWatchBarTexture2,
--~ 		ReputationWatchBarTexture3,
		ReputationXPBarTexture0,
		ReputationXPBarTexture1,
		ReputationXPBarTexture2,
		ReputationXPBarTexture3,
		MainMenuBarTexture0,
		MainMenuBarTexture1,
		MainMenuBarTexture2,
		MainMenuBarTexture3,
		MainMenuXPBarTextureRightCap,
		MainMenuXPBarTextureMid,
		MainMenuXPBarTextureLeftCap,
		ActionBarUpButton:GetRegions(),
		ActionBarDownButton:GetRegions(),
		--BonusActionBarFrame:GetRegions(),
		--KeyRingButton:GetRegions(),	
		--select(2, BonusActionBarFrame:GetRegions()),
        
        MainMenuMaxLevelBar0,
        MainMenuMaxLevelBar1,
        MainMenuMaxLevelBar2,
        MainMenuMaxLevelBar3,
        MainMenuBarMaxLevelBar,
        MainMenuBarMaxLevelBarTexture0,
        MainMenuBarMaxLevelBarTexture1,
        MainMenuBarMaxLevelBarTexture2,
        MainMenuBarMaxLevelBarTexture3,
        
        --Rep-Bar
        ReputationWatchBarTexture0,
        ReputationWatchBarTexture1,
        ReputationWatchBarTexture2,
        ReputationWatchBarTexture3,
        		
		-- Exp bubble dividers
		MainMenuXPBarDiv1,
		MainMenuXPBarDiv2,
		MainMenuXPBarDiv3,
		MainMenuXPBarDiv4,
		MainMenuXPBarDiv5,
		MainMenuXPBarDiv6,
		MainMenuXPBarDiv7,
		MainMenuXPBarDiv8,
		MainMenuXPBarDiv9,
		MainMenuXPBarDiv10,
		MainMenuXPBarDiv11,
		MainMenuXPBarDiv12,
		MainMenuXPBarDiv13,
		MainMenuXPBarDiv14,
		MainMenuXPBarDiv15,
		MainMenuXPBarDiv16,
		MainMenuXPBarDiv17,
		MainMenuXPBarDiv18,
		MainMenuXPBarDiv19,
		
		-- Chat frame buttons
		select(2, FriendsMicroButton:GetRegions()),
		ChatFrameMenuButton:GetRegions(),
		ChatFrame1ButtonFrameUpButton:GetRegions(),
		ChatFrame1ButtonFrameDownButton:GetRegions(),
		select(2, ChatFrame1ButtonFrameBottomButton:GetRegions()),
		ChatFrame2ButtonFrameUpButton:GetRegions(),
		ChatFrame2ButtonFrameDownButton:GetRegions(),
		select(2, ChatFrame2ButtonFrameBottomButton:GetRegions()),
		
		-- Chat edit box
--~ 		select(6, ChatFrame1EditBox:GetRegions()),
--~ 		select(7, ChatFrame1EditBox:GetRegions()),
--~ 		select(8, ChatFrame1EditBox:GetRegions()),
--~ 		select(5, ChatFrame1EditBox:GetRegions()),
		
--~ 		-- Micro menu buttons
--~ 		select(2, SpellbookMicroButton:GetRegions()),
--~ 		select(3, CharacterMicroButton:GetRegions()),
--~ 		select(2, TalentMicroButton:GetRegions()),
--~ 		select(2, AchievementMicroButton:GetRegions()),
--~ 		select(2, QuestLogMicroButton:GetRegions()),
--~ 		select(2, GuildMicroButton:GetRegions()),
--~ 		select(3, PVPMicroButton:GetRegions()),
--~ 		select(2, LFDMicroButton:GetRegions()),
--~ 		select(4, MainMenuMicroButton:GetRegions()),
--~ 		select(2, HelpMicroButton:GetRegions()),
		
		-- Other
		select(2,CastingBarFrame:GetRegions()),
		select(2,MirrorTimer1:GetRegions()),
		CastingBarFrameBorder,
		FocusFrameSpellBarBorder,
		TargetFrameSpellBarBorder,
        
	}
	
--	Brighten the class colors
	-------------------------
	if class then
		local classcolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
		topcolor.r, topcolor.g, topcolor.b = (classcolor.r * 1.2), (classcolor.g * 1.2), (classcolor.b * 1.2)
	end

--	Paint function
	--------------
	local paint = function(object)
		object:SetDesaturated(1)
			if gradient then
				object:SetGradientAlpha("VERTICAL", bottomcolor.r, bottomcolor.g, bottomcolor.b, bottomalpha, topcolor.r, topcolor.g, topcolor.b, topalpha)
			else
				object:SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)
			end
	end

--	Execute!
	--------
	local exec = function()
		for i,v in pairs(objects) do
			if v:GetObjectType() == "Texture" then
				paint(v)
			end
		end
	end
	exec()

--	Miscellaneous
	-------------
	-- Calendar button text
	select(5, GameTimeFrame:GetRegions()):SetVertexColor(1, 1, 1)
	
	-- Desaturation fix for elite target texture (thanks SDPhantom!)
	hooksecurefunc("TargetFrame_CheckClassification", function(self)
		self.borderTexture:SetDesaturated(1);
	end);

	
	-- Opposing horizontal gradients for the gryphons <3
	if gradient then
		MainMenuBarLeftEndCap:SetGradientAlpha("HORIZONTAL", bottomcolor.r, bottomcolor.g, bottomcolor.b, bottomalpha, topcolor.r, topcolor.g, topcolor.b, topalpha)
		MainMenuBarRightEndCap:SetGradientAlpha("HORIZONTAL", topcolor.r, topcolor.g, topcolor.b, topalpha, bottomcolor.r, bottomcolor.g, bottomcolor.b, bottomalpha)
	else
		MainMenuBarLeftEndCap:SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)
		MainMenuBarRightEndCap:SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)
	end
	
	-- Game tooltip
	TOOLTIP_DEFAULT_COLOR = { r = topcolor.r * 0.7, g = topcolor.g * 0.7, b = topcolor.b * 0.7 };
	TOOLTIP_DEFAULT_BACKGROUND_COLOR = { r = bottomcolor.r * 0.2, g = bottomcolor.g * 0.2, b = bottomcolor.b * 0.2};
	
	-- ShardBar via SetVertexColor per SetGradientAlpha fail
	select(5,ShardBarFrameShard1:GetRegions()):SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)
	select(5,ShardBarFrameShard2:GetRegions()):SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)
	select(5,ShardBarFrameShard3:GetRegions()):SetVertexColor(topcolor.r, topcolor.g, topcolor.b, topalpha)