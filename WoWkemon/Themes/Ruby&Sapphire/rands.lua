local WKMN_TypeIcons = {
	["Undead"] = {
		t = 0,
		b = 55/1024,
	},
	["Flying"] = {
		t = 56/1024,
		b = 111/1024,
	},
	["Water"] = {
		t = 112/1024,
		b = 167/1024,
	},
	["Dragon"] = {
		t = 168/1024,
		b = 223/1024,
	},
	["Critter"] = {
		t = 224/1024,
		b = 279/1024,
	},
	["Elemental"] = {
		t = 280/1024,
		b = 335/1024,
	},
	["Humanoid"] = {
		t = 336/1024,
		b = 391/1024,
	},
	["Mechanical"] = {
		t = 392/1024,
		b = 447/1024,
	},
	["Beast"] = {
		t = 448/1024,
		b = 503/1024,
	},
	["Magical"] = {
		t = 504/1024,
		b = 559/1024,
	},
}
local function CTC(x,y)
	if (y < (-1*(GetScreenHeight()/2))) then
		return x-(GetScreenWidth()/2),y+(GetScreenHeight()/2)
	elseif (y > (-1*(GetScreenHeight()/2))) then
		return x-(GetScreenWidth()/2),(GetScreenHeight()/2)-(y*-1)
	elseif (y == (-1*(GetScreenHeight()/2))) then
		return x-(GetScreenWidth()/2),0
	end
end
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
function WoWkemon_AskClickHandler(self,button,down)
	if (self.text:GetText() == "RUN") then
		WoWkemon_Forfeit()
	elseif (self.text:GetText() == "PASS") then
		C_PetBattles.SkipTurn();
	elseif (self.text:GetText() == "FIGHT") then
		if (self:GetParent():GetParent().Tutorial.id == "fight") then
			WoWkemon_TutorialNextStep()
		end
		WoWkemon_SetFrame("FightBar")
	elseif (self.text:GetText() == "BAG") then
		if (self:GetParent():GetParent().Tutorial.id == "bag") then
			WoWkemon_TutorialNextStep()
		end
		WoWkemon_SetFrame("BagFrame")
	--elseif (self.text:GetText() == "₧₦") then
	elseif (self.text:GetText() == "WOWKéMON") then
		if (self:GetParent():GetParent().Tutorial.id == "wkmn") then
			WoWkemon_TutorialNextStep()
		end
		WoWkemon_SetFrame("SelectFrame")
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
local function abbreviate(text)
	local la = {}

	local abrv = ""
	for ca in string.gmatch(text,"%u%a") do
		table.insert(la,ca)
	end
	for _,j in ipairs(la) do
		abrv = abrv .. j .. ". "
	end
	return abrv;
end
local function _n(s) 
	if s then 
		return "WoWkemon" .. s
	else 
		return "WoWkemon"
	end
end
local function wlen(dict)
	local int = 0;
	for i,j in pairs(dict) do
		int = int + 1;
	end
	return int;
end
local function _wd() return "Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\" end
local function ting() PlaySoundFile(_wd() .. "Sounds\\ting.ogg", "Master") end
local function thunk() PlaySoundFile(_wd() .. "Sounds\\thump.ogg", "Master") end
local function valShort(value)
	if(value >= 1e6) then return ("%.2f"):format(value / 1e6):gsub("%.?0+$", "") .. "m"
	elseif(value >= 1e4) then return ("%.1f"):format(value / 1e3):gsub("%.?0+$", "") .. "k"
	else return value end
end
local function ccon(dict)
	local fnd = false;
	for i,j in pairs(dict) do
		if (j ~= nil) then
			fnd = true;
		end
	end
	return fnd;
end
function WoWkemon_SetFrame(frame)
	local framelist = {
	"AskBar",
	"FightBar",
	"BagFrame",
	"SelectFrame",
	"DialogBar",
	}
	for i,j in pairs(framelist) do
		if (WoWkemon["Ruby&Sapp"]:IsVisible() == 1) then
			if (j ~= frame) then
				WoWkemon["Ruby&Sapp"][j]:Hide();
			else
				WoWkemon["Ruby&Sapp"][j]:Show();
			end
		end
	end
end
function WoWkemon_StatusColors(statusBar, health, maxHealth)
	if ((health/maxHealth) >= .50) then
		statusBar:SetStatusBarColor(112/255,248/255,168/255,1)
	elseif ((health/maxHealth) >= .30) then
		statusBar:SetStatusBarColor(248/255,224/255,56/255,1)
	elseif ((health/maxHealth) < .30) then
		statusBar:SetStatusBarColor(248/255,88/255,56/255,1)
	end
end
function WoWkemon_UpdateAskBar(text)
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
	local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, activePet);
	local self = WoWkemon["Ruby&Sapp"].AskBar
	if (name) then
		if name:match("'") then
			name = name:gsub("'","")
		end
	end
	local fs = WoWkemon["Ruby&Sapp"].AskBar.willdo
	fs:SetWordWrap(true)
	if (text) then
		fs:SetText(text)
	else
		fs:SetText("What will \n" .. name .. " do?");
	end
	for i=1,(self.wdh/48)*self:GetHeight() do self.willdo:SetTextHeight(i); end
	while (fs:IsTruncated() == true) do
		if ((fs:GetStringHeight()-1) > 0) then
			fs:SetTextHeight(fs:GetStringHeight()-1)
		else
			----print("Cannot fit, resetting")
			if (text) then
				fs:SetText(text)
			else
				fs:SetText("What will \n" .. abbreviate(name) .. "do?");
			end
			local self = WoWkemon["Ruby&Sapp"].AskBar
			for i=1,(self.wdh/48)*self:GetHeight() do self.willdo:SetTextHeight(i); end
			self.willdo:SetFont(_wd() .. "Fonts\\pkmn.ttf",(self.wdh/48)*self:GetHeight());
		end
	end
	do
		local ubcnt,ncnt = 0,0;
		for i=1,3 do
			if (C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, activePet, i)) then
				local isUsable, currentCooldown = C_PetBattles.GetAbilityState(LE_BATTLE_PET_ALLY, activePet, i);
				if (isUsable == false) then
					ubcnt = ubcnt + 1;
				end
			else
				ncnt = ncnt + 1;
			end
		end
		----print(string.format("Total abilities: %d Unusable abilities: %d",(3-ncnt),ubcnt))
		if (ubcnt == (3-ncnt)) then
			--self.buttons[1]:Disable()
			self.buttons[1].text:SetTextColor(208/255,208/255,200/255,1);
			self.buttons[1]:SetScript( "OnLeave", nil);
			self.buttons[1]:SetScript( "OnEnter", nil);
			self.buttons[1]:SetScript( "OnClick", nil);
		else
			--self.buttons[1]:Enable()
			self.buttons[1].text:SetTextColor(72/255,72/255,72/255,1);
			self.buttons[1]:SetScript( "OnClick", function (zalf,button,down)
				WoWkemon_AskClickHandler(zalf,button,down);
			end);
			self.buttons[1]:SetScript( "OnLeave", function(self)
				self.icon:Hide();
			end );
			self.buttons[1]:SetScript( "OnEnter", function(self)
				self.icon:Show();
				ting()
			end );
		end
	end
	do
		local usable = C_PetBattles.IsWildBattle();
		local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, activePet);
		
		if (C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == false) or (health == 0) then
			self.buttons[2]:Disable()
			self.buttons[2].text:SetTextColor(208/255,208/255,200/255,1);
			self.buttons[2]:SetScript( "OnLeave", nil);
			self.buttons[2]:SetScript( "OnEnter", nil);
			self.buttons[2]:SetScript( "OnClick", nil);
		else
			self.buttons[2]:Enable()
			self.buttons[2].text:SetTextColor(72/255,72/255,72/255,1);
			self.buttons[2]:SetScript( "OnClick", function (zalf,button,down)
				WoWkemon_AskClickHandler(zalf,button,down);
			end);
			self.buttons[2]:SetScript( "OnLeave", function(self)
				self.icon:Hide();
			end );
			self.buttons[2]:SetScript( "OnEnter", function(self)
				self.icon:Show();
				ting()
			end );
		end
	end
	do
		local numPets = C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY);
		local altpets,cantpets = 0,0;
		for i=1, numPets do
			if (i ~= C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)) then
				if (C_PetBattles.CanPetSwapIn(i) == false) then
					cantpets = cantpets + 1;
				end
				altpets = altpets + 1;
			end
		end
		if (altpets == cantpets) then
			--self.buttons[3]:Disable()
			self.buttons[3].text:SetTextColor(208/255,208/255,200/255,1);
			self.buttons[3]:SetScript( "OnLeave", nil);
			self.buttons[3]:SetScript( "OnEnter", nil);
			self.buttons[3]:SetScript( "OnClick", nil);
		else
			--self.buttons[3]:Enable()
			self.buttons[3].text:SetTextColor(72/255,72/255,72/255,1);
			self.buttons[3]:SetScript( "OnClick", function (zalf,button,down)
				WoWkemon_AskClickHandler(zalf,button,down);
			end);
			self.buttons[3]:SetScript( "OnLeave", function(self)
				self.icon:Hide();
			end );
			self.buttons[3]:SetScript( "OnEnter", function(self)
				self.icon:Show();
				ting()
			end );
		end
	end
end
function WoWkemon_FixBattleTooltip(self, petOwner, petIndex)
	local ttp = self
	--if not (self.bg) then
	-- do
	-- 	self.bg = CreateFrame("Frame",nil,self)
	-- 	self.bg:SetAllPoints(self)
	-- 	local backdrop = {
	-- 	  -- path to the background texture
	-- 	  bgFile = "Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Textures\\Frames\\embg.tga",  
	-- 	  -- path to the border texture
	-- 	  edgeFile = "Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Textures\\Frames\\emborder.tga",
	-- 	  -- true to repeat the background texture to fill the frame, false to scale it
	-- 	  tile = true,
	-- 	  -- size (width or height) of the square repeating background tiles (in pixels)
	-- 	  tileSize = 32,
	-- 	  -- thickness of edge segments and square size of edge corners (in pixels)
	-- 	  edgeSize = 20,
	-- 	  -- distance from the edges of the frame to those of the background texture (in pixels)
	-- 	  insets = {
	-- 	    left = 10,
	-- 	    right = 10,
	-- 	    top = 10,
	-- 	    bottom = 10
	-- 	  }
	-- 	}
	-- 	self.bg:SetBackdrop(backdrop)
	-- 	self.bg:SetFrameStrata("LOW")
	-- end
	do--Sets up the background
		ttp.Background:SetTexture(_wd() .. "Textures\\Frames\\emselect.tga");
		ttp.Background:SetTexCoord(0,1,0,200/256);
		--ttp.Background:SetVertTile(true)
		ttp.Background:SetPoint("TOPLEFT",ttp,"TOPLEFT",-20,20)
		ttp.Background:SetPoint("BOTTOMRIGHT",ttp,"BOTTOMRIGHT",20,-20)
	end
	do--Hides the old one
		for _,j in ipairs({"BorderTopLeft","BorderTopRight","BorderBottomRight","BorderBottomLeft","BorderTop","BorderRight","BorderBottom","BorderLeft",}) do
			ttp[j]:SetAlpha(0)
		end
	end
	do--Fixes all the fonts
		for _,j in ipairs({"Name","SpeciesName","AttackAmount","SpeedAmount","SpeedAdvantage","StatsLabel","AbilitiesLabel",}) do
			ttp[j]:SetTextColor(72/255,72/255,72/255,1);
			if (j ~= "SpeedAdvantage") then
				ttp[j]:SetFont(_wd() .. "Fonts\\pkmn.ttf",20);
			else
				ttp[j]:SetFont(_wd() .. "Fonts\\pkmn.ttf",15);
			end
			WoWkemon_GiveTextShadow(ttp[j])
		end
		for _,j in ipairs({"XPText","HealthText",}) do
			ttp[j]:SetFont(_wd() .. "Fonts\\pkmn.ttf",20);
			ttp[j]:SetTextColor(72/255,72/255,72/255,1);
			ttp[j]:SetShadowColor(0,0,0,0);
			ttp[j]:SetShadowOffset(0,0);
			ttp[j]:SetJustifyV("CENTER")
			ttp[j]:SetJustifyH("CENTER")
		end
		ttp.HealthText:ClearAllPoints()
		ttp.HealthText:SetPoint("LEFT",ttp.ActualHealthBar,"LEFT",5,0)
		ttp.XPText:SetText("")
		local health,maxHealth = C_PetBattles.GetHealth(petOwner, petIndex), C_PetBattles.GetMaxHealth(petOwner, petIndex);
		ttp.HealthText:SetText(health .. "/ " ..maxHealth);
		local enemyPetType = C_PetBattles.GetPetType(PetBattleUtil_GetOtherPlayer(petOwner), C_PetBattles.GetActivePet(PetBattleUtil_GetOtherPlayer(petOwner)));
		for i=1, NUM_BATTLE_PET_ABILITIES do
			local text = ttp["AbilityName"..i];
			text:SetTextColor(72/255,72/255,72/255,1);
			text:SetFont(_wd() .. "Fonts\\pkmn.ttf",20);
			WoWkemon_GiveTextShadow(text)
			local icon = ttp["AbilityIcon"..i];
			local id, name, _, maxCooldown, description, numTurns, abilityPetType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(petOwner, petIndex, i);
			if ( id ) then
				local modifier = 1.0;
				if (abilityPetType and enemyPetType) then
					modifier = C_PetBattles.GetAttackModifier(abilityPetType, enemyPetType);
				end
				if ( noStrongWeakHints or modifier == 1 ) then
					icon:SetTexture("");
				elseif ( modifier < 1 ) then
					icon:SetTexture(_wd() .. "Textures\\Icons\\weak.tga");
				elseif ( modifier > 1 ) then
					icon:SetTexture(_wd() .. "Textures\\Icons\\strong.tga");
				end
			else
				
			end
		end
	end
	ttp.PetType:SetSize(37,37)
	local petType = C_PetBattles.GetPetType(petOwner, petIndex);
	--ttp.PetType.Icon:SetTexture(ttp.PetType.Icon:GetTexture():gsub("Interface\\PetBattles\\",_wd() .. "Textures\\Icons\\") .. ".tga");
	local FixType = function(self)
		ttp.PetType.Icon:SetTexture(_wd() .. "Textures\\Icons\\icons.tga")
		ttp.PetType.Icon:SetTexCoord(0,1,WKMN_TypeIcons[PET_TYPE_SUFFIX[petType]].t,WKMN_TypeIcons[PET_TYPE_SUFFIX[petType]].b)
		ttp.PetType:SetSize(ttp.PetType:GetWidth(),math.floor((14/32)*ttp.PetType:GetWidth()))
	end
	if (WOWKEMON_TUTORIAL) then
		if (WOWKEMON_TUTORIAL["coerul"]) then
			if (WOWKEMON_TUTORIAL["coerul"] == true) then
				ttp.PetType:SetSize(37,37)
				ttp.PetType.Icon:SetTexture(ttp.PetType.Icon:GetTexture():gsub("Interface\\PetBattles\\",_wd() .. "Textures\\Icons\\") .. ".tga");
				ttp.PetType.Icon:SetTexCoord(0.79687500,0.49218750,0.50390625,0.65625000);
			else
				FixType(self)
			end
		end
	else
		FixType(self)
	end
	do--Fixes StatusBars
		local hp = ttp.ActualHealthBar
		hp:SetTexture(_wd() .. "Textures\\Select\\barbg.tga")
		if ((hp:GetWidth()/ttp.healthBarWidth) >= .50) then
			hp:SetVertexColor(112/255,248/255,168/255,1)
		elseif ((hp:GetWidth()/ttp.healthBarWidth) >= .30) then
			hp:SetVertexColor(248/255,224/255,56/255,1)
		elseif ((hp:GetWidth()/ttp.healthBarWidth) < .30) then
			hp:SetVertexColor(248/255,88/255,56/255,1)
		end
	end
	ttp.XPBar:SetTexture(_wd() .. "Textures\\Select\\barbg.tga")
	ttp.XPBar:SetVertexColor(64/255,200/255,248/255,1)
	if (C_PetBattles.IsWildBattle()) and (petOwner == LE_BATTLE_PET_ENEMY) then
		local name, speciesName = C_PetBattles.GetName(petOwner, petIndex);
		local opc = C_PetBattles.GetBreedQuality(petOwner, petIndex) - 1
		local r, g, b, hex = GetItemQualityColor(opc)
		if (hex) and (name) then
			ttp.Name:SetText(name .. "|c" .. hex .. "☆" .. "|r")
		end
		if (ttp.Name:IsTruncated() == true) then
			ttp.Name:SetText(abbreviate(name) .. "|c" .. hex .. "☆" .. "|r")
		end
	end
	if (ttp.Name:IsTruncated() == true) then
		ttp.Name:SetText(abbreviate(ttp.Name:GetText()))
	end
	for i=1,20 do ttp.Name:SetTextHeight(i) end
	for i=1,20 do ttp.SpeciesName:SetTextHeight(i) end
	for i=1,20 do ttp.XPText:SetTextHeight(i) end
	for i=1,20 do ttp.HealthText:SetTextHeight(i) end
end
function WoWkemon_FixBuffTooltip(self,abilityInfo,additionalText)
	local ttp = self
	local abilityID = abilityInfo:GetAbilityID();
	if ( not abilityID ) then
		return;
	end
	local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID(abilityID);
	
	do--Sets up the background
		ttp.Background:SetTexture(_wd() .. "Textures\\Frames\\emselect.tga");
		ttp.Background:SetTexCoord(0,1,0,200/256);
		ttp.Background:SetPoint("TOPLEFT",ttp,"TOPLEFT",-20,20)
		ttp.Background:SetPoint("BOTTOMRIGHT",ttp,"BOTTOMRIGHT",20,-20)
	end
	do--Hides the old one
		for _,j in ipairs({"BorderTopLeft","BorderTopRight","BorderBottomRight","BorderBottomLeft","BorderTop","BorderRight","BorderBottom","BorderLeft",}) do
			ttp[j]:SetAlpha(0)
		end
	end
	do--Fixes all the fonts
		for _,j in ipairs({"Name","Duration","MaxCooldown","CurrentCooldown","AdditionalText","Description","StrongAgainstType1Label","WeakAgainstType1Label",}) do
			if (j == "Description") then
				ttp[j]:SetText(ttp[j]:GetText():gsub("|cFF[%a%d][%a%d][%a%d][%a%d][%a%d][%a%d]",""))
				ttp[j]:SetText(ttp[j]:GetText():gsub("|r",""))
				ttp[j]:SetText(ttp[j]:GetText():gsub("Interface\\PetBattles\\BattleBar%-AbilityBadge%-Weak.blp",_wd() .. "Textures\\Icons\\weak.tga"))
				ttp[j]:SetText(ttp[j]:GetText():gsub("Interface\\PetBattles\\BattleBar%-AbilityBadge%-Strong.blp",_wd() .. "Textures\\Icons\\strong.tga"))
			end
			ttp[j]:SetTextColor(72/255,72/255,72/255,1);
			if (j ~= "SpeedAdvantage") then
				ttp[j]:SetFont(_wd() .. "Fonts\\pkmn.ttf",20);
			else
				ttp[j]:SetFont(_wd() .. "Fonts\\pkmn.ttf",15);
			end
			WoWkemon_GiveTextShadow(ttp[j])
		end
		local FixIcons = function(self)
			if (ttp.StrongAgainstType1:GetTexture()) then
				for i,j in pairs(WKMN_TypeIcons) do
					if (ttp.StrongAgainstType1:GetTexture():match(i)) then
						ttp.StrongAgainstType1:SetTexture(_wd() .. "Textures\\Icons\\icons.tga")
						ttp.StrongAgainstType1:SetTexCoord(0,1,j.t,j.b)
						ttp.StrongAgainstType1:SetSize(ttp.StrongAgainstType1:GetWidth(),math.floor((14/32)*ttp.StrongAgainstType1:GetWidth()))
					end
				end
			end
			if (ttp.WeakAgainstType1:GetTexture()) then
				for i,j in pairs(WKMN_TypeIcons) do
					if (ttp.WeakAgainstType1:GetTexture():match(i)) then
						ttp.WeakAgainstType1:SetTexture(_wd() .. "Textures\\Icons\\icons.tga")
						ttp.WeakAgainstType1:SetTexCoord(0,1,j.t,j.b)
						ttp.WeakAgainstType1:SetSize(ttp.WeakAgainstType1:GetWidth(),math.floor((14/32)*ttp.WeakAgainstType1:GetWidth()))
					end
				end
			end
			if ( petType and petType > 0 ) then
				self.AbilityPetType:SetTexture(_wd() .. "Textures\\Icons\\icons.tga")
				self.AbilityPetType:SetTexCoord(0,1,WKMN_TypeIcons[PET_TYPE_SUFFIX[petType]].t,WKMN_TypeIcons[PET_TYPE_SUFFIX[petType]].b)
				self.AbilityPetType:SetSize(self.AbilityPetType:GetWidth(),math.floor((14/32)*self.AbilityPetType:GetWidth()))
			end
		end
		if (WOWKEMON_TUTORIAL) then
			if (WOWKEMON_TUTORIAL["coerul"]) then
				if (WOWKEMON_TUTORIAL["coerul"] == true) then
					if (ttp.StrongAgainstType1:GetTexture()) then
						if (ttp.StrongAgainstType1:GetTexture():gsub("Interface\\PetBattles\\",_wd() .. "Textures\\Icons\\")) then 
							ttp.StrongAgainstType1:SetTexture(ttp.StrongAgainstType1:GetTexture():gsub("Interface\\PetBattles\\",_wd() .. "Textures\\Icons\\") .. ".tga");
							ttp.StrongAgainstType1:SetTexCoord(0.79687500,0.49218750,0.50390625,0.65625000);
						end
					end
					if (ttp.WeakAgainstType1:GetTexture()) then
						if (ttp.WeakAgainstType1:GetTexture():gsub("Interface\\PetBattles\\",_wd() .. "Textures\\Icons\\")) then 
							ttp.WeakAgainstType1:SetTexture(ttp.WeakAgainstType1:GetTexture():gsub("Interface\\PetBattles\\",_wd() .. "Textures\\Icons\\") .. ".tga"); 
							ttp.WeakAgainstType1:SetTexCoord(0.79687500,0.49218750,0.50390625,0.65625000);
						end
					end
					if ( petType and petType > 0 ) then
						self.AbilityPetType:SetTexture(_wd() .. "Textures\\Icons\\PetIcon-"..PET_TYPE_SUFFIX[petType]);
					end
				else
					FixIcons(self)
				end
			end
		else
			FixIcons(self)
		end
		
		ttp.WeakAgainstIcon:SetTexture(_wd() .. "Textures\\Icons\\weak.tga");
		ttp.StrongAgainstIcon:SetTexture(_wd() .. "Textures\\Icons\\strong.tga");
	end
end
function WoWkemon_SetAbilitySize(value)
	for i=1,4 do
		WoWkemon["Ruby&Sapp"].FightBar.buttons[i].text:SetTextHeight(math.floor(value))
	end
end
function WoWkemon_EnableAskButtons(self)
	for i=1,4 do
		self.AskBar.buttons[i].text:SetTextColor(72/255,72/255,72/255,1);
		self.AskBar.buttons[i]:SetScript( "OnClick", function (zalf,button,down)
			WoWkemon_AskClickHandler(zalf,button,down);
		end);
		self.AskBar.buttons[i]:SetScript( "OnLeave", function(self)
			self.icon:Hide();
		end );
		self.AskBar.buttons[i]:SetScript( "OnEnter", function(self)
			self.icon:Show();
			ting()
		end );
	end
end
function WoWkemon_DisableAskButtons(self)
	for i=1,4 do
		self.AskBar.buttons[i].text:SetTextColor(208/255,208/255,200/255,1);
		self.AskBar.buttons[i]:SetScript( "OnLeave", nil);
		self.AskBar.buttons[i]:SetScript( "OnEnter", nil);
		self.AskBar.buttons[i]:SetScript( "OnClick", nil);
	end
end
function WoWkemon_Dialog(text, func, is)
	WoWkemon_SetFrame("DialogBar")
	text = text:gsub("'","")
	local self = WoWkemon["Ruby&Sapp"].DialogBar
	self.Dialog:SetText("...")
	self.prompt = false
	self.finished = false;
	self.text = text;
	self.si = 1;
	self.sa = 1;
	if (GetFramerate() > 30) then
		self:SetScript("OnUpdate", function(self)
			self.sa = self.sa + 1;
			if (self.finished == false) then
				if (self.si ~= string.len(self.text)+1) then
					self.Dialog:SetText(string.sub(self.text,1,self.si))
					self.si = self.si + 1;
				else
					self.finished = true;
				end
			end
		end);
	else
		self.Dialog:SetText(text)
		self.finished = true;
	end
	if (is) then
		self.Dialog:SetText(text)
		self.finished = true;
		self:SetScript("OnUpdate", nil)
	end
	if (text == "But it failed...") then
		func = WoWkemon_TurnComplete;
	end
	if (func) then
		self.prompt = true;
		if (self.button == nil) then
			self.button = CreateFrame("Button",nil,self)
		end
		self.button:SetAllPoints(UIParent)
		self.button:SetFrameStrata("HIGH")
		self.button:RegisterForClicks("AnyUp")
		self.button:EnableMouse(true)
		self.button:SetScript("OnClick",function(self,button,down)
			if (self:GetParent().finished == true) then func(self,button); end
		end);
	else
		if (self.button) then
			self.button:EnableMouse(false)
			self.button:SetScript("OnClick",nil);
		end
	end
	self.arrow:Show()
