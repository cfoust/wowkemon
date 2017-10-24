WOWKEMON_THEMES = {}

local themeTemplate = {
	--Name of the theme
	name = "ExampleWoWkemonTheme",
	usrName = "",
	desc = "",
	--Image that previews the theme
	--Images should be of the ratio 16:9 in size
	--(e.g 32x18,64x36, etc.)
	previewImg = "Path\\To\\Image.tga",
	--Texcoords of that image
	previewImgTCoords = {
		l = 0,
		r = 1,
		t = 0,
		b = 1,
	},
	--This is only a hook. Does not replace my
	--already built battle logic.
	onEvent = function(self, event, ...)
	end,
	--Also only a hook. Feel free to 
	--register whatever events you want, up to you.
	onLoad = function(self)
	end,
	onUnload = function(self)
	end,
	--Fires when WoWkemon, the main frame shows.
	--Only happens when a pet battle starts.
	onShow = function(self)
	end,
	--The following function is called
	--when a tooltip showing a pet's tooltip
	--is shown. See default theme for detailed example.
	--Note: Used to change the look of the tooltips.
	fixBattleTooltip = function(self,petOwner,petIndex)
	end,
	--Same as battle, but for abilities.
	fixBuffTooltip = function(self,petOwner,petIndex)
	end,
	--There are 5 frames in WoWkemon as the default. You are not required
	--to use all of them or even any of them, but they provide a simple
	--means of changing what the user sees through WoWkemon_SetFrame:
	--	1. AskBar
	-- 		The AskBar shows when the player can select an action to do.
	--		(e.g after a turn ends)
	--		I usually manifest it at the bottom of the screen, but the sky's
	--		the limit.
	--	2. FightBar
	-- 		Completely optional. This frame is shown when the user clicks
	--		the FIGHT button in the default theme.
	--		Contains buttons that have all the abilities to use.
	--	3. BagFrame
	-- 		Ususally used as a full-screen frame that shows the pokeball and stuff.
	--	4. SelectFrame
	-- 		For switching pets.
	--	5. DialogBar
	--		If you initialize this and hook its objects into WoWkemon_Dialog(text),
	--		Makes it a lot easier to show things like "ABRA USED TELEPORT"
	--		and the like.
	--	Like I said, you don't need to use any of these at all. They're just convenient,
	--	as they're caked into the addon's original code.
	-- Note: The initialization functions will be passed a number:
	-- 0 for initialization of frames
	-- 1 for resolution-based calculations
	-- The reason for this is that when the user changes resolutions, everything is
	-- recalculated. At theme initialization, both parts of the function are called.
	--Initializes the Ask Bar
	initAskBar = function(self,num)
		if (num == 0) then
			-- Initialization code
		else
			-- Resolution-based calculations
		end
	end,
	--Used to update the ask bar in different ways
	updateAskBar = function(self,text)
	end,
	--Initializes the DialogBar
	initDialogBar = function(self,num)
		if (num == 0) then
			-- Initialization code
		else
			-- Resolution-based calculations
		end
	end,
	dialog = function(text)
		--do something with the text
		-- Used for things like "ABRA USED TELEPORT"
	end,
	--Initializes the FightBar
	initFightBar = function(self,num)
		if (num == 0) then
			-- Initialization code
		else
			-- Resolution-based calculations
		end
	end,
	--Called when the fight bar is shown
	--Update abilities here
	fightBarOnShow = function(self)
	end,
	--Initializes the BagFrame
	initBagFrame = function(self,num)
		if (num == 0) then
			-- Initialization code
		else
			-- Resolution-based calculations
		end
	end,
	--Initializes the SelectFrame
	initSelectFrame = function(self,num)
		if (num == 0) then
			-- Initialization code
		else
			-- Resolution-based calculations
		end
	end,
	selectFrameOnShow = function(self)

	end,
	--Initializes the unit frames
	initUnitFrames = function(self,num)
		if (num == 0) then
			-- Initialization code
		else
			-- Resolution-based calculations
		end
	end,
	updateUnitFrames = function(self)

	end,
	initTimer = function(self,num)
		if (num == 0) then
			-- Initialization code
		else
			-- Resolution-based calculations
		end
	end,
	updateTimer = function(self)
		
	end,
	updateTimerValues = function(self)
		
	end,
	turnComplete = function()

	end,
}
WOWKEMON_CURRENT_THEME = nil;
local function sysprint(text)
	print("|cffdaa520WOWKéMON: |r|cff00ffff" .. text .. "|r")
end
function WoWkemon_RegisterTheme(theme)
	if (type(theme) ~= "table") then error("WoWkemon_RegisterTheme(table) requires a table as argument #1") end
	--Check the validity of the theme
	for i,j in pairs(themeTemplate) do
		if (theme[i]) then
		else
			error("Registered theme does not have a " .. i .. " field, which it needs.")
		end
	end
	if (#WOWKEMON_THEMES > 1) then
		for i,j in pairs(WOWKEMON_THEMES) do
			if (i == theme.name) then
				fnd = true;
				error("Theme already registered.")
			end
		end
		WOWKEMON_THEMES[theme.name] = theme;
	else
		WOWKEMON_THEMES[theme.name] = theme;
	end
	--sysprint("Registered theme: " .. theme.usrName)
end
function WoWkemon_LoadTheme(theme)
	local tarray;
	if (WOWKEMON_CURRENT_THEME) then
		WOWKEMON_CURRENT_THEME.onUnload(WoWkemon[WOWKEMON_CURRENT_THEME_NAME])
	end
	if (WOWKEMON_THEMES[theme]) then
		tarray = WOWKEMON_THEMES[theme];
	else
		error("No such theme: " .. tostring(theme))
	end
	-- for i,j in pairs(WoWkemon) do
	-- 	if (type(j) == "table") then
	-- 		if (j["Hide"]) then j:Hide(); end
	-- 	end
	-- end
	if (WoWkemon[theme]) then
	else
		WoWkemon[theme] = CreateFrame("Frame",nil,WoWkemon)
		WoWkemon[theme]:SetAllPoints(UIParent)
	end
	local result = tarray.onLoad(WoWkemon[theme])
	if (result ~= 1) then
		for i,j in pairs({"initAskBar","initSelectFrame","initBagFrame","initFightBar","initDialogBar","initUnitFrames","initTimer"}) do
			tarray[j](WoWkemon[theme],0)
			tarray[j](WoWkemon[theme],1)
			tarray[j](WoWkemon[theme],2)
		end
	end
	WOWKEMON_CURRENT_THEME = tarray;
	WOWKEMON_CURRENT_THEME_NAME = theme;
	sysprint("Loaded theme: " .. tarray.usrName)
end