local debug = true;
local function sysprint(text)
	if (debug == true) then
		print("|cffdaa520WOWKéMON: |r|cff00ffff" .. text .. "|r")
	end
end
local function ting() PlaySoundFile("Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Sounds\\ting.ogg", "Master") end
local function thunk() PlaySoundFile("Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Sounds\\thump.ogg", "Master") end
function WoWkemon_GiveTextShadow(textObject)
	textObject:SetShadowColor(208/255,208/255,200/255,1);
	textObject:SetShadowOffset(3,-3);
end
function WoWkemon_GiveTextDarkEmShadow(textObject)
	textObject:SetShadowColor(104/255,88/255,112/255,1);
	textObject:SetShadowOffset(3,-3);
end
function WoWkemon_GiveTextDarkShadow(textObject)
	textObject:SetShadowColor(112/255,112/255,112/255,1);
	textObject:SetShadowOffset(3,-3);
end
function WoWkemon_GiveTextBrownShadow(textObject)
	textObject:SetShadowColor(216/255,208/255,176/255,1);
	textObject:SetShadowOffset(2,-2);
end
function WoWkemon_SetGMenu(table)
	if (WoWkemon.gmenu) then
		
		local ba = WoWkemon.gmenu.buttons
		local biggest = 5;
		for i,j in ipairs(table) do
			ba[i].text:SetText(j.text)
			if (ba[i].text:GetStringWidth() > biggest) then
				biggest = ba[i].text:GetStringWidth();
			end
			ba[i]:SetScript("OnClick", j.func)
			ba[i]:Show()
		end
		local normal = ((WoWkemon.gmenu:GetWidth())+10+(((21/30)*(50-20))-12))
		-- for i=1,5 do
		-- 	for j=1,50 do ba[i].text:SetTextHeight(j); end
		-- 	while (ba[i].text:IsTruncated() == true) do
		-- 		ba[i].text:SetTextHeight(ba[i].text:GetStringHeight()-1)
		-- 	end
		-- end
		for i = #table+1,5 do ba[i]:Hide() end
		WoWkemon.gmenu.bg:SetPoint("BOTTOMLEFT",WoWkemon.gmenu.buttons[#table],"BOTTOMLEFT",-10,-10)
	end
end
local function abbreviate(text,lim)
	local la = {}

	local abrv = ""
	-- for ca in string.gmatch(text,"%u%a") do
	-- 	table.insert(la,ca)
	-- end
	-- for _,j in ipairs(la) do
	-- 	abrv = abrv .. j .. ". "
	-- end
	if (string.len(text) > lim) then
		return string.sub(text,0,lim-3).."...";
	else
		return text
	end
	
end
local OPA = {
	PET_BATTLE_COMBAT_LOG_AURA_APPLIED = PET_BATTLE_COMBAT_LOG_AURA_APPLIED;
	PET_BATTLE_COMBAT_LOG_AURA_FADES = PET_BATTLE_COMBAT_LOG_AURA_FADES;
	PET_BATTLE_COMBAT_LOG_BLOCKED = PET_BATTLE_COMBAT_LOG_BLOCKED;
	PET_BATTLE_COMBAT_LOG_DAMAGE_CRIT = string.sub(PET_BATTLE_COMBAT_LOG_DAMAGE,0,-2) .. PET_BATTLE_COMBAT_LOG_DAMAGE_CRIT;
	PET_BATTLE_COMBAT_LOG_DAMAGE_STRONG = string.sub(PET_BATTLE_COMBAT_LOG_DAMAGE,0,-2) .. PET_BATTLE_COMBAT_LOG_DAMAGE_STRONG;
	PET_BATTLE_COMBAT_LOG_DAMAGE_WEAK = string.sub(PET_BATTLE_COMBAT_LOG_DAMAGE,0,-2) .. PET_BATTLE_COMBAT_LOG_DAMAGE_WEAK;
	-- PET_BATTLE_COMBAT_LOG_DAMAGE_CRIT = PET_BATTLE_COMBAT_LOG_DAMAGE_CRIT;
	-- PET_BATTLE_COMBAT_LOG_DAMAGE_STRONG = PET_BATTLE_COMBAT_LOG_DAMAGE_STRONG;
	-- PET_BATTLE_COMBAT_LOG_DAMAGE_WEAK = PET_BATTLE_COMBAT_LOG_DAMAGE_WEAK;
	PET_BATTLE_COMBAT_LOG_DAMAGE = PET_BATTLE_COMBAT_LOG_DAMAGE;
	PET_BATTLE_COMBAT_LOG_DEATH = PET_BATTLE_COMBAT_LOG_DEATH;
	PET_BATTLE_COMBAT_LOG_DEFLECT = PET_BATTLE_COMBAT_LOG_DEFLECT;
	PET_BATTLE_COMBAT_LOG_DODGE = PET_BATTLE_COMBAT_LOG_DODGE;
	--PET_BATTLE_COMBAT_LOG_ENEMY = PET_BATTLE_COMBAT_LOG_ENEMY;
	--PET_BATTLE_COMBAT_LOG_ENEMY_LOWER = PET_BATTLE_COMBAT_LOG_ENEMY_LOWER;
	--PET_BATTLE_COMBAT_LOG_ENEMY_TEAM = PET_BATTLE_COMBAT_LOG_ENEMY_TEAM;
	--PET_BATTLE_COMBAT_LOG_ENEMY_TEAM_LOWER = PET_BATTLE_COMBAT_LOG_ENEMY_TEAM_LOWER;
	PET_BATTLE_COMBAT_LOG_HEALING = PET_BATTLE_COMBAT_LOG_HEALING;
	PET_BATTLE_COMBAT_LOG_IMMUNE = PET_BATTLE_COMBAT_LOG_IMMUNE;
	PET_BATTLE_COMBAT_LOG_MISS = PET_BATTLE_COMBAT_LOG_MISS;
	PET_BATTLE_COMBAT_LOG_NEW_ROUND = PET_BATTLE_COMBAT_LOG_NEW_ROUND;
	PET_BATTLE_COMBAT_LOG_PAD_AURA_APPLIED = PET_BATTLE_COMBAT_LOG_PAD_AURA_APPLIED;
	PET_BATTLE_COMBAT_LOG_PAD_AURA_FADES = PET_BATTLE_COMBAT_LOG_PAD_AURA_FADES;
	PET_BATTLE_COMBAT_LOG_PARRY = PET_BATTLE_COMBAT_LOG_PARRY;
	PET_BATTLE_COMBAT_LOG_PET_SWITCHED = PET_BATTLE_COMBAT_LOG_PET_SWITCHED;
	PET_BATTLE_COMBAT_LOG_REFLECT = PET_BATTLE_COMBAT_LOG_REFLECT;
	PET_BATTLE_COMBAT_LOG_TRAP_HIT = PET_BATTLE_COMBAT_LOG_TRAP_HIT;
	PET_BATTLE_COMBAT_LOG_TRAP_MISS = PET_BATTLE_COMBAT_LOG_TRAP_MISS;
	PET_BATTLE_COMBAT_LOG_WEATHER_AURA_APPLIED = PET_BATTLE_COMBAT_LOG_WEATHER_AURA_APPLIED;
	PET_BATTLE_COMBAT_LOG_WEATHER_AURA_FADES = PET_BATTLE_COMBAT_LOG_WEATHER_AURA_FADES;
}
for i,j in pairs(OPA) do 
	j = j:gsub("%(","%%(");
	j = j:gsub("%)","%%)");
	j = j:gsub("%%s","(.+)"); 
	j = j:gsub("%%d","(%%d+)"); 
	--j = j:gsub("%.","%%."); 
	OPA[i] = j; 
end
function WoWkemon_CombatLogEvent(unparsed)
	for i,j in pairs(OPA) do
		if unparsed:match(j) then
			return i;
		end
	end
end
local function split(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end
    if maxNb == nil or maxNb < 1 then
        maxNb = 0    -- No limit
    end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gmatch(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then break end
    end
    -- Handle the last field
    if nb ~= maxNb then
        result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end
local function stime(seconds)

	if (seconds < 60) then
		return "< minute"
	elseif (seconds > 60) and (seconds < 3600) then
		return tostring(math.floor(seconds/60)) .. " minute(s)"
	elseif (seconds > 3600) then
		return math.floor(seconds/3600) .. " hour(s)"
	end
end
local function wlen(dict)
	local int = 0;
	for i,j in pairs(dict) do
		int = int + 1;
	end
	return int;
end
local function valShort(value)
	if(value >= 1e6) then return ("%.2f"):format(value / 1e6):gsub("%.?0+$", "") .. "m"
	elseif(value >= 1e4) then return ("%.1f"):format(value / 1e3):gsub("%.?0+$", "") .. "k"
	else return value end
end
local function themesToMenu()
	local menu = {}
	if (WOWKEMON_CURRENT_THEME_NAME == "none") then
		table.insert(menu,{text = "|cffb8860bNone|r", func = thunk})
	else
		table.insert(menu,{text = "None", func = function()
			if (WOWKEMON_CURRENT_THEME) then
				WOWKEMON_CURRENT_THEME.onUnload(WoWkemon[WOWKEMON_CURRENT_THEME_NAME])
				WOWKEMON_CURRENT_THEME = nil;
				WOWKEMON_CURRENT_THEME_NAME = "none"
				sysprint("Unloaded theme.")
			end
			WoWkemon_SetGMenu(themesToMenu())
		end})
	end
	for i,j in pairs(WOWKEMON_THEMES) do
		if (WOWKEMON_CURRENT_THEME_NAME == i) then
			table.insert(menu,{text = "|cffb8860b" .. abbreviate(WOWKEMON_THEMES[i].usrName,18) .. "|r", func = thunk});
		else
			table.insert(menu,{text = abbreviate(WOWKEMON_THEMES[i].usrName,18), func = function()
				WoWkemon_LoadTheme(i)
				WoWkemon_SetGMenu(themesToMenu())
			end})
		end
	end
	table.insert(menu,{text = "BACK", func = function() WoWkemon_SetGMenu(WoWkemon.gmenu.options) end})
	return menu
end
local WoWkemon_OptionsMenu = {
	{
		text = "THEMES",
		func = function() WoWkemon_SetGMenu(themesToMenu()) end,
	},
	{
		text = "BACK",
		func = function() WoWkemon_SetGMenu(WoWkemon.gmenu.main) end,
	},
}
local WoWkemon_MainMenu = {
	{
		text = "OPTIONS",
		func = function() WoWkemon_SetGMenu(WoWkemon_OptionsMenu) end,
	},
	{
		text = "BAG",
		func = function() ToggleAllBags(); end,
	},
	-- {
	-- 	text = "SAVE",
	-- 	func = function() print("Hello") end,
	-- },
	{
		text = "EXIT",
		func = function() HideUIPanel(GameMenuFrame); end,
	},
}
function WoWkemon_OnEvent(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...;
	
	if (WOWKEMON_CURRENT_THEME) then
		local theme = WOWKEMON_CURRENT_THEME
		
		if (event == "PET_BATTLE_CLOSE") then
			self:Hide();
		elseif (event == "PET_BATTLE_OVER") then

		-- else
		elseif (event == "PET_BATTLE_OPENING_START") then
			-- StartSplashTexture:Hide()
			-- StartSplashTexture.splashAnim:Stop();
			StartSplashTexture:SetAlpha(0)
			_G["PetBattleFrame"]:Hide()
			for i,j in pairs({"initAskBar","initSelectFrame","initBagFrame","initFightBar","initDialogBar","initUnitFrames","initTimer"}) do
				theme[j](WoWkemon[theme.name],1)
			end
			_G["WoWkemon"]:Show()
		elseif (event == "PET_BATTLE_OPENING_DONE") then
		elseif (event == "DISPLAY_SIZE_CHANGED") then
			for i,j in pairs({"initAskBar","initSelectFrame","initBagFrame","initFightBar","initDialogBar","initUnitFrames","initTimer"}) do
				theme[j](WoWkemon[theme.name],1)
			end
		elseif (event == "PET_BATTLE_TURN_STARTED") then
			-- if (WoWkemon_EnemyDead() == false) then
			-- 	WoWkemon_UpdateTimerValues(self.Timer);
			-- end
			--_G["WoWkemon"].IntroFrame:Hide()
		elseif (event == "CHAT_MSG_PET_BATTLE_COMBAT_LOG") then
			lovas = {...}
			np = tostring(lovas[1])
			if (WoWkemon_CombatLogEvent(np)) then
				if (WoWkemon_CombatLogEvent(np):match("PET_BATTLE_COMBAT_LOG_DAMAGE")) then
					local an = string.sub(string.match(np,"%[.+%]"),2,-2)
					local petOwner;
					local fa,fe = false,false;
					for i=1, NUM_BATTLE_PET_ABILITIES do
						local id, name, _, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY), i);
						if ( name ) then
							if name == an then
								fa = true;
								break
							end
						else
						end
					end
					for i=1, NUM_BATTLE_PET_ABILITIES do
						local id, name, _, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY), i);
						if ( name ) then
							if name == an then
								fe = true;
								break
							end
						else
						end
					end
					if (fe == true) and (fa == true) then
						if np:match(PET_BATTLE_COMBAT_LOG_ENEMY_LOWER) then petOwner = LE_BATTLE_PET_ALLY elseif np:match(PET_BATTLE_COMBAT_LOG_YOUR_LOWER) then petOwner = LE_BATTLE_PET_ENEMY; end
					elseif (fe == true) then
						petOwner = LE_BATTLE_PET_ENEMY
					elseif (fa == true) then
						petOwner = LE_BATTLE_PET_ALLY
					end
					local crit = 0;
					if (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_DAMAGE_STRONG") or (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_DAMAGE_CRIT") then crit = 1; elseif (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_DAMAGE_WEAK") then crit = -1; end
					local petName,_ = C_PetBattles.GetName(petOwner, C_PetBattles.GetActivePet(petOwner));
					if (petName) then
						petName = petName:gsub("'","")
						if (crit == 1) then
							theme.dialog(petName .. " used " .. string.upper(an) .. "! It was super effective!",nil,true)
						elseif (crit == -1) then
							theme.dialog(petName .. " used " .. string.upper(an) .. "! It was not very effective...",nil,true)
						else
							theme.dialog(petName .. " used " .. string.upper(an) .. "!",nil,true)
						end
					end
				elseif (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_PAD_AURA_APPLIED") or (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_AURA_APPLIED") then
					local an;
					local id = np:match("HbattlePetAbil:%d+"):match("%d+")
					local _, an = C_PetBattles.GetAbilityInfoByID(id);
					local petOwner;
					local fa,fe = false,false;
					for i=1, NUM_BATTLE_PET_ABILITIES do
						local id, name, _, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY), i);
						if ( name ) then
							if name == an then
								fa = true;
								break
							end
						else
						end
					end
					for i=1, NUM_BATTLE_PET_ABILITIES do
						local id, name, _, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY), i);
						if ( name ) then
							if name == an then
								fe = true;
								break
							end
						else
						end
					end
					if (fe == true) and (fa == true) then
						if np:match(PET_BATTLE_COMBAT_LOG_ENEMY_LOWER) then petOwner = LE_BATTLE_PET_ALLY elseif np:match(PET_BATTLE_COMBAT_LOG_YOUR_LOWER) then petOwner = LE_BATTLE_PET_ENEMY; end
					elseif (fe == true) then
						petOwner = LE_BATTLE_PET_ENEMY
					elseif (fa == true) then
						petOwner = LE_BATTLE_PET_ALLY
					end
					local petName,_ = C_PetBattles.GetName(petOwner, C_PetBattles.GetActivePet(petOwner));
					if (petName) then
						theme.dialog(petName .. " used " .. string.upper(an) .. "!",nil,true)
					end
				elseif (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_WEATHER_AURA_APPLIED") then
					local an;
					local id = np:match("HbattlePetAbil:%d+"):match("%d+")
					local _, an = C_PetBattles.GetAbilityInfoByID(id);
					local petOwner;
					local fa,fe = false,false;
					for i=1, NUM_BATTLE_PET_ABILITIES do
						local id, name, _, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY), i);
						if ( name ) then
							if name == an then
								fa = true;
								break
							end
						else
						end
					end
					for i=1, NUM_BATTLE_PET_ABILITIES do
						local id, name, _, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY), i);
						if ( name ) then
							if name == an then
								fe = true;
								break
							end
						else
						end
					end
					if (fe == true) and (fa == true) then
						if np:match(PET_BATTLE_COMBAT_LOG_ENEMY_LOWER) then petOwner = LE_BATTLE_PET_ALLY elseif np:match(PET_BATTLE_COMBAT_LOG_YOUR_LOWER) then petOwner = LE_BATTLE_PET_ENEMY; end
					elseif (fe == true) then
						petOwner = LE_BATTLE_PET_ENEMY
					elseif (fa == true) then
						petOwner = LE_BATTLE_PET_ALLY
					end
					local petName,_ = C_PetBattles.GetName(petOwner, C_PetBattles.GetActivePet(petOwner));
					if (petName) then
						theme.dialog(petName .. " used " .. string.upper(an) .. "!",nil,true)
					end	
					--end
				elseif (WoWkemon_CombatLogEvent(np):match("TRAP")) then
					if (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_TRAP_MISS") then
						theme.dialog("But it failed...")
						-- local frame = CreateFrame("Frame",nil,UIParent)
						-- frame.time = 0;
						-- frame:SetScript("OnUpdate", function(self,elapsed)
						-- 	self.time = self.time + elapsed;
						-- 	if (self.time >= 2.0) then
						-- 		WoWkemon_TurnComplete()
						-- 		self:SetScript("OnUpdate",nil)
						-- 	end
						-- end)
					elseif (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_TRAP_HIT") then
						local petName,_ = C_PetBattles.GetName(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY));
						if (petName) then
							theme.dialog("Caught wild " .. petName .. "!",nil,true)
						end
					end
				elseif (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_MISS") or (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_DODGE") or (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_BLOCKED") then
					local an;
					local id = np:match("HbattlePetAbil:%d+"):match("%d+")
					local _, an = C_PetBattles.GetAbilityInfoByID(id);
					local petOwner;
					local fa,fe = false,false;
					for i=1, NUM_BATTLE_PET_ABILITIES do
						local id, name, _, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY), i);
						if ( name ) then
							if name == an then
								fa = true;
								break
							end
						else
						end
					end
					for i=1, NUM_BATTLE_PET_ABILITIES do
						local id, name, _, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY), i);
						if ( name ) then
							if name == an then
								fe = true;
								break
							end
						else
						end
					end
					if (fe == true) and (fa == true) then
						if np:match(PET_BATTLE_COMBAT_LOG_ENEMY_LOWER) then petOwner = LE_BATTLE_PET_ALLY elseif np:match(PET_BATTLE_COMBAT_LOG_YOUR_LOWER) then petOwner = LE_BATTLE_PET_ENEMY; end
					elseif (fe == true) then
						petOwner = LE_BATTLE_PET_ENEMY
					elseif (fa == true) then
						petOwner = LE_BATTLE_PET_ALLY
					end
					local crit = 0;
					local petName,_ = C_PetBattles.GetName(petOwner, C_PetBattles.GetActivePet(petOwner));
					petName = petName:gsub("'","")
					theme.dialog(petName .. " used " .. string.upper(an) .. "! But it missed...",nil,true)
				elseif (WoWkemon_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_PET_SWITCHED") then
					local petOwner;
					if np:match(PET_BATTLE_COMBAT_LOG_YOUR_LOWER) then petOwner = LE_BATTLE_PET_ALLY elseif np:match(PET_BATTLE_COMBAT_LOG_ENEMY_LOWER) then petOwner = LE_BATTLE_PET_ENEMY; end
					if np:match(PET_BATTLE_COMBAT_LOG_YOUR_LOWER) then
						local petName,_ = C_PetBattles.GetName(petOwner, C_PetBattles.GetActivePet(petOwner));
						theme.dialog("Go! " .. petName .. "!",nil,true)
					elseif np:match(PET_BATTLE_COMBAT_LOG_ENEMY_LOWER) then
						local petName,_ = C_PetBattles.GetName(petOwner, C_PetBattles.GetActivePet(petOwner));
						if (C_PetBattles.IsWildBattle() == true) then
							theme.dialog(petName .. " jumps forward!",nil,true)
						else
							theme.dialog("Enemy sent out " .. petName .. "!",nil,true)
						end
					end
				end
			end
		end
		theme.onEvent(self[theme.name],event,...)
	end
	if (event == "ADDON_LOADED") and (arg1 == "WoWkemon") then
		sysprint("Done loading. Open the WoW in game menu for options.")
		if (WOWKEMON_CURRENT_THEME_NAME) then
			if (WOWKEMON_CURRENT_THEME_NAME == "none") then
			else
				WoWkemon_LoadTheme(WOWKEMON_CURRENT_THEME_NAME)
			end
		else
			WoWkemon_LoadTheme("Default")
		end
	end
end
function WoWkemon_OnHide(self)
	PetBattlePrimaryUnitTooltip:Hide()
	PetBattlePrimaryAbilityTooltip:Hide()
end
function WoWkemon_OnLoad(self)
	self:RegisterEvent("PET_BATTLE_OPENING_START");
	self:RegisterEvent("PET_BATTLE_OPENING_DONE");
	self:RegisterEvent("PET_BATTLE_TURN_STARTED");
	self:RegisterEvent("PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE");
	self:RegisterEvent("PET_BATTLE_PET_CHANGED");
	self:RegisterEvent("PET_BATTLE_XP_CHANGED");
	self:RegisterEvent("DISPLAY_SIZE_CHANGED");
	self:RegisterEvent("PET_BATTLE_OVER");
	self:RegisterEvent("PET_BATTLE_CLOSE");
	self:RegisterEvent("PET_BATTLE_HEALTH_CHANGED");
	self:RegisterEvent("PET_BATTLE_MAX_HEALTH_CHANGED");
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("CHAT_MSG_PET_BATTLE_COMBAT_LOG");
	self:RegisterEvent("CHAT_MSG_ADDON");
	self:RegisterEvent("PLAYER_LOGOUT");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("PET_BATTLE_AURA_APPLIED");
	self:RegisterEvent("PET_BATTLE_AURA_CANCELED");
	self:RegisterEvent("PET_BATTLE_AURA_CHANGED");
	self:RegisterEvent("PET_BATTLE_AURA_CHANGED");
	self:RegisterEvent("CHAT_MSG_ADDON");
	self:RegisterEvent("FRIENDLIST_UPDATE");
	do
		self.gmenu = CreateFrame("Frame",nil,GameMenuFrame)
		self.gmenu:SetSize((GetScreenHeight()/7)*(420/210),GetScreenHeight()/7)
		self.gmenu:SetPoint("TOP",GameMenuFrame,"TOPRIGHT",GetScreenWidth()/4,0)
		self.gmenu.options = WoWkemon_OptionsMenu;
		self.gmenu.main = WoWkemon_MainMenu;
		-- self.gmenu.bg = self.gmenu:CreateTexture(nil,"OVERLAY",nil,1)
		-- -- self.gmenu.bg:SetTexture("Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Textures\\Splash\\wktitle.tga")
		-- -- self.gmenu.bg:SetTexCoord(0,1,156/512,365/512)
		-- self.gmenu.bg:SetTexture("Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Textures\\Frames\\emselect.tga")
		-- self.gmenu.bg:SetTexCoord(0,1,0,0.78125);
		-- self.gmenu.bg:SetTexCoord(0,1,0,0.78125);
		-- self.gmenu.bg:SetAllPoints(self.gmenu)
		local backdrop = {
		  -- path to the background texture
		  bgFile = "Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Textures\\Frames\\embg.tga",  
		  -- path to the border texture
		  edgeFile = "Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Textures\\Frames\\emborder.tga",
		  -- true to repeat the background texture to fill the frame, false to scale it
		  tile = true,
		  -- size (width or height) of the square repeating background tiles (in pixels)
		  tileSize = 32,
		  -- thickness of edge segments and square size of edge corners (in pixels)
		  edgeSize = 20,
		  -- distance from the edges of the frame to those of the background texture (in pixels)
		  insets = {
		    left = 10,
		    right = 10,
		    top = 10,
		    bottom = 10
		  }
		}
		self.gmenu.bg = CreateFrame("Frame",nil,self.gmenu)
		local bg = self.gmenu.bg
		bg:SetBackdrop(backdrop)
		bg:SetAllPoints(self.gmenu)

		local MenuButtons = {
			{
				ank1 = "TOPRIGHT",
				ank2 = "TOPRIGHT",
				ank12x = -10,
				ank12y = -20,
				refobj = self.gmenu,
				ank3 = "BOTTOMLEFT",
				ank4 = "TOPRIGHT",
				ank34x = (self.gmenu:GetWidth()*-1)+10,
				-- ank34y = -1*math.floor(self.BAGFrames:GetHeight()*0.19375),
				ank34y = -52,
				text = "POOP",
				just = "RIGHT",
				clrr = 0,
				clrg = 0,
				clrb = 0,
				fh = 50,
			},
			{
				ank1 = "TOPRIGHT",
				ank2 = "TOPRIGHT",
				ank12x = -10,
				ank12y = -20,
				refobj = self.gmenu,
				ank3 = "BOTTOMLEFT",
				ank4 = "TOPRIGHT",
				ank34x = (self.gmenu:GetWidth()*-1),
				-- ank34y = -1*math.floor(self.BAGFrames:GetHeight()*0.19375),
				ank34y = -52,
				text = "POOP2",
				just = "RIGHT",
				clrr = 0,
				clrg = 0,
				clrb = 0,
				fh = 50,
			},
			-- {
			-- 	ank1 = "TOPLEFT",
			-- 	ank2 = "BOTTOMLEFT",
			-- 	ank12x = 0,
			-- 	ank12y = -20,
			-- 	refobj = 0,
			-- 	ank3 = "BOTTOMRIGHT",
			-- 	ank4 = "BOTTOMRIGHT",
			-- 	ank34x = 0,
			-- 	ank34y = (-1*math.floor(self.BAGFrames:GetHeight()*0.05625))-20,
			-- 	text = "CLOSE BAG",
			-- 	just = "LEFT",
			-- 	clrr = 0,
			-- 	clrg = 0,
			-- 	clrb = 0,
			-- 	fh = math.floor(self.BAGFrames:GetHeight()*0.05625),
			-- },
		}
		self.gmenu.buttons = {}
		for i=1,5 do
			self.gmenu.buttons[i] = CreateFrame("Button",nil, self.gmenu);
			local button = self.gmenu.buttons[i];
			if (i == 1) then
				button:SetPoint("TOPRIGHT",self.gmenu,"TOPRIGHT",-15,-20)
				button:SetPoint("BOTTOMLEFT",self.gmenu,"TOPRIGHT",(self.gmenu:GetWidth()*-1)+10+((21/30)*(50-20))+12,-60)
			else
				button:SetPoint("TOPRIGHT",self.gmenu.buttons[i-1],"BOTTOMRIGHT")
				button:SetPoint("BOTTOMLEFT",self.gmenu.buttons[i-1],"BOTTOMLEFT",0,self.gmenu.buttons[i-1]:GetHeight()*-1)
			end
			button.text = button:CreateFontString(nil,"OVERLAY",nil,2)
			button.text:SetFont("Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Fonts\\pkmn.ttf",60);
			for i=1,46 do button.text:SetTextHeight(i); end
			button.text:SetAllPoints(button);
			button.text:SetText(i .. "_button");
			button.text:SetTextColor(72/255,72/255,72/255,1);
			button.text:SetJustifyH("RIGHT");
			WoWkemon_GiveTextShadow(button.text)
			button.icon = button:CreateTexture(nil, "ARTWORK");
			button.icon:SetTexture("Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Textures\\arrow.tga")
			button.icon:SetVertexColor(72/255,72/255,72/255,1)
			button.icon:SetHeight(50-20);
			button.icon:SetWidth((21/30)*(50-20));
			button.icon:SetTexCoord(0,0.62890625,0,0.87109375);
			button.icon:SetPoint("RIGHT",button,"LEFT");
			button.icon:Hide();
			button:SetScript( "OnLeave", function(self)
				self.icon:Hide();
			end );
			button:SetScript( "OnEnter", function(self)
				self.icon:Show();
				ting()
			end );
			button:RegisterForClicks("LeftButtonUp")
			button:SetScript( "OnClick", function(self, button, down)
				
			end );
			button:Show()
		end
		
		WoWkemon_SetGMenu(WoWkemon_MainMenu)
		GameMenuFrame:HookScript("OnShow", function()
			WoWkemon.gmenu:Hide()
			if (C_PetBattles.IsInBattle() == false) then
				WoWkemon_SetGMenu(WoWkemon_MainMenu)
				WoWkemon.gmenu:Show()
			end
		end)
		GameMenuFrame:HookScript("OnHide", function()
			WoWkemon.gmenu:Hide()
		end)
	end
	do
		-- WoWkemon.sequence = {"UP","UP","DOWN","DOWN","LEFT","RIGHT","LEFT","RIGHT","B","A"}
		-- WoWkemon.compl = 1;
		-- WoWkemon:SetScript("OnKeyUp",function(self,key)
		-- 	if (GetMouseFocus() == WoWkemon.BattleFrames.Ally) then
		-- 		if (key == self.sequence[self.compl]) then
		-- 			if (self.compl == 10) then
		-- 				PlaySoundFile(_wd() .. "Sounds\\secret.ogg", "Master")
		-- 				self.compl = 1;
		-- 			else
		-- 				self.compl = self.compl + 1
		-- 			end
		-- 		else
		-- 			self.compl = 1
		-- 		end
		-- 	end
		-- end)
	end
end
function WoWkemon_OnShow(self)	
end