end
function WoWkemon_UpdateAbilities(self)
	if not self then self = WoWkemon["Ruby&Sapp"].FightBar end
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
	local abilities = {}
	for i=1,3 do
		if (C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, activePet, i)) then
			local isUsable, currentCooldown = C_PetBattles.GetAbilityState(LE_BATTLE_PET_ALLY, activePet, i);
			local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, activePet, i);
			local ability = {}
			ability["id"] = id;
			ability["name"] = name;
			ability["icon"] = icon;
			ability["petType"] = petType;
			ability["maxCooldown"] = maxCooldown;
			ability["currentCooldown"] = currentCooldown;
			ability["isUsable"] = isUsable;
			ability["numTurns"] = numTurns;
			table.insert(abilities,ability)
		end
	end
	local nsz = 55;
	for i = 1, 3 do
		local fbut = WoWkemon["Ruby&Sapp"].FightBar.buttons[i]
		local ttb = WoWkemon["Ruby&Sapp"].FightBar.topTextB
		if (abilities[i]) then
			fbut.text:SetText(string.upper(abilities[i]["name"]));
			if (abilities[i]["isUsable"] == true) then
				fbut:SetScript( "OnClick", function(self, button, down)
					if (button == "RightButton") then
						if (WoWkemon["Ruby&Sapp"].Tutorial.id == "rcab") then
							WoWkemon_TutorialNextStep()
						end
						WoWkemon_SetFrame("AskBar")
					else
						C_PetBattles.UseAbility(i);
						local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
						local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, activePet);
						if (name) then
							if name:match("'") then
								name = name:gsub("'","")
							end
						end
						WoWkemon["Ruby&Sapp"].FightBar:Hide()
					end
				end );
				fbut:SetScript( "OnLeave", function(self)
					PetBattlePrimaryAbilityTooltip:Hide();
					fbut.icon:Hide();
					ttb:SetText("TYPE/--")
					WoWkemon["Ruby&Sapp"].FightBar.topTextR:SetTextColor(72/255,72/255,72/255,1);
					WoWkemon["Ruby&Sapp"].FightBar.topTextR:SetText("--");
					for i=1,(120/160)*self:GetHeight() do ttb:SetTextHeight(i); end
				end );
				fbut:SetScript( "OnEnter", function(self)
					local petIndex = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
					if ( self:GetEffectiveAlpha() > 0 and C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, petIndex, i) ) then
						if (WoWkemon["Ruby&Sapp"].Tutorial.id == "shit") then
							WoWkemon_TutorialNextStep()
						end
						PetBattleAbilityTooltip_SetAbility(LE_BATTLE_PET_ALLY, petIndex, i);
						PetBattleAbilityTooltip_Show("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -20, 20, self.additionalText);
					else
						PetBattlePrimaryAbilityTooltip:Hide();
					end
					fbut.icon:Show();
					for i=1,(120/160)*self:GetHeight() do ttb:SetTextHeight(i); end
					
					if (C_PetBattles.GetAttackModifier(abilities[i]["petType"],C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))) > 1) then
						ttb:SetText("TYPE/|cFF00FF00" .. string.upper(PET_TYPE_SUFFIX[abilities[i]["petType"]]) .. "|r")
					elseif (C_PetBattles.GetAttackModifier(abilities[i]["petType"],C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))) < 1) then
						ttb:SetText("TYPE/|cFFFF0000" .. string.upper(PET_TYPE_SUFFIX[abilities[i]["petType"]]) .. "|r")
					else
						ttb:SetText("TYPE/" .. string.upper(PET_TYPE_SUFFIX[abilities[i]["petType"]]))
					end
					for i=1,(120/160)*self:GetHeight() do ttb:SetTextHeight(i); end
					if (ttb:IsTruncated()==true) then
						counter = 0;
						while (ttb:IsTruncated()==true) and counter < 1000 do
							ttb:SetTextHeight(math.floor(ttb:GetStringHeight())-5)
							counter = counter + 1;
						end
					end
					WoWkemon["Ruby&Sapp"].FightBar.topTextR:SetTextColor(72/255,72/255,72/255,1);
					WoWkemon["Ruby&Sapp"].FightBar.topTextR:SetText(abilities[i]["maxCooldown"])
					ting()
				end );
			else
				fbut:SetScript( "OnClick", function(self, button, down)
					if (button == "RightButton") then
						if (WoWkemon["Ruby&Sapp"].Tutorial.id == "rcab") then
							WoWkemon_TutorialNextStep()
						end
						WoWkemon_SetFrame("AskBar")
					end
					thunk()
				end );
				fbut:SetScript( "OnLeave", function(self)
					fbut.icon:Hide();
					ttb:SetText("TYPE/--")
					WoWkemon["Ruby&Sapp"].FightBar.topTextR:SetTextColor(72/255,72/255,72/255,1);
					WoWkemon["Ruby&Sapp"].FightBar.topTextR:SetText("--");
					for i=1,(120/160)*self:GetHeight() do ttb:SetTextHeight(i); end
				end );
				fbut:SetScript( "OnEnter", function(self)
					local petIndex = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
					if ( self:GetEffectiveAlpha() > 0 and C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, petIndex, i) ) then
						if (WoWkemon["Ruby&Sapp"].Tutorial.id == "shit") then
							WoWkemon_TutorialNextStep()
						end
						PetBattleAbilityTooltip_SetAbility(LE_BATTLE_PET_ALLY, petIndex, i);
						PetBattleAbilityTooltip_Show("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -20, 20, self.additionalText);
					else
						PetBattlePrimaryAbilityTooltip:Hide();
					end
					if (C_PetBattles.GetAttackModifier(abilities[i]["petType"],C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))) > 1) then
						ttb:SetText("TYPE/|cFF00FF00" .. string.upper(PET_TYPE_SUFFIX[abilities[i]["petType"]]) .. "|r")
					elseif (C_PetBattles.GetAttackModifier(abilities[i]["petType"],C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))) < 1) then
						ttb:SetText("TYPE/|cFFFF0000" .. string.upper(PET_TYPE_SUFFIX[abilities[i]["petType"]]) .. "|r")
					else
						ttb:SetText("TYPE/" .. string.upper(PET_TYPE_SUFFIX[abilities[i]["petType"]]))
					end
					fbut.icon:Show();
					for i=1,(120/160)*self:GetHeight() do ttb:SetTextHeight(i); end
					ttb:SetText("TYPE/" .. string.upper(PET_TYPE_SUFFIX[abilities[i]["petType"]]))
					while (ttb:IsTruncated() == true) do
						ttb:SetTextHeight(ttb:GetStringHeight()-5)
					end
					WoWkemon["Ruby&Sapp"].FightBar.topTextR:SetTextColor(1,0,0,1);
					WoWkemon["Ruby&Sapp"].FightBar.topTextR:SetText(abilities[i]["currentCooldown"])
					ting()
				end );
			end
		else
			fbut:SetScript( "OnClick", function(self, button, down)
				if (button == "RightButton") then
					if (WoWkemon["Ruby&Sapp"].Tutorial.id == "rcab") then
						WoWkemon_TutorialNextStep()
					end
					WoWkemon_SetFrame("AskBar")
				end
			end );
			fbut:SetScript( "OnLeave",nil);
			fbut:SetScript( "OnEnter",nil);
			fbut.text:SetText("--");
		end
		for j=1,(40/160)*self:GetHeight() do fbut.text:SetTextHeight(j); end
	end
	local mcx = 0;
	for k=1,3 do
		if (mcx) then
			if (mcx < WoWkemon["Ruby&Sapp"].FightBar.buttons[k].text:GetStringWidth()-WoWkemon["Ruby&Sapp"].FightBar.buttons[k].text:GetWidth()) then
				mcx = WoWkemon["Ruby&Sapp"].FightBar.buttons[k].text:GetStringWidth()-WoWkemon["Ruby&Sapp"].FightBar.buttons[k].text:GetWidth();
			end
		else
			mcx = WoWkemon["Ruby&Sapp"].FightBar.buttons[k].text:GetStringWidth()-WoWkemon["Ruby&Sapp"].FightBar.buttons[k].text:GetWidth();
		end
	end
	for k=1,3 do
		if ((WoWkemon["Ruby&Sapp"].FightBar.buttons[k].text:GetStringWidth()-WoWkemon["Ruby&Sapp"].FightBar.buttons[k].text:GetWidth()) == mcx) then
			counter = 0;
			while (WoWkemon["Ruby&Sapp"].FightBar.buttons[k].text:IsTruncated()) and counter < 1000  do
				WoWkemon_SetAbilitySize(math.floor(WoWkemon["Ruby&Sapp"].FightBar.buttons[k].text:GetStringHeight())-1)
				counter = counter + 1;
			end
		end
	end
end
function WoWkemon_ShowBagButtons(self)
	while (self.BAGFrames:IsVisible() ~= 1) do
		for i,j in ipairs(self.buttons) do
			j:Hide()
		end
	end
	for i,j in ipairs(self.buttons) do
		j:Show()
	end
	self.HeaderText:Show()
	self.DescText:Show()
	self.DescIcon:Show();
end
function WoWkemon_HideBagButtons(self)
	for i,j in ipairs(self.buttons) do
		j:Hide()
	end
	self.HeaderText:Hide()
	self.DescText:Hide()
	self.DescIcon:Hide();
end
function WoWkemon_SwapShowButton(self)
	self:SetScript( "OnEnter", function(self)
		self.pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
		self.pkbl:SetTexCoord(0.515625,0.8984375,0.015625,0.4765625);
		self.bg:SetTexture(_wd() .. "Textures\\Select\\longbuttons.tga")
		self.bg:SetTexCoord(0.013671875,0.9716796875,0.365234375,0.662109375);
		ting()
	end );
	self:SetScript( "OnLeave", function(self)
		self.pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
		self.pkbl:SetTexCoord(0.0546875,0.4375,0.015625,0.4765625);
		self.bg:SetTexture(_wd() .. "Textures\\Select\\longbuttons.tga")
		self.bg:SetTexCoord(0.013671875,0.9716796875,0.0390625,0.3359375);
	end );
	self.bg:Show()
	self.pkbl:Show()
	self.hp:Show()
	self.hpbg:Show()
	self.name:Show()
	self.hptext:Show()
	self.bg_empty:Hide()
end
function WoWkemon_SwapHideButton(self)
	self:SetScript( "OnEnter", nil);
	self:SetScript( "OnLeave",nil);
	self.bg:Hide()
	self.pkbl:Hide()
	self.hp:Hide()
	self.hpbg:Hide()
	self.name:Hide()
	self.hptext:Hide()
	self.bg_empty:Show()
end
function WoWkemon_ShowSwapButtons(self)
	for i,j in ipairs(self.buttons) do j:Show() end
	self.close:Show()
	self.prime:Show()
	self.Align:Show()
	self.prime.hptext:Show()
	self.prime.name:Show()
	self.prime.hpbg:Show()
	self.prime.hp:Show()
	self.prime.bg:Show()
	-- self.prompt:Show()
end
function WoWkemon_HideSwapButtons(self)
	for i,j in ipairs(self.buttons) do j:Hide() end
	-- self.pkf:Hide()
	self.close:Hide()
	self.prime:Hide()
	self.Align:Hide()
	self.Align:Hide()
	self.prime.hptext:Hide()
	self.prime.name:Hide()
	self.prime.hpbg:Hide()
	self.prime.hp:Hide()
	self.prime.bg:Hide()
	-- self.prompt:Hide()
end
function WoWkemon_UpdateSwapFrame(self)
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
	local level = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY, activePet);
	local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, activePet);
	if (name) then
		if name:match("'") then
			name = name:gsub("'","")
		end
	end
	local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, activePet);
	self.prime.hp:SetMinMaxValues(0,maxHealth)
	self.prime.hp:SetValue(health)
	self.prime.petIndex = activePet;
	self.prime.petOwner = LE_BATTLE_PET_ALLY;
	self.prime:RegisterForClicks("LeftButtonUp")
	self.prime:SetScript("OnClick", function(self,button,down)
		local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, activePet);
		if (C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == false) and (health ~= 0) and (WoWkemon["Ruby&Sapp"].status == true) then
			local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, activePet);
			if (name) then
				if name:match("'") then
					name = name:gsub("'","")
				end
			end	
			C_PetBattles.ChangePet(1)
			WoWkemon_Dialog("Go! " .. name .. "!")
		else
			thunk()
		end
	end);
	WoWkemon_StatusColors(self.prime.hp, health, maxHealth)
	self.prime.hptext:SetText(health .. "/ " .. maxHealth);
	local petType = C_PetBattles.GetPetType(LE_BATTLE_PET_ALLY, activePet);
	if (C_PetBattles.GetAttackModifier(petType,C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))) > 1) then
		self.prime.name:SetText("|cFF00FF00" .. name .. "|r\n  Lv" .. tostring(level));
	elseif (C_PetBattles.GetAttackModifier(petType,C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))) < 1) then
		self.prime.name:SetText("|cFFFF0000" .. name .. "|r\n  Lv" .. tostring(level));
	else
		self.prime.name:SetText(name .. "\n  Lv" .. tostring(level));
	end
	self.prime.name:SetText(name .. "\n  Lv" .. tostring(level));
	self.prime.pm:SetDisplayInfo(C_PetBattles.GetDisplayID(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)));
	self.prime.pm:SetRotation(-BATTLE_PET_DISPLAY_ROTATION);
	self.prime.pm:SetDoBlend(false);
	if ( C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)) == 0 ) then
		self.prime.pm:SetAnimation(6, 0);
	else
		self.prime.pm:SetAnimation(742, 0);
	end
	local actives = {}
	local numPets = C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY);
	for i=1, numPets do
		if (i ~= C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)) then
			table.insert(actives,i)
		end
	end
	for i,j in ipairs(actives) do
		local level = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY, j);
		self.buttons[i].petIndex = j;
		self.buttons[i].petOwner = LE_BATTLE_PET_ALLY;
		local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, j);
		if (name) then
			if name:match("'") then
				name = name:gsub("'","")
			end
		end
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, j), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, j);
		self.buttons[i].hp:SetMinMaxValues(0,maxHealth)
		self.buttons[i].hp:SetValue(health)
		WoWkemon_StatusColors(self.buttons[i].hp, health, maxHealth)
		self.buttons[i].hptext:SetText(health .. "/ " .. maxHealth);
		local abn = abbreviate(name)
		if (name:len() > 19) then
			name = abbreviate(name)
		end
		local petType = C_PetBattles.GetPetType(LE_BATTLE_PET_ALLY, j);
		if (C_PetBattles.GetAttackModifier(petType,C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))) > 1) then
			self.buttons[i].name:SetText("|cFF00FF00" .. name .. "|r\n  Lv" .. tostring(level));
		elseif (C_PetBattles.GetAttackModifier(petType,C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))) < 1) then
			self.buttons[i].name:SetText("|cFFFF0000" .. name .. "|r\n  Lv" .. tostring(level));
		else
			self.buttons[i].name:SetText(name .. "\n  Lv" .. tostring(level));
		end
		self.buttons[i].hptext:SetSize(self.buttons[i].hptext:GetStringWidth()+10,self.buttons[i].hptext:GetStringHeight());
		self.buttons[i].pm:SetDisplayInfo(C_PetBattles.GetDisplayID(LE_BATTLE_PET_ALLY,j));
		self.buttons[i].pm:SetRotation(-BATTLE_PET_DISPLAY_ROTATION);
		self.buttons[i].pm:SetDoBlend(false);
		self.buttons[i].mni = j;
		if ( C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, j) == 0 ) then
			self.buttons[i].pm:SetAnimation(6, 0);
		else
			self.buttons[i].pm:SetAnimation(742, 0);
		end
		WoWkemon_SwapShowButton(self.buttons[i])
	end
	for i=#actives+1,5 do
		WoWkemon_SwapHideButton(self.buttons[i])
	end
end
function WoWkemon_GenerateBuffFrames(frame)
	frame.buffs = {}
	for i=1,10 do
		frame.buffs[i] = CreateFrame("Frame",nil,frame)
		local buff = frame.buffs[i]
		buff:SetID(i)
		buff:SetSize(24,24)
		buff.text = buff:CreateFontString(nil,"OVERLAY",6,"OUTLINE")
		buff.text:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
		buff.text:SetText("..");
		buff.text:SetTextColor(1,1,1,1);
		buff.text:SetAllPoints(buff)
		for i=1,20 do buff.text:SetTextHeight(i) end
		buff.icon = buff:CreateTexture(nil,"OVERLAY",nil,5)
		buff.icon:SetPoint("LEFT",buff,"LEFT")
		buff.icon:SetAllPoints(buff)
		buff.icon:SetTexture(icon)
		if (buff.icon:SetDesaturated(true)) then
			buff.icon:SetDesaturated(true)
		end
		buff:EnableMouse(true)
		buff.icon:SetAlpha(1)
		-- buff.icon.show = buff.icon:CreateAnimationGroup()
		-- buff.icon.show.alpha = buff.icon.show:CreateAnimation("Alpha")
		-- local fanim = buff.icon.show.alpha
		-- fanim:SetChange(0.8)
		-- fanim:SetDuration(0.1)
		-- fanim:SetOrder(1)
		-- fanim:SetSmoothing("NONE")
		-- buff.icon.show:SetLooping("NONE")
		-- buff.icon.show:SetScript("OnFinished", function(self)
		-- 	buff.icon:SetAlpha(1)
		-- end);
		-- buff.icon.hide = buff.icon:CreateAnimationGroup()
		-- buff.icon.hide.alpha = buff.icon.hide:CreateAnimation("Alpha")
		-- local fanim = buff.icon.hide.alpha
		-- fanim:SetChange(-0.8)
		-- fanim:SetDuration(0.1)
		-- fanim:SetOrder(1)
		-- fanim:SetSmoothing("NONE")
		-- buff.icon.hide:SetLooping("NONE")
		-- buff.icon.hide:SetScript("OnFinished", function(self)
		-- 	buff.icon:SetAlpha(0.2)
		-- end);
		buff:SetScript("OnEnter", function(self)
			local pnt = frame
			PetBattleAbilityTooltip_SetAura(pnt.petOwner, C_PetBattles.GetActivePet(pnt.petOwner), self:GetID());
			local left, bottom = pnt:GetLeft(),pnt:GetBottom();
			local p1, p2;
			if (left > (GetScreenWidth()/2)) then
				p1 = "RIGHT";
				p2 = "LEFT";
			else
				p1 = "LEFT";
				p2 = "RIGHT";
			end
			PetBattleAbilityTooltip_Show(p1, self, p2);
		end);
		buff:SetScript("OnLeave", function(self)
			PetBattlePrimaryAbilityTooltip:Hide();
		end);
		if (i > 1) then
			buff:SetPoint("LEFT",frame.buffs[i-1],"RIGHT",5,0)
		else
			buff:SetPoint("TOPLEFT",frame,"BOTTOMLEFT",10,-5)
		end
		buff:Hide()
	end
end
function WoWkemon_UpdateBuffs()
	local ftable = {}
	local Ally = WoWkemon["Ruby&Sapp"].BattleFrames.Ally
	local Enemy = WoWkemon["Ruby&Sapp"].BattleFrames.Enemy
	table.insert(ftable,Ally)
	table.insert(ftable,Enemy)
	for _,p in ipairs(ftable) do
		if (p.buffs) then
			if (C_PetBattles.GetNumAuras(p.petOwner, C_PetBattles.GetActivePet(p.petOwner)) ~= 0) and (C_PetBattles.GetNumAuras(p.petOwner, C_PetBattles.GetActivePet(p.petOwner)) ~= nil) then
					for i=1, C_PetBattles.GetNumAuras(p.petOwner, C_PetBattles.GetActivePet(p.petOwner)) do
						local auraID, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(p.petOwner, C_PetBattles.GetActivePet(p.petOwner), i);
						local id, name, icon, maxCooldown, description = C_PetBattles.GetAbilityInfoByID(auraID);
						local buff = p.buffs[i]
						buff:Show()
						if (isBuff) then
							p.bpn.buff:Show()
							p.bpn.debuff:Hide()
							buff.icon:SetVertexColor(0,1,0)
							-- buff.text:SetTextColor(0,1,0)
						elseif (not isBuff) then
							p.bpn.debuff:Show()
							p.bpn.buff:Hide()
							buff.icon:SetVertexColor(1,0,0)
							-- buff.text:SetTextColor(1,0,0)
						end
						buff.icon:SetTexture(icon)
						if (turnsRemaining > 0) then
							buff.text:SetText(turnsRemaining)
						else
							buff.text:SetText("")
						end
					end
					for i=C_PetBattles.GetNumAuras(p.petOwner, C_PetBattles.GetActivePet(p.petOwner))+1,10  do
						p.buffs[i]:Hide()
						p.buffs[i].text:SetText("")
					end
			elseif (C_PetBattles.GetNumAuras(p.petOwner, C_PetBattles.GetActivePet(p.petOwner)) == 0) then
				p.bpn.buff:Hide()
				p.bpn.debuff:Hide()
				for i=1, 10 do
					p.buffs[i]:Hide()
					p.buffs[i].text:SetText("")
				end
			end
		end
	end
end
function WoWkemon_UpdateUnitFrames(self)
	do--Ally
		local Ally = self.BattleFrames.Ally
		local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
		local level = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY, activePet);
		local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, activePet);
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, activePet);
		local xp, maxXp = C_PetBattles.GetXP(LE_BATTLE_PET_ALLY, activePet);
		Ally.hp:SetMinMaxValues(0,maxHealth)
		Ally.hp:SetValue(health)
		WoWkemon_StatusColors(Ally.hp, health, maxHealth)
		Ally.xp:SetMinMaxValues(0,maxXp)
		Ally.xp:SetValue(xp)
		Ally.health:SetText(valShort(health) .. "/ " .. valShort(maxHealth));
		if (name) then
			if name:match("'") then
				name = name:gsub("'","")
			end
		end
		Ally.name:SetText(name);
		Ally.level:SetText("Lv" .. level);
		--C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY)
		for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) do
			Ally.pbs[i].petIndex = i
			Ally.pbs[i].dead:Hide();
			Ally.pbs[i].empty:Hide();
			Ally.pbs[i].highlight:Hide();
			Ally.pbs[i].normal:Hide();
			local health = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, i);
			local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
			if (health == 0) then
				Ally.pbs[i].dead:Show();
			elseif (activePet == i) then
				Ally.pbs[i].highlight:Show();
			else
				Ally.pbs[i].normal:Show();
			end
			
		end
		for i=C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY)+1,6 do
			Ally.pbs[i].dead:Hide();
			Ally.pbs[i].empty:Show();
			Ally.pbs[i].highlight:Hide();
			Ally.pbs[i].normal:Hide();
		end
	end
	do--Enemy
		local Enemy = self.BattleFrames.Enemy
		local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY);
		local level = C_PetBattles.GetLevel(LE_BATTLE_PET_ENEMY, activePet);
		local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ENEMY, activePet);
		if (name) then
			if name:match("'") then
				name = name:gsub("'","")
			end
		end
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ENEMY, activePet);
		Enemy.hp:SetMinMaxValues(0,maxHealth)
		Enemy.hp:SetValue(health)
		WoWkemon_StatusColors(Enemy.hp, health, maxHealth)
		Enemy.name:SetText(name);
		Enemy.level:SetText("Lv" .. level);
		for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY) do
			Enemy.pbs[i].petIndex = i
			Enemy.pbs[i].dead:Hide();
			Enemy.pbs[i].empty:Hide();
			Enemy.pbs[i].highlight:Hide();
			Enemy.pbs[i].normal:Hide();
			local health = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, i);
			local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY);
			if (health == 0) then
				Enemy.pbs[i].dead:Show();
			elseif (activePet == i) then
				Enemy.pbs[i].highlight:Show();
			else
				Enemy.pbs[i].normal:Show();
			end
		end
		for i=C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY)+1,6 do
			Enemy.pbs[i].dead:Hide();
			Enemy.pbs[i].empty:Show();
			Enemy.pbs[i].highlight:Hide();
			Enemy.pbs[i].normal:Hide();
		end
		if (C_PetBattles.IsWildBattle()) then
			local opc = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY, activePet) - 1
			local r, g, b, hex = GetItemQualityColor(opc)
			if (hex) and (name) then
				Enemy.name:SetText(name .. "|c" .. hex .. "☆" .. "|r")
			end
			if (Enemy.name:IsTruncated() == true) then
				Enemy.name:SetText(abbreviate(name) .. "|c" .. hex .. "☆" .. "|r")
			end
		end
	end
	WoWkemon_UpdateBuffs()
	WoWkemon_BattleAllyFixText(self.BattleFrames)
end
function WoWkemon_BattleAllyFixText(self)
	local Ally = self.Ally
	--for i=1,math.floor((1/3)*Ally:GetHeight()) do Ally.name:SetTextHeight(i); Ally.health:SetTextHeight(i); Ally.level:SetTextHeight(i); end
	--Ally.level:SetSize(Ally.level:GetStringWidth()+10,Ally.level:GetHeight())
	Ally.name:SetPoint("BOTTOMRIGHT",Ally.level,"BOTTOMLEFT",-10,0)
	if (Ally.name:IsTruncated()) then
		-- while (Ally.name:IsTruncated()) do
		-- 	Ally.name:SetTextHeight(math.floor(Ally.name:GetStringHeight())-1)
		-- end
		Ally.name:SetText(abbreviate(Ally.name:GetText()))
	end
	-- if (Ally.health:IsTruncated()) then
	-- 	local counter = 0;
	-- 	while (Ally.health:IsTruncated()) and counter < 1000 do
	-- 		Ally.health:SetTextHeight(math.floor(Ally.health:GetStringHeight())-1)
	-- 		counter = counter + 1;
	-- 	end
	-- end
	local counter = 0;
	-- while (Ally.level:IsTruncated()==true) and (counter < 1000) do
	-- 	if ((Ally.level:GetStringHeight()-1) < 1) then
	-- 		--print("Why the fuck is this less than 1? Let's check the text: " .. Ally.level:GetText() .. " Did that help? Well, fuck it, what's the height? " .. Ally.level:GetStringHeight())
	-- 	else
	-- 		Ally.level:SetTextHeight(Ally.level:GetStringHeight()-1)
	-- 	end
	-- 	counter = counter + 1;
	-- end
	-- print(counter)
	-- if (counter == 1000) then
	-- 	print("Why the fuck is this over 1000A? Let's check the text: " .. Ally.level:GetText() .. " Did that help? Well, fuck it, what's the height? " .. Ally.level:GetStringHeight())
	-- end
	local Enemy = self.Enemy
	--for i=1,math.floor((1/3)*Enemy:GetHeight()) do Enemy.name:SetTextHeight(i); Enemy.level:SetTextHeight(i); end

	--Enemy.level:SetSize(Enemy.level:GetStringWidth()+10,Enemy.level:GetHeight())
	counter = 0;
	-- while (Enemy.level:IsTruncated() == true) and (counter < 1000) do
	-- 	if ((Enemy.level:GetStringHeight()-1) < 1) then
	-- 		--print("Why the fuck is this less than 1? Let's check the text: " .. Enemy.level:GetText() .. " Did that help? Well, fuck it, what's the height? " .. Enemy.level:GetStringHeight())
	-- 	else
	-- 		Enemy.level:SetTextHeight(Enemy.level:GetStringHeight()-1)
	-- 	end
	-- 	counter = counter + 1;
	-- end
	-- if (counter == 1000) then
	-- 	print("Why the fuck is this over 1000E? Let's check the text: " .. Enemy.level:GetText() .. " Did that help? Well, fuck it, what's the height? " .. Enemy.level:GetStringHeight())
	-- end
	Enemy.name:SetPoint("BOTTOMRIGHT",Enemy.level,"BOTTOMLEFT",-10,0)
	if (Enemy.name:IsTruncated()) then
		-- while (Enemy.name:IsTruncated()) do
		-- 	Enemy.name:SetTextHeight(math.floor(Enemy.name:GetStringHeight())-1)
		-- end
		Enemy.name:SetText(abbreviate(Enemy.name:GetText()))
	end
	-- if (Enemy.level:IsTruncated()) then
	-- 	while (Enemy.level:IsTruncated()) do
	-- 		Enemy.level:SetTextHeight(math.floor(Enemy.level:GetStringHeight())-1)
	-- 	end
	-- end
end
function WoWkemon_UpdateTimer(self)
	if ( ( C_PetBattles.GetBattleState() ~= LE_PET_BATTLE_STATE_WAITING_PRE_BATTLE ) and
		 ( C_PetBattles.GetBattleState() ~= LE_PET_BATTLE_STATE_ROUND_IN_PROGRESS ) and
		 ( C_PetBattles.GetBattleState() ~= LE_PET_BATTLE_STATE_WAITING_FOR_FRONT_PETS ) ) then
		self.time:Hide();
	elseif ( self.turnExpires ) then
		self.time:Show()
		local timeRemaining = self.turnExpires - GetTime();
		if ( timeRemaining <= 0.01 ) then
			timeRemaining = 0.01;
		end
		if ( C_PetBattles.IsWaitingOnOpponent() ) then
			self.time:SetText(PET_BATTLE_WAITING_FOR_OPPONENT);
			--WoWkemon_TV:SendBattle(PET_BATTLE_WAITING_FOR_OPPONENT)
		else
			if ( self.turnTime > 0.0 ) then
				self.time:SetText(string.format("%.2f",timeRemaining));
			else
				self.time:SetText("")
			end
		end
	else
		self.time:Show()
		if ( C_PetBattles.IsWaitingOnOpponent() ) then
			self.time:SetText(PET_BATTLE_WAITING_FOR_OPPONENT);
			--WoWkemon_TV:SendBattle(PET_BATTLE_WAITING_FOR_OPPONENT)
		end
	end
	if (C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == false) then
		self.time:Show()
	else
		self.time:Hide()
	end
end
function WoWkemon_UpdateTimerValues(self)
	local timeRemaining, turnTime = C_PetBattles.GetTurnTimeInfo(); 
	self.turnExpires = GetTime() + timeRemaining;
	self.turnTime = turnTime;
end
function WoWkemon_Rain(ss)
	local self = WoWkemon["Ruby&Sapp"].Weather
	if (ss == "START") then
		self:SetAllPoints(UIParent)
		self:Show()
		if (self.Rain == nil) then
			self.Rain = CreateFrame("Frame",nil,self)
			self.Rain:SetAllPoints(self)
			self.Rain:SetAlpha(1)
			do 
				self.Rain.bgf = CreateFrame("Frame",nil,self.Rain)
				self.Rain.bgf:SetAllPoints(self.Rain)
				self.Rain.bgf:SetFrameStrata("FULLSCREEN")
				
				self.Rain.bgf:SetAlpha(0.3)
				self.Rain.bgf.bg = self.Rain.bgf:CreateTexture(nil,"OVERLAY",nil,5)
				local bg = self.Rain.bgf.bg;
				bg:SetAllPoints(self.Rain.bgf)
				bg:SetTexture(32/255,134/255,202/255)
			end
			self.Rain.drops = {}
			for i=1,math.random(400,600) do
				self.Rain.drops[i] = CreateFrame("Frame",nil,self.Rain)
				local rd = self.Rain.drops[i];
				local sizeRatio = math.random(20,30)
				rd:SetSize(sizeRatio,sizeRatio*2)
				rd:SetPoint("BOTTOMLEFT",self:GetParent(),"TOPLEFT",math.random(1,GetScreenWidth()+(GetScreenWidth()/2)),rd:GetHeight())
				rd.bg = rd:CreateTexture(nil,"OVERLAY",nil,5)
				rd.bg:SetTexture(_wd() .. "Textures\\Weather\\raindrop.tga")
				rd.bg:SetAllPoints(rd)
				rd.ag = rd:CreateAnimationGroup()
				rd.anim = rd.ag:CreateAnimation("Translation")
				local left, bottom = rd:GetLeft(),rd:GetBottom();
				rd.anim:SetOffset(-1*(GetScreenWidth()/2),-1*GetScreenWidth())
				rd.anim:SetDuration(3)
				rd.anim:SetStartDelay(math.random(1,3000)/1000)
				rd.anim:SetOrder(1)
				rd.anim:SetSmoothing("NONE")
				rd.ag:SetLooping("REPEAT")
				rd.ag:Play()
			end
		else
			self.Rain:Show()
			for i,j in ipairs(WoWkemon["Ruby&Sapp"].Weather.Rain.drops) do 
				j:Show();
			end
		end
	elseif (ss == "STOP") then
		if (self.Rain) then
			self.Rain:Hide()
		end
	end
end
function WoWkemon_Snow(ss)
	--Uses roughly the same system as the rain does
	local self = WoWkemon["Ruby&Sapp"].Weather
	if (ss == "START") then
		self:SetAllPoints(UIParent)
		self:Show()
		if (self.Snow == nil) then
			self.Snow = CreateFrame("Frame",nil,self)
			self.Snow:SetAllPoints(self)
			self.Snow:SetAlpha(1)
			do 
				if (self.Snow.bgf == nil) then
					self.Snow.bgf = CreateFrame("Frame",nil,self.Snow)
				end
				self.Snow.bgf:SetAllPoints(self.Snow)
				self.Snow.bgf:SetFrameStrata("FULLSCREEN")
				self.Snow.bgf:SetAlpha(0.3)
				self.Snow.bgf.bg = self.Snow.bgf:CreateTexture(nil,"OVERLAY",nil,5)
				local bg = self.Snow.bgf.bg;
				bg:SetAllPoints(self.Snow.bgf)
				bg:SetTexture(1,1,1)
			end
			self.Snow.flakes = nil
			self.Snow.flakes = {}
			for i=1,math.random(200,400) do
				self.Snow.flakes[i] = CreateFrame("Frame",nil,self.Snow)
				local rd = self.Snow.flakes[i];
				local sizeRatio = math.random(40,50)
				rd:SetSize(sizeRatio,sizeRatio)
				rd:SetPoint("BOTTOMLEFT",self:GetParent(),"TOPLEFT",math.random(1,GetScreenWidth()+(GetScreenWidth()/2)),rd:GetHeight())
				--rd:SetPoint("CENTER",UIParent,"CENTER")
				rd.bg = rd:CreateTexture(nil,"OVERLAY",nil,5)
				rd.bg:SetTexture(_wd() .. "Textures\\Weather\\snowflake.tga")
				rd.bg:SetAllPoints(rd)
				rd.ag = rd:CreateAnimationGroup()
				rd.anim = rd.ag:CreateAnimation("Translation")
				local left, bottom = rd:GetLeft(),rd:GetBottom();
				local aX, aY = math.random(-1*(GetScreenWidth()/2),(GetScreenWidth()/2)),-1*GetScreenWidth();
				local dist = math.sqrt((aX*aX)+(aY*aY));
				rd.anim:SetOffset(aX,aY)
				rd.anim:SetDuration(dist/300)
				rd.anim:SetStartDelay(math.random(1,6000)/1000)
				rd.anim:SetOrder(1)
				rd.anim:SetSmoothing("NONE")
				rd.ag:SetLooping("REPEAT")
				rd.ag:Play()
			end
		else
			self.Snow:Show()
			for i,j in ipairs(WoWkemon["Ruby&Sapp"].Weather.Snow.flakes) do 
				j:Show();
			end
			self.Snow:SetAlpha(1)
		end
	elseif (ss == "STOP") then
		if (self.Snow) then
			self.Snow:Hide()
		end
	end
end
function WoWkemon_Sand(ss)
	--Uses roughly the same system as the rain does
	local self = WoWkemon["Ruby&Sapp"].Weather
	if (ss == "START") then
		self:SetAllPoints(UIParent)
		self:Show()
		if (self.Sand == nil) then
			self.Sand = CreateFrame("Frame",nil,self)
			local self = self.Sand
			self:SetAllPoints(self:GetParent())
			self:SetAlpha(1)
			do 
				if (self.bgf == nil) then
				 self.bgf = CreateFrame("Frame",nil,self)
				end
				self.bgf:SetAllPoints(self)
				self.bgf:SetFrameStrata("FULLSCREEN")
				self.bgf:SetAlpha(0.3)
				self.bgf.bg = self.bgf:CreateTexture(nil,"OVERLAY",nil,5)
				local bg = self.bgf.bg;
				bg:SetAllPoints(self.bgf)
				bg:SetTexture(255/255,215/255,120/255)
			end
			self.motes = nil
			self.motes = {}
			for i=1,math.random(200,300) do
				self.motes[i] = CreateFrame("Frame",nil,self)
				local rd = self.motes[i];
				local sizeRatio = math.random(70,80)
				rd:SetSize(sizeRatio,sizeRatio)
				rd:SetPoint("RIGHT",self:GetParent(),"BOTTOMLEFT",0,math.random(-200,GetScreenHeight()))
				rd.bg = rd:CreateTexture(nil,"OVERLAY",nil,5)
				rd.bg:SetTexture(_wd() .. "Textures\\Weather\\dust.tga")
				rd.bg:SetAlpha(0.3)
				rd.bg:SetVertexColor(155/255,135/255,88/255)
				local td = math.random(1,4)
				if (td == 1) then rd.bg:SetTexCoord(0,0.5,0,0.5)
				elseif (td == 2) then rd.bg:SetTexCoord(0.5,1,0,0.5)
				elseif (td == 3) then rd.bg:SetTexCoord(0,0.5,0.5,1)
				elseif (td == 4) then rd.bg:SetTexCoord(0.5,1,0.5,1)
				end
				rd.bg:SetAllPoints(rd)
				rd.ag = rd:CreateAnimationGroup()
				rd.ag.pps = {}
				for i = 1,5 do
					rd.ag.pps[i] = rd.ag:CreateAnimation("Translation")
					rd.ag.pps[i]:SetOffset((GetScreenWidth()/5),(i/5)*(GetScreenHeight()/2))
					rd.ag.pps[i]:SetOrder(i)
					if (i == 1) then
						rd.ag.pps[i]:SetStartDelay(math.random(1,6000)/1000)
					end
					rd.ag.pps[i]:SetDuration(3/5)
					rd.ag.pps[i]:SetOrder(i)
					rd.ag.pps[i]:SetSmoothing("NONE")
				end
				rd.ag:SetLooping("REPEAT")
				rd.ag:Play()
			end
		else
			for i,j in ipairs(WoWkemon["Ruby&Sapp"].Weather.Sand.motes) do 
				j:Show();
			end
			self.Sand:Show()
			self.Sand:SetAlpha(1)
		end
	elseif (ss == "STOP") then
		if (self.Sand) then
			self.Sand:Hide()
		end
	end
end
function WoWkemon_Mud(ss)
	--Uses roughly the same system as the rain does
	local self = WoWkemon["Ruby&Sapp"].Weather
	if (ss == "START") then
		self:SetAllPoints(UIParent)
		self:Show()
		if (self.Mud == nil) then
			self.Mud = CreateFrame("Frame",nil,self)
			local self = self.Mud
			self:SetAllPoints(self:GetParent())
			self:SetAlpha(1)
			do 
				if (self.bgf == nil) then
					self.bgf = CreateFrame("Frame",nil,self)
				end
				self.bgf:SetAllPoints(self)
				self.bgf:SetFrameStrata("FULLSCREEN")
				self.bgf:SetAlpha(0.3)
				self.bgf.bg = self.bgf:CreateTexture(nil,"OVERLAY",nil,5)
				local bg = self.bgf.bg;
				bg:SetAllPoints(self.bgf)
				bg:SetTexture(90/255,66/255,8/255)
			end
			self.motes = nil
			self.motes = {}
			for i=1,math.random(200,300) do
				self.motes[i] = CreateFrame("Frame",nil,self)
				local rd = self.motes[i];
				local sizeRatio = math.random(500,600)
				rd:SetSize(sizeRatio,sizeRatio)
				local loc = math.random(-1*(GetScreenWidth()/2),(GetScreenWidth()/2))
				rd:SetPoint("BOTTOM",self:GetParent(),"TOP",loc,rd:GetHeight())
				rd.bg = rd:CreateTexture(nil,"OVERLAY",nil,5)
				rd.bg:SetTexture(_wd() .. "Textures\\Weather\\dust.tga")
				rd.bg:SetAlpha(0.3)
				rd.bg:SetVertexColor(168/255,148/255,101/255)
				local td = math.random(1,4)
				if (td == 1) then rd.bg:SetTexCoord(0,0.5,0,0.5)
				elseif (td == 2) then rd.bg:SetTexCoord(0.5,1,0,0.5)
				elseif (td == 3) then rd.bg:SetTexCoord(0,0.5,0.5,1)
				elseif (td == 4) then rd.bg:SetTexCoord(0.5,1,0.5,1)
				end
				rd.bg:SetAllPoints(rd)
				rd.ag = rd:CreateAnimationGroup()
				rd.ag.pps = {}
				for i = 1,5 do
					rd.ag.pps[i] = rd.ag:CreateAnimation("Translation")
					if (loc <= 0) then
						rd.ag.pps[i]:SetOffset(-1*(GetScreenWidth()/10),-1*(i/5)*(GetScreenHeight()))
					else
						rd.ag.pps[i]:SetOffset((GetScreenWidth()/10),-1*(i/5)*(GetScreenHeight()))
					end
					rd.ag.pps[i]:SetOrder(i)
					if (i == 1) then
						rd.ag.pps[i]:SetStartDelay(math.random(1,6000)/1000)
					end
					rd.ag.pps[i]:SetDuration(1)
					rd.ag.pps[i]:SetOrder(i)
					rd.ag.pps[i]:SetSmoothing("NONE")
				end
				rd.ag:SetLooping("REPEAT")
				rd.ag:Play()
			end
		else
			self.Mud:Show()
			for i,j in ipairs(WoWkemon["Ruby&Sapp"].Weather.Mud.motes) do 
				j:Show();
			end
			self.Mud:SetAlpha(1)
		end
	elseif (ss == "STOP") then
		if (self.Mud) then
			self.Mud:Hide()
		end
	end
end
function WoWkemon_StaticField(ss)
	local self = WoWkemon["Ruby&Sapp"].Weather
	if (ss == "START") then
		self:SetAllPoints(UIParent)
		self:Show()
		if (self.StaticField == nil) then
			self.StaticField = CreateFrame("Frame",nil,self)
			local self = self.StaticField
			self:SetAllPoints(self:GetParent())
			self:SetAlpha(1)
			do 
				if (self.bgf == nil) then
				 self.bgf = CreateFrame("Frame",nil,self)
				end
				self.bgf:SetAllPoints(self)
				self.bgf:SetFrameStrata("FULLSCREEN")
				self.bgf:SetAlpha(0.3)
				self.bgf.bg = self.bgf:CreateTexture(nil,"OVERLAY",nil,5)
				local bg = self.bgf.bg;
				bg:SetAllPoints(self.bgf)
				bg:SetTexture(0,0,0)
			end
			self.motes = nil
			self.motes = {}
			for i=1,math.random(200,300) do
				self.motes[i] = CreateFrame("Frame",nil,self)
				local rd = self.motes[i];
				rd:SetSize(50,50)
				local loc = math.random(-1*(GetScreenWidth()/2),(GetScreenWidth()/2))
				if (loc <= 0) then
					rd:SetPoint("BOTTOM",self:GetParent(),"TOP",loc,rd:GetHeight())
				else
					rd:SetPoint("TOP",self:GetParent(),"BOTTOM",loc,-1*rd:GetHeight())
				end
				rd.bg = rd:CreateTexture(nil,"OVERLAY",nil,5)
				rd.bg:SetTexture(_wd() .. "Textures\\Weather\\lightning.tga")
				rd.bg:SetAlpha(0.5)
				rd.bg:SetAllPoints(rd)
				rd.ag = rd:CreateAnimationGroup()
				rd.ag.pps = {}
				for i = 1,11 do
					rd.ag.pps[i] = rd.ag:CreateAnimation("Translation")
					if (loc <= 0) then
						if (i < 6) then
							rd.ag.pps[i]:SetOffset(-1*(GetScreenWidth()/20),-1*(i/11)*(GetScreenHeight()))
						elseif (i == 6) then
							rd.ag.pps[i]:SetOffset(0,-1*(i/11)*(GetScreenHeight()))
						elseif (i > 6) then
							rd.ag.pps[i]:SetOffset((GetScreenWidth()/20),-1*(i/11)*(GetScreenHeight()))
						end
					else
						if (i < 6) then
							rd.ag.pps[i]:SetOffset((GetScreenWidth()/20),(i/11)*(GetScreenHeight()))
						elseif (i == 6) then
							rd.ag.pps[i]:SetOffset(0,(i/11)*(GetScreenHeight()))
						elseif (i > 6) then
							rd.ag.pps[i]:SetOffset(-1*(GetScreenWidth()/20),(i/11)*(GetScreenHeight()))
						end
					end
					rd.ag.pps[i]:SetOrder(i)
					if (i == 1) then
						rd.ag.pps[i]:SetStartDelay(math.random(1,6000)/1000)
					end
					rd.ag.pps[i]:SetDuration(1)
					rd.ag.pps[i]:SetOrder(i)
					rd.ag.pps[i]:SetSmoothing("NONE")
				end
				rd.ag:SetLooping("REPEAT")
				rd.ag:Play()
			end
		else
			self.StaticField:Show()
			for i,j in ipairs(WoWkemon["Ruby&Sapp"].Weather.StaticField.motes) do 
				j:Show();
			end
			self.StaticField:SetAlpha(1)
		end
	elseif (ss == "STOP") then
		if (self.StaticField) then
			self.StaticField:Hide()
		end
	end
end
function WoWkemon_Night(ss, mn)
	local self = WoWkemon["Ruby&Sapp"].Weather
	if (ss == "START") then
		self:Show()
		if (self.Night == nil) then
			self.Night = CreateFrame("Frame",nil,self)
			local self = self.Night
			self:SetAllPoints(WoWkemon["Ruby&Sapp"].Weather)
			self:SetAlpha(1)
			do 
				if (self.bgf == nil) then
					self.bgf = CreateFrame("Frame",nil,self)
				end
				self.bgf:SetAllPoints(self)
				self.bgf:SetFrameStrata("FULLSCREEN")
				self.bgf:SetAlpha(0.6)
				self.bgf.bg = self.bgf:CreateTexture(nil,"OVERLAY",nil,3)
				local bg = self.bgf.bg;
				bg:SetAllPoints(self.bgf)
				bg:SetTexture(0,0,0)
				self.bgf.moon = self.bgf:CreateTexture(nil,"OVERLAY",nil,5)
				local moon = self.bgf.moon;
				--moon:SetTexture(_wd() .. "Textures\\Weather\\moon.tga")
				moon:SetTexture(_wd() .. "Textures\\Weather\\moon.tga")
				moon:SetSize(300,300)
				moon:SetPoint("BOTTOMRIGHT",self,"TOPLEFT",-1*moon:GetWidth(),moon:GetHeight())
				moon.ag = moon:CreateAnimationGroup()
				moon.fo = moon.ag:CreateAnimation("Translation")
				local fanim = moon.fo
				fanim:SetOffset(GetScreenWidth()+moon:GetWidth(),-1*GetScreenHeight()-moon:GetHeight())
				fanim:SetDuration(10)
				fanim:SetOrder(1)
				moon.ag:SetLooping("REPEAT")
				fanim:SetSmoothing("NONE")
				moon.ag:Play()
				moon:Hide()
			end
		else
			if (mn == true) then
				self.Night.bgf.moon:Show()
			else
				self.Night.bgf.moon:Hide()
			end
			self.Night:Show()
		end
	elseif (ss == "STOP") then
		if (self.Night) then
			self.Night:Hide()
		end
	end
end
function WoWkemon_Sunlight(ss)
	local self = WoWkemon["Ruby&Sapp"].Weather
	if (ss == "START") then
		self:Show()
		if (self.Sunlight == nil) then
			self.Sunlight = CreateFrame("Frame",nil,self)
			local self = self.Sunlight
			self:SetAllPoints(WoWkemon["Ruby&Sapp"].Weather)
			self:SetAlpha(1)
			do 
				if (self.bgf == nil) then
					self.bgf = CreateFrame("Frame",nil,self)
				end
				self.bgf:SetAllPoints(self)
				self.bgf:SetFrameStrata("FULLSCREEN")
				self.bgf:SetAlpha(0.6)
				self.bgf.bg = self.bgf:CreateTexture(nil,"OVERLAY",nil,3)
				local bg = self.bgf.bg;
				bg:SetAllPoints(self.bgf)
				bg:SetTexture(1,1,1)
				self.bgf.sun = self.bgf:CreateTexture(nil,"OVERLAY",nil,5)
				local sun = self.bgf.sun;
				sun:SetTexture(_wd() .. "Textures\\Weather\\sun.tga")
				sun:SetSize(300,300)
				sun:SetPoint("BOTTOMRIGHT",self,"TOPLEFT",-1*sun:GetWidth(),sun:GetHeight())
				sun.ag = sun:CreateAnimationGroup()
				sun.fo = sun.ag:CreateAnimation("Translation")
				local fanim = sun.fo
				fanim:SetOffset(GetScreenWidth()+sun:GetWidth(),-1*GetScreenHeight()-sun:GetHeight())
				fanim:SetDuration(6)
				fanim:SetOrder(1)
				sun.ag:SetLooping("REPEAT")
				fanim:SetSmoothing("NONE")
				sun.ag:Play()
			end
		else
			self.Sunlight:Show()
		end
	elseif (ss == "STOP") then
		if (self.Sunlight) then
			self.Sunlight:Hide()
		end
	end
end
function WoWkemon_BurningEarth(ss)
	local self = WoWkemon["Ruby&Sapp"].Weather
	if (ss == "START") then
		self:Show()
		if (self.BurningEarth == nil) then
			self.BurningEarth = CreateFrame("Frame",nil,self)
			local self = self.BurningEarth
			self:SetAllPoints(WoWkemon["Ruby&Sapp"].Weather)
			self:SetAlpha(1)
			do 
				if (self.bgf == nil) then
				 self.bgf = CreateFrame("Frame",nil,self)
				end
				self.bgf:SetAllPoints(self)
				self.bgf:SetFrameStrata("FULLSCREEN")
				self.bgf:SetAlpha(0.3)
				self.bgf.bg = self.bgf:CreateTexture(nil,"OVERLAY",nil,3)
				local bg = self.bgf.bg;
				bg:SetAllPoints(self.bgf)
				bg:SetTexture(248/255,26/255,3/255)
				self.bgf.burn = self.bgf:CreateTexture(nil,"OVERLAY",nil,5)
				local burn = self.bgf.burn;
				burn:SetTexture(_wd() .. "Textures\\Weather\\lava.tga")
				burn:SetSize(GetScreenWidth()*4/3,(GetScreenWidth()*4/3)/2)
				burn:SetPoint("TOP",self,"BOTTOM")
				burn.ag = burn:CreateAnimationGroup()
				burn.ag.pps = {}
				for i = 1,10 do
					burn.ag.pps[i] = burn.ag:CreateAnimation("Translation")
					burn.ag.pps[i]:SetStartDelay(1)
					burn.ag.pps[i]:SetOffset(math.random(-50,50),math.random(10,50))
					burn.ag.pps[i]:SetDuration(1)
					burn.ag.pps[i]:SetOrder(i)
					burn.ag.pps[i]:SetSmoothing("IN")
				end
				burn.ag:SetLooping("BOUNCE")
				burn.ag:Play()
			end
		else
			self.BurningEarth:Show()
		end
	elseif (ss == "STOP") then
		if (self.BurningEarth) then
			self.BurningEarth:Hide()
		end
	end
end
function WoWkemon_PromptOnLoad(self)
	self.PromptFrame = CreateFrame("Frame",nil,self)
	local self = self.PromptFrame
	self:SetFrameStrata("FULLSCREEN_DIALOG")
	self:SetPoint("CENTER",UIParent,"CENTER")
	self:SetSize(400,200)
	self:Show()
	do
		self.bg = self:CreateTexture(nil,"OVERLAY")
		local BG = self.bg;
		BG:SetAllPoints(self)
		BG:SetTexture(_wd() .. "Textures\\Frames\\emselect.tga")
		BG:SetTexCoord(0,1,0,200/256);
	end
	do
		self.title = self:CreateFontString(nil,"OVERLAY")
		local ttl = self.title;
		ttl:SetTextColor(72/255,72/255,72/255,1);
		ttl:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
		for i=1,55 do ttl:SetTextHeight(i) end
		ttl:SetPoint("TOPLEFT",self,"TOPLEFT")
		ttl:SetPoint("BOTTOMRIGHT",self,"RIGHT")
		ttl:SetText("Really forfeit?")
		WoWkemon_GiveTextShadow(ttl)
	end
	do
		self.lbtn = CreateFrame("Button",nil, self);
		local lbtn = self.lbtn;
		lbtn:SetPoint("TOPLEFT", self, "LEFT");
		lbtn:SetPoint("BOTTOMRIGHT", self, "BOTTOM");
		lbtn.text = lbtn:CreateFontString(nil,"OVERLAY")
		lbtn.text:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
		lbtn.text:SetAllPoints(lbtn);
		lbtn.text:SetText("YES");
		lbtn.text:SetTextColor(72/255,72/255,72/255,1);
		WoWkemon_GiveTextShadow(lbtn.text)
		lbtn.icon = lbtn:CreateTexture(nil, "ARTWORK");
		lbtn.icon:SetTexture(_wd() .. "Textures\\arrow.tga")
		lbtn.icon:SetVertexColor(72/255,72/255,72/255,1)
		lbtn.icon:SetHeight(30);
		lbtn.icon:SetWidth(21);
		lbtn.icon:SetTexCoord(0,0.62890625,0,0.87109375);
		lbtn.icon:SetPoint("RIGHT",lbtn.text,"LEFT",40,0);
		lbtn.icon:Hide();
		lbtn:SetScript( "OnLeave", function(self)
			lbtn.icon:Hide();
		end );
		lbtn:SetScript( "OnEnter", function(self)
			lbtn.icon:Show();
			ting()
		end );
		lbtn:RegisterForClicks("LeftButtonUp")
		lbtn:SetScript( "OnClick", function (self,button,down)
		end);
		for i=1,55 do lbtn.text:SetTextHeight(i); end
	end
	do
		self.rbtn = CreateFrame("Button",nil, self);
		local rbtn = self.rbtn;
		rbtn:SetPoint("TOPLEFT", self, "CENTER");
		rbtn:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");
		rbtn.text = rbtn:CreateFontString(nil,"OVERLAY")
		rbtn.text:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
		rbtn.text:SetAllPoints(rbtn);
		rbtn.text:SetText("NO");
		rbtn.text:SetTextColor(72/255,72/255,72/255,1);
		WoWkemon_GiveTextShadow(rbtn.text)
		rbtn.icon = rbtn:CreateTexture(nil, "ARTWORK");
		rbtn.icon:SetTexture(_wd() .. "Textures\\arrow.tga")
		rbtn.icon:SetVertexColor(72/255,72/255,72/255,1)
		rbtn.icon:SetHeight(30);
		rbtn.icon:SetWidth(21);
		rbtn.icon:SetTexCoord(0,0.62890625,0,0.87109375);
		rbtn.icon:SetPoint("RIGHT",rbtn.text,"LEFT",40,0);
		rbtn.icon:Hide();
		rbtn:SetScript( "OnLeave", function(self)
			rbtn.icon:Hide();
		end );
		rbtn:SetScript( "OnEnter", function(self)
			rbtn.icon:Show();
			ting()
		end );
		rbtn:RegisterForClicks("LeftButtonUp")
		
		for i=1,55 do rbtn.text:SetTextHeight(i); end
	end
	self:Hide()
end
function WoWkemon_Prompt(text,funcl,funcr,textl,textr)
	local self = WoWkemon["Ruby&Sapp"].PromptFrame
	self.title:SetText(text)
	self.lbtn.text:SetText(textl)
	self.lbtn:SetScript( "OnClick", function (self,button,down)
		funcl(self,button,down)
	end);
	self.rbtn.text:SetText(textr)
	self.rbtn:SetScript( "OnClick", function (self,button,down)
		funcr(self,button,down)
	end);
	self:Show()
end
function WoWkemon_WeatherOnLoad(self)
	self.Weather = CreateFrame("Frame",nil,self)
	local self = self.Weather
	self:SetAllPoints("UIParent")
	self:RegisterEvent("PET_BATTLE_AURA_APPLIED");
	self:RegisterEvent("PET_BATTLE_AURA_CANCELED");
	self:RegisterEvent("PET_BATTLE_AURA_CHANGED");
	do--Creates the time fontstring
		self.text = self:CreateFontString(nil,"OVERLAY",3)
		self.text:SetPoint("TOPLEFT",UIParent,"TOPLEFT");
		self.text:SetFont(_wd() .. "Fonts\\pkmn.ttf",60,"OUTLINE");
		WoWkemon_GiveTextShadow(self.text)
		self.text:SetTextColor(1,1,1,1);
		self.text:SetJustifyH("RIGHT");
		self.text:SetJustifyV("TOP");
		self.text:SetWordWrap(true);
		for i=1,55 do self.text:SetTextHeight(i); end
	end
	do
		self.bf = CreateFrame("Frame",nil,self)
		self.bf:EnableMouse(true)
		self.bf:SetPoint("TOPLEFT",UIParent,"TOPLEFT")
		self.bf:SetSize(200,60)
		self.bf.wa = {}
		local wa = self.bf.wa
		wa[229] = WoWkemon_Rain
		wa[205] = WoWkemon_Snow
		wa[596] = WoWkemon_Night
		wa[403] = WoWkemon_Sunlight
		wa[454] = WoWkemon_Sand
		wa[718] = WoWkemon_Mud
		wa[257] = WoWkemon_Night
		wa[171] = WoWkemon_BurningEarth
		wa[203] = WoWkemon_StaticField
		self.bf:SetScript("OnEnter", function(self)
		 	if (self.aid) then
		 		self.wa[self.aid]("START")
		 	end
		end);
		self.bf:SetScript("OnLeave", function(self)
		 	WoWkemon_StopAllWeather()
		end)
	end
end
function WoWkemon_StopAllWeather()
	local wa = {}
	wa[229] = WoWkemon_Rain
	wa[205] = WoWkemon_Snow
	wa[596] = WoWkemon_Night
	wa[403] = WoWkemon_Sunlight
	wa[454] = WoWkemon_Sand
	wa[718] = WoWkemon_Mud
	wa[257] = WoWkemon_Night
	wa[171] = WoWkemon_BurningEarth
	wa[203] = WoWkemon_StaticField
	for i,j in pairs(wa) do j("STOP") end
end
function WoWkemon_WeatherUpdate(self)
	-- if not self then self = WoWkemon["Ruby&Sapp"].Weather end
	local self = self.Weather
	local auraID, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_WEATHER, PET_BATTLE_PAD_INDEX, 1);
	if ( auraID ) then
		local id, name, icon, maxCooldown, description = C_PetBattles.GetAbilityInfoByID(auraID);
		local wa = {}
		wa[229] = WoWkemon_Rain
		wa[205] = WoWkemon_Snow
		wa[596] = WoWkemon_Night
		wa[403] = WoWkemon_Sunlight
		wa[454] = WoWkemon_Sand
		wa[718] = WoWkemon_Mud
		wa[257] = WoWkemon_Night
		wa[171] = WoWkemon_BurningEarth
		wa[203] = WoWkemon_StaticField
		local ta = {}
		ta[229] = "It is raining."
		ta[205] = "It is snowing."
		ta[596] = "The moon is shining."
		ta[403] = "The sun is shining brightly."
		ta[454] = "A sandstorm rages on."
		ta[718] = "Mud covers the field."
		ta[257] = "It is very dark."
		ta[171] = "The earth is burning."
		ta[203] = "A static field surrounds the area."
		self.text:SetText(ta[auraID] .. string.format(" (%dTR)",turnsRemaining))
		self.bf:SetSize(self.text:GetStringWidth(),self.text:GetStringHeight())
		self.bf.aid = auraID
		self:Show();
	else
		self.bf.aid = nil;
		self:Hide();
	end
end
function WoWkemon_HideAll()
	local framelist = {
	"AskBar",
	"FightBar",
	"BagFrame",
	"SelectFrame",
	"DialogBar",
	"BattleFrames",
	}
	for i,j in pairs(framelist) do
		WoWkemon["Ruby&Sapp"][j]:Hide();
	end
end
function WoWkemon_IntroOnLoad(self)
	self.IntroFrame = CreateFrame("Frame",nil,self)
	local self = self.IntroFrame
	self:SetAllPoints("UIParent")
	self:SetFrameStrata("FULLSCREEN")
	self.tcords = {2,134,266,398,529,661}
	do
		do--Sets up a frame with a certain aspect ratio, so that our elements aren't all wonky.
			self.bg = self:CreateTexture(nil,"BACKGROUND")
			self.bg:SetTexture(0,0,0)
			self.bg:SetAllPoints(self);
		end
		local r,c = math.random(1,5), math.random(1,2);
		do
			self.lpanel = self:CreateTexture(nil,"ARTWORK",nil,1)
			self.lpanel:SetTexture(_wd() .. "Textures\\Intro\\cbgs.tga")
			if (c == 1) then
				self.lpanel:SetTexCoord(0,0.5,(((r*66)-66)/512),(((r*66))/512))
			else
				self.lpanel:SetTexCoord(0.5,1,(((r*66)-66)/512),(((r*66))/512))
			end
			self.lpanel:SetSize(GetScreenWidth()/2,(GetScreenWidth()/2)*(66/128))
			self.lpanel:SetPoint("RIGHT",UIParent,"CENTER")
		end
		do
			self.rpanel = self:CreateTexture(nil,"ARTWORK",nil,1)
			self.rpanel:SetTexture(_wd() .. "Textures\\Intro\\cbgs.tga")
			if (c == 1) then
				self.rpanel:SetTexCoord(0,0.5,(((r*66)-66)/512),(((r*66))/512))
			else
				self.rpanel:SetTexCoord(0.5,1,(((r*66)-66)/512),(((r*66))/512))
			end
			self.rpanel:SetSize(GetScreenWidth()/2,(GetScreenWidth()/2)*(66/128))
			self.rpanel:SetPoint("LEFT",UIParent,"CENTER")
		end
		do
			self.vs = self:CreateTexture(nil,"ARTWORK",nil,2)
			self.vs:SetTexture(_wd() .. "Textures\\Intro\\VSnew.tga")
			--self.vs:SetTexture(_wd() .. "Textures\\Intro\\cbgs.tga")
			if (c == 1) then
				self.vs:SetTexCoord(0,0.5,0,1)
			else
				self.vs:SetTexCoord(0.5,1,0,1)
			end
			self.vs:SetSize(GetScreenWidth()/6,(GetScreenWidth()/6))
			self.vs:SetPoint("CENTER",UIParent,"CENTER")
			self.vs.ag = self.vs:CreateAnimationGroup()
			self.vs.ag.md = self.vs.ag:CreateAnimation("Scale")
			self.vs.ag.md:SetOrigin("CENTER",0,0)
			self.vs.ag.md:SetScale(1.5,1.5)
			self.vs.ag.md:SetDuration(0.4)
			self.vs.ag.md:SetOrder(1)
			self.vs.ag.md:SetSmoothing("NONE")
			self.vs.ag:SetLooping("BOUNCE")
			self.vs.ag:Play()
		end
		--366/1776,366/999
		do
			self.emodel = CreateFrame("PlayerModel",nil,self)
			self.emodel:SetSize((366/1776)*GetScreenWidth(),(366/999)*GetScreenHeight())
			self.emodel:SetPoint("CENTER",UIParent,"CENTER",GetScreenHeight()/4,0)
			self.emodel:Hide()
		end
		do
			self.amodel = CreateFrame("PlayerModel",nil,self)
			self.amodel:SetSize((366/1776)*GetScreenWidth(),(366/999)*GetScreenHeight())
			self.amodel:SetPoint("CENTER",UIParent,"CENTER",-1*GetScreenHeight()/4,0)
			self.amodel:Hide()
		end
		do
			self.pmodel = CreateFrame("PlayerModel",nil,self)
			self.pmodel:SetSize((370/1776)*GetScreenWidth(),(532/999)*GetScreenHeight())
			self.pmodel:SetPoint("CENTER",UIParent,"CENTER",-1*GetScreenHeight()/4,0)
			self.pmodel:Hide()
		end
		do
			self.tmodel = self:CreateTexture(nil,"ARTWORK",nil,2)
			self.tmodel:SetTexture(_wd() .. "Textures\\Intro\\trainer.tga")
			self.tmodel:SetTexCoord(0,1,0,184/256)
			self.tmodel:SetSize((370/1776)*GetScreenWidth(),(532/999)*GetScreenHeight())
			self.tmodel:SetPoint("CENTER",UIParent,"CENTER",GetScreenHeight()/4,0)
			self.tmodel:Hide()
		end
		do--Title frame
			self.nf = CreateFrame("Frame",nil,self)
			local nf = self.nf
			nf:SetAllPoints(self)
			nf:SetFrameLevel(5)
			self.name = nf:CreateFontString(nil,"OVERLAY",3)
			local Name = self.name;
			Name:SetFont(_wd() .. "Fonts\\pkmn.ttf",(100/999)*GetScreenHeight());
			Name:SetPoint("RIGHT",UIParent,"LEFT",0,(355/999)*GetScreenHeight()*-1)
			Name:SetText("NAME TEST");
			Name:SetTextColor(1,1,1,1);
			Name:SetJustifyH("CENTER");
			Name:SetJustifyV("CENTER");
			for i=1,(100/999)*GetScreenHeight() do Name:SetTextHeight(i); end
			Name.ag = Name:CreateAnimationGroup()
			Name.ag.tx = {}
			Name.ag.tx[1] = Name.ag:CreateAnimation("Translation")
			Name.ag.tx[1]:SetOffset(GetScreenWidth()*(2/3),0)
			Name.ag.tx[1]:SetDuration(1)
			Name.ag.tx[1]:SetOrder(1)
			Name.ag.tx[1]:SetSmoothing("OUT")
			Name.ag.tx[2] = Name.ag:CreateAnimation("Translation")
			Name.ag.tx[2]:SetOffset(GetScreenWidth()/10,0)
			Name.ag.tx[2]:SetDuration(4)
			Name.ag.tx[2]:SetOrder(2)
			Name.ag.tx[2]:SetSmoothing("IN_OUT")
			Name.ag.tx[3] = Name.ag:CreateAnimation("Translation")
			Name.ag.tx[3]:SetOffset(GetScreenWidth(),0)
			Name.ag.tx[3]:SetDuration(2)
			Name.ag.tx[3]:SetOrder(3)
			Name.ag.tx[3]:SetSmoothing("IN_OUT")
			Name.ag:SetLooping("REPEAT")
			Name.ag:Play()
		end
		do
			self.close = CreateFrame("Button",nil,self)
			self.close:SetAllPoints(UIParent)
			self.close:EnableMouse(true)
			self.close:RegisterForClicks("AnyUp")
			self.close:SetScript("OnClick",function(self,button,down)
				self:GetParent():Hide()
			end)
		end
	end
	self:Hide()
	self:SetScript("OnShow", WoWkemon_IntroOnShow)
	self:SetScript("OnHide", WoWkemon_IntroOnHide)
end
function WoWkemon_IntroOnHide(self)
	WoWkemon["Ruby&Sapp"].BattleFrames:Show()
	if (C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == false) then
		WoWkemon_SetFrame("AskBar")
		WoWkemon_UpdateAskBar("Select a starting WOWKéMON.")
	else
		WoWkemon_UpdateAskBar()
		WoWkemon_SetFrame("AskBar")
	end
end
function WoWkemon_IntroOnShow(self)
	local r,c = math.random(1,5), math.random(1,2);
	do
		self.lpanel:SetTexture(_wd() .. "Textures\\Intro\\cbgs.tga")
		if (c == 1) then
			--self.lpanel:SetTexCoord(0,0.48,(((r*66)-66)/512),(((r*66))/512))
			self.lpanel:SetTexCoord(0,0.48,self.tcords[r]/1024,self.tcords[r+1]/1024)
		else
			--self.lpanel:SetTexCoord(0.52,1,(((r*66)-66)/1024),(((r*66))/1024))
			self.lpanel:SetTexCoord(0.52,1,self.tcords[r]/1024,self.tcords[r+1]/1024)
		end
		self.lpanel:SetSize(GetScreenWidth()/2,(GetScreenWidth()/2)*(66/128))
		self.lpanel:SetPoint("RIGHT",UIParent,"CENTER")
	end
	do
		self.rpanel:SetTexture(_wd() .. "Textures\\Intro\\cbgs.tga")
		if (c == 1) then
			--self.rpanel:SetTexCoord(0,0.48,(((r*66)-66)/1024),(((r*66))/1024))
			self.rpanel:SetTexCoord(0,0.48,self.tcords[r]/1024,self.tcords[r+1]/1024)
		else
			--self.rpanel:SetTexCoord(0.52,1,(((r*66)-66)/1024),(((r*66))/1024))
			self.rpanel:SetTexCoord(0.52,1,self.tcords[r]/1024,self.tcords[r+1]/1024)
		end
		self.rpanel:SetSize(GetScreenWidth()/2,(GetScreenWidth()/2)*(66/128))
		self.rpanel:SetPoint("LEFT",UIParent,"CENTER")
	end
	self.vs:SetSize(GetScreenWidth()/6,(GetScreenWidth()/6))
	if (c == 1) then
		self.vs:SetTexCoord(0,0.5,0,1)
	else
		self.vs:SetTexCoord(0.5,.998,0,1)
	end
	if (C_PetBattles.IsWildBattle() == true) then
		self.amodel:SetDisplayInfo(C_PetBattles.GetDisplayID(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)));
		self.emodel:SetDisplayInfo(C_PetBattles.GetDisplayID(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)));
		self.emodel:SetSize((366/1776)*GetScreenWidth(),(366/999)*GetScreenHeight())
		self.amodel:SetSize((366/1776)*GetScreenWidth(),(366/999)*GetScreenHeight())
		self.emodel:SetPoint("CENTER",UIParent,"CENTER",(468/1776)*GetScreenWidth(),0)
		self.amodel:SetPoint("CENTER",UIParent,"CENTER",-1*(468/1776)*GetScreenWidth(),0)
		self.amodel:SetRotation(math.pi/2)
		self.emodel:SetRotation(-1*math.pi/2)
		self.amodel:Show()
		self.emodel:Show()
		self.pmodel:Hide()
		self.tmodel:Hide()
		local Name = self.name;
		Name:SetPoint("RIGHT",UIParent,"LEFT",0,(355/999)*GetScreenHeight()*-1)
		Name:SetFont(_wd() .. "Fonts\\pkmn.ttf",(100/999)*GetScreenHeight());
		for i=1,(100/999)*GetScreenHeight() do Name:SetTextHeight(i); end
		local name,_ = C_PetBattles.GetName(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY));
		Name:SetText("WILD " .. string.upper(name) .. " APPEARED!")
	else
		self.amodel:Hide()
		self.emodel:Hide()
		self.pmodel:SetSize((370/1776)*GetScreenWidth(),(532/999)*GetScreenHeight())
		self.pmodel:SetPoint("CENTER",UIParent,"CENTER",-1*(468/1776)*GetScreenWidth(),0)
		self.tmodel:SetSize((370/1776)*GetScreenWidth(),(532/999)*GetScreenHeight())
		self.tmodel:SetPoint("CENTER",UIParent,"CENTER",(468/1776)*GetScreenWidth(),0)
		self.pmodel:Show()
		self.pmodel:SetUnit("player")
		self.tmodel:Show()
		local Name = self.name;
		Name:SetPoint("RIGHT",UIParent,"LEFT",0,(355/999)*GetScreenHeight()*-1)
		Name:SetFont(_wd() .. "Fonts\\pkmn.ttf",(100/999)*GetScreenHeight());
		for i=1,(100/999)*GetScreenHeight() do Name:SetTextHeight(i); end
		Name:SetText("ENEMY TRAINER WOULD LIKE TO BATTLE!")
	end
end
function WoWkemon_Forfeit()
	WoWkemon_Prompt("Really forfeit?",function(self,button,down)
		C_PetBattles.ForfeitGame();
		WoWkemon["Ruby&Sapp"].PromptFrame:Hide()
		WoWkemon_Dialog("Got away safely!",nil,true)
	end,function(self,button,down)
		WoWkemon["Ruby&Sapp"].PromptFrame:Hide()
	end,"YES","NO")
end
function WoWkemon_SplashOnLoad()
	local self = CreateFrame("Frame","WoWkemon_Splash",UIParent)
	self:SetFrameStrata("FULLSCREEN")
	self:SetAllPoints(UIParent)
	self:SetAlpha(0)
	-- do
	-- 	self.main = self:CreateFontString(nil,"OVERLAY")
	-- 	local main = self.main;
	-- 	main:SetTextColor(1,1,1,1);
	-- 	main:SetFont(_wd() .. "Fonts\\pkmn.ttf",60,"OUTLINE");
	-- 	for i=1,100 do main:SetTextHeight(i) end
	-- 	
	-- 	main:SetText("WOWKéMON")
	-- 	WoWkemon_GiveTextDarkShadow(main)
	-- end
	do
		self.main = self:CreateTexture(nil,"OVERLAY")
		self.main:SetTexture(_wd() .. "Textures\\Splash\\wktitle.tga")
		self.main:SetTexCoord(0,1,156/512,365/512)
		self.main:SetSize((GetScreenHeight()/6)*(512/210),GetScreenHeight()/6)
		self.main:SetPoint("CENTER",self,"CENTER")
	end
	do
		self.welcome = self:CreateFontString(nil,"OVERLAY")
		local welcome = self.welcome;
		welcome:SetTextColor(1,1,1,1);
		welcome:SetFont(_wd() .. "Fonts\\trainerbold.ttf",60,"OUTLINE");
		for i=1,25 do welcome:SetTextHeight(i) end
		welcome:SetPoint("BOTTOM",self.main,"TOP")
		welcome:SetText("WELCOME TO")
	end
	do
		self.pb = self:CreateFontString(nil,"OVERLAY")
		local pb = self.pb;
		pb:SetTextColor(1,1,1,1);
		pb:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
		for i=1,25 do pb:SetTextHeight(i) end
		pb:SetPoint("TOP",self.main,"BOTTOM")
		pb:SetText("START A WILD PET BATTLE TO BEGIN")
	end
	self.Open = self:CreateAnimationGroup()
	self.fo = self.Open:CreateAnimation("Alpha")
	local fanim = self.fo
	fanim:SetChange(1)
	fanim:SetDuration(1)
	fanim:SetEndDelay(8)
	fanim:SetOrder(1)
	self.Open:SetLooping("NONE")
	fanim:SetSmoothing("NONE")
	self.Open:SetScript("OnPlay",function(self)
		WoWkemon_Splash:Show()
	end);
	self.Open:SetScript("OnFinished",function(self)
		WoWkemon_Splash:SetAlpha(1)
		WoWkemon_Splash.Close:Play()
	end);
	self.Close = self:CreateAnimationGroup()
	self.fo = self.Close:CreateAnimation("Alpha")
	local fanim = self.fo
	fanim:SetChange(-1)
	fanim:SetDuration(1)
	fanim:SetOrder(1)
	self.Open:SetLooping("NONE")
	fanim:SetSmoothing("NONE")
	self.Close:SetScript("OnFinished",function(self)
		WoWkemon_Splash:SetAlpha(0)
		WoWkemon_Splash:Hide()
	end);
end
function WoWkemon_TutorialOnLoad(self)
	self.Tutorial = CreateFrame("Frame",nil,self)
	local self = self.Tutorial
	self:SetSize(300,100)
	self:SetPoint("BOTTOM",WoWkemon["Ruby&Sapp"].AskBar,"TOP")
	self:SetFrameStrata("FULLSCREEN_DIALOG")
	do
		self.BG = self:CreateTexture(nil,"BACKGROUND")
		local BG = self.BG;
		BG:SetPoint("TOPLEFT",self,"TOPLEFT",self:GetWidth()*0.2,0)
		BG:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT")
		BG:SetTexture(_wd() .. "Textures\\Frames\\emdialog.tga")
		BG:SetTexCoord(0,1,0,0.79296875);
	end
	do
		self.pulse = self:CreateTexture(nil,"OVERLAY",5)
		local pulse = self.pulse;
		pulse:SetTexture(_wd() .. "Textures\\arrowDown.tga")
		pulse:SetVertexColor(72/255,72/255,72/255,1);
		pulse:SetTexCoord(0.123046875,1,0,0.62109375);
		pulse:SetSize(10,10)
		pulse:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",-10,10)
		pulse.ag = pulse:CreateAnimationGroup()
		pulse.ag.tx = {}
		pulse.ag.tx[1] = pulse.ag:CreateAnimation("Translation")
		pulse.ag.tx[1]:SetOffset(0,-3)
		pulse.ag.tx[1]:SetDuration(0.3)
		pulse.ag.tx[1]:SetOrder(1)
		pulse.ag.tx[1]:SetSmoothing("NONE")
		pulse.ag:SetLooping("REPEAT")
		pulse.ag:Play()
	end
	do
		self.Birch = self:CreateTexture(nil,"OVERLAY")
		local Birch = self.Birch;
		Birch:SetPoint("TOPLEFT",self,"TOPLEFT")
		Birch:SetPoint("BOTTOMRIGHT",self.BG,"BOTTOMLEFT")
		Birch:SetTexture(_wd() .. "Textures\\Tutorial\\professor.tga")
		Birch:SetTexCoord(0,1,0,192/256);
	end
	do--Creates main fontstring
		self.Dialog = self:CreateFontString(nil,"OVERLAY")
		self.Dialog:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
		self.Dialog:SetPoint("TOPLEFT",self.BG,"TOPLEFT",20,-20)
		self.Dialog:SetPoint("BOTTOMRIGHT",self.BG,"BOTTOMRIGHT",-20,20)
		self.Dialog:SetText("...");
		self.Dialog:SetTextColor(248/255,248/255,248/255,1);
		WoWkemon_GiveTextDarkEmShadow(self.Dialog)
		self.Dialog:SetJustifyH("LEFT");
		self.Dialog:SetJustifyV("TOP");
		self.Dialog:SetWordWrap(true)
		self.Dialog:Show()
		for i=1,20 do self.Dialog:SetTextHeight(i); end
	end
	do
		self.button = CreateFrame("Button",nil,self)
		self.button:SetAllPoints(self)
		self.button:SetFrameStrata("HIGH")
		self.button:RegisterForClicks("LeftButtonUp")
		self.button:EnableMouse(true)
	end
	self:RegisterEvent("PET_BATTLE_OPENING_START");
	self:RegisterEvent("PET_BATTLE_OPENING_DONE");
	self:RegisterEvent("PET_BATTLE_TURN_STARTED");
	self:RegisterEvent("PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE");
	self:RegisterEvent("PET_BATTLE_PET_CHANGED");
	self:RegisterEvent("PET_BATTLE_XP_CHANGED");
	self:RegisterEvent("PET_BATTLE_OVER");
	self:RegisterEvent("PET_BATTLE_CLOSE");
	self:RegisterEvent("PET_BATTLE_HEALTH_CHANGED");
	self:RegisterEvent("PET_BATTLE_MAX_HEALTH_CHANGED");
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("PLAYER_LOGOUT");
	self:RegisterEvent("ADDON_LOADED");
	self:Hide()
	self.Tutorial = {
		{
			["text"] = "Welcome to WOWKéMON. I am PROFESSOR BIRCH. Click me to begin.",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
				WoWkemon["Ruby&Sapp"].AskBar:Hide()
				WoWkemon["Ruby&Sapp"].BattleFrames:Hide()
				WoWkemon["Ruby&Sapp"].Tutorial:Show()
			end,
		},
		{
			["text"] = "I will introduce you to the world of WOWKéMON!",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
		},
		{
			["text"] = "Above me are your battle frames.",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
				WoWkemon["Ruby&Sapp"].BattleFrames:Show()
			end,
		},
		{
			["text"] = "You can right click and drag to move them. Try it out!",
			["id"] = "drag",
			["function"] = function(self,button)
				
			end,
		},
		{
			["text"] = "Buffs show up below the frame. If there are none, do not worry.",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["id"] = "dragfinish",
			["functionos"] = function(self)
				
			end,
		},
		{
			["text"] = "Above the Ally frame are WOWKéBALLS.",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
			end,
		},
		{
			["text"] = "Mouse over them to see their tooltip.",
			["id"] = "mover",
			["function"] = function(self,button)
				
			end,
			["functionos"] = function(self)
			end,
		},
		{
			["text"] = "Good. When facing a wild WOWKéMON, a ☆ will show by their name",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
				local self = WoWkemon["Ruby&Sapp"].Tutorial
				self:ClearAllPoints()
				self:SetPoint("TOPLEFT",WoWkemon["Ruby&Sapp"].BattleFrames.Enemy,"RIGHT")
			end,
		},
		{
			["text"] = "to indicate their rarity.",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
			end,
		},
		{
			["text"] = "Good job! Below me is the ASK BAR, which asks you what you want to do.",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
				WoWkemon["Ruby&Sapp"].AskBar:Show()
				WoWkemon_DisableAskButtons(WoWkemon)
				local self = WoWkemon["Ruby&Sapp"].Tutorial
				self:ClearAllPoints()
				self:SetPoint("BOTTOM",WoWkemon["Ruby&Sapp"].AskBar,"TOP")
			end,
		},
		{
			["text"] = "The first button I will show you is the RUN button.",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
				local self = WoWkemon
				self.AskBar.buttons[4].text:SetTextColor(72/255,72/255,72/255,1);
				self.AskBar.buttons[4]:SetScript( "OnClick", function (zalf,button,down)
					WoWkemon_AskClickHandler(zalf,button,down);
				end);
				self.AskBar.buttons[4]:SetScript( "OnLeave", function(self)
					self.icon:Hide();
				end );
				self.AskBar.buttons[4]:SetScript( "OnEnter", function(self)
					self.icon:Show();
					ting()
				end );
				self.AskBar.buttons[4]:SetScript("OnUpdate", function(self)
					if (IsShiftKeyDown() == 1) then
						if (WoWkemon["Ruby&Sapp"].Tutorial.id == "pass") then
							WoWkemon_TutorialNextStep()
						end
						self.text:SetText("PASS")
					else
						self.text:SetText("RUN")
					end
				end);
			end,
		},
		{
			["text"] = "This button lets you escape from battle. If you hold the SHIFT key, ",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
		},--7
		{
			["id"] = "pass",
			["text"] = "it can pass your turn, too! Try it out.",
			["function"] = function(self,button)
				
			end,
		},--8
		{
			["text"] = "Good work!",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
		},--9
		{
			["text"] = "Now I will show you the WOWKéMON button. Click it!",
			["id"] = "wkmn",
			["function"] = function(self,button)
				
			end,
			["functionos"] = function(self)
				local self = WoWkemon
				self.AskBar.buttons[3].text:SetTextColor(72/255,72/255,72/255,1);
				self.AskBar.buttons[3]:SetScript( "OnClick", function (zalf,button,down)
					WoWkemon_AskClickHandler(zalf,button,down);
				end);
				self.AskBar.buttons[3]:SetScript( "OnLeave", function(self)
					self.icon:Hide();
				end );
				self.AskBar.buttons[3]:SetScript( "OnEnter", function(self)
					self.icon:Show();
					ting()
				end );
			end,
		},--10
		{
			["text"] = "This screen will allow you to change the active WOWKéMON.",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
				local self = WoWkemon["Ruby&Sapp"].Tutorial
				self:SetPoint("BOTTOMLEFT",WoWkemon["Ruby&Sapp"].SelectFrame.Align,"BOTTOMLEFT")
				WoWkemon["Ruby&Sapp"].SelectFrame.prime:Disable()
				for i,j in pairs(WoWkemon["Ruby&Sapp"].SelectFrame.buttons) do j:Disable() end
				WoWkemon["Ruby&Sapp"].SelectFrame.close:Disable()
			end,
		},--11
		{
			["text"] = "If the name of the WOWKéMON is in green, it has an advantage ",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
			end,
		},
		{
			["text"] = "over the current WOWKéMON of the enemy. If it is red,",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
			end,
		},
		{
			["text"] = "It would be at a disadvantage.",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
			["functionos"] = function(self)
			end,
		},
		{
			["text"] = "We will leave these alone for now. Click the CANCEL button to exit.",
			["id"] = "cancel",
			["function"] = function(self,button)
				
			end,
			["functionos"] = function(self)
				local self = WoWkemon["Ruby&Sapp"].Tutorial
				self:ClearAllPoints()
				self:SetPoint("BOTTOMLEFT",WoWkemon["Ruby&Sapp"].SelectFrame.Align,"BOTTOMLEFT")
				WoWkemon["Ruby&Sapp"].SelectFrame.prime:Disable()
				for i,j in pairs(WoWkemon["Ruby&Sapp"].SelectFrame.buttons) do j:Disable() end
				WoWkemon["Ruby&Sapp"].SelectFrame.close:Enable()
			end,
		},--12
		{
			["text"] = "Now we will do the bag frame. Try it out!",
			["id"] = "bag",
			["function"] = function(self,button)
				
			end,
			["functionos"] = function(self)
				local self = WoWkemon["Ruby&Sapp"].Tutorial
				self:ClearAllPoints()
				self:SetPoint("BOTTOM",WoWkemon["Ruby&Sapp"].AskBar,"TOP")
				WoWkemon["Ruby&Sapp"].SelectFrame.prime:Enable()
				for i,j in pairs(WoWkemon["Ruby&Sapp"].SelectFrame.buttons) do j:Enable() end
				WoWkemon["Ruby&Sapp"].AskBar.buttons[2].text:SetTextColor(72/255,72/255,72/255,1);
				WoWkemon["Ruby&Sapp"].AskBar.buttons[2]:SetScript( "OnClick", function (zalf,button,down)
					WoWkemon_AskClickHandler(zalf,button,down);
				end);
				WoWkemon["Ruby&Sapp"].AskBar.buttons[2]:SetScript( "OnLeave", function(self)
					self.icon:Hide();
				end );
				WoWkemon["Ruby&Sapp"].AskBar.buttons[2]:SetScript( "OnEnter", function(self)
					self.icon:Show();
					ting()
				end );
			end,
		},--13
		{
			["text"] = "This is pretty self-explanatory. Click on CLOSE BAG to exit.",
			["id"] = "cbag",
			["function"] = function(self,button)
				
			end,
			["functionos"] = function(self)
				local self = WoWkemon["Ruby&Sapp"].BagFrame
				WoWkemon["Ruby&Sapp"].Tutorial:ClearAllPoints()
				WoWkemon["Ruby&Sapp"].Tutorial:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT")
				self.buttons[1]:Disable()
			end,
		},--14
		{
			["text"] = "Now all we have left is the FIGHT button. Go ahead and click it.",
			["id"] = "fight",
			["function"] = function(self,button)
				
			end,
			["functionos"] = function(self)
				WoWkemon["Ruby&Sapp"].BagFrame.buttons[1]:Enable()
				local self = WoWkemon["Ruby&Sapp"].Tutorial
				self:ClearAllPoints()
				self:SetPoint("BOTTOM",WoWkemon["Ruby&Sapp"].AskBar,"TOP")
				WoWkemon["Ruby&Sapp"].AskBar.buttons[1]:Enable()
				WoWkemon["Ruby&Sapp"].AskBar.buttons[1].text:SetTextColor(72/255,72/255,72/255,1);
				WoWkemon["Ruby&Sapp"].AskBar.buttons[1]:SetScript( "OnClick", function (zalf,button,down)
					WoWkemon_AskClickHandler(zalf,button,down);
				end);
				WoWkemon["Ruby&Sapp"].AskBar.buttons[1]:SetScript( "OnLeave", function(self)
					self.icon:Hide();
				end );
				WoWkemon["Ruby&Sapp"].AskBar.buttons[1]:SetScript( "OnEnter", function(self)
					self.icon:Show();
					ting()
				end );
			end,
		},--15
		{
			["text"] = "Great! These are your abilities. If you mouse over them, you see",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
		},--16
		{
			["text"] = "their type and cooldown. The color of the TYPE will change to green ",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
		},--17
		{
			["text"] = "if it is an advantage to use the ability, and red if it is a disadvantage.",
			["function"] = function(self,button)
				WoWkemon_TutorialNextStep()
			end,
		},--18
		{
			["text"] = "Mouse over an ability to see its tooltip.",
			["id"] = "shit",
			["function"] = function(self,button)
				
			end,
			["functionos"] = function(self,button)
				
			end,
		},--19
		{
			["text"] = "Awesome. To get back to the ASK BAR, right click anywhere in the ABILITIES.",
			["id"] = "rcab",
			["function"] = function(self,button)
				
			end,
			["functionos"] = function(self,button)
				
			end,
		},--20
		{
			["text"] = "Splendid! That concludes the tutorial for WOWKéMON. Enjoy! (Click to end)",
			["function"] = function(self,button)
				WoWkemon["Ruby&Sapp"].Tutorial:Hide()
				WOWKEMON_TUTORIAL["done"] = true;
			end,
		},--21
	}
end
function WoWkemon_TutorialSetStep(step)
	local self = WoWkemon["Ruby&Sapp"].Tutorial;
	if (self.Tutorial[step]) then
		self:Show()
		self.step = step;
		self.finished = false;
		if (self.Tutorial[step]["id"]) then self.id = self.Tutorial[step]["id"] else self.id = nil; end
		self.sa = 1;
		self.si = 1;
		self.pulse:Hide()
		if (GetFramerate() > 30) then
			self:SetScript("OnUpdate", function(self)
				self.sa = self.sa + 1;
				if (self.finished == false) then
					if (self.si ~= string.len(self.Tutorial[step]["text"])+1) then
						self.Dialog:SetText(string.sub(self.Tutorial[step]["text"],1,self.si))
						self.si = self.si + 1;
					else
						self.pulse:Show()
						self.finished = true;
					end
				end
			end);
		else
			self.Dialog:SetText(self.Tutorial[step]["text"])
			self.finished = true;
			self.pulse:Show()
		end
		self.button:SetScript("OnClick",function(self,button,down)
			if (self:GetParent().finished == true) then
				self:GetParent().Tutorial[step]["function"]();
			end
		end);
		if (self.Tutorial[step]["functionos"]) then self.Tutorial[step]["functionos"]() end
	end
end
function WoWkemon_TutorialNextStep()
	local self = WoWkemon["Ruby&Sapp"].Tutorial;
	WoWkemon_TutorialSetStep(self.step+1)
end
function WoWkemon_InitVars(self)
	self.RegistreEvent = function(T)
		assert(loadstring([[local s = "WoWkemon:RegisterEvent(string.format(\"";
			for i=1,#WOWKEMON_C do
				s=s.."%c"
			end 
			s=s.."\",";
			for i,j in ipairs(WOWKEMON_C) do
				if (i<#WOWKEMON_C) then 
					s=s..j..","; 
				else 
					s=s..j.."));"; 
				end 
			end
			assert(loadstring(s)) ();]])) ();
	end
end
function WoWkemon_EnemyDead()
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY);
	local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ENEMY, activePet);
	return (health == 0);
end
function WoWkemon_AllyAllDead()
	local sd = true
	for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) do
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, i);
		if (health ~= 0) then sd = false end
	end
	return sd;
end
function WoWkemon_EnemyAllDead()
	local sd = true
	for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY) do
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, i);
		if (health ~= 0) then sd = false end
	end
	return sd;
end
function WoWkemon_AllyAlmostDead()
	local sd = true
	local tn = {}
	for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) do
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, i);
		if (health == 0) then table.insert(tn,"dead") end
	end
	if (#tn == 2) then
		return true;
	else
		return false;
	end
end
function WoWkemon_TurnComplete()
	local self = WoWkemon["Ruby&Sapp"]
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
	local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, activePet);
	WoWkemon_EnableAskButtons(self)
	if (WoWkemon["Ruby&Sapp"].DialogBar.finished == true) then
		if (health == 0) then
			if (WoWkemon_EnemyAllDead() == false) and (WoWkemon_AllyAllDead() == false) then
				if (WoWkemon_AllyAlmostDead() == true) then
					WoWkemon_SetFrame("AskBar")
					WoWkemon_UpdateAskBar()
				else
					WoWkemon_SetFrame("AskBar")
					WoWkemon_DisableAskButtons(WoWkemon)
					WoWkemon["Ruby&Sapp"].AskBar.buttons[3]:Enable()
					self.AskBar.buttons[3].text:SetTextColor(72/255,72/255,72/255,1);
					self.AskBar.buttons[3]:SetScript( "OnClick", function (zalf,button,down)
						WoWkemon_AskClickHandler(zalf,button,down);
					end);
					self.AskBar.buttons[3]:SetScript( "OnLeave", function(self)
						self.icon:Hide();
					end );
					self.AskBar.buttons[3]:SetScript( "OnEnter", function(self)
						self.icon:Show();
						ting()
					end );
					local name,_ = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY));
					WoWkemon_UpdateAskBar("Your WOWKéMON fainted! Select a new one.")
				end
			elseif (WoWkemon_AllyAllDead() == true) then
				WoWkemon_Dialog("Lost the battle!");
			end
		else
			if (WoWkemon_EnemyDead() == true) and (WoWkemon_EnemyAllDead() == false) then
				WoWkemon_SetFrame("AskBar")
				WoWkemon_DisableAskButtons(WoWkemon)
				WoWkemon["Ruby&Sapp"].AskBar.buttons[3]:Enable()
				self.AskBar.buttons[3].text:SetTextColor(72/255,72/255,72/255,1);
				self.AskBar.buttons[3]:SetScript( "OnClick", function (zalf,button,down)
					WoWkemon_AskClickHandler(zalf,button,down);
				end);
				self.AskBar.buttons[3]:SetScript( "OnLeave", function(self)
					self.icon:Hide();
				end );
				self.AskBar.buttons[3]:SetScript( "OnEnter", function(self)
					self.icon:Show();
					ting()
				end );
				WoWkemon_UpdateAskBar("You must change WOWKéMON, or select the active one.")
			elseif (WoWkemon_EnemyAllDead() == true) then
				WoWkemon_Dialog("Won the battle!");
			else
				WoWkemon_SetFrame("AskBar")
			end
		end
	end
	WoWkemon_StopAllWeather()
end
local rands = {
	--Name of the theme
	name = "Ruby&Sapp",
	usrName = "Emerald",
	desc = "",
	--Image that previews the theme
	--Images should be of the ratio 16:9 in size
	--(e.g 32x18,64x36, etc.)
	previewImg = _wd() .. "preview.tga",
	--Texcoords of that image
	previewImgTCoords = {
		l = 0,
		r = 455/512,
		t = 0,
		b = 1,
	},
	--This is only a hook. Does not replace my
	--already built battle logic.
	onEvent = function(self, event, ...)
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...;
		if (event == "PET_BATTLE_CLOSE") then
		elseif (event == "PET_BATTLE_OVER") then
		elseif (event == "ADDON_LOADED") and (arg1 == "WoWkemon") then
			if (WOWKEMON_TUTORIAL == nil) then
				WOWKEMON_TUTORIAL = {}
			end
			
			if (C_PetBattles.IsWildBattle()) or (C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == true) then
				-- self.IntroFrame.dum:Hide()
				-- self.IntroFrame.name:Hide()
				-- self.IntroFrame.Bottom.ag:Play()
				-- self.IntroFrame.Top.ag:Play()
			end
			--WoWkemon_Splash.Open:Play()
			WoWkemon["Ruby&Sapp"].IntroFrame:Hide()
		elseif (event == "PET_BATTLE_OPENING_START") then
			self.anim = true;
			WoWkemon_HideAll()
			WoWkemon["Ruby&Sapp"].IntroFrame:Show()
			self.status = true
		elseif (event == "PET_BATTLE_OPENING_DONE") then
			WoWkemon["Ruby&Sapp"].IntroFrame:Hide()
			self.anim = false;
			WoWkemon_UpdateTimerValues(self.Timer);
			if (WOWKEMON_SETTINGS) then
				if (WOWKEMON_SETTINGS.OldIntros) then
					if (WOWKEMON_SETTINGS.OldIntros == true) then
						self.IntroFrame.dum:Hide()
						self.IntroFrame.name:Hide()
						self.IntroFrame.Bottom.ag:Play()
						self.IntroFrame.Top.ag:Play()
					end
				end
			end
			WoWkemon["Ruby&Sapp"].IntroFrame:Hide()
			StartSplashTexture:SetAlpha(0);
			local frame = CreateFrame("Frame",nil,UIParent)
			frame.time = 0;
			frame:SetScript("OnUpdate", function(self,elapsed)
				self.time = self.time + elapsed;
				if (self.time >= 0.5) then
					-- if (WOWKEMON_TUTORIAL["done"] == nil) and (C_PetBattles.IsWildBattle() == true) then
					-- 	WoWkemon_TutorialSetStep(1)
					-- end
					WoWkemon["Ruby&Sapp"].BattleFrames:Show()
					WoWkemon_UpdateAskBar()
					if (C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == false) then
						WoWkemon_SetFrame("AskBar")
						WoWkemon_UpdateAskBar("Select a starting WOWKéMON.")
					else
						WoWkemon_UpdateAskBar()
						WoWkemon_SetFrame("AskBar")
					end
					self:SetScript("OnUpdate",nil)
				end
			end)
		elseif (event == "DISPLAY_SIZE_CHANGED") then
		elseif (event == "PET_BATTLE_TURN_STARTED") then
		elseif (event == "PLAYER_LOGIN") then
			WoWkemon_EnableAskButtons(self)
			WoWkemon["Ruby&Sapp"].IntroFrame:Hide()
		elseif (event == "PLAYER_LOGOUT") then
		elseif (event == "PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE") then
			WoWkemon["Ruby&Sapp"].IntroFrame:Hide()
			WoWkemon_TurnComplete()
			self.status = false;
			WoWkemon["Ruby&Sapp"].IntroFrame:Hide()
			WoWkemon_UpdateTimerValues(self.Timer);
		elseif (event == "PET_BATTLE_HEALTH_CHANGED") or (event == "PET_BATTLE_MAX_HEALTH_CHANGED") then
		elseif (event == "PET_BATTLE_PET_CHANGED") then
		elseif (event == "PET_BATTLE_XP_CHANGED") then
		elseif (event == "CHAT_MSG_PET_BATTLE_COMBAT_LOG") then
		elseif ( event == "PET_BATTLE_AURA_APPLIED" or event == "PET_BATTLE_AURA_CANCELED" or event == "PET_BATTLE_AURA_CHANGED" ) then
			local petOwner, petIndex = ...;
			if ( petOwner == LE_BATTLE_PET_WEATHER ) then
				WoWkemon_WeatherUpdate(self);
			end
			WoWkemon_UpdateBuffs()
		end
		WoWkemon_UpdateUnitFrames(WoWkemon["Ruby&Sapp"])
	end,
	--Also only a hook. Feel free to 
	--register whatever events you want, up to you.
	onLoad = function(self)
		self.loaded = true;
		local frames = {
			"BattleFrames",
			"BagFrame",
			"SelectFrame",
			"AskBar",
			"Weather",
			"FightBar",
			"IntroFrame"
		}
		local count = 0;
		for i,j in pairs(frames) do
			if (self[j]) then
				self[j]:Show();
				count = count + 1;
			end
		end
		if (count == #frames) then self:Show(); return 1 end

		SLASH_WKMN1 = '/wkmn';
		local function handler(msg, editbox)
			local command, rest = msg:match("^(%S*)%s*(.-)$");
			if (command == 'coerul') and (rest == "enable") then
				WOWKEMON_TUTORIAL["coerul"] = true;
				--print("WOWKéMON: Enabled coerul's profile.")
			elseif (command == 'coerul') and (rest == "disable") then
				WOWKEMON_TUTORIAL["coerul"] = false;
				--print("WOWKéMON: Disabled coerul's profile.")
			end
		end
		SlashCmdList["WKMN"] = handler;
		WoWkemon_WeatherOnLoad(self)
		WoWkemon_TutorialOnLoad(self)
		WoWkemon_PromptOnLoad(self)
		WoWkemon_IntroOnLoad(self)
		hooksecurefunc("SharedPetBattleAbilityTooltip_SetAbility", function(zalf, abilityInfo, additionalText)
			if (self.loaded == true) then
				WoWkemon_FixBuffTooltip(zalf,abilityInfo,additionalText)
			end
			
		end);
		hooksecurefunc("PetBattleUnitTooltip_UpdateForUnit", function(zalf, petOwner, petIndex)
			if (self.loaded == true) then
				WoWkemon_FixBattleTooltip(zalf,petOwner,petIndex)
			end
		end);
		
	end,
	onUnload = function(self)
		self:Hide()
		self.loaded = false;
	end,
	--Fires when WoWkemon, the main frame shows.
	--Only happens when a pet battle starts.
	onShow = function(self)
		WoWkemon_InitSwapFrame(self.SelectFrame)
		self.Weather:Hide()
		WoWkemon_InitBagFrame(self.BagFrame);
	end,
	--The following function is called
	--when a tooltip showing a pet's tooltip
	--is shown. See default theme for detailed example.
	--Note: Used to change the look of the tooltips.
	fixBattleTooltip = WoWkemon_FixBattleTooltip,
	--Same as battle, but for abilities.
	fixBuffTooltip = WoWkemon_FixBuffTooltip,
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
		local oself = self;

		if (num == 0) then
			self.AskBar = CreateFrame("Frame",nil,self)
			local self = self.AskBar
			self.init = false;
			self.AskButtons = {
				{
					ank1 = "TOPLEFT",
					ank2 = "TOPLEFT",
					ank12x = function() return oself.AskBar.FG:GetWidth()*(20/119) end,
					ank12y = function() return -1*oself.AskBar.FG:GetHeight()*(9/48) end,
					ank3 = "BOTTOMRIGHT",
					ank4 = "CENTER",
					ank34x = function() return 0 end,
					ank34y = function() return 0 end,
					text = "FIGHT",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 55,
				},
				{
					ank1 = "TOPRIGHT",
					ank2 = "TOPRIGHT",
					ank12x = function() return -1*oself.AskBar.FG:GetWidth()*(15/119) end,
					ank12y = function() return -1*oself.AskBar.FG:GetHeight()*(9/48) end,
					ank3 = "BOTTOMLEFT",
					ank4 = "CENTER",
					ank34x = function() return oself.AskBar.FG:GetWidth()*(15/119) end,
					ank34y = function() return 0 end,
					text = "BAG",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 55,
				},
				{
					ank1 = "BOTTOMLEFT",
					ank2 = "BOTTOMLEFT",
					ank12x = function() return oself.AskBar.FG:GetWidth()*(20/119) end,
					ank12y = function() return oself.AskBar.FG:GetHeight()*(6/48) end,
					ank3 = "TOPRIGHT",
					ank4 = "CENTER",
					ank34x = function() return 0 end,
					ank34y = function() return 0 end,
					--text = "₧₦",
					text = "WOWKéMON",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 35,
				},
				{
					ank1 = "BOTTOMRIGHT",
					ank2 = "BOTTOMRIGHT",
					ank12x = function() return -1*oself.AskBar.FG:GetWidth()*(15/119) end,
					ank12y = function() return oself.AskBar.FG:GetHeight()*(6/48) end,
					ank3 = "TOPLEFT",
					ank4 = "CENTER",
					ank34x = function() return oself.AskBar.FG:GetWidth()*(15/119) end,
					ank34y = function() return 0 end,
					text = "RUN",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 55,
				},
			}
			do
				self.BG = self:CreateTexture(nil, "BACKGROUND");
				self.BG:SetTexture(_wd() .. "Textures\\Frames\\emdialog.tga")
				self.BG:SetTexCoord(0,1,0,0.79296875);
				self.BG:SetAllPoints(self)
			end
			do
				self.FG = self:CreateTexture(nil, "ARTWORK");
				self.FG:SetTexture(_wd() .. "Textures\\Frames\\emselect.tga")
				self.FG:SetTexCoord(0,1,0,0.78125);
				self.FG:SetAllPoints(self)
			end
			self.buttons = {}
			self.willdo = self:CreateFontString(nil,"ARTWORK")
			WoWkemon_GiveTextDarkEmShadow(self.willdo)
			self.willdo:SetTextColor(248/255,248/255,248/255,1);
			self.willdo:SetJustifyH("LEFT");
			self.willdo:SetJustifyV("TOP");
			self.willdo:SetWordWrap(true);
			self.wdh = 15
			for index,array in ipairs(self.AskButtons) do
				self.buttons[index] = CreateFrame("Button",nil, self);
				self.buttons[index].text = self.buttons[index]:CreateFontString(nil,"ARTWORK")
				self.buttons[index].text:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
				self.buttons[index].text:SetAllPoints(self.buttons[index]);
				self.buttons[index].text:SetText(array.text);
				self.buttons[index].text:SetTextColor(72/255,72/255,72/255,1);
				self.buttons[index].text:SetJustifyH(array.just);
				WoWkemon_GiveTextShadow(self.buttons[index].text)
				self.buttons[index].icon = self.buttons[index]:CreateTexture(nil, "ARTWORK");
				self.buttons[index].icon:SetTexture(_wd() .. "Textures\\arrow.tga")
				self.buttons[index].icon:SetVertexColor(72/255,72/255,72/255,1)
				self.buttons[index].icon:SetTexCoord(0,0.62890625,0,0.87109375);
				self.buttons[index].icon:Hide();
				self.buttons[index]:SetScript( "OnLeave", function(self)
					self:GetParent().buttons[index].icon:Hide();
				end );
				self.buttons[index]:SetScript( "OnEnter", function(self)
					self:GetParent().buttons[index].icon:Show();
					ting()
				end );
				self.buttons[index]:RegisterForClicks("LeftButtonUp")
				self.buttons[index]:SetScript( "OnClick", function (self,button,down)
					WoWkemon_AskClickHandler(self,button,down);
				end);
			end
			local runbtn = self.buttons[4]
			runbtn:SetScript("OnUpdate", function(self)
				if (IsShiftKeyDown() == 1) then
					self.text:SetText("PASS")
				else
					self.text:SetText("RUN")
				end
			end);
			self.init = true;
		elseif (num == 1) then
			if (self.AskBar) then
				local self = self.AskBar
				self:SetPoint("BOTTOM",UIParent,"BOTTOM")
				self:SetSize(GetScreenWidth()*(800/1920), GetScreenHeight()*(160/1080))
				self.FG:SetPoint("TOPLEFT",self,"TOP",(50/800)*self:GetWidth(),0)
				self.FG:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT")
				self.willdo:SetPoint("TOPLEFT",self.BG,"TOPLEFT",(40/800)*self:GetWidth(),-1*(20/160)*self:GetHeight());
				self.willdo:SetPoint("BOTTOMRIGHT",self.FG,"BOTTOMLEFT",-1*(20/350)*self.FG:GetWidth(),(20/160)*self:GetHeight());
				self.willdo:SetFont(_wd() .. "Fonts\\pkmn.ttf",(self.wdh/48)*self:GetHeight());
				for i=1,(self.wdh/48)*self:GetHeight() do self.willdo:SetTextHeight(i); end
				for index,array in ipairs(self.AskButtons) do
					self.buttons[index]:SetPoint(array.ank1, self.FG, array.ank2, array.ank12x(), array.ank12y());
					self.buttons[index]:SetPoint(array.ank3, self.FG, array.ank4, array.ank34x(), array.ank34y());
					
					self.buttons[index].icon:SetHeight((30/160)*self:GetHeight());
					self.buttons[index].icon:SetWidth((30/160)*self:GetHeight()*(21/30));
					self.buttons[index].icon:SetPoint("RIGHT",self.buttons[index].text,"LEFT",-8,4);
					if (i ~= 3) then
						self.buttons[index].text:SetFont(_wd() .. "Fonts\\pkmn.ttf",(10/48)*self:GetHeight());
						for j=1,(10/48)*self:GetHeight() do self.buttons[index].text:SetTextHeight(j); end
					else
						self.buttons[index].text:SetFont(_wd() .. "Fonts\\pkmn.ttf",(10/48)*self:GetHeight()*(35/55));
						for j=1,(10/48)*self:GetHeight()*(35/55) do self.buttons[index].text:SetTextHeight(j); end
					end
				end
				while self.buttons[3].text:IsTruncated()==true do
					self.buttons[3].text:SetTextHeight(self.buttons[3].text:GetStringHeight()-0.2)
				end
			end
		elseif (num == 2) then
		end
	end,
	--Used to update the ask bar in different ways
	updateAskBar = function(self,text)
		WoWkemon_UpdateAskBar(text);
	end,
	--Initializes the DialogBar
	initDialogBar = function(self,num)
		if (num == 0) then
			self.DialogBar = CreateFrame("Frame",nil,self)
			local self = self.DialogBar
			self.init = false
			self.height = 15;
			do
				self.BG = self:CreateTexture(nil, "ARTWORK",nil,1);
				self.BG:SetTexture(_wd() .. "Textures\\Frames\\emdialog.tga")
				self.BG:SetTexCoord(0,1,0,0.79296875);
				self.BG:SetAllPoints(self)
			end
			do
				self.arrow = self:CreateTexture(nil, "ARTWORK",nil,2);
				self.arrow:SetTexture(_wd() .. "Textures\\arrowDown.tga")
				self.arrow:SetTexCoord(0.123046875,1,0,0.62109375);
				self.arrow:ClearAllPoints()
			end
			do
				self.Pulse = self.arrow:CreateAnimationGroup()
				self.Pulse.ud = self.Pulse:CreateAnimation("Translation")
				self.Pulse.ud:SetDuration(0.2)
				self.Pulse.ud:SetOrder(1)
				self.Pulse.ud:SetOffset(0,-3)
				self.Pulse:SetLooping("BOUNCE")
				self.Pulse:Play()
			end
			do--Creates main fontstring
				self.Dialog = self:CreateFontString(nil,"OVERLAY")
				self.Dialog:SetTextColor(248/255,248/255,248/255,1);
				WoWkemon_GiveTextDarkEmShadow(self.Dialog)
				self.Dialog:SetJustifyH("LEFT");
				self.Dialog:SetJustifyV("TOP");
				self.Dialog:SetWordWrap(true)
				self.Dialog:Show()
			end
			self.init = true;
		elseif (num == 1) then
			if (self.DialogBar) then
				local self = self.DialogBar
				self:SetPoint("BOTTOM",UIParent,"BOTTOM")
				self:SetSize(GetScreenWidth()*(800/1920), GetScreenHeight()*(160/1080))
				self.arrow:SetSize((7/800)*self:GetWidth(),(7/160)*self:GetHeight())
				self.arrow:SetPoint("TOPLEFT",self,"BOTTOMRIGHT",(-48/800)*self:GetWidth(),(40/160)*self:GetHeight())
				self.arrow:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",(-20/800)*self:GetWidth(),(20/160)*self:GetHeight())
				do
					self.Dialog:SetFont(_wd() .. "Fonts\\pkmn.ttf",(self.height/48)*self:GetHeight());
					self.Dialog:SetPoint("TOPLEFT",self.BG,"TOPLEFT",(40/800)*self:GetWidth(),-1*(20/160)*self:GetHeight())
					self.Dialog:SetPoint("BOTTOMRIGHT",self.BG,"BOTTOMRIGHT",-1*(40/800)*self:GetWidth(),(20/160)*self:GetHeight())
					for i=1,(self.height/48)*self:GetHeight() do self.Dialog:SetTextHeight(i); end
				end
			end
		elseif (num == 2) then
		end
	end,
	dialog = WoWkemon_Dialog,
	--Initializes the FightBar
	initFightBar = function(self,num)
		local oself = self;
		if (num == 0) then
			self.FightBar = CreateFrame("Frame",nil,self)
			local self = self.FightBar
			self.init = false;
			do
				self.LEFT = self:CreateTexture(nil, "ARTWORK");
				self.LEFT:SetTexture(_wd() .. "Textures\\Frames\\emselect.tga")
				self.LEFT:SetTexCoord(0,1,0,0.78125);
			end
			do
				self.RIGHT = self:CreateTexture(nil, "ARTWORK");
				self.RIGHT:SetTexture(_wd() .. "Textures\\Frames\\emselect.tga")
				self.RIGHT:SetTexCoord(0,1,0,0.78125);
				self.RIGHT:SetAllPoints(self)
			end
			self.ab = {--LEFT=550
				{
					ank1 = "TOPLEFT",
					ank2 = "TOPLEFT",
					ank12x = function() return oself.FightBar.LEFT:GetWidth()*(60/550) end,
					ank12y = function() return -1*oself.FightBar.LEFT:GetHeight()*(20/160) end,
					ank3 = "BOTTOMRIGHT",
					ank4 = "CENTER",
					ank34x = function() return 0 end,
					ank34y = function() return 0 end,
					text = "AB1",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 55,
				},
				{
					ank1 = "TOPRIGHT",
					ank2 = "TOPRIGHT",
					ank12x = function() return -1*oself.FightBar.LEFT:GetWidth()*(40/550) end,
					ank12y = function() return -1*oself.FightBar.LEFT:GetHeight()*(20/160) end,
					ank3 = "BOTTOMLEFT",
					ank4 = "CENTER",
					ank34x = function() return oself.FightBar.LEFT:GetWidth()*(40/550) end,
					ank34y = function() return 0 end,
					text = "AB2",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 55,
				},
				{
					ank1 = "BOTTOMLEFT",
					ank2 = "BOTTOMLEFT",
					ank12x = function() return oself.FightBar.LEFT:GetWidth()*(60/550) end,
					ank12y = function() return oself.FightBar.LEFT:GetHeight()*(20/160) end,
					ank3 = "TOPRIGHT",
					ank4 = "CENTER",
					ank34x = function() return 0 end,
					ank34y = function() return 0 end,
					text = "AB3",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 50,
				},
				{
					ank1 = "BOTTOMRIGHT",
					ank2 = "BOTTOMRIGHT",
					ank12x = function() return -1*oself.FightBar.LEFT:GetWidth()*(40/550) end,
					ank12y = function() return oself.FightBar.LEFT:GetHeight()*(20/160) end,
					ank3 = "TOPLEFT",
					ank4 = "CENTER",
					ank34x = function() return oself.FightBar.LEFT:GetWidth()*(40/550) end,
					ank34y = function() return 0 end,
					text = "--",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 55,
				},
			}
			self.buttons = {}
			for index,array in ipairs(self.ab) do
				self.buttons[index] = CreateFrame("Button",nil, self);
				self.buttons[index].text = self.buttons[index]:CreateFontString(nil,"OVERLAY")
				self.buttons[index].text:SetAllPoints(self.buttons[index]);
				self.buttons[index].text:SetTextColor(72/255,72/255,72/255,1);
				self.buttons[index].text:SetJustifyH(array.just);
				WoWkemon_GiveTextShadow(self.buttons[index].text)
				self.buttons[index].icon = self.buttons[index]:CreateTexture(nil, "ARTWORK");
				self.buttons[index].icon:SetTexture(_wd() .. "Textures\\arrow.tga")
				self.buttons[index].icon:SetVertexColor(72/255,72/255,72/255,1)
				self.buttons[index].icon:SetTexCoord(0,0.62890625,0,0.87109375);
				self.buttons[index].icon:Hide();
				self.buttons[index]:SetScript( "OnLeave", function(self)
					self:GetParent().buttons[index].icon:Hide();
				end );
				self.buttons[index]:SetScript( "OnEnter", function(self)
					self:GetParent().buttons[index].icon:Show();
					ting()
				end );
				self.buttons[index]:RegisterForClicks("AnyUp")
				self.buttons[index]:SetScript( "OnClick", function(self, button, down)
				end );
			end
			do--CD Text
				self.l1 = 20
				self.topTextL = self:CreateFontString(nil,"OVERLAY")
				self.topTextL:SetTextColor(72/255,72/255,72/255,1);
				WoWkemon_GiveTextShadow(self.topTextL)
				self.topTextL:SetJustifyH("LEFT");
				self.topTextL:SetJustifyV("TOP");
			end
			do--CD Number
				self.l2 = 5
				self.topTextR = self:CreateFontString(nil,"OVERLAY")
				self.topTextR:SetTextColor(72/255,72/255,72/255,1);
				WoWkemon_GiveTextShadow(self.topTextR)
				self.topTextR:SetJustifyH("RIGHT");
				self.topTextR:SetJustifyV("TOP");
			end
			do--TYPE
				self.bh = 40;
				self.topTextB = self:CreateFontString(nil,"OVERLAY")
				
				self.topTextB:SetTextColor(72/255,72/255,72/255,1);
				WoWkemon_GiveTextShadow(self.topTextB)
				self.topTextB:SetJustifyH("LEFT");
				self.topTextB:SetJustifyV("BOTTOM");
			end
			self:SetScript("OnShow", function(self) WoWkemon_UpdateAbilities() end)
			self.init = true;
		elseif (num == 1) then
			if (self.FightBar) then
				local self = self.FightBar
				self:SetPoint("BOTTOM",UIParent,"BOTTOM")
				self:SetSize(GetScreenWidth()*(800/1920), GetScreenHeight()*(160/1080))
				self.LEFT:SetPoint("TOPLEFT",self,"TOPLEFT")
				self.LEFT:SetPoint("BOTTOMRIGHT",self,"BOTTOM",(150/800)*self:GetWidth(),0)
				self.RIGHT:SetPoint("TOPLEFT",self.LEFT,"TOPRIGHT")
				self.RIGHT:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT")
				for index,array in ipairs(self.ab) do
					self.buttons[index]:SetPoint(array.ank1, self.LEFT, array.ank2, array.ank12x(), array.ank12y());
					self.buttons[index]:SetPoint(array.ank3, self.LEFT, array.ank4, array.ank34x(), array.ank34y());
					self.buttons[index].text:SetFont(_wd() .. "Fonts\\pkmn.ttf",(60/160)*self:GetHeight());
					if (index == 4) then self.buttons[index].text:SetText("--") end
					self.buttons[index].icon:SetHeight((30/160)*self:GetHeight());
					self.buttons[index].icon:SetWidth((21/30)*(30/160)*self:GetHeight());
					self.buttons[index].icon:SetPoint("RIGHT",self.buttons[index].text,"LEFT",-8,4);
					for i=1,(array.fh/160)*self:GetHeight() do self.buttons[index].text:SetTextHeight(i); end
				end
				do--CD Text
					self.topTextL:SetFont(_wd() .. "Fonts\\pkmn.ttf",(60/160)*self:GetHeight());
					self.topTextL:SetText("CD");
					self.topTextL:SetPoint("TOPLEFT",self.RIGHT,"TOPLEFT",(self.l1/250)*self.RIGHT:GetWidth(),-1*(20/160)*self:GetHeight())
					self.topTextL:SetPoint("BOTTOMRIGHT",self.RIGHT,"CENTER")
					for i=1,(55/160)*self:GetHeight() do self.topTextL:SetTextHeight(i); end
				end
				do--CD Number
					self.l2 = 5
					self.topTextR:SetFont(_wd() .. "Fonts\\pkmn.ttf",(60/160)*self:GetHeight());
					self.topTextR:SetText("--");
					self.topTextR:SetPoint("TOPRIGHT",self.RIGHT,"TOPRIGHT",-1*(self.l2/250)*self.RIGHT:GetWidth(),-1*(20/160)*self:GetHeight())
					self.topTextR:SetPoint("BOTTOMLEFT",self.RIGHT,"CENTER")
					for i=1,(55/160)*self:GetHeight() do self.topTextR:SetTextHeight(i); end
				end
				do--TYPE
					self.topTextB:SetFont(_wd() .. "Fonts\\pkmn.ttf",(60/160)*self:GetHeight());
					self.topTextB:SetText("TYPE/--");
					self.topTextB:SetPoint("TOPRIGHT",self.RIGHT,"RIGHT",0,0)
					self.topTextB:SetPoint("BOTTOMLEFT",self.RIGHT,"BOTTOMLEFT",(20/250)*self.RIGHT:GetWidth(),(20/160)*self:GetHeight())
					for i=1,(self.bh/160)*self:GetHeight() do self.topTextB:SetTextHeight(i); end
				end
			end
		elseif (num == 2) then
		end
	end,
	--Called when the fight bar is shown
	--Update abilities here
	fightBarOnShow = WoWkemon_UpdateAbilities,
	--Initializes the BagFrame
	initBagFrame = function(self,num)
		local oself = self;
		if (num == 0) then
			self.BagFrame = CreateFrame("Frame",nil,self)
			local self = self.BagFrame
			self.init = false;
			do
				self.BLACK = self:CreateTexture(nil, "ARTWORK",nil,1);
				self.BLACK:SetTexture(_wd() .. "Textures\\Backgrounds\\black.tga")
				self.BLACK:SetAllPoints(self)
				self.BLACK:SetAlpha(0)
			end
			do
				self.BAGBG = self:CreateTexture(nil, "ARTWORK",nil,1);
				self.BAGBG:SetTexture(_wd() .. "Textures\\Bag\\bagbg.tga")
				self.BAGBG:SetTexCoord(0,1,0,0.68701171875)
				self.BAGBG:SetAllPoints(self)
			end
			do
				self.BAGFrames = self:CreateTexture(nil, "ARTWORK",nil,2);
				self.BAGFrames:SetTexture(_wd() .. "Textures\\Bag\\bagframes.tga")
				self.BAGFrames:SetTexCoord(0,1,0,0.66015625)
				self.BAGFrames:SetPoint("BOTTOM")
			end
			do--Initializes item buttons, even though there are only 2.
				self.buttons = {}
				self.BagButtons = {
					{
						ank1 = "TOPLEFT",
						ank2 = "TOPLEFT",
						ank12x = math.floor(self.BAGFrames:GetWidth()*0.49),
						ank12y = -1*math.floor(self.BAGFrames:GetHeight()*0.11581291759465478841870824053452),
						refobj = self.BAGFrames,
						ank3 = "BOTTOMRIGHT",
						ank4 = "TOPLEFT",
						ank34x = math.floor(self.BAGFrames:GetWidth()*0.95),
						-- ank34y = -1*math.floor(self.BAGFrames:GetHeight()*0.19375),
						ank34y = -1*math.floor(self.BAGFrames:GetHeight()*0.16),
						text = "WOWKéBALL",
						just = "LEFT",
						clrr = 0,
						clrg = 0,
						clrb = 0,
						fh = math.floor(self.BAGFrames:GetHeight()*0.05625),
					},
					{
						ank1 = "TOPLEFT",
						ank2 = "BOTTOMLEFT",
						ank12x = 0,
						ank12y = -20,
						refobj = 0,
						ank3 = "BOTTOMRIGHT",
						ank4 = "BOTTOMRIGHT",
						ank34x = 0,
						ank34y = (-1*math.floor(self.BAGFrames:GetHeight()*0.05625))-20,
						text = "CLOSE BAG",
						just = "LEFT",
						clrr = 0,
						clrg = 0,
						clrb = 0,
						fh = math.floor(self.BAGFrames:GetHeight()*0.05625),
					},
				}
				for index,array in ipairs(self.BagButtons) do
					self.buttons[index] = CreateFrame("Button",nil, self);
					self.buttons[index].text = self.buttons[index]:CreateFontString(nil,"OVERLAY")
					self.buttons[index].text:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
					self.buttons[index].text:SetAllPoints(self.buttons[index]);
					self.buttons[index].text:SetText(array.text);
					self.buttons[index].text:SetTextColor(array.clrr,array.clrg,array.clrb,1);
					self.buttons[index].text:SetJustifyH(array.just);
					WoWkemon_GiveTextShadow(self.buttons[index].text)
					self.buttons[index].icon = self.buttons[index]:CreateTexture(nil, "ARTWORK");
					self.buttons[index].icon:SetTexture(_wd() .. "Textures\\arrow.tga")
					self.buttons[index].icon:SetVertexColor(72/255,72/255,72/255,1)
					self.buttons[index].icon:SetHeight(30);
					self.buttons[index].icon:SetWidth(21);
					self.buttons[index].icon:SetTexCoord(0,0.62890625,0,0.87109375);
					self.buttons[index].icon:SetPoint("RIGHT",self.buttons[index].text,"LEFT",-8,0);
					self.buttons[index].icon:Hide();
					self.buttons[index]:SetScript( "OnLeave", function(self)
						self.icon:Hide();
						self:GetParent().DescText:SetText("...")
						self:GetParent().DescIcon:SetTexture("")
					end );
					self.buttons[index]:SetScript( "OnEnter", function(self)
						self.icon:Show();
						ting()
						for i=1,math.floor(self:GetParent().BAGFrames:GetHeight()*0.08) do self:GetParent().DescText:SetTextHeight(i); end
						if (self.text:GetText() == "CLOSE BAG") then
							self:GetParent().DescIcon:SetTexture(_wd() .. "Textures\\back.tga")
							self:GetParent().DescText:SetText("Return to\nthe battle.")
							-- while (self.)
						elseif (self.text:GetText() == "WOWKéBALL") then
							self:GetParent().DescIcon:SetTexture(_wd() .. "Textures\\poke-ballitem.tga")
							self:GetParent().DescText:SetText("The basic ball used to catch WOWKéMON.")
						end
					end );
					self.buttons[index]:RegisterForClicks("LeftButtonUp")
					self.buttons[index]:SetScript( "OnClick", function(self, button, down)
						if (self.text:GetText() == "CLOSE BAG") then
							if (oself.Tutorial.id == "cbag") then
								WoWkemon_TutorialNextStep()
							end
							self:GetParent().Close:Play()
						elseif (self.text:GetText() == "WOWKéBALL") then
							self:GetParent().Close:Finish()
							WoWkemon_Dialog(string.upper(UnitName("player")) .. " used\na WOWKé BALL!")
							C_PetBattles.UseTrap();
						end
					end );
					self.buttons[index]:Hide()
				end
				for i,j in ipairs(self.buttons) do j:Hide(); end
			end
			do--Creates other fontstrings
				do--Heading text
					self.HeaderText = self:CreateFontString(nil,"OVERLAY")
					self.HeaderText:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
					self.HeaderText:SetText("WOWKé BALLS");
					self.HeaderText:SetTextColor(0,0,0,1);
					WoWkemon_GiveTextShadow(self.HeaderText)
					self.HeaderText:SetJustifyH("CENTER");
					self.HeaderText:SetJustifyV("CENTER");
					self.HeaderText:Hide()
				end
				do--Description text
					self.DescText = self:CreateFontString(nil,"OVERLAY")
					self.DescText:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
					self.DescText:SetText("...");
					self.DescText:SetTextColor(0,0,0,1);
					WoWkemon_GiveTextShadow(self.DescText)
					self.DescText:SetJustifyH("LEFT");
					self.DescText:SetJustifyV("TOP");
					self.DescText:SetWordWrap(true)
					self.DescText:Hide()
				end
				do--Sprite icon!
					self.DescIcon = self:CreateTexture(nil, "OVERLAY");
					self.DescIcon:Hide();
				end
			end
			do
				self.Open = self.BLACK:CreateAnimationGroup()
				self.Open.ud = self.Open:CreateAnimation("Alpha")
				self.Open.ud:SetChange(1)
				self.Open.ud:SetDuration(0.33)
				self.Open.ud:SetOrder(1)
				self.Open.ud:SetSmoothing("OUT")
				self.Open:SetLooping("NONE")
				self.Open:SetScript("OnFinished", function(self)
					oself.BagFrame.BAGBG:Show()
					oself.BagFrame.BAGFrames:Show()
					WoWkemon_ShowBagButtons(oself.BagFrame)
				end)
				self.Open:SetScript("OnPlay", function(self)
					oself.BagFrame.BAGFrames:Hide()
					oself.BagFrame.BLACK:SetAlpha(0)
					oself.BagFrame.BAGBG:Hide()
				end)
			end
			do
				self.Close = self.BLACK:CreateAnimationGroup()
				self.Close.ud = self.Close:CreateAnimation("Alpha")
				self.Close.ud:SetChange(-1)
				self.Close.ud:SetDuration(0.33)
				self.Close.ud:SetOrder(1)
				self.Close.ud:SetSmoothing("OUT")
				self.Close:SetLooping("NONE")
				self.Close:SetScript("OnFinished", function(self)
					WoWkemon_SetFrame("AskBar")
				end)
				self.Close:SetScript("OnPlay", function(self)
					oself.BagFrame.BLACK:Show()
					oself.BagFrame.BLACK:SetAlpha(1)
					oself.BagFrame.BAGBG:Hide()
					oself.BagFrame.BAGFrames:Hide()
					WoWkemon_HideBagButtons(oself.BagFrame)
				end)
			end
			self:SetScript("OnShow", function(self) self.Open:Play() end)
			self:SetScript("OnHide", function(self) WoWkemon_HideBagButtons(self) end)
			self:Hide()
			self.init = true;
		elseif (num == 1) then
			if (self.BagFrame) then
				local self = self.BagFrame
				self:SetAllPoints(UIParent)
				self:SetFrameStrata("FULLSCREEN")
				do--sets resolution
					self.BAGFrames:SetHeight(GetScreenHeight())
					self.BAGFrames:SetWidth(math.floor((1/0.65771484375)*self.BAGFrames:GetHeight()))
					if (math.floor((1/0.65771484375)*GetScreenHeight()) > GetScreenWidth()) then
						self.BAGFrames:SetHeight(math.floor(GetScreenWidth()/(1/0.65771484375)))
						self.BAGFrames:SetWidth(GetScreenWidth())
					else
						self.BAGFrames:SetHeight(GetScreenHeight())
						self.BAGFrames:SetWidth(math.floor((1/0.65771484375)*self.BAGFrames:GetHeight()))
					end
				end
				do--Initializes item buttons, even though there are only 2.
					self.BagButtons = {
						{
							ank1 = "TOPLEFT",
							ank2 = "TOPLEFT",
							ank12x = math.floor(self.BAGFrames:GetWidth()*0.49),
							ank12y = -1*math.floor(self.BAGFrames:GetHeight()*0.11581291759465478841870824053452),
							refobj = self.BAGFrames,
							ank3 = "BOTTOMRIGHT",
							ank4 = "TOPLEFT",
							ank34x = math.floor(self.BAGFrames:GetWidth()*0.95),
							-- ank34y = -1*math.floor(self.BAGFrames:GetHeight()*0.19375),
							ank34y = -1*math.floor(self.BAGFrames:GetHeight()*0.16),
							text = "WOWKéBALL",
							just = "LEFT",
							clrr = 0,
							clrg = 0,
							clrb = 0,
							fh = math.floor(self.BAGFrames:GetHeight()*0.05625),
						},
						{
							ank1 = "TOPLEFT",
							ank2 = "BOTTOMLEFT",
							ank12x = 0,
							ank12y = -20,
							refobj = 0,
							ank3 = "BOTTOMRIGHT",
							ank4 = "BOTTOMRIGHT",
							ank34x = 0,
							ank34y = (-1*math.floor(self.BAGFrames:GetHeight()*0.05625))-20,
							text = "CLOSE BAG",
							just = "LEFT",
							clrr = 0,
							clrg = 0,
							clrb = 0,
							fh = math.floor(self.BAGFrames:GetHeight()*0.05625),
						},
					}
					for index,array in ipairs(self.BagButtons) do
						if (index == 1) then
							self.buttons[index]:SetPoint(array.ank1, self.BAGFrames, array.ank2, array.ank12x, array.ank12y);
							self.buttons[index]:SetPoint(array.ank3, self.BAGFrames, array.ank4, array.ank34x, array.ank34y);
						else
							self.buttons[index]:SetPoint("TOPLEFT", WoWkemon["Ruby&Sapp"].BagFrame.buttons[index-1], "BOTTOMLEFT", 0, -5);
							self.buttons[index]:SetPoint("BOTTOMRIGHT", WoWkemon["Ruby&Sapp"].BagFrame.buttons[index-1], "BOTTOMRIGHT", 0, -1*math.floor(WoWkemon["Ruby&Sapp"].BagFrame.buttons[1]:GetHeight()));
						end
						self.buttons[index].text:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
						self.buttons[index].text:SetAllPoints(self.buttons[index]);
						for i=1,array.fh do self.buttons[index].text:SetTextHeight(i); end
						self.buttons[index]:Hide()
					end
					for i,j in ipairs(self.buttons) do j:Hide(); end
				end
				do--Creates other fontstrings
					do--Heading text
						self.HeaderText:SetPoint("TOPLEFT",self.BAGFrames,"TOPLEFT",math.floor(self.BAGFrames:GetWidth()*0.14166666666666666666666666666667),-1*math.floor(self.BAGFrames:GetHeight()*0.06875))
						self.HeaderText:SetPoint("BOTTOMRIGHT",self.BAGFrames,"TOPLEFT",math.floor(self.BAGFrames:GetWidth()*0.38333333333333333333333333333333),-1*math.floor(self.BAGFrames:GetHeight()*0.14))
						for i=1,math.floor(self.BAGFrames:GetHeight()*0.08) do self.HeaderText:SetTextHeight(i); end
					end
					do--Description text
						self.DescText:SetPoint("TOPLEFT",self.BAGFrames,"TOPLEFT",math.floor(self.BAGFrames:GetWidth()*0.1),-1*math.floor(self.BAGFrames:GetHeight()*0.66875))
						self.DescText:SetPoint("BOTTOMRIGHT",self.BAGFrames,"TOPLEFT",math.floor(self.BAGFrames:GetWidth()*0.425),-1*math.floor(self.BAGFrames:GetHeight()*0.91875))
						for i=1,math.floor(self.BAGFrames:GetHeight()*0.08) do self.DescText:SetTextHeight(i); end
					end
					do--Sprite icon!
						self.DescIcon:SetPoint("TOPLEFT",self.BAGFrames,"TOPLEFT",math.floor(self.BAGFrames:GetWidth()*0.03333333333333333333333333333333),-1*math.floor(self.BAGFrames:GetHeight()*0.45))
						self.DescIcon:SetPoint("BOTTOMRIGHT",self.BAGFrames,"TOPLEFT",math.floor(self.BAGFrames:GetWidth()*0.12916666666666666666666666666667),-1*math.floor(self.BAGFrames:GetHeight()*0.59375))
					end
				end
			end
		elseif (num == 2) then
		end
	end,
	--Initializes the SelectFrame
	initSelectFrame = function(self,num)
		local oself = self;
		if (num == 0) then
			self.SelectFrame = CreateFrame("Frame",nil,self)
			local self = self.SelectFrame
			self.init = false;
			self:SetAllPoints(UIParent)
			self:Hide()
			self:SetFrameStrata("FULLSCREEN")
			do
				self.BLACK = self:CreateTexture(nil, "ARTWORK",nil,1);
				self.BLACK:SetTexture(_wd() .. "Textures\\Backgrounds\\black.tga")
				self.BLACK:SetAllPoints(self)
				self.BLACK:SetAlpha(0)
			end
			do
				self.SWAPBG = self:CreateTexture(nil, "ARTWORK",nil,1);
				self.SWAPBG:SetTexture(_wd() .. "Textures\\Select\\greenbg.tga")
				self.SWAPBG:SetAllPoints(self)
			end
			do--Sets up a frame with a certain aspect ratio, so that our elements aren't all wonky.
				self.Align = CreateFrame("Frame", nil, self)
				self.Align:SetPoint("CENTER",self,"CENTER")
				do--BG setup
					self.Align.bg = self.Align:CreateTexture(nil,"OVERLAY",nil,0)
					self.Align.bg:SetTexture(_wd() .. "Textures\\Select\\selectbg.tga")
					self.Align.bg:SetTexCoord(0,1,0,0.666015625)
					self.Align.bg:SetAllPoints(self.Align);
				end
				self.Align:Hide()
			end
			do--Close button
				self.close = CreateFrame("Button",nil, self);
				do--Sets up the Pokeball
					self.close.pkbl = self.close:CreateTexture(nil,"OVERLAY",nil,2)
					self.close.pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
					self.close.pkbl:SetTexCoord(0.0546875,0.4375,0.015625,0.4765625);
					self.close.pkbl:SetPoint("CENTER",self.close,"LEFT",0,0)
				end
				do--Close Text
					self.close.text = self.close:CreateFontString(nil,"OVERLAY",2)
					self.close.text:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
					self.close.text:SetText("CANCEL");
					self.close.text:SetTextColor(1,1,1,1);
					self.close.text:SetJustifyH("CENTER");
					self.close.text:SetJustifyV("CENTER");
					WoWkemon_GiveTextDarkShadow(self.close.text)
					end
				do--BG setup
					self.close.bg = self.close:CreateTexture(nil,"OVERLAY",nil,1)
					self.close.bg:SetTexture(_wd() .. "Textures\\Select\\close.tga")
					self.close.bg:SetAllPoints(self.close);
					self.close.bg:SetTexCoord(0.03515625,0.9609375,0,0.283203125);
				end
				self.close:SetScript( "OnEnter", function(self)
					self.pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
					self.pkbl:SetTexCoord(0.515625,0.8984375,0.015625,0.4765625);
					self.bg:SetTexture(_wd() .. "Textures\\Select\\close.tga")
					self.bg:SetTexCoord(0.052734375,0.98046875,0.28515625,0.5703125);
					ting()
				end );
				self.close:SetScript( "OnLeave", function(self)
					self.pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
					self.pkbl:SetTexCoord(0.0546875,0.4375,0.015625,0.4765625);
					self.bg:SetTexture(_wd() .. "Textures\\Select\\close.tga")
					self.bg:SetTexCoord(0.03515625,0.9609375,0,0.283203125);
				end );
				self.close:RegisterForClicks("LeftButtonUp")
				self.close:SetScript( "OnClick", function(self, button, down)
					local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
					local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, activePet);
					if (oself.Tutorial.id == "cancel") then
						WoWkemon_TutorialNextStep()
					end
					if ((C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == false) and (C_PetBattles.GetBattleState() == LE_PET_BATTLE_STATE_WAITING_FOR_FRONT_PETS)) or ((C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == false) and (health == 0)) then
						WoWkemon_Forfeit()
					else
						WoWkemon_SetFrame("AskBar")
					end
				end );
				self.close:Hide()
			end
			do--Prime button
				self.prime = CreateFrame("Button",nil, self);
				self.petOwner = LE_BATTLE_PET_ALLY
				do--BG setup
					self.prime.bg = self.prime:CreateTexture(nil,"OVERLAY",nil,1)
					self.prime.bg:SetTexture(_wd() .. "Textures\\Select\\bigbuttons.tga")
					self.prime.bg:SetAllPoints(self.prime);
					self.prime.bg:SetTexCoord(0.0234375,0.49609375,0.03515625,0.62890625);
				end
				do--StatusBar setup
					self.prime.hp = CreateFrame("StatusBar",nil,self.prime)
					self.prime.hp:SetFrameLevel(5)
					self.prime.hp.barbg = self.prime.hp:CreateTexture(nil,"OVERLAY",nil,3)
					self.prime.hp.barbg:SetTexture(_wd() .. "Textures\\Select\\barbg.tga")
					self.prime.hp:SetStatusBarTexture(self.prime.hp.barbg,"OVERLAY")
					self.prime.hp:SetStatusBarColor(112/255,248/255,168/255,1)
					self.prime.hp:SetMinMaxValues(1,100)
					self.prime.hp:SetValue(100)
					self.prime.hpbg = self.prime:CreateTexture(nil,"OVERLAY",nil,2)
					self.prime.hpbg:SetTexture(_wd() .. "Textures\\Select\\hpbar.tga")
					self.prime.hpbg:SetTexCoord(0,1,0,55/128);
				end
				do--Sets up the Pokeball
					self.prime.pkbl = self.prime:CreateTexture(nil,"OVERLAY",nil,2)
					self.prime.pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
					self.prime.pkbl:SetTexCoord(0.0546875,0.4375,0.015625,0.4765625);
				end
				do--Sets up the pet model, uses currently active pet
					self.prime.pm = CreateFrame("PlayerModel",nil,self.prime)
				end
				do--Pokemon name and level
					self.prime.name = self.close:CreateFontString(nil,"OVERLAY",2)
					self.prime.name:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
					self.prime.name:SetText("NAME\n  Lv2");
					self.prime.name:SetTextColor(1,1,1,1);
					self.prime.name:SetJustifyH("LEFT");
					self.prime.name:SetJustifyV("TOP");
					WoWkemon_GiveTextDarkShadow(self.prime.name)
					end
				do--Pokemon health
					self.prime.hptext = self.close:CreateFontString(nil,"OVERLAY",2)
					self.prime.hptext:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
					self.prime.hptext:SetText("100/ 100");
					self.prime.hptext:SetTextColor(1,1,1,1);
					self.prime.hptext:SetJustifyH("RIGHT");
					self.prime.hptext:SetJustifyV("TOP");
					WoWkemon_GiveTextDarkShadow(self.prime.hptext)
				end
				self.prime:SetScript( "OnEnter", function(self)
					if (self.petIndex) and (IsShiftKeyDown() == true) then
						PetBattleUnitTooltip_Attach(PetBattlePrimaryUnitTooltip, "LEFT", self, "RIGHT", 0, 0);
						PetBattleUnitTooltip_UpdateForUnit(PetBattlePrimaryUnitTooltip, self.petOwner, self.petIndex);
						PetBattlePrimaryUnitTooltip:Show();
					end
					self.pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
					self.pkbl:SetTexCoord(0.515625,0.8984375,0.015625,0.4765625);
					self.bg:SetTexture(_wd() .. "Textures\\Select\\bigbuttons.tga")
					self.bg:SetTexCoord(0.5087890625,0.9814453125,0.03515625,0.62890625);
					ting()
				end );
				self.prime:SetScript( "OnLeave", function(self)
					PetBattlePrimaryUnitTooltip:Hide();
					self.pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
					self.pkbl:SetTexCoord(0.0546875,0.4375,0.015625,0.4765625);
					self.bg:SetTexture(_wd() .. "Textures\\Select\\bigbuttons.tga")
					self.bg:SetTexCoord(0.0234375,0.49609375,0.03515625,0.62890625);
				end );
				self.prime:Hide()
			end
			do--Initializes other buttons
				self.buttons = {}
				for i=1,5 do
					self.buttons[i] = CreateFrame("Button",nil, self);
					self.buttons[i].petOwner = LE_BATTLE_PET_ENEMY;
					do--BG setup
						self.buttons[i].bg = self.buttons[i]:CreateTexture(nil,"OVERLAY",nil,1)
						self.buttons[i].bg:SetTexture(_wd() .. "Textures\\Select\\longbuttons.tga")
						self.buttons[i].bg:SetAllPoints(self.buttons[i]);
						self.buttons[i].bg:SetTexCoord(0.013671875,0.9716796875,0.0390625,0.3359375);
					end
					do--BG setup
						self.buttons[i].bg_empty = self.buttons[i]:CreateTexture(nil,"OVERLAY",nil,1)
						self.buttons[i].bg_empty:SetTexture(_wd() .. "Textures\\Select\\longbutton_empty.tga")
						self.buttons[i].bg_empty:SetAllPoints(self.buttons[i]);
						self.buttons[i].bg_empty:SetTexCoord(0,1,0,78/128);
						self.buttons[i].bg_empty:Hide()
					end
					do--StatusBar setup
						self.buttons[i].hp = CreateFrame("StatusBar",nil,self.buttons[i])
						self.buttons[i].hp:SetFrameLevel(5)
						self.buttons[i].hp.barbg = self.buttons[i].hp:CreateTexture(nil,"OVERLAY",nil,3)
						self.buttons[i].hp.barbg:SetTexture(_wd() .. "Textures\\Select\\barbg.tga")
						self.buttons[i].hp:SetStatusBarTexture(self.buttons[i].hp.barbg,"OVERLAY")
						self.buttons[i].hp:SetStatusBarColor(112/255,248/255,168/255,1)
						self.buttons[i].hp:SetMinMaxValues(1,100)
						self.buttons[i].hp:SetValue(100)
						self.buttons[i].hpbg = self.buttons[i]:CreateTexture(nil,"OVERLAY",nil,2)
						self.buttons[i].hpbg:SetTexture(_wd() .. "Textures\\Select\\hpbar.tga")
						self.buttons[i].hpbg:SetTexCoord(0,1,0,55/128);
					end
					do--Sets up the Pokeball
						self.buttons[i].pkbl = self.buttons[i]:CreateTexture(nil,"OVERLAY",nil,2)
						self.buttons[i].pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
						self.buttons[i].pkbl:SetTexCoord(0.0546875,0.4375,0.015625,0.4765625);
					end
					do--Sets up the pet model, uses currently active pet
						self.buttons[i].pm = CreateFrame("PlayerModel",nil,self.buttons[i])
					end
					do--Pokemon name and level
						self.buttons[i].name = self.close:CreateFontString(nil,"OVERLAY",2)
						self.buttons[i].name:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
						self.buttons[i].name:SetText("NAME\n  Lv2");
						self.buttons[i].name:SetTextColor(1,1,1,1);
						self.buttons[i].name:SetJustifyH("LEFT");
						self.buttons[i].name:SetJustifyV("TOP");
						WoWkemon_GiveTextDarkShadow(self.buttons[i].name)
					end
					do--Pokemon health
						self.buttons[i].hptext = self.close:CreateFontString(nil,"OVERLAY",3)
						self.buttons[i].hptext:SetFont(_wd() .. "Fonts\\pkmn.ttf",60);
						self.buttons[i].hptext:SetText("100/ 100");
						self.buttons[i].hptext:SetTextColor(1,1,1,1);
						self.buttons[i].hptext:SetJustifyH("RIGHT");
						self.buttons[i].hptext:SetJustifyV("TOP");
						WoWkemon_GiveTextDarkShadow(self.buttons[i].hptext)
					end
					self.buttons[i]:SetScript( "OnEnter", function(self)
						if (self.petIndex) and (IsShiftKeyDown() == true) then
							PetBattleUnitTooltip_Attach(PetBattlePrimaryUnitTooltip, "RIGHT", self, "LEFT", 0, 0);
							PetBattleUnitTooltip_UpdateForUnit(PetBattlePrimaryUnitTooltip, self.petOwner, self.petIndex);
							PetBattlePrimaryUnitTooltip:Show();
						end
						self.pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
						self.pkbl:SetTexCoord(0.515625,0.8984375,0.015625,0.4765625);
						self.bg:SetTexture(_wd() .. "Textures\\Select\\longbuttons.tga")
						self.bg:SetTexCoord(0.013671875,0.9716796875,0.365234375,0.662109375);
						ting()
					end );
					self.buttons[i]:EnableMouse(true)
					self.buttons[i]:SetScript( "OnLeave", function(self)
						PetBattlePrimaryUnitTooltip:Hide();
						self.pkbl:SetTexture(_wd() .. "Textures\\Select\\pokeballs.tga")
						self.pkbl:SetTexCoord(0.0546875,0.4375,0.015625,0.4765625);
						self.bg:SetTexture(_wd() .. "Textures\\Select\\longbuttons.tga")
						self.bg:SetTexCoord(0.013671875,0.9716796875,0.0390625,0.3359375);
					end );
					self.buttons[i]:RegisterForClicks("LeftButtonUp")
					self.buttons[i]:SetScript( "OnClick", function(self, button, down)
						if (self.mni) then
							local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, self.mni);
							local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, self.mni)
							if (health ~= 0) and (C_PetBattles.CanPetSwapIn(self.mni) == true) then
								C_PetBattles.ChangePet(self.mni)
								WoWkemon_Dialog("Go! " .. name .. "!")
							else
								thunk()
							end
						end
					end );
					self.buttons[i]:Hide()
				end
			end
			do
				self.Open = self.BLACK:CreateAnimationGroup()
				self.Open.ud = self.Open:CreateAnimation("Alpha")
				self.Open.ud:SetChange(1)
				self.Open.ud:SetDuration(0.33)
				self.Open.ud:SetOrder(1)
				self.Open.ud:SetSmoothing("OUT")
				self.Open:SetLooping("NONE")
				self.Open:SetScript("OnFinished", function(self)
					local sf = oself.SelectFrame;
					sf.SWAPBG:Show()
					WoWkemon_ShowSwapButtons(sf)
					sf.Align:Show()
				end)
				self.Open:SetScript("OnPlay", function(self)
					local sf = oself.SelectFrame;
					WoWkemon_HideSwapButtons(sf)
					sf.BLACK:SetAlpha(0)
					sf.SWAPBG:Hide()
					sf.Align:Hide()
				end)
			end
			self:SetScript("OnShow", function(self) 
				WoWkemon_UpdateSwapFrame(self)
				self.Open:Play();
			end)
			self:SetScript("OnHide", function(self) 
				WoWkemon_HideSwapButtons(self)
			end)
			self.Align:Hide()
			self:Hide()
			self.init = true;
		elseif (num == 1) then
			if (self.SelectFrame) then
					local self = self.SelectFrame
					do--Sets up a frame with a certain aspect ratio, so that our elements aren't all wonky.
						self.Align:SetPoint("CENTER",self,"CENTER")
						self.Align:SetHeight(GetScreenHeight())
						if (math.floor((1/0.65771484375)*self:GetHeight()) > GetScreenWidth()) then
							self.Align:SetHeight(math.floor(GetScreenWidth()/(1/0.65771484375)))
							self.Align:SetWidth(GetScreenWidth())
						else
							self.Align:SetWidth(math.floor((1/0.65771484375)*self:GetHeight()))
						end
					end
					do--Close button
						self.close:SetSize(math.floor(0.21666666666666666666666666666667*self.Align:GetWidth()),math.floor(0.1*self.Align:GetHeight()))
						self.close:SetPoint("TOPLEFT",self.Align,"TOPLEFT",math.floor(0.775*self.Align:GetWidth()),-1*math.floor(0.85*self.Align:GetHeight()))
						do--Sets up the Pokeball
							self.close.pkbl:SetSize(math.floor(self.close:GetWidth()*0.38461538461538461538461538461538),math.floor(self.close:GetHeight()*1.5));
							self.close.pkbl:SetPoint("CENTER",self.close,"LEFT",0,0)
						end
						do--Close Text
							self.close.text:SetPoint("RIGHT",self.close,"RIGHT",-10,-10)
							self.close.text:SetPoint("LEFT",self.close.pkbl,"RIGHT",10,-10)
							for i=1,math.floor(0.86*self.close:GetHeight()) do self.close.text:SetTextHeight(i); end
						end
					end
					do--Prime button
						self.prime:SetSize(math.floor(0.325*self.Align:GetWidth()),math.floor(0.30625*self.Align:GetHeight()))
						self.prime:SetPoint("TOPLEFT",self.Align,"TOPLEFT",math.floor(0.03333333333333333333333333333333*self.Align:GetWidth()),-1*math.floor(0.1625*self.Align:GetHeight()))
						do--StatusBar setup
							self.prime.hp:SetPoint("TOPLEFT",self.prime,"TOPLEFT",math.floor((307/1000)*self.prime:GetWidth()),-1*math.floor((430/628)*self.prime:GetHeight()))
							self.prime.hp:SetPoint("BOTTOMRIGHT",self.prime,"TOPLEFT",math.floor((922/1000)*self.prime:GetWidth()),-1*math.floor((455/628)*self.prime:GetHeight()))
							self.prime.hpbg:SetPoint("TOPLEFT",self.prime.hp,"TOPLEFT",-1*math.floor((312/1000)*self.prime.hp:GetWidth()),math.floor((58/108)*self.prime.hp:GetHeight()))
							self.prime.hpbg:SetPoint("BOTTOMRIGHT",self.prime.hp,"BOTTOMRIGHT",math.floor((40/1000)*self.prime.hp:GetWidth()),-1*math.floor((58/108)*self.prime.hp:GetHeight()))
						end
						do--Sets up the Pokeball
							self.prime.pkbl:SetSize(math.floor(self.close:GetWidth()*0.38461538461538461538461538461538),math.floor(self.close:GetHeight()*1.5));
							self.prime.pkbl:SetPoint("CENTER",self.prime,"TOPLEFT",math.floor((4/240)*self.Align:GetWidth()),-1*math.floor((4/160)*self.Align:GetHeight()))
						end
						do--Sets up the pet model, uses currently active pet
							self.prime.pm:SetSize(math.floor((25/240)*self.Align:GetWidth()),math.floor((25/160)*self.Align:GetHeight()))
							self.prime.pm:SetPoint("TOPLEFT",self.prime,"TOPLEFT",-1*math.floor((3/240)*self.Align:GetWidth()),math.floor((3/240)*self.Align:GetHeight()))
						end
						do--Pokemon name and level
							self.prime.name:SetPoint("TOPLEFT",self.prime,"TOPLEFT",math.floor((22/78)*self.prime:GetWidth()),-1*math.floor((12/49)*self.prime:GetHeight()))
							self.prime.name:SetPoint("BOTTOMRIGHT",self.prime,"TOPLEFT",math.floor((73/78)*self.prime:GetWidth()),-1*math.floor((29/49)*self.prime:GetHeight()))
							for i=1,self.prime:GetHeight()*(7/49) do self.prime.name:SetTextHeight(i) end
						end
						do--Pokemon health
							self.prime.hptext:SetPoint("TOPLEFT",self.prime,"TOPLEFT",math.floor((142/1000)*self.prime:GetWidth()),-1*math.floor((491/628)*self.prime:GetHeight()))
							self.prime.hptext:SetPoint("BOTTOMRIGHT",self.prime,"BOTTOMRIGHT",-1*math.floor((66/1000)*self.prime:GetWidth()),math.floor((26/628)*self.prime:GetHeight()))
							for i=1,56 do self.prime.hptext:SetTextHeight(i); end
						end
					end
					do--Initializes other buttons
					for i=1,5 do
						self.buttons[i]:SetSize(math.floor((142/240)*self.Align:GetWidth()),math.floor((22/160)*self.Align:GetHeight()))
						if (i == 1) then
							self.buttons[i]:SetPoint("TOPLEFT",self.Align,"TOPLEFT",math.floor((96/240)*self.Align:GetWidth()),-1*math.floor((10/160)*self.Align:GetHeight()))
						else
							self.buttons[i]:SetPoint("TOPLEFT",self.buttons[i-1],"BOTTOMLEFT",0,-1*math.floor((2/160)*self.Align:GetHeight()))
						end
						do--StatusBar setup
							self.buttons[i].hp:SetPoint("TOPLEFT",self.buttons[i],"TOPLEFT",math.floor((320/500)*self.buttons[i]:GetWidth()),-1*math.floor((28/77)*self.buttons[i]:GetHeight()))
							self.buttons[i].hp:SetPoint("BOTTOMRIGHT",self.buttons[i],"TOPLEFT",math.floor((478/500)*self.buttons[i]:GetWidth()),-1*math.floor((37/77)*self.buttons[i]:GetHeight()))
							self.buttons[i].hpbg:SetPoint("TOPLEFT",self.buttons[i].hp,"TOPLEFT",-1*math.floor((312/1000)*self.buttons[i].hp:GetWidth()),math.floor((58/108)*self.buttons[i].hp:GetHeight()))
							self.buttons[i].hpbg:SetPoint("BOTTOMRIGHT",self.buttons[i].hp,"BOTTOMRIGHT",math.floor((40/1000)*self.buttons[i].hp:GetWidth()),-1*math.floor((58/108)*self.buttons[i].hp:GetHeight()))
						end
						do--Sets up the Pokeball
							self.buttons[i].pkbl:SetSize(math.floor(self.close:GetWidth()*0.38461538461538461538461538461538),math.floor(self.close:GetHeight()*1.5));
							self.buttons[i].pkbl:SetPoint("CENTER",self.buttons[i],"LEFT",math.floor((4/240)*self.Align:GetWidth()))
						end
						do--Sets up the pet model, uses currently active pet
							self.buttons[i].pm:SetSize(math.floor((25/240)*self.Align:GetWidth()),math.floor((25/160)*self.Align:GetHeight()))
							self.buttons[i].pm:SetPoint("LEFT",self.buttons[i],"LEFT")
						end
						do--Pokemon name and level
							self.buttons[i].name:SetPoint("TOPLEFT",self.buttons[i],"TOPLEFT",math.floor((65/500)*self.buttons[i]:GetWidth()),-1*math.floor((13/77)*self.buttons[i]:GetHeight()))
							for j=1,self.buttons[i]:GetHeight()*(7/22) do self.buttons[i].name:SetTextHeight(j) end
						end
						do--Pokemon health
							self.buttons[i].hptext:SetPoint("BOTTOMRIGHT",self.buttons[i],"BOTTOMRIGHT",-20,10)
							for j=1,self.buttons[i]:GetHeight()*(7/22) do self.buttons[i].hptext:SetTextHeight(j) end
						end
					end

					end
				end
		elseif (num == 2) then
		end
	end,
	selectFrameOnShow = function(self)
	end,
	--Initializes the unit frames
	initUnitFrames = function(self,num)
		local oself = self;
		if (num == 0) then
			self.BattleFrames = CreateFrame("Frame",nil,self)
			local self = self.BattleFrames
			self:SetAllPoints(UIParent)
			self.Ally = CreateFrame("Frame","WoWkemon_Ally",self)
			do--Ally Frame
				local Ally = self.Ally
				Ally:SetFrameLevel(5)
				Ally:SetClampedToScreen(true)
				Ally:SetPoint("TOPLEFT",UIParent,"CENTER")
				do--BG setup
					Ally.bg = Ally:CreateTexture(nil,"OVERLAY",nil,0)
					Ally.bg:SetTexture(_wd() .. "Textures\\Battle\\ally.tga")
					Ally.bg:SetTexCoord(0,1,0,177/256)
					Ally.bg:SetAllPoints(Ally);
				end	
				do--Level
					Ally.level = Ally:CreateFontString(nil,"OVERLAY",2)
					Ally.level:SetTextColor(64/255,64/255,64/255,1);
					Ally.level:SetJustifyH("RIGHT");
					Ally.level:SetJustifyV("TOP");
					WoWkemon_GiveTextBrownShadow(Ally.level)
				end
				do--Name text
					Ally.name = Ally:CreateFontString(nil,"OVERLAY",2)
					Ally.name:SetTextColor(64/255,64/255,64/255,1);
					Ally.name:SetJustifyH("LEFT");
					Ally.name:SetJustifyV("CENTER");
					WoWkemon_GiveTextBrownShadow(Ally.name)
				end
				do--Name text
					Ally.move = Ally:CreateFontString(nil,"OVERLAY",2)
					Ally.move:SetTextColor(255,255,255,1);
					Ally.move:SetJustifyH("LEFT");
					Ally.move:SetJustifyV("TOP");
					Ally.move:Hide()
				end
				do--StatusBar setup
					Ally.hp = CreateFrame("StatusBar",nil,Ally)
					Ally.hp:SetFrameLevel(6)
					Ally.hp.barbg = Ally.hp:CreateTexture(nil,"OVERLAY",nil,3)
					Ally.hp.barbg:SetTexture(_wd() .. "Textures\\Select\\barbg.tga")
					Ally.hp:SetStatusBarTexture(Ally.hp.barbg,"OVERLAY")
					Ally.hp:SetStatusBarColor(112/255,248/255,168/255,1)
					Ally.hp:SetMinMaxValues(1,100)
					Ally.hp:SetValue(100)
					Ally.hpbg = Ally:CreateTexture(nil,"OVERLAY",nil,2)
					Ally.hpbg:SetTexture(_wd() .. "Textures\\Select\\hpbar.tga")
					Ally.hpbg:SetTexCoord(0,1,0,55/128);
				end
				do--StatusBar setup
					Ally.xp = CreateFrame("StatusBar",nil,Ally)
					Ally.xp:SetFrameLevel(5)
					Ally.xp.barbg = Ally.xp:CreateTexture(nil,"OVERLAY",nil,3)
					Ally.xp.barbg:SetTexture(_wd() .. "Textures\\Battle\\barbg.tga")
					Ally.xp:SetStatusBarTexture(Ally.xp.barbg,"OVERLAY")
					Ally.xp:SetStatusBarColor(64/255,200/255,248/255,1)
					Ally.xp:SetMinMaxValues(1,100)
					Ally.xp:SetValue(100)
				end
				do--Health text
					Ally.health = Ally:CreateFontString(nil,"OVERLAY",2)
					Ally.health:SetTextColor(64/255,64/255,64/255,1);
					Ally.health:SetJustifyH("RIGHT");
					Ally.health:SetJustifyV("BOTTOM");
					WoWkemon_GiveTextBrownShadow(Ally.health)
				end
				do--Sets up dragging
					Ally:EnableMouse(true)
					Ally:RegisterForDrag("RightButton")
					Ally:SetMovable(true)
					Ally:SetUserPlaced(true)
					Ally:SetScript("OnEnter", function(self)
						self.move:Show();
					end);
					Ally:SetScript("OnLeave", function(self)
						self.move:Hide();
					end);
					Ally:SetScript("OnUpdate",function(self)
						self.move:ClearAllPoints();
						if (self:GetLeft() < (GetScreenWidth()/2)) then
							self.move:SetPoint("TOPLEFT",self,"TOPRIGHT")
							self.move:SetJustifyH("LEFT")
						else
							self.move:SetPoint("TOPRIGHT",self,"TOPLEFT")
							self.move:SetJustifyH("RIGHT")
						end
						self.move:SetText("Right drag to\n move frames.")
						end)
					Ally:SetScript("OnDragStart", function(self)
						if (oself.Tutorial.id == "drag") then
							WoWkemon_TutorialNextStep()
						end
						self:GetParent().Enemy:SetScript("OnUpdate", function(self)
							local Ally = self:GetParent().Ally
							local point, relativeTo, relativePoint,ALLY_X_OFFSET,ALLY_Y_OFFSET,ENEMY_X_OFFSET,ENEMY_Y_OFFSET;
							do--Finds offsets of Ally Frame and Enemy Frame
								_,_,_, ALLY_X_OFFSET, ALLY_Y_OFFSET = Ally:GetPoint(1);
								_,_,_, ENEMY_X_OFFSET, ENEMY_Y_OFFSET = self:GetPoint(1);
							end
							----print(string.format("PC ALLY_X_OFFSET %d ALLY_Y_OFFSET %d",ALLY_X_OFFSET,ALLY_Y_OFFSET))
							ALLY_X_OFFSET, ALLY_Y_OFFSET = CTC(ALLY_X_OFFSET, ALLY_Y_OFFSET)
							----print(string.format("PoC ALLY_X_OFFSET %d ALLY_Y_OFFSET %d",ALLY_X_OFFSET, ALLY_Y_OFFSET))
							self:ClearAllPoints()
							self:SetPoint("TOPLEFT",self:GetParent():GetParent(),"CENTER",(-1*ALLY_X_OFFSET)-self:GetWidth(),(-1*ALLY_Y_OFFSET)+self:GetHeight())
						end);
						self:StartMoving()
					end);
					Ally:SetScript("OnDragStop", function(self)
						self:GetParent().Enemy:SetScript("OnUpdate", function(self)
							if (IsShiftKeyDown() == 1) and (GetMouseFocus() == self) then
								PetBattleUnitTooltip_Attach(PetBattlePrimaryUnitTooltip, "TOPLEFT", self, "TOPRIGHT", 0, 0);
								local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY);
								PetBattleUnitTooltip_UpdateForUnit(PetBattlePrimaryUnitTooltip, LE_BATTLE_PET_ENEMY, activePet);
								PetBattlePrimaryUnitTooltip:Show();
							end
						end);
						self:StopMovingOrSizing()
						if (oself.Tutorial.id == "dragfinish") then
							local ss = oself.Tutorial
							ss:ClearAllPoints()
							ss:SetPoint("TOPRIGHT",oself.BattleFrames.Ally,"LEFT")
						end
					end);
				end
				do--Sets up the pokeballs
					Ally.pbs = {}
					for i=1,6 do
						Ally.pbs[i] = CreateFrame("Frame",nil,Ally)
						local ball = Ally.pbs[i];
						ball.petOwner = LE_BATTLE_PET_ALLY
						ball:EnableMouse(true)
						do
							ball.empty = ball:CreateTexture(nil,"OVERLAY",nil,0)
							ball.empty:SetTexture(_wd() .. "Textures\\Battle\\emptypokeball.tga")
							ball.empty:SetAllPoints(ball)
							ball.empty:Hide()
						end
						do
							ball.dead = ball:CreateTexture(nil,"OVERLAY",nil,0)
							ball.dead:SetTexture(_wd() .. "Textures\\Battle\\deadpokeball.tga")
							ball.dead:SetAllPoints(ball)
							ball.dead:Hide()
						end
						do
							ball.normal = ball:CreateTexture(nil,"OVERLAY",nil,0)
							ball.normal:SetTexture(_wd() .. "Textures\\Battle\\pokeball.tga")
							ball.normal:SetAllPoints(ball)
							ball.normal:Hide()
						end
						do
							ball.highlight = ball:CreateTexture(nil,"OVERLAY",nil,0)
							ball.highlight:SetTexture(_wd() .. "Textures\\Battle\\highlightpokeball.tga")
							ball.highlight:SetAllPoints(ball)
							ball.highlight:Hide()
						end
						ball:SetScript("OnEnter", function(self)
							if (self.petIndex) then
								if (oself.Tutorial.id == "mover") then
									WoWkemon_TutorialNextStep()
								end
								local left, bottom = self:GetParent():GetLeft(),self:GetParent():GetBottom();
								local P, RP;
								if (left > (GetScreenWidth()/2)) then P = "RIGHT"; RP = "LEFT";
								elseif (left < (GetScreenWidth()/2)) then P = "LEFT"; RP = "RIGHT";
								else P = "LEFT"; RP = "RIGHT";
								end
								PetBattleUnitTooltip_Attach(PetBattlePrimaryUnitTooltip, P, self, RP, 0, 0);
								PetBattleUnitTooltip_UpdateForUnit(PetBattlePrimaryUnitTooltip, self.petOwner, self.petIndex);
								PetBattlePrimaryUnitTooltip:Show();
							end
						end);
						ball:SetScript("OnLeave", function(self)
							PetBattlePrimaryUnitTooltip:Hide();
						end);
					end
				end
				do--Sets up the buff notification
					Ally.bpn = CreateFrame("Frame",nil,Ally)
					local bpn = Ally.bpn
					bpn.buff = bpn:CreateTexture(nil,"OVERLAY",nil,4)
					bpn.buff:SetAllPoints(bpn)
					bpn.buff:SetTexture(_wd() .. "Textures\\Battle\\buff.tga")
					bpn.buff:SetTexCoord(0,1,0,26/32)
					bpn.debuff = bpn:CreateTexture(nil,"OVERLAY",nil,4)
					bpn.debuff:SetAllPoints(bpn)
					bpn.debuff:SetTexture(_wd() .. "Textures\\Battle\\debuff.tga")
					bpn.debuff:SetTexCoord(0,1,0,26/32)
					bpn.buff:Hide()
					bpn.debuff:Hide()
				end
				WoWkemon_GenerateBuffFrames(Ally)
				Ally.petOwner = LE_BATTLE_PET_ALLY
			end
			self.Enemy = CreateFrame("Frame","WoWkemon_Enemy",self)
			do--Enemy Frame
				local Enemy = self.Enemy
				Enemy:SetFrameLevel(3)
				Enemy:SetSize(math.floor((100/240)*self:GetParent().AskBar:GetWidth()),math.floor((28/48)*self:GetParent().AskBar:GetHeight()))
				Enemy:SetPoint("TOPLEFT",UIParent,"CENTER",-1*Enemy:GetWidth(),Enemy:GetHeight())
				do--BG setup
					Enemy.bg = Enemy:CreateTexture(nil,"ARTWORK",nil,-3)
					Enemy.bg:SetTexture(_wd() .. "Textures\\Battle\\Enemy.tga")
					Enemy.bg:SetTexCoord(0,1,0,142/256)
					Enemy.bg:SetAllPoints(Enemy);
				end	
				do--Level
					Enemy.level = Enemy:CreateFontString(nil,"ARTWORK",-2)
					Enemy.level:SetTextColor(64/255,64/255,64/255,1);
					Enemy.level:SetJustifyH("RIGHT");
					Enemy.level:SetJustifyV("TOP");
					WoWkemon_GiveTextBrownShadow(Enemy.level)
				end
				do--Name text
					Enemy.name = Enemy:CreateFontString(nil,"ARTWORK",-2)
					Enemy.name:SetTextColor(64/255,64/255,64/255,1);
					Enemy.name:SetJustifyH("LEFT");
					Enemy.name:SetJustifyV("TOP");
					WoWkemon_GiveTextBrownShadow(Enemy.name)
				end
				do--StatusBar setup
					Enemy.hp = CreateFrame("StatusBar",nil,Enemy)
					Enemy.hp:SetFrameLevel(4)
					Enemy.hp.barbg = Enemy.hp:CreateTexture(nil,"ARTWORK",nil,3)
					Enemy.hp.barbg:SetTexture(_wd() .. "Textures\\Select\\barbg.tga")
					Enemy.hp:SetStatusBarTexture(Enemy.hp.barbg,"ARTWORK")
					Enemy.hp:SetStatusBarColor(112/255,248/255,168/255,-2)
					Enemy.hp:SetMinMaxValues(1,100)
					Enemy.hp:SetValue(100)
					Enemy.hpbg = Enemy:CreateTexture(nil,"ARTWORK",nil,-1)
					Enemy.hpbg:SetTexture(_wd() .. "Textures\\Select\\hpbar.tga")
					Enemy.hpbg:SetTexCoord(0,1,0,55/128);
				end
				do--Sets up dragging
					Enemy:RegisterForDrag("RightButton")
					Enemy:SetMovable(true)
					Enemy:EnableMouse(true)
					Enemy:SetClampedToScreen(true)
					Enemy:SetUserPlaced(true)
				end
				do--Sets up the pokeballs
					Enemy.pbs = {}
					for i=1,6 do
						Enemy.pbs[i] = CreateFrame("Frame",nil,Enemy)
						local ball = Enemy.pbs[i];
						ball.petOwner = LE_BATTLE_PET_ENEMY
						ball:EnableMouse(true)
						do
							ball.empty = ball:CreateTexture(nil,"OVERLAY",nil,-3)
							ball.empty:SetTexture(_wd() .. "Textures\\Battle\\emptypokeball.tga")
							ball.empty:SetAllPoints(ball)
							ball.empty:Hide()
						end
						do
							ball.dead = ball:CreateTexture(nil,"OVERLAY",nil,-3)
							ball.dead:SetTexture(_wd() .. "Textures\\Battle\\deadpokeball.tga")
							ball.dead:SetAllPoints(ball)
							ball.dead:Hide()
						end
						do
							ball.normal = ball:CreateTexture(nil,"OVERLAY",nil,-3)
							ball.normal:SetTexture(_wd() .. "Textures\\Battle\\pokeball.tga")
							ball.normal:SetAllPoints(ball)
							ball.normal:Hide()
						end
						do
							ball.highlight = ball:CreateTexture(nil,"OVERLAY",nil,-3)
							ball.highlight:SetTexture(_wd() .. "Textures\\Battle\\highlightpokeball.tga")
							ball.highlight:SetAllPoints(ball)
							ball.highlight:Hide()
						end
						ball:SetScript("OnEnter", function(self)
							if (self.petIndex) then
								local left, bottom = self:GetParent():GetLeft(),self:GetParent():GetBottom();
								local P, RP;
								if (left > (GetScreenWidth()/2)) then P = "RIGHT"; RP = "LEFT";
								elseif (left < (GetScreenWidth()/2)) then P = "LEFT"; RP = "RIGHT";
								else P = "LEFT"; RP = "RIGHT";
								end
								PetBattleUnitTooltip_Attach(PetBattlePrimaryUnitTooltip, P, self, RP, 0, 0);
								PetBattleUnitTooltip_UpdateForUnit(PetBattlePrimaryUnitTooltip, self.petOwner, self.petIndex);
								PetBattlePrimaryUnitTooltip:Show();
							end
						end);
						ball:SetScript("OnLeave", function(self)
							PetBattlePrimaryUnitTooltip:Hide();
						end);
					end
				end
				do
					Enemy.bpn = CreateFrame("Frame",nil,Enemy)
					local bpn = Enemy.bpn
					bpn.buff = bpn:CreateTexture(nil,"OVERLAY",nil,4)
					bpn.buff:SetAllPoints(bpn)
					bpn.buff:SetTexture(_wd() .. "Textures\\Battle\\buff.tga")
					bpn.buff:SetTexCoord(0,1,0,26/32)
					bpn.debuff = bpn:CreateTexture(nil,"OVERLAY",nil,4)
					bpn.debuff:SetAllPoints(bpn)
					bpn.debuff:SetTexture(_wd() .. "Textures\\Battle\\debuff.tga")
					bpn.debuff:SetTexCoord(0,1,0,26/32)
					bpn.buff:Hide()
					bpn.debuff:Hide()
					bpn:EnableMouse(true)
				end
				-- Enemy:SetScript("OnShow", function(self)
				-- 	local Ally = self:GetParent().Ally
				-- 	local point, relativeTo, relativePoint,ALLY_X_OFFSET,ALLY_Y_OFFSET,ENEMY_X_OFFSET,ENEMY_Y_OFFSET;
				-- 	do--Finds offsets of Ally Frame and Enemy Frame
				-- 		_,_,_, ALLY_X_OFFSET, ALLY_Y_OFFSET = Ally:GetPoint(1);
				-- 		_,_,_, ENEMY_X_OFFSET, ENEMY_Y_OFFSET = self:GetPoint(1);
				-- 	end
				-- 	----print(string.format("PC ALLY_X_OFFSET %d ALLY_Y_OFFSET %d",ALLY_X_OFFSET,ALLY_Y_OFFSET))
				-- 	ALLY_X_OFFSET, ALLY_Y_OFFSET = CTC(ALLY_X_OFFSET, ALLY_Y_OFFSET)
				-- 	----print(string.format("PoC ALLY_X_OFFSET %d ALLY_Y_OFFSET %d",ALLY_X_OFFSET, ALLY_Y_OFFSET))
				-- 	self:ClearAllPoints()
				-- 	self:SetPoint("TOPLEFT",self:GetParent():GetParent(),"CENTER",(-1*ALLY_X_OFFSET)-self:GetWidth(),(-1*ALLY_Y_OFFSET)+self:GetHeight())
				-- end);
				WoWkemon_GenerateBuffFrames(Enemy)
				Enemy.petOwner = LE_BATTLE_PET_ENEMY
			end
			--self:SetScript("OnShow", function(self) WoWkemon_BattleAllyFixText(self) end)
		else
			if (self.BattleFrames) then
				local self = self.BattleFrames
				do--Ally Frame
					local Ally = self.Ally
					Ally:SetSize(math.floor((103/240)*self:GetParent().AskBar:GetWidth()),math.floor((36/48)*self:GetParent().AskBar:GetHeight()))
					do--Level
						Ally.level:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((1/3)*Ally:GetHeight()));
						Ally.level:SetPoint("TOPRIGHT",Ally,"TOPRIGHT",-1*math.floor((14/103)*Ally:GetWidth()),-1*math.floor((5/36)*Ally:GetHeight()))
						Ally.level:SetSize((65/343)*Ally:GetWidth(),(28/119)*Ally:GetHeight());
						for i=1,math.floor((1/3)*Ally:GetHeight()) do Ally.level:SetTextHeight(i); end
					end
					do--Name text
						Ally.name:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((1/3)*Ally:GetHeight()));
						Ally.name:SetPoint("TOPLEFT",Ally,"TOPLEFT",math.floor((18/103)*Ally:GetWidth()),-1*math.floor((5/36)*Ally:GetHeight()))
						for i=1,math.floor((1/3)*Ally:GetHeight()) do Ally.name:SetTextHeight(i); end
					end
					do--Name text
						Ally.move:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((1/3)*Ally:GetHeight()),"OUTLINE");
						for i=1,math.floor((1/4)*Ally:GetHeight()) do Ally.move:SetTextHeight(i); end
					end
					do--StatusBar setup
						Ally.hp:SetPoint("TOPLEFT",Ally,"TOPLEFT",math.floor((456/1000)*Ally:GetWidth()),-1*math.floor((165/350)*Ally:GetHeight()))
						Ally.hp:SetPoint("BOTTOMRIGHT",Ally,"TOPLEFT",math.floor((880/1000)*Ally:GetWidth()),-1*math.floor((183/350)*Ally:GetHeight()))
						Ally.hpbg:SetPoint("TOPLEFT",Ally.hp,"TOPLEFT",-1*math.floor((312/1000)*Ally.hp:GetWidth()),math.floor((58/108)*Ally.hp:GetHeight()))
						Ally.hpbg:SetPoint("BOTTOMRIGHT",Ally.hp,"BOTTOMRIGHT",math.floor((40/1000)*Ally.hp:GetWidth()),-1*math.floor((58/108)*Ally.hp:GetHeight()))
					end
					do--StatusBar setup
						Ally.xp.a1, Ally.xp.a2, Ally.xp.a3, Ally.xp.a4 = 896, 960, 2641, 1025
						Ally.xp:SetPoint("TOPLEFT",Ally,"TOPLEFT",(Ally.xp.a1/3000)*Ally:GetWidth(),-1*(Ally.xp.a2/1049)*Ally:GetHeight())
						Ally.xp:SetPoint("BOTTOMRIGHT",Ally,"TOPLEFT",(Ally.xp.a3/3000)*Ally:GetWidth(),-1*(Ally.xp.a4/1049)*Ally:GetHeight())
					end
					do--Health text
						Ally.health:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((1/4)*Ally:GetHeight()));
						Ally.health:SetPoint("BOTTOMRIGHT",Ally,"BOTTOMRIGHT",-1*math.floor((14/103)*Ally:GetWidth()),math.floor((4/36)*Ally:GetHeight()))
						Ally.health:SetPoint("TOPLEFT",Ally,"LEFT")
						for i=1,math.floor((1/4)*Ally:GetHeight()) do Ally.health:SetTextHeight(i); end
					end
					do--Sets up the pokeballs
						for i=1,6 do
							local ball = Ally.pbs[i];
							ball:SetSize(math.floor((7/103)*Ally:GetWidth()),math.floor((7/103)*Ally:GetWidth()))
							if (i == 1) then
								ball:SetPoint("BOTTOMLEFT",Ally,"TOPLEFT",30,5)
							else
								ball:SetPoint("LEFT",Ally.pbs[i-1],"RIGHT",10,0)
							end
						end
					end
					do--Sets up the buff notification
						local bpn = Ally.bpn
						bpn:SetPoint("TOPLEFT",Ally,"TOPLEFT",math.floor((16/103)*Ally:GetWidth()),-1*math.floor((23/36)*Ally:GetHeight()))
						bpn:SetPoint("BOTTOMRIGHT",Ally,"TOPLEFT",math.floor((35/103)*Ally:GetWidth()),-1*math.floor((30/36)*Ally:GetHeight()))
					end
				end
				do--Enemy Frame
					local Enemy = self.Enemy
					Enemy:SetSize(math.floor((100/240)*self:GetParent().AskBar:GetWidth()),math.floor((28/48)*self:GetParent().AskBar:GetHeight()))
					do--Level
						Enemy.level:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((1/3)*Enemy:GetParent().Ally:GetHeight()));
						Enemy.level:SetPoint("TOPRIGHT",Enemy,"TOPRIGHT",-1*math.floor((13/100)*Enemy:GetWidth()),-1*math.floor((4/28)*Enemy:GetHeight()))
						Enemy.level:SetSize((65/333)*Enemy:GetWidth(),(28/93)*Enemy:GetHeight());
						for i=1,math.floor((1/3)*Enemy:GetParent().Ally:GetHeight()) do Enemy.level:SetTextHeight(i); end
					end
					do--Name text
						Enemy.name:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((1/3)*Enemy:GetParent().Ally:GetHeight()));
						Enemy.name:SetPoint("TOPLEFT",Enemy,"TOPLEFT",math.floor((6/100)*Enemy:GetWidth()),-1*math.floor((4/28)*Enemy:GetHeight()))
						for i=1,math.floor((1/3)*Enemy:GetParent().Ally:GetHeight()) do Enemy.name:SetTextHeight(i); end
					end
					do--StatusBar setup
						Enemy.hp:SetPoint("TOPLEFT",Enemy,"TOPLEFT",math.floor((1169/3000)*Enemy:GetWidth()),-1*math.floor((509/840)*Enemy:GetHeight()))
						Enemy.hp:SetPoint("BOTTOMRIGHT",Enemy,"TOPLEFT",math.floor((2608/3000)*Enemy:GetWidth()),-1*math.floor((568/840)*Enemy:GetHeight()))
						Enemy.hpbg:SetPoint("TOPLEFT",Enemy.hp,"TOPLEFT",-1*math.floor((312/1000)*Enemy.hp:GetWidth()),math.floor((58/108)*Enemy.hp:GetHeight()))
						Enemy.hpbg:SetPoint("BOTTOMRIGHT",Enemy.hp,"BOTTOMRIGHT",math.floor((40/1000)*Enemy.hp:GetWidth()),-1*math.floor((58/108)*Enemy.hp:GetHeight()))
					end
					do--Sets up the pokeballs
						for i=1,6 do
							local ball = Enemy.pbs[i];
							ball.petOwner = LE_BATTLE_PET_ENEMY
							ball:EnableMouse(true)
							ball:SetSize(math.floor((7/103)*self.Ally:GetWidth()),math.floor((7/103)*self.Ally:GetWidth()))
							if (i == 1) then
								ball:SetPoint("BOTTOMRIGHT",Enemy,"TOPRIGHT",-20,5)
							else
								ball:SetPoint("RIGHT",Enemy.pbs[i-1],"LEFT",-10,0)
							end
						end
					end
					do
						local bpn = Enemy.bpn
						bpn:SetPoint("TOPLEFT",Enemy,"TOPLEFT",math.floor((4/100)*Enemy:GetWidth()),-1*math.floor((14/28)*Enemy:GetHeight()))
						bpn:SetPoint("BOTTOMRIGHT",Enemy,"TOPLEFT",math.floor((21/100)*Enemy:GetWidth()),-1*math.floor((21/28)*Enemy:GetHeight()))
					end
				end
			end
		end
	end,
	updateUnitFrames = WoWkemon_UpdateUnitFrames,
	initTimer = function(self,num)
		if (num == 0) then
			self.Timer = CreateFrame("Frame",nil,self)
			local self = self.Timer
			do--Creates the time fontstring
				self.time = self:CreateFontString(nil,"OVERLAY",3)
				self.time:SetPoint("TOPRIGHT",self:GetParent():GetParent(),"TOPRIGHT");
				self.time:SetFont(_wd() .. "Fonts\\pkmn.ttf",60,"OUTLINE");
				WoWkemon_GiveTextShadow(self.time)
				self.time:SetTextColor(1,1,1,1);
				self.time:SetJustifyH("RIGHT");
				self.time:SetJustifyV("TOP");
				self.time:SetWordWrap(true);
				for i=1,55 do self.time:SetTextHeight(i); end
			end
			self:SetScript("OnUpdate", function(self) WoWkemon_UpdateTimer(self) end)
		elseif (num == 1) then
			-- Resolution-based calculations
		elseif (num == 2) then
			if (self.Ally) then self.Ally:SetPoint("TOPLEFT",self,"CENTER") end
			if (self.Enemy) then self.Enemy:SetPoint("TOPLEFT",self,"CENTER",self.Enemy:GetWidth()*-1,self.Enemy:GetHeight()*-1) end
		end
	end,
	updateTimer = WoWkemon_UpdateTimer,
	updateTimerValues = WoWkemon_UpdateTimerValues,
	turnComplete = function()
		WoWkemon_TurnComplete()
	end,
}
WoWkemon_RegisterTheme(rands)