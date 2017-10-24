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
function WoWkemon_Default_GiveTextShadow(textObject)
	textObject:SetShadowColor(137/255,163/255,125/255,1);
	textObject:SetShadowOffset(3,-3);
end
function WoWkemon_Default_GiveTextBrownShadow(textObject)
	textObject:SetShadowColor(229/255,229/255,185/255,1);
	textObject:SetShadowOffset(3,-3);
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
local function wrap(str, limit, indent, indent1)
  indent = indent or ""
  indent1 = indent1 or indent
  limit = limit or 72
  local here = 1-#indent1
  local ds = 0
  return indent1..str:gsub("(%s+)()(%S+)()",
      function(sp, st, word, fi)
        if fi-here > limit then
          here = st - #indent
         -- print((here-(ds*87)))
            return "\n"..word
        end
      end)
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
local function wlen(dict)
	local int = 0;
	for i,j in pairs(dict) do
		int = int + 1;
	end
	return int;
end
local function _wd() return "Interface\\AddOns\\WoWkemon\\Themes\\Default\\" end
local function ting() PlaySoundFile("Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Sounds\\ting.ogg", "Master") end
local function thunk() PlaySoundFile("Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\Sounds\\thump.ogg", "Master") end
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
function WoWkemon_Default_SetFrame(frame)
	local framelist = {
	"AskBar",
	-- "FightBar",
	-- "DialogBar",
	}
	for i,j in pairs(framelist) do
		if (WoWkemon["Default"]:IsVisible() == 1) then
			if (j ~= frame) then
				WoWkemon["Default"][j]:Hide();
			else
				WoWkemon["Default"][j]:Show();
			end
		end
	end
end
function WoWkemon_Default_UpdateSwap()
	local sl = WoWkemon["Default"].AskBar.Select
	for i = 1, C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) do
		local button = sl.btns[i]
		button.petIndex = i;
		button.petOwner = LE_BATTLE_PET_ALLY;
		local name,_ = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, i);
		if (string.len(name) >= 18) then
			name = abbreviate(name,18)
		end
		if (C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, i) == 0) then
			button.name:SetText("|cffa9a9a9" .. name .. "|r")
		else
			button.name:SetText(name)
		end
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, i), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, i);
		button.hp:SetMinMaxValues(0,maxHealth)
		button.hp:SetValue(health)
		WoWkemon_Default_StatusColors(button.hp,health,maxHealth)
		local level = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY, i);
		button.level:SetText("Lv:" .. level)
		button.pm:SetDisplayInfo(C_PetBattles.GetDisplayID(LE_BATTLE_PET_ALLY,i));
		button.pm:SetRotation(-BATTLE_PET_DISPLAY_ROTATION);
		button.pm:SetDoBlend(false);
		if ( C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, i) == 0 ) then
			button.pm:SetAnimation(6, 0);
		else
			button.pm:SetAnimation(742, 0);
		end
		button:Show()
	end
	for i = C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) + 1,3 do
		local button = sl.btns[i]
		button:Hide()
	end 
end
function WoWkemon_Default_AskClickHandler(self,button,down)
	if (self.text:GetText() == "RUN") then
		WoWkemon_Default_Forfeit()
	elseif (self.text:GetText() == "PASS") then
		WoWkemon_Default_ActionChosen()
		C_PetBattles.SkipTurn();
		self.icon:Hide()
	elseif (self.text:GetText() == "FIGHT") then
		WoWkemon_Default_UpdateAbilities()
		local ab = WoWkemon["Default"].AskBar
		ab.Select:Hide()
		ab.Fight:Show()
	elseif (self.text:GetText() == "SWAP") then
		local ab = WoWkemon["Default"].AskBar
		WoWkemon_Default_UpdateSwap()
		ab.Fight:Hide()
		ab.Select:Show()
	end
end
function WoWkemon_Default_StatusColors(statusBar, health, maxHealth)
	if ((health/maxHealth) >= .50) then
		statusBar:SetStatusBarColor(112/255,248/255,168/255,1)
	elseif ((health/maxHealth) >= .30) then
		statusBar:SetStatusBarColor(248/255,224/255,56/255,1)
	elseif ((health/maxHealth) < .30) then
		statusBar:SetStatusBarColor(248/255,88/255,56/255,1)
	end
end
function WoWkemon_Default_UpdateAskBar(text)
	local name = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY));
	local self = WoWkemon["Default"].AskBar
	-- if (name) then
	-- 	if name:match("'") then
	-- 		name = name:gsub("'","")
	-- 	end
	-- end
	local fs = self.willdo
	fs:SetWordWrap(true)
	if (text) then
		fs:SetText(text)
	else
		fs:SetText("What will \n" .. name .. " do?");
	end
	self.willdo:SetFont(_wd() .. "Fonts\\04b03.TTF",(43/241)*self:GetHeight());
	for i=1,(43/241)*self:GetHeight() do self.willdo:SetTextHeight(i); end
	local ubcnt = 0;
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
	for i=1,3 do
		if (C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, activePet, i)) then
			local isUsable, currentCooldown = C_PetBattles.GetAbilityState(LE_BATTLE_PET_ALLY, activePet, i);
			if (isUsable == true) then
				ubcnt = ubcnt + 1;
			end
		end
	end
	-- 	----print(string.format("Total abilities: %d Unusable abilities: %d",(3-ncnt),ubcnt))
	if (ubcnt == 0) then
		--self.buttons[1]:Disable()
		self.buttons[1].text:SetTextColor(208/255,208/255,200/255,1);
		self.buttons[1]:SetScript( "OnLeave", nil);
		self.buttons[1]:SetScript( "OnEnter", nil);
		self.buttons[1]:SetScript( "OnClick", nil);
		self.buttons[1].icon:Hide();
	else
		--self.buttons[1]:Enable()
		self.buttons[1].text:SetTextColor(32/255,56/255,0,1);
		self.buttons[1]:SetScript( "OnClick", function (zalf,button,down)
			WoWkemon_Default_AskClickHandler(zalf,button,down);
		end);
		self.buttons[1]:SetScript( "OnLeave", function(self)
			self.icon:Hide();
		end );
		self.buttons[1]:SetScript( "OnEnter", function(self)
			self.icon:Show();
			ting()
		end );
	end
	local ap = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY);
	local eh,emh = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, ap), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ENEMY, ap);
	if ((eh/emh) <= 0.3) and (C_PetBattles.IsWildBattle() == true) then
		self.trap:Show()
	else
		self.trap:Hide()
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
			self.buttons[3].icon:Hide();
		else
			--self.buttons[3]:Enable()
			self.buttons[3].text:SetTextColor(32/255,56/255,0,1);
			self.buttons[3]:SetScript( "OnClick", function (zalf,button,down)
				WoWkemon_Default_AskClickHandler(zalf,button,down);
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
	for j,i in ipairs({2,4}) do
		self.buttons[i].text:SetTextColor(32/255,56/255,0,1);
		self.buttons[i]:SetScript( "OnClick", function (zalf,button,down)
			WoWkemon_Default_AskClickHandler(zalf,button,down);
		end);
		self.buttons[i]:SetScript( "OnLeave", function(self)
			self.icon:Hide();
		end );
		self.buttons[i]:SetScript( "OnEnter", function(self)
			self.icon:Show();
			ting()
		end );
	end
end
function WoWkemon_Default_UnitTTPOnLoad(self,num)
	if (num == 0) then
		self.unit = CreateFrame("Frame",nil,self)
		local unit = self.unit
		local backdrop = {
		  -- path to the background texture
		  bgFile = _wd() .. "Textures\\Frames\\bg.tga",
		  -- path to the border texture
		  edgeFile = _wd() .. "Textures\\Frames\\border.tga",
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
		unit:SetBackdrop(backdrop)
		unit:SetFrameStrata("TOOLTIP")
		unit.model = CreateFrame("PlayerModel",nil,unit)
		unit.model:SetRotation(-BATTLE_PET_DISPLAY_ROTATION);
		unit.model:SetDoBlend(false);
		do--Name text
			unit.name = unit:CreateFontString(nil,"OVERLAY",2)
			unit.name:SetTextColor(32/255,56/255,0,1);
			unit.name:SetJustifyH("CENTER");
			unit.name:SetJustifyV("TOP");
			WoWkemon_Default_GiveTextBrownShadow(unit.name)
		end
		do--Name text
			unit.level = unit:CreateFontString(nil,"OVERLAY",2)
			unit.level:SetTextColor(32/255,56/255,0,1);
			unit.level:SetJustifyH("CENTER");
			unit.level:SetJustifyV("TOP");
			WoWkemon_Default_GiveTextBrownShadow(unit.level)
		end
		do--Name text
			unit.health = unit:CreateFontString(nil,"OVERLAY",2)
			unit.health:SetTextColor(32/255,56/255,0,1);
			unit.health:SetJustifyH("CENTER");
			unit.health:SetJustifyV("TOP");
			WoWkemon_Default_GiveTextBrownShadow(unit.health)
		end
		unit.type = unit:CreateTexture(nil,"OVERLAY",2)
		unit.type:SetTexture(_wd() .. "Textures\\Icons\\icons.tga")
		unit.hpbg = unit:CreateTexture(nil,"OVERLAY",nil,2)
		unit.hpbg:SetTexture(_wd() .. "Textures\\Battle\\hpbg.tga")
		unit.hp = CreateFrame("StatusBar",nil,unit)
		unit.hp:SetFrameLevel(6)
		unit.hp.barbg = unit.hp:CreateTexture(nil,"OVERLAY",nil,3)
		unit.hp.barbg:SetTexture(_wd() .. "Textures\\Battle\\barbg.tga")
		unit.hp:SetStatusBarTexture(unit.hp.barbg,"OVERLAY")
		unit.hp:SetStatusBarColor(112/255,248/255,168/255,1)
		unit.hp:SetMinMaxValues(1,100)
		unit.hp:SetValue(100)
		unit.xpbg = unit:CreateTexture(nil,"OVERLAY",2)
		unit.xpbg:SetTexture(_wd() .. "Textures\\Battle\\xp.tga")
		unit.xpbg:SetTexCoord(0,1,0,15/16)
		do--StatusBar setup
			unit.xp = CreateFrame("StatusBar",nil,unit)
			unit.xp:SetFrameLevel(5)
			unit.xp.barbg = unit.xp:CreateTexture(nil,"OVERLAY",nil,3)
			unit.xp.barbg:SetTexture(_wd() .. "Textures\\Battle\\barbg.tga")
			unit.xp:SetStatusBarTexture(unit.xp.barbg,"OVERLAY")
			unit.xp:SetStatusBarColor(64/255,200/255,248/255,1)
			unit.xp:SetMinMaxValues(1,100)
			unit.xp:SetValue(100)
		end
		unit.ab = CreateFrame("Frame",nil,unit)
		unit.ab:SetSize(250,200)
		unit.ab:SetBackdrop(backdrop)
		local ab = unit.ab
		do
			ab.attack = ab:CreateFontString(nil,"OVERLAY",2)
			ab.attack:SetTextColor(32/255,56/255,0,1);
			ab.attack:SetJustifyH("LEFT");
			ab.attack:SetJustifyV("TOP");
			WoWkemon_Default_GiveTextBrownShadow(ab.attack)
		end
		do
			ab.speed = ab:CreateFontString(nil,"OVERLAY",2)
			ab.speed:SetTextColor(32/255,56/255,0,1);
			ab.speed:SetJustifyH("RIGHT");
			ab.speed:SetJustifyV("TOP");
			WoWkemon_Default_GiveTextBrownShadow(ab.speed)
		end
		do
			ab.abname = ab:CreateFontString(nil,"OVERLAY",2)
			ab.abname:SetTextColor(32/255,56/255,0,1);
			ab.abname:SetJustifyH("LEFT");
			ab.abname:SetJustifyV("TOP");
			WoWkemon_Default_GiveTextBrownShadow(ab.abname)
		end
		do
			ab.cd = ab:CreateFontString(nil,"OVERLAY",2)
			ab.cd:SetTextColor(32/255,56/255,0,1);
			ab.cd:SetJustifyH("LEFT");
			ab.cd:SetJustifyV("TOP");
			WoWkemon_Default_GiveTextBrownShadow(ab.cd)
		end
		do
			ab.abns = {}
			for i=1,3 do
				ab.abns[i] = ab:CreateFontString(nil,"OVERLAY",2)
				local abnstr = ab.abns[i];
				abnstr:SetTextColor(32/255,56/255,0,1);
				abnstr:SetJustifyH("LEFT");
				abnstr:SetJustifyV("TOP");
				WoWkemon_Default_GiveTextBrownShadow(abnstr)
			end
			ab.cds = {}
			for i=1,3 do
				ab.cds[i] = ab:CreateFontString(nil,"OVERLAY",2)
				local abnstr = ab.cds[i];
				abnstr:SetTextColor(32/255,56/255,0,1);
				abnstr:SetJustifyH("CENTER");
				abnstr:SetJustifyV("TOP");
				WoWkemon_Default_GiveTextBrownShadow(abnstr)
			end
		end
		unit:Hide()
	elseif (num == 1) then
		local unit = self.unit
		unit:SetSize((300/1080)*GetScreenHeight()*(250/300),(300/1080)*GetScreenHeight())
		local uw, uh = unit:GetWidth(), unit:GetHeight()
		unit.model:SetPoint("TOPLEFT",unit,"TOPLEFT",(20/250)*uw,-1*(20/300)*uh)
		unit.model:SetPoint("BOTTOMRIGHT",unit,"BOTTOMRIGHT",-1*(20/250)*uw,(20/300)*uh)
		do
			unit.name:SetFont(_wd() .. "Fonts\\04b03.TTF",(50/717)*uh);
			unit.name:SetPoint("TOP",unit,"TOP",0,-1*(uh*(46/717)))
			for i=1,(50/717)*uh do unit.name:SetTextHeight(i); end
		end
		do
			unit.level:SetFont(_wd() .. "Fonts\\04b03.TTF",(50/717)*uh);
			unit.level:SetPoint("TOPLEFT",unit,"TOPLEFT",(64/600)*uw,-1*(uh*(104/717)))
			for i=1,(50/717)*uh do unit.level:SetTextHeight(i); end
		end
		do
			unit.health:SetFont(_wd() .. "Fonts\\04b03.TTF",(50/717)*uh);
			unit.health:SetPoint("BOTTOMRIGHT",unit,"TOPRIGHT",-1*(64/600)*uw,-1*(uh*(994/1195)))
			for i=1,(50/717)*uh do unit.health:SetTextHeight(i); end
		end
		unit.type:SetPoint("TOPRIGHT",unit,"TOPRIGHT",-1*(64/600)*uw,-1*(uh*(104/717)))
		unit.type:SetSize((50/717)*uh*(32/14),(50/717)*uh)
		unit.hpbg:SetPoint("TOPLEFT",unit,"TOPLEFT",(108/1000)*uw,-1*(uh*(1001/1195)))
		unit.hpbg:SetPoint("BOTTOMRIGHT",unit,"TOPLEFT",(899/1000)*uw,-1*(uh*(1051/1195)))
		unit.hp:SetPoint("TOPLEFT",unit,"TOPLEFT",(233/1000)*uw,-1*(uh*(1018/1195)))
		unit.hp:SetPoint("BOTTOMRIGHT",unit,"TOPLEFT",(882/1000)*uw,-1*(uh*(1034/1195)))
		do--StatusBar setup
			unit.xpbg:SetPoint("TOPLEFT",unit,"TOPLEFT",(108/1000)*uw,-1*(1080/1195)*uh)
			unit.xpbg:SetPoint("BOTTOMRIGHT",unit,"TOPLEFT",(899/1000)*uw,-1*(1104/1195)*uh)
		end
		do--StatusBar setup
			unit.xp:SetPoint("TOPLEFT",unit,"TOPLEFT",(108/1000)*uw,-1*(1080/1195)*uh)
			unit.xp:SetPoint("BOTTOMRIGHT",unit,"TOPLEFT",(899/1000)*uw,-1*(1104/1195)*uh)
		end
		local abw, abh = unit.ab:GetWidth(),unit.ab:GetHeight()
		local ab = unit.ab
		do
			ab.attack:SetPoint("TOPLEFT",ab,"TOPLEFT",(77/1000)*abw,-1*(66/793)*abh)
			ab.attack:SetFont(_wd() .. "Fonts\\04b03.TTF",(60/717)*uh);
		end
		do
			ab.speed:SetPoint("TOPRIGHT",ab,"TOPRIGHT",-1*(77/1000)*abw,-1*(66/793)*abh)
			ab.speed:SetFont(_wd() .. "Fonts\\04b03.TTF",(60/717)*uh);
		end
		do
			ab.abname:SetPoint("TOPLEFT",ab,"TOPLEFT",(17/246)*abw,-1*(47/194)*abh)
			ab.abname:SetFont(_wd() .. "Fonts\\04b03.TTF",(18/194)*abh);
			ab.abname:SetText("Ability Name")
		end
		do
			ab.cd:SetPoint("TOPRIGHT",ab,"TOPLEFT",(218/246)*abw,-1*(47/194)*abh)
			ab.cd:SetFont(_wd() .. "Fonts\\04b03.TTF",(18/194)*abh);
			ab.cd:SetText("CD")
		end
		do
			for i=1,3 do
				local abnstr = ab.abns[i];
				if (i == 1) then
					abnstr:SetPoint("TOPLEFT",ab.abname,"TOPLEFT",0,-1*(30/194)*abh)
				else
					abnstr:SetPoint("TOPLEFT",ab.abns[i-1],"TOPLEFT",0,-1*(30/194)*abh)
				end
				abnstr:SetFont(_wd() .. "Fonts\\04b03.TTF",(18/194)*abh);
				abnstr:SetText("Name")
			end
			for i=1,3 do
				local abnstr = ab.cds[i];
				if (i == 1) then
					abnstr:SetPoint("TOPRIGHT",ab.cd,"TOPRIGHT",0,-1*(30/194)*abh)
				else
					abnstr:SetPoint("TOPRIGHT",ab.cds[i-1],"TOPRIGHT",0,-1*(30/194)*abh)
				end
				abnstr:SetFont(_wd() .. "Fonts\\04b03.TTF",(18/194)*abh);
				abnstr:SetText(i)
			end
		end
	end	
end
function WoWkemon_Default_UnitTTPLoadForUnit(petOwner,petIndex)
	local unit = WoWkemon["Default"].unit
	unit.model:SetDisplayInfo(C_PetBattles.GetDisplayID(petOwner, petIndex));
	if ( C_PetBattles.GetHealth(petOwner, petIndex) == 0 ) then
		unit.model:SetAnimation(6, 0);
	else
		unit.model:SetAnimation(742, 0);
	end
	local name, speciesName = C_PetBattles.GetName(petOwner, petIndex);
	if (string.len(name) >= 15) then
		name = abbreviate(name,15)
	end
	unit.name:SetText(name)
	local level = C_PetBattles.GetLevel(petOwner,petIndex);
	unit.level:SetText("Lv:" .. level)
	local petType = C_PetBattles.GetPetType(petOwner, petIndex);
	unit.type:SetTexCoord(0,1,WKMN_TypeIcons[PET_TYPE_SUFFIX[petType]].t,WKMN_TypeIcons[PET_TYPE_SUFFIX[petType]].b)
	local health,maxHealth = C_PetBattles.GetHealth(petOwner, petIndex), C_PetBattles.GetMaxHealth(petOwner, petIndex);
	unit.hp:SetMinMaxValues(0,maxHealth)
	unit.hp:SetValue(health)
	unit.health:SetText(valShort(health) .. "/" .. valShort(maxHealth))
	WoWkemon_Default_StatusColors(unit.hp,health,maxHealth)
	if (petOwner == LE_BATTLE_PET_ALLY) then
		local xp, maxXp = C_PetBattles.GetXP(petOwner, petIndex);
		unit.xp:SetMinMaxValues(0,maxXp)
		unit.xp:SetValue(xp)
		unit.xp:Show()
		unit.xpbg:Show()
	else
		unit.xp:Hide()
		unit.xpbg:Hide()
	end
	local ab = unit.ab
	local attack = C_PetBattles.GetPower(petOwner, petIndex);
	local speed = C_PetBattles.GetSpeed(petOwner, petIndex);
	local opponentSpeed = 0;
	if ( petOwner == LE_BATTLE_PET_ALLY ) then
		opponentSpeed = C_PetBattles.GetSpeed(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY));
	else
		opponentSpeed = C_PetBattles.GetSpeed(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY));
	end
	ab.attack:SetText("|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:0:0:32:32:0:16:0:16|t" .. attack)
	if (speed > opponentSpeed) then
		ab.speed:SetText("|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:0:0:32:32:0:16:16:32|t" .. speed .. "|cFF00FF00(adv)|r")
	else
		ab.speed:SetText("|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:0:0:32:32:0:16:16:32|t" .. speed)
	end
	for i=1,3 do
		local abnstr = ab.abns[i];
		local cdstr = ab.cds[i];
		if (C_PetBattles.GetAbilityInfo(petOwner, petIndex, i)) then
			local isUsable, currentCooldown = C_PetBattles.GetAbilityState(petOwner, petIndex, i);
			local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(petOwner, petIndex, i);
			if (string.len(name) > 14) then
				name = abbreviate(name,14);
			end
			if (isUsable == false) then
				name = "|cffa9a9a9" .. name .. "|r"
			end
			if (C_PetBattles.GetAttackModifier(petType,C_PetBattles.GetPetType(PetBattleUtil_GetOtherPlayer(petOwner), C_PetBattles.GetActivePet(PetBattleUtil_GetOtherPlayer(petOwner)))) > 1) then
				name = name .. "|cFF00FF00(a)|r"
			elseif (C_PetBattles.GetAttackModifier(petType,C_PetBattles.GetPetType(PetBattleUtil_GetOtherPlayer(petOwner), C_PetBattles.GetActivePet(PetBattleUtil_GetOtherPlayer(petOwner)))) < 1) then
				name = name .. "|cFFFF0000(d)|r"
			end
			name = "|T" .. icon .. ":0|t " .. name
			abnstr:SetText(name)
			if (isUsable == true) then
				if (maxCooldown == 0) then
					cdstr:SetText("--")
				else
					cdstr:SetText(maxCooldown)
				end
				
			else
				cdstr:SetText("|cFFFF0000" .. currentCooldown .. "|r")
			end
		else
			abnstr:SetText("--")
			cdstr:SetText("--")
		end
	end
end
function WoWkemon_Default_UnitTTPAttach(point,refobj,point2)
	local unit = WoWkemon["Default"].unit
	unit.ab:ClearAllPoints()
	unit:ClearAllPoints()
	if (point == "RIGHT") then
		unit.ab:SetPoint("TOPRIGHT",unit,"TOPLEFT")
	else
		unit.ab:SetPoint("TOPLEFT",unit,"TOPRIGHT")
	end
	unit:SetPoint(point,refobj,point2)
end
function WoWkemon_Default_UnitTTPShow()
	local unit = WoWkemon["Default"].unit
	unit:Show()
end
function WoWkemon_Default_UnitTTPHide()
	local unit = WoWkemon["Default"].unit
	unit:Hide()
end
function WoWkemon_Default_AbilityTTPOnLoad(self,num)
	if (num == 0) then
		self.ability = CreateFrame("Frame",nil,self)
		local ability = self.ability
		local backdrop = {
		  -- path to the background texture
		  bgFile = _wd() .. "Textures\\Frames\\bg.tga",
		  -- path to the border texture
		  edgeFile = _wd() .. "Textures\\Frames\\border.tga",
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
		ability:SetBackdrop(backdrop)
		ability:SetFrameStrata("TOOLTIP")
		do--Name text
			ability.name = ability:CreateFontString(nil,"OVERLAY",2)
			ability.name:SetTextColor(32/255,56/255,0,1);
			ability.name:SetJustifyH("LEFT");
			ability.name:SetJustifyV("TOP");
			WoWkemon_Default_GiveTextBrownShadow(ability.name)
		end
		ability.type = ability:CreateTexture(nil,"OVERLAY",2)
		ability.type:SetTexture(_wd() .. "Textures\\Icons\\icons.tga")
		do--Name text
			ability.cd = ability:CreateFontString(nil,"OVERLAY",2)
			ability.cd:SetTextColor(32/255,56/255,0,1);
			ability.cd:SetJustifyH("LEFT");
			ability.cd:SetJustifyV("TOP");
			WoWkemon_Default_GiveTextBrownShadow(ability.cd)
		end
		do--Name text
			ability.desc = ability:CreateFontString(nil,"OVERLAY",2)
			ability.desc:SetTextColor(32/255,56/255,0,1);
			ability.desc:SetJustifyH("LEFT");
			ability.desc:SetJustifyV("TOP");
			WoWkemon_Default_GiveTextBrownShadow(ability.desc)
		end
		ability:Hide()
	elseif (num == 1) then
		local ability = self.ability
		--print("Screen dimensions on load: ",GetScreenWidth(),GetScreenHeight())
		ability:SetSize((270/1080)*GetScreenHeight(),(213/1080)*GetScreenHeight())
		
		--print("Set ability size to",(300/1080)*GetScreenHeight()*(380/300),(300/1080)*GetScreenHeight())
		--ability.bg:SetSize((300/1080)*GetScreenHeight()*(400/300),(300/1080)*GetScreenHeight())
		local uw, uh = ability:GetWidth(), ability:GetHeight()
		do
			ability.name:SetFont(_wd() .. "Fonts\\04b03.TTF",(50/717)*uh);
			ability.name:SetText("Hello world")
			ability.name:SetPoint("TOPLEFT",ability,"TOPLEFT",(75/1000)*uw,-1*(75/929)*uh)
			for i=1,(80/929)*uh do ability.name:SetTextHeight(i); end
		end
		ability.type:SetPoint("TOPRIGHT",ability,"TOPRIGHT",-1*(75/1000)*uw,-1*(uh*(75/929)))
		ability.type:SetSize((75/929)*uh*(32/14),(75/929)*uh)
		ability.type:SetTexCoord(0,1,WKMN_TypeIcons[PET_TYPE_SUFFIX[1]].t,WKMN_TypeIcons[PET_TYPE_SUFFIX[1]].b)
		do
			ability.cd:SetFont(_wd() .. "Fonts\\04b03.TTF",(50/717)*uh);
			ability.cd:SetText("3 round cooldown")
			ability.cd:SetPoint("TOPLEFT",ability.name,"BOTTOMLEFT",0,-1*(20/929)*uh)
			for i=1,(80/929)*uh do ability.cd:SetTextHeight(i); end
		end
		do
			ability.desc:SetFont(_wd() .. "Fonts\\04b03.TTF",(50/717)*uh);
			ability.desc:SetText(wrap("This is a long sample of text that is really long.",23))
			ability.desc:SetPoint("TOPLEFT",ability.cd,"BOTTOMLEFT",0,-1*(20/929)*uh)
			for i=1,(80/929)*uh do ability.desc:SetTextHeight(i); end
			--23
		end
		ability:SetSize((300/1080)*GetScreenHeight()*(380/300),ability.name:GetHeight()+(80/929)*uh+(80/929)*uh+(20/929)*uh+(20/929)*uh+ability.desc:GetStringHeight()+(75/929)*uh)
	end	
end
function WoWkemon_Default_AbilityTTPLoadForAbility(petOwner,petIndex,abilityIndex)
	local ability = WoWkemon["Default"].ability
	local uw, uh = ability:GetWidth(), ability:GetHeight()
	local isUsable, currentCooldown = C_PetBattles.GetAbilityState(petOwner,petIndex, abilityIndex);
	local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(petOwner,petIndex, abilityIndex);
	PET_BATTLE_ABILITY_INFO.petOwner = petOwner;
	PET_BATTLE_ABILITY_INFO.petIndex = petIndex;
	PET_BATTLE_ABILITY_INFO.abilityID = id;
	PET_BATTLE_ABILITY_INFO.abilityIndex = abilityIndex;
	if (string.len(name) > 18) then
		ability.name:SetText(abbreviate(name,18))
	else
		ability.name:SetText(name)
	end
	ability.type:SetTexCoord(0,1,WKMN_TypeIcons[PET_TYPE_SUFFIX[petType]].t,WKMN_TypeIcons[PET_TYPE_SUFFIX[petType]].b)
	if (maxCooldown == 0) then
		ability.cd:SetText("CD: none")
	else
		if (isUsable == false) then
			ability.cd:SetText("CD: |cFFFF0000" .. currentCooldown .. "|r")
		else
			ability.cd:SetText("CD: " .. maxCooldown)
		end
	end
	local description = wrap(SharedPetAbilityTooltip_ParseText(PET_BATTLE_ABILITY_INFO, unparsedDescription),29) 
	-- if (not noStrongWeakHints) then
	-- 	local strongAg,weakAg = nil,nil;
	-- 	for i=1, C_PetJournal.GetNumPetTypes() do
	-- 		local modifier = C_PetBattles.GetAttackModifier(petType, i);

	-- 		if ( modifier > 1 ) then
	-- 			strongAg = "|cFF00FF00adv|r against |T" .. _wd() .. "Textures\\Icons\\icons.tga:"..math.floor(ability.type:GetHeight()*0.6) ..":" .. math.floor(ability.type:GetWidth()*0.6) .. ":0:0:128:1024:0:128:" .. WKMN_TypeIcons[PET_TYPE_SUFFIX[i]].t*1024 .. ":" .. WKMN_TypeIcons[PET_TYPE_SUFFIX[i]].b*1024 .. "|t"
	-- 		elseif ( modifier < 1 ) then
	-- 			weakAg = "|cFFFF0000disadv|r against |T" .. _wd() .. "Textures\\Icons\\icons.tga:"..math.floor(ability.type:GetHeight()*0.6) ..":" .. math.floor(ability.type:GetWidth()*0.6) .. ":0:0:128:1024:0:128:" .. WKMN_TypeIcons[PET_TYPE_SUFFIX[i]].t*1024 .. ":" .. WKMN_TypeIcons[PET_TYPE_SUFFIX[i]].b*1024 .. "|t"
	-- 		end
	-- 	end
	-- 	if (strongAg~=nil and weakAg~=nil) then
	-- 		description = description .. "\n\n" .. strongAg .. "\n" .. weakAg;
	-- 	end
	-- end
	ability.desc:SetText(description);
	ability:SetSize((300/1080)*GetScreenHeight()*(340/300),ability.name:GetHeight()+ability.cd:GetHeight()+ability.desc:GetHeight()+(20/929)*uh*7+(75/929)*uh*3)
end
function WoWkemon_Default_AbilityTTPLoadForAura(petOwner,petIndex,auraIndex)
	local ability = WoWkemon["Default"].ability
	local uw, uh = ability:GetWidth(), ability:GetHeight()
	local isUsable, currentCooldown = C_PetBattles.GetAbilityState(petOwner,petIndex, abilityIndex);
	local id, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(petOwner,petIndex,auraIndex);
	local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID(id);
	PET_BATTLE_ABILITY_INFO.petOwner = petOwner;
	PET_BATTLE_ABILITY_INFO.petIndex = petIndex;
	PET_BATTLE_ABILITY_INFO.abilityID = id;
	PET_BATTLE_ABILITY_INFO.abilityIndex = abilityIndex;
	if (string.len(name) > 18) then
		ability.name:SetText(abbreviate(name,18))
	else
		ability.name:SetText(name)
	end
	if (petType) then
		ability.type:SetTexCoord(0,1,WKMN_TypeIcons[PET_TYPE_SUFFIX[petType]].t,WKMN_TypeIcons[PET_TYPE_SUFFIX[petType]].b)
	else
		ability.type:SetTexCoord(0,1,560,565)
	end
	
	if (turnsRemaining == -1) then
		ability.cd:SetText("|cffa9a9a9(Passive buff)|r")
	else
		ability.cd:SetText(turnsRemaining .. " TR")
	end
	local description = wrap(SharedPetAbilityTooltip_ParseText(PET_BATTLE_ABILITY_INFO, unparsedDescription),24):gsub("|cFFFFFFFF","|cFF000000"):gsub("|cffffffff","|cFF000000")
	ability.desc:SetText(description);
	ability:SetSize((300/1080)*GetScreenHeight()*(340/300),ability.name:GetHeight()+ability.cd:GetHeight()+ability.desc:GetHeight()+(1/4)*ability.name:GetHeight()*5+(75/80)*ability.name:GetHeight()*3)
end
function WoWkemon_Default_AbilityTTPAttach(point,refobj,point2)
	local ability = WoWkemon["Default"].ability
	ability:ClearAllPoints()
	ability:SetPoint(point,refobj,point2)
	--WoWkemon_Default_AbilityTTPOnLoad(WoWkemon["Default"],1)
end
function WoWkemon_Default_AbilityTTPShow()
	local ability = WoWkemon["Default"].ability
	ability:Show()
end
function WoWkemon_Default_AbilityTTPHide()
	local ability = WoWkemon["Default"].ability
	ability:Hide()
end
function WoWkemon_Default_FixBattleTooltip(self, petOwner, petIndex)
	local ttp = self
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
		for _,j in ipairs({"Name","SpeciesName","AttackAmount","SpeedAmount","SpeedAdvantage","StatsLabel","AbilitiesLabel",}) do
			ttp[j]:SetTextColor(72/255,72/255,72/255,1);
			if (j ~= "SpeedAdvantage") then
				ttp[j]:SetFont(_wd() .. "Fonts\\pkmn.ttf",20);
			else
				ttp[j]:SetFont(_wd() .. "Fonts\\pkmn.ttf",15);
			end
			WoWkemon_Default_GiveTextShadow(ttp[j])
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
			WoWkemon_Default_GiveTextShadow(text)
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
	if (WOWKEMON_Default_TUTORIAL["coerul"]) then
		if (WOWKEMON_Default_TUTORIAL["coerul"] == true) then
			ttp.PetType:SetSize(37,37)
			ttp.PetType.Icon:SetTexture(ttp.PetType.Icon:GetTexture():gsub("Interface\\PetBattles\\",_wd() .. "Textures\\Icons\\") .. ".tga");
			ttp.PetType.Icon:SetTexCoord(0.79687500,0.49218750,0.50390625,0.65625000);
		else
			FixType(self)
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
			ttp.Name:SetText(abbreviate(name,18) .. "|c" .. hex .. "☆" .. "|r")
		end
	end
	if (ttp.Name:IsTruncated() == true) then
		ttp.Name:SetText(abbreviate(ttp.Name:GetText(),18))
	end
	for i=1,20 do ttp.Name:SetTextHeight(i) end
	for i=1,20 do ttp.SpeciesName:SetTextHeight(i) end
	for i=1,20 do ttp.XPText:SetTextHeight(i) end
	for i=1,20 do ttp.HealthText:SetTextHeight(i) end
end
function WoWkemon_Default_FixBuffTooltip(self,abilityInfo,additionalText)
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
			WoWkemon_Default_GiveTextShadow(ttp[j])
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
		if (WOWKEMON_Default_TUTORIAL["coerul"]) then
			if (WOWKEMON_Default_TUTORIAL["coerul"] == true) then
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
		else
			FixIcons(self)
		end
		
		ttp.WeakAgainstIcon:SetTexture(_wd() .. "Textures\\Icons\\weak.tga");
		ttp.StrongAgainstIcon:SetTexture(_wd() .. "Textures\\Icons\\strong.tga");
	end
end
function WoWkemon_Default_SetAbilitySize(value)
	for i=1,4 do
		WoWkemon["Default"].FightBar.buttons[i].text:SetTextHeight(math.floor(value))
	end
end
function WoWkemon_Default_EnableAskButtons(self)
	for i=1,4 do
		self.AskBar.buttons[i].text:SetTextColor(72/255,72/255,72/255,1);
		self.AskBar.buttons[i]:SetScript( "OnClick", function (zalf,button,down)
			WoWkemon_Default_AskClickHandler(zalf,button,down);
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
function WoWkemon_Default_DisableAskButtons(self)
	for i=1,4 do
		self.AskBar.buttons[i].text:SetTextColor(208/255,208/255,200/255,1);
		self.AskBar.buttons[i]:SetScript( "OnLeave", nil);
		self.AskBar.buttons[i]:SetScript( "OnEnter", nil);
		self.AskBar.buttons[i]:SetScript( "OnClick", nil);
	end
end
function WoWkemon_Default_Dialog(text, func, is)
	local self = WoWkemon["Default"].AskBar
	self.willdo:SetText("...")
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
					self.willdo:SetText(string.sub(self.text,1,self.si))
					self.si = self.si + 1;
				else
					self.finished = true;
				end
			end
		end);
	else
		self.willdo:SetText(text)
		self.finished = true;
	end
	if (is) then
		self.willdo:SetText(text)
		self.finished = true;
		self:SetScript("OnUpdate", nil)
	end
	-- if (func) then
	-- 	self.prompt = true;
	-- 	if (self.button == nil) then
	-- 		self.button = CreateFrame("Button",nil,self)
	-- 	end
	-- 	self.button:SetAllPoints(UIParent)
	-- 	self.button:SetFrameStrata("HIGH")
	-- 	self.button:RegisterForClicks("AnyUp")
	-- 	self.button:EnableMouse(true)
	-- 	self.button:SetScript("OnClick",function(self,button,down)
	-- 		if (self:GetParent().finished == true) then func(self,button); end
	-- 	end);
	-- else
	-- 	if (self.button) then
	-- 		self.button:EnableMouse(false)
	-- 		self.button:SetScript("OnClick",nil);
	-- 	end
	-- end
	-- self.arrow:Show()
end
function WoWkemon_Default_UpdateAbilities()
	local self = WoWkemon["Default"].AskBar
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
	local ac = 0;
	for i=1,3 do
		local button = self.Fight.btns[i]
		if (C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, activePet, i)) then
			local isUsable, currentCooldown = C_PetBattles.GetAbilityState(LE_BATTLE_PET_ALLY, activePet, i);
			local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, activePet, i);
			if (isUsable == true) then
				button.name:SetText(name)
			else
				button.name:SetText("|cffa9a9a9" .. name .. "|r")
			end
			button.icon:SetTexture(icon)
			if (C_PetBattles.GetAttackModifier(petType,C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))) > 1) then
				button.type:SetText("TYPE: |cFF00FF00" .. PET_TYPE_SUFFIX[petType] .. "|r")
			elseif (C_PetBattles.GetAttackModifier(petType,C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))) < 1) then
				button.type:SetText("TYPE: |cFFFF0000" .. PET_TYPE_SUFFIX[petType] .. "|r")
			else
				button.type:SetText("TYPE: " .. PET_TYPE_SUFFIX[petType])
			end
			if (isUsable == true) then
				button.cd:SetText("CD: " .. maxCooldown)
			else
				button.cd:SetText("CD: |cFFFF0000" .. currentCooldown .. "|r")
			end
			ac = i;
			button.abi = i;
			button.iu = isUsable;
			button:Show()
		end
	end
	for i = ac + 1,3 do
		local button = self.Fight.btns[i]
		button:Hide()
	end
end
function WoWkemon_Default_GenerateBuffFrames(frame)
	frame.buffs = {}
	for i=1,10 do
		frame.buffs[i] = CreateFrame("Frame",nil,frame)
		local buff = frame.buffs[i]
		buff:SetID(i)
		buff:SetSize(24,24)
		buff.text = buff:CreateFontString(nil,"OVERLAY",6,"OUTLINE")
		buff.text:SetFont(_wd() .. "Fonts\\04b03.TTF",60);
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
		buff.icon.show = buff.icon:CreateAnimationGroup()
		buff.icon.show.alpha = buff.icon.show:CreateAnimation("Alpha")
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
			
			WoWkemon_Default_AbilityTTPLoadForAura(pnt.petOwner, C_PetBattles.GetActivePet(pnt.petOwner), self:GetID())
			
			local left, bottom = pnt:GetLeft(),pnt:GetBottom();
			local p1, p2;
			if (left > (GetScreenWidth()/2)) then
				p1 = "RIGHT";
				p2 = "LEFT";
			else
				p1 = "LEFT";
				p2 = "RIGHT";
			end
			WoWkemon_Default_AbilityTTPAttach(p1, self, p2)
			WoWkemon_Default_AbilityTTPShow()
		end);
		buff:SetScript("OnLeave", function(self)
			WoWkemon_Default_AbilityTTPHide()
		end);
		if (i > 1) then
			buff:SetPoint("LEFT",frame.buffs[i-1],"RIGHT",5,0)
		else
			buff:SetPoint("TOPLEFT",frame,"BOTTOMLEFT",10,-5)
		end
		buff:Hide()
	end
end
function WoWkemon_Default_UpdateBuffs()
	local ftable = {}
	local Ally = WoWkemon["Default"].BattleFrames.Ally
	local Enemy = WoWkemon["Default"].BattleFrames.Enemy
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
function WoWkemon_Default_UpdateUnitFrames(self)
	do--Ally
		local Ally = self.BattleFrames.Ally
		local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
		local level = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY, activePet);
		local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, activePet);
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, activePet);
		local xp, maxXp = C_PetBattles.GetXP(LE_BATTLE_PET_ALLY, activePet);
		Ally.hp:SetMinMaxValues(0,maxHealth)
		Ally.hp:SetValue(health)
		WoWkemon_Default_StatusColors(Ally.hp, health, maxHealth)
		Ally.xp:SetMinMaxValues(0,maxXp)
		Ally.xp:SetValue(xp)
		Ally.health:SetText(valShort(health) .. "/" .. valShort(maxHealth));
		if (string.len(name) >= 18) then
			name = abbreviate(name,18)
		end
		Ally.name:SetText(name);
		Ally.level:SetText("Lv:" .. level);
		for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) do
			Ally.pbs[i].petIndex = i
			Ally.pbs[i].dead:Hide();
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
		for i=C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY)+1,3 do
			Ally.pbs[i].dead:Hide();
			Ally.pbs[i].highlight:Hide();
			Ally.pbs[i].normal:Hide();
		end
	end
	do--Enemy
		local Enemy = self.BattleFrames.Enemy
		local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY);
		local level = C_PetBattles.GetLevel(LE_BATTLE_PET_ENEMY, activePet);
		local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ENEMY, activePet);
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ENEMY, activePet);
		Enemy.hp:SetMinMaxValues(0,maxHealth)
		Enemy.hp:SetValue(health)
		WoWkemon_Default_StatusColors(Enemy.hp, health, maxHealth)
		if (string.len(name) >= 18) then
			name = abbreviate(name,18)
		end
		Enemy.name:SetText(name);
		Enemy.rare:ClearAllPoints()
		Enemy.rare:SetPoint("LEFT",Enemy.name,"RIGHT")
		if (C_PetBattles.IsWildBattle() == true) then
			local opc = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY, activePet) - 1
			local r, g, b, hex = GetItemQualityColor(opc)
			--print("Setting color to ",r,g,b,"and showing")
			local function doNothing()
				--Literally does nothing
			end
			doNothing()
			Enemy.rare:SetVertexColor(r,g,b)
			Enemy.rare:SetAlpha(1)
		else
			Enemy.rare:SetAlpha(0)
		end
		Enemy.level:SetText("Lv:" .. level);
		for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY) do
			Enemy.pbs[i].petIndex = i
			Enemy.pbs[i].dead:Hide();
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
		for i=C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY)+1,3 do
			Enemy.pbs[i].dead:Hide();
			Enemy.pbs[i].highlight:Hide();
			Enemy.pbs[i].normal:Hide();
		end
		if (C_PetBattles.IsWildBattle()) then
			-- local opc = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY, activePet) - 1
			-- local r, g, b, hex = GetItemQualityColor(opc)
			-- if (hex) and (name) then
			-- 	Enemy.name:SetText(name .. "|c" .. hex .. "☆" .. "|r")
			-- end
			-- if (Enemy.name:IsTruncated() == true) then
			-- 	Enemy.name:SetText(abbreviate(name) .. "|c" .. hex .. "☆" .. "|r")
			-- end
		end
	end
	WoWkemon_Default_UpdateBuffs()
	--WoWkemon_Default_BattleAllyFixText(self.BattleFrames)
end
function WoWkemon_Default_BattleAllyFixText(self)
	local Ally = self.Ally
	--for i=1,math.floor((1/3)*Ally:GetHeight()) do Ally.name:SetTextHeight(i); Ally.health:SetTextHeight(i); Ally.level:SetTextHeight(i); end
	--Ally.level:SetSize(Ally.level:GetStringWidth()+10,Ally.level:GetHeight())
	Ally.name:SetPoint("BOTTOMRIGHT",Ally.level,"BOTTOMLEFT",-10,0)
	if (Ally.name:IsTruncated()) then
		-- while (Ally.name:IsTruncated()) do
		-- 	Ally.name:SetTextHeight(math.floor(Ally.name:GetStringHeight())-1)
		-- end
		Ally.name:SetText(abbreviate(Ally.name:GetText(),18))
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
		Enemy.name:SetText(abbreviate(Enemy.name:GetText(),18))
	end
	-- if (Enemy.level:IsTruncated()) then
	-- 	while (Enemy.level:IsTruncated()) do
	-- 		Enemy.level:SetTextHeight(math.floor(Enemy.level:GetStringHeight())-1)
	-- 	end
	-- end
end
function WoWkemon_Default_UpdateTimer(self)
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
			self.time:SetText("Waiting...");
			--WoWkemon_Default_TV:SendBattle(PET_BATTLE_WAITING_FOR_OPPONENT)
		else
			if ( self.turnTime > 0.0 ) then
				self.time:SetText(math.floor(timeRemaining));
			else
				self.time:SetText("")
			end
		end
	else
		self.time:Show()
		if ( C_PetBattles.IsWaitingOnOpponent() ) then
			self.time:SetText(PET_BATTLE_WAITING_FOR_OPPONENT);
			--WoWkemon_Default_TV:SendBattle(PET_BATTLE_WAITING_FOR_OPPONENT)
		end
	end
	if (C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == false) then
		self.time:Show()
	else
		self.time:Hide()
	end
end
function WoWkemon_Default_UpdateTimerValues(self)
	local timeRemaining, turnTime = C_PetBattles.GetTurnTimeInfo(); 
	self.turnExpires = GetTime() + timeRemaining;
	self.turnTime = turnTime;
end
function WoWkemon_Default_Rain(ss)
	local self = WoWkemon["Default"].Weather
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
			for i,j in ipairs(WoWkemon["Default"].Weather.Rain.drops) do 
				j:Show();
			end
		end
	elseif (ss == "STOP") then
		if (self.Rain) then
			self.Rain:Hide()
		end
	end
end
function WoWkemon_Default_Snow(ss)
	--Uses roughly the same system as the rain does
	local self = WoWkemon["Default"].Weather
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
			for i,j in ipairs(WoWkemon["Default"].Weather.Snow.flakes) do 
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
function WoWkemon_Default_Sand(ss)
	--Uses roughly the same system as the rain does
	local self = WoWkemon["Default"].Weather
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
			for i,j in ipairs(WoWkemon["Default"].Weather.Sand.motes) do 
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
function WoWkemon_Default_Mud(ss)
	--Uses roughly the same system as the rain does
	local self = WoWkemon["Default"].Weather
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
			for i,j in ipairs(WoWkemon["Default"].Weather.Mud.motes) do 
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
function WoWkemon_Default_StaticField(ss)
	local self = WoWkemon["Default"].Weather
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
			for i,j in ipairs(WoWkemon["Default"].Weather.StaticField.motes) do 
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
function WoWkemon_Default_Night(ss, mn)
	local self = WoWkemon["Default"].Weather
	if (ss == "START") then
		self:Show()
		if (self.Night == nil) then
			self.Night = CreateFrame("Frame",nil,self)
			local self = self.Night
			self:SetAllPoints(WoWkemon["Default"].Weather)
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
function WoWkemon_Default_Sunlight(ss)
	local self = WoWkemon["Default"].Weather
	if (ss == "START") then
		self:Show()
		if (self.Sunlight == nil) then
			self.Sunlight = CreateFrame("Frame",nil,self)
			local self = self.Sunlight
			self:SetAllPoints(WoWkemon["Default"].Weather)
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
function WoWkemon_Default_BurningEarth(ss)
	local self = WoWkemon["Default"].Weather
	if (ss == "START") then
		self:Show()
		if (self.BurningEarth == nil) then
			self.BurningEarth = CreateFrame("Frame",nil,self)
			local self = self.BurningEarth
			self:SetAllPoints(WoWkemon["Default"].Weather)
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
function WoWkemon_Default_PromptOnLoad(self)
	self.PromptFrame = CreateFrame("Frame",nil,self)
	local self = self.PromptFrame
	self:SetFrameStrata("FULLSCREEN_DIALOG")
	self:SetPoint("CENTER",UIParent,"CENTER")
	self:SetSize(300,200)
	local backdrop = {
	  -- path to the background texture
	  bgFile = _wd() .. "Textures\\Frames\\bg.tga",
	  -- path to the border texture
	  edgeFile = _wd() .. "Textures\\Frames\\border.tga",
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
	self:SetBackdrop(backdrop)
	do
		self.title = self:CreateFontString(nil,"OVERLAY")
		local ttl = self.title;
		ttl:SetTextColor(32/255,56/255,0,1);
		ttl:SetFont(_wd() .. "Fonts\\04b03.TTF",30);
		for i=1,30 do ttl:SetTextHeight(i) end
		ttl:SetPoint("TOPLEFT",self,"TOPLEFT")
		ttl:SetPoint("BOTTOMRIGHT",self,"RIGHT")
		ttl:SetText("Really forfeit?")
		WoWkemon_Default_GiveTextShadow(ttl)
	end
	do
		self.lbtn = CreateFrame("Button",nil, self);
		local lbtn = self.lbtn;
		lbtn:SetPoint("TOPLEFT", self, "LEFT");
		lbtn:SetPoint("BOTTOMRIGHT", self, "BOTTOM");
		lbtn.text = lbtn:CreateFontString(nil,"OVERLAY")
		lbtn.text:SetFont(_wd() .. "Fonts\\04b03.TTF",30);
		lbtn.text:SetAllPoints(lbtn);
		lbtn.text:SetText("YES");
		lbtn.text:SetTextColor(32/255,56/255,0,1);
		WoWkemon_Default_GiveTextShadow(lbtn.text)
		lbtn.icon = lbtn:CreateTexture(nil, "ARTWORK");
		lbtn.icon:SetTexture(_wd() .. "Textures\\arrow.tga")
		lbtn.icon:SetTexCoord(0,20/25,0,1);
		lbtn.icon:SetHeight(25);
		lbtn.icon:SetWidth(20);
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
			C_PetBattles.ForfeitGame();
			self:GetParent():Hide()
		end);
		for i=1,30 do lbtn.text:SetTextHeight(i); end
	end
	do
		self.rbtn = CreateFrame("Button",nil, self);
		local rbtn = self.rbtn;
		rbtn:SetPoint("TOPLEFT", self, "CENTER");
		rbtn:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");
		rbtn.text = rbtn:CreateFontString(nil,"OVERLAY")
		rbtn.text:SetFont(_wd() .. "Fonts\\04b03.TTF",30);
		rbtn.text:SetAllPoints(rbtn);
		rbtn.text:SetText("NO");
		rbtn.text:SetTextColor(32/255,56/255,0,1);
		WoWkemon_Default_GiveTextShadow(rbtn.text)
		rbtn.icon = rbtn:CreateTexture(nil, "ARTWORK");
		rbtn.icon:SetTexture(_wd() .. "Textures\\arrow.tga")
		rbtn.icon:SetTexCoord(0,20/25,0,1);
		rbtn.icon:SetHeight(25);
		rbtn.icon:SetWidth(20);
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
		rbtn:SetScript( "OnClick", function (self,button,down)
			self:GetParent():Hide()
		end);
		for i=1,30 do rbtn.text:SetTextHeight(i); end
	end
	self:Hide()
end
function WoWkemon_Default_Prompt(text,funcl,funcr,textl,textr)
	local self = WoWkemon["Default"].PromptFrame
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
function WoWkemon_Default_WeatherOnLoad(self)
	self.Weather = CreateFrame("Frame",nil,self)
	local self = self.Weather
	self:SetAllPoints("UIParent")
	self:RegisterEvent("PET_BATTLE_AURA_APPLIED");
	self:RegisterEvent("PET_BATTLE_AURA_CANCELED");
	self:RegisterEvent("PET_BATTLE_AURA_CHANGED");
	do--Creates the time fontstring
		self.text = self:CreateFontString(nil,"OVERLAY",3)
		self.text:SetPoint("TOPLEFT",UIParent,"TOPLEFT");
		self.text:SetFont(_wd() .. "Fonts\\04b03.TTF",60,"OUTLINE");
		WoWkemon_Default_GiveTextShadow(self.text)
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
		wa[229] = WoWkemon_Default_Rain
		wa[205] = WoWkemon_Default_Snow
		wa[596] = WoWkemon_Default_Night
		wa[403] = WoWkemon_Default_Sunlight
		wa[454] = WoWkemon_Default_Sand
		wa[718] = WoWkemon_Default_Mud
		wa[257] = WoWkemon_Default_Night
		wa[171] = WoWkemon_Default_BurningEarth
		wa[203] = WoWkemon_Default_StaticField
		self.bf:SetScript("OnEnter", function(self)
		 	if (self.aid) then
		 		self.wa[self.aid]("START")
		 	end
		end);
		self.bf:SetScript("OnLeave", function(self)
		 	WoWkemon_Default_StopAllWeather()
		end)
	end
end
function WoWkemon_Default_StopAllWeather()
	local wa = {}
	wa[229] = WoWkemon_Default_Rain
	wa[205] = WoWkemon_Default_Snow
	wa[596] = WoWkemon_Default_Night
	wa[403] = WoWkemon_Default_Sunlight
	wa[454] = WoWkemon_Default_Sand
	wa[718] = WoWkemon_Default_Mud
	wa[257] = WoWkemon_Default_Night
	wa[171] = WoWkemon_Default_BurningEarth
	wa[203] = WoWkemon_Default_StaticField
	for i,j in pairs(wa) do j("STOP") end
end
function WoWkemon_Default_WeatherUpdate(self)
	-- if not self then self = WoWkemon["Default"].Weather end
	local self = self.Weather
	local auraID, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_WEATHER, PET_BATTLE_PAD_INDEX, 1);
	if ( auraID ) then
		local id, name, icon, maxCooldown, description = C_PetBattles.GetAbilityInfoByID(auraID);
		local wa = {}
		wa[229] = WoWkemon_Default_Rain
		wa[205] = WoWkemon_Default_Snow
		wa[596] = WoWkemon_Default_Night
		wa[403] = WoWkemon_Default_Sunlight
		wa[454] = WoWkemon_Default_Sand
		wa[718] = WoWkemon_Default_Mud
		wa[257] = WoWkemon_Default_Night
		wa[171] = WoWkemon_Default_BurningEarth
		wa[203] = WoWkemon_Default_StaticField
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
function WoWkemon_Default_HideAll()
	local framelist = {
	"AskBar",
	"FightBar",
	"BagFrame",
	"SelectFrame",
	"DialogBar",
	"BattleFrames",
	}
	for i,j in pairs(framelist) do
		WoWkemon["Default"][j]:Hide();
	end
end
function WoWkemon_Default_IntroOnLoad(self)
	self.IntroFrame = CreateFrame("Frame",nil,self)
	local self = self.IntroFrame
	local function _vd() return "Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\" end
	self:SetAllPoints("UIParent")
	self:SetFrameStrata("FULLSCREEN")
	do
		self.main = self:CreateTexture(nil,"OVERLAY")
		self.main:SetTexture(_vd() .. "Textures\\Splash\\wktitle.tga")
		self.main:SetTexCoord(0,1,156/512,365/512)
		self.main:SetSize((GetScreenHeight()/4)*(512/210),GetScreenHeight()/4)
		self.main:SetPoint("CENTER",self,"CENTER")
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
	self:Hide()
	self:SetScript("OnShow", WoWkemon_Default_IntroOnShow)
	self:SetScript("OnHide", WoWkemon_Default_IntroOnHide)
end
function WoWkemon_Default_IntroOnHide(self)
	--WoWkemon["Default"].BattleFrames:Show()
	if (C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == false) then
		WoWkemon_Default_SetFrame("AskBar")
		WoWkemon_Default_UpdateAskBar("Select a starting WOWKéMON.")
	else
		WoWkemon_Default_UpdateAskBar()
		WoWkemon_Default_SetFrame("AskBar")
	end
	local ns = WoWkemon["Default"]
	ns.BattleFrames:Show();
	ns.AskBar:Show();
end
function WoWkemon_Default_IntroOnShow(self)
	local function _vd() return "Interface\\AddOns\\WoWkemon\\Themes\\Ruby&Sapphire\\" end
	local r,c = math.random(1,5), math.random(1,2);
	local ns = WoWkemon["Default"]
	ns.BattleFrames:Hide();
	ns.AskBar:Hide();
end
function WoWkemon_Default_Forfeit()
	WoWkemon["Default"].PromptFrame:Show()
	-- WoWkemon_Default_Prompt("Really forfeit?",function(self,button,down)
	-- 	C_PetBattles.ForfeitGame();
	-- 	WoWkemon["Default"].PromptFrame:Hide()
	-- 	WoWkemon_Default_Dialog("Got away safely!",nil,true)
	-- end,function(self,button,down)
	-- 	WoWkemon["Default"].PromptFrame:Hide()
	-- end,"YES","NO")
end
function WoWkemon_Default_SplashOnLoad()
	local self = CreateFrame("Frame","WoWkemon_Default_Splash",UIParent)
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
	-- 	WoWkemon_Default_GiveTextDarkShadow(main)
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
		WoWkemon_Default_Splash:Show()
	end);
	self.Open:SetScript("OnFinished",function(self)
		WoWkemon_Default_Splash:SetAlpha(1)
		WoWkemon_Default_Splash.Close:Play()
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
		WoWkemon_Default_Splash:SetAlpha(0)
		WoWkemon_Default_Splash:Hide()
	end);
end
function WoWkemon_Default_ActionChosen()
	local self = WoWkemon["Default"]
	self.AskBar.Select:Hide()
	self.AskBar.Fight:Hide()
	self.PromptFrame:Hide()
	for i = 1, 4 do
		local button = self.AskBar.buttons[i]
		button.text:SetTextColor(208/255,208/255,200/255,1);
		button:SetScript( "OnLeave", nil);
		button:SetScript( "OnEnter", nil);
		button:SetScript( "OnClick", nil);
	end
end
function WoWkemon_Default_EnemyDead()
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY);
	local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ENEMY, activePet);
	return (health == 0);
end
function WoWkemon_Default_AllyAllDead()
	local sd = true
	for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) do
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, i);
		if (health ~= 0) then sd = false end
	end
	return sd;
end
function WoWkemon_Default_EnemyAllDead()
	local sd = true
	for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY) do
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, i);
		if (health ~= 0) then sd = false end
	end
	return sd;
end
function WoWkemon_Default_AllyAlmostDead()
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
function WoWkemon_Default_TurnComplete()
	local self = WoWkemon["Default"]
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
	local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, activePet);
	if (health == 0) then
		if (WoWkemon_Default_EnemyAllDead() == false) and (WoWkemon_Default_AllyAllDead() == false) then
			if (WoWkemon_Default_AllyAlmostDead() == true) then
				--WoWkemon_Default_SetFrame("AskBar")
				WoWkemon_Default_UpdateAskBar()
			else
				-- WoWkemon_Default_SetFrame("AskBar")
				-- WoWkemon_Default_DisableAskButtons(WoWkemon)
				-- WoWkemon["Default"].AskBar.buttons[3]:Enable()
				-- self.AskBar.buttons[3].text:SetTextColor(72/255,72/255,72/255,1);
				-- self.AskBar.buttons[3]:SetScript( "OnClick", function (zalf,button,down)
				-- 	WoWkemon_Default_AskClickHandler(zalf,button,down);
				-- end);
				-- self.AskBar.buttons[3]:SetScript( "OnLeave", function(self)
				-- 	self.icon:Hide();
				-- end );
				-- self.AskBar.buttons[3]:SetScript( "OnEnter", function(self)
				-- 	self.icon:Show();
				-- 	ting()
				-- end );
				local name,_ = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY));
				WoWkemon_Default_UpdateAskBar("Your WOWKeMON fainted! Select a new one.")
			end
		elseif (WoWkemon_Default_AllyAllDead() == true) then
			WoWkemon_Default_Dialog("Lost the battle!");
		end
	else
		if (WoWkemon_Default_EnemyDead() == true) and (WoWkemon_Default_EnemyAllDead() == false) then
			-- WoWkemon_Default_SetFrame("AskBar")
			-- WoWkemon_Default_DisableAskButtons(WoWkemon)
			-- WoWkemon["Default"].AskBar.buttons[3]:Enable()
			-- self.AskBar.buttons[3].text:SetTextColor(72/255,72/255,72/255,1);
			-- self.AskBar.buttons[3]:SetScript( "OnClick", function (zalf,button,down)
			-- 	WoWkemon_Default_AskClickHandler(zalf,button,down);
			-- end);
			-- self.AskBar.buttons[3]:SetScript( "OnLeave", function(self)
			-- 	self.icon:Hide();
			-- end );
			-- self.AskBar.buttons[3]:SetScript( "OnEnter", function(self)
			-- 	self.icon:Show();
			-- 	ting()
			-- end );
			WoWkemon_Default_UpdateAskBar("You must change WOWKeMON, or select the active one.")
		elseif (WoWkemon_Default_EnemyAllDead() == true) then
			WoWkemon_Default_Dialog("Won the battle!");
		else
			WoWkemon_Default_UpdateAskBar()
			--WoWkemon_Default_SetFrame("AskBar")
		end
	end
	--WoWkemon_Default_StopAllWeather()
end
local default = {
	--Name of the theme
	name = "Default",
	usrName = "WoWkemon",
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
			self.IntroFrame:Hide()
			WoWkemon_Default_AbilityTTPOnLoad(self,1);
		elseif (event == "PET_BATTLE_OPENING_START") then
			WoWkemon_Default_WeatherUpdate(self);
			WoWkemon_Default_AbilityTTPOnLoad(self,1);
			self.anim = true;
			--WoWkemon_Default_HideAll()
			for i = 1, 4 do
				local button = self.AskBar.buttons[i]
				button.text:SetTextColor(208/255,208/255,200/255,1);
				button:SetScript( "OnLeave", nil);
				button:SetScript( "OnEnter", nil);
				button:SetScript( "OnClick", nil);
			end
			WoWkemon["Default"].IntroFrame:Show()
			self.AskBar.Select:Hide()
			self.AskBar.Fight:Hide()
			self.status = true
		elseif (event == "PET_BATTLE_OPENING_DONE") then
			--WoWkemon["Default"].IntroFrame:Hide()
			self.anim = false;

			WoWkemon_Default_UpdateTimerValues(self.Timer);
			WoWkemon["Default"].IntroFrame:Hide()
			local frame = CreateFrame("Frame",nil,UIParent)
			frame.time = 0;
			frame:SetScript("OnUpdate", function(self,elapsed)
				self.time = self.time + elapsed;
				if (self.time >= 0.5) then
					WoWkemon["Default"].BattleFrames:Show()
					WoWkemon_Default_UpdateAskBar()
					if (C_PetBattles.IsPlayerNPC(LE_BATTLE_PET_ENEMY) == false) then
						WoWkemon_Default_UpdateAskBar("Select a starting WOWKeMON.")
					else
						WoWkemon_Default_UpdateAskBar()
					end
					self:SetScript("OnUpdate",nil)
				end
			end)
		elseif (event == "DISPLAY_SIZE_CHANGED") then
		elseif (event == "PET_BATTLE_TURN_STARTED") then
			self.AskBar.Select:Hide()
		elseif (event == "PLAYER_LOGIN") then
			WoWkemon["Default"].IntroFrame:Hide()


		elseif (event == "PLAYER_LOGOUT") then
		elseif (event == "PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE") then
			WoWkemon["Default"].IntroFrame:Hide()
			WoWkemon_Default_TurnComplete()
			self.status = false;
			self.IntroFrame:Hide()
			WoWkemon_Default_UpdateTimerValues(self.Timer);
		elseif (event == "PET_BATTLE_HEALTH_CHANGED") or (event == "PET_BATTLE_MAX_HEALTH_CHANGED") then
		elseif (event == "PET_BATTLE_PET_CHANGED") then
		elseif (event == "PET_BATTLE_XP_CHANGED") then
		elseif (event == "CHAT_MSG_PET_BATTLE_COMBAT_LOG") then
		elseif ( event == "PET_BATTLE_AURA_APPLIED" or event == "PET_BATTLE_AURA_CANCELED" or event == "PET_BATTLE_AURA_CHANGED" ) then
			local petOwner, petIndex = ...;
			if ( petOwner == LE_BATTLE_PET_WEATHER ) then
				WoWkemon_Default_WeatherUpdate(self);
			end
			WoWkemon_Default_UpdateBuffs()
		end
		if (C_PetBattles.IsInBattle() == true) then
			WoWkemon_Default_UpdateUnitFrames(self)
		end
	end,
	--Also only a hook. Feel free to 
	--register whatever events you want, up to you.
	onLoad = function(self)
		self.loaded = true;
		local frames = {
			"BattleFrames",
			-- "BagFrame",
			-- "SelectFrame",
			"AskBar",
			-- "Weather",
			-- "FightBar",
			-- "IntroFrame"
		}
		local count = 0;
		for i,j in pairs(frames) do
			if (self[j]) then
				self[j]:Show();
				count = count + 1;
			end
		end
		if (count == #frames) then return 1 end

		WoWkemon_Default_WeatherOnLoad(self)
		WoWkemon_Default_PromptOnLoad(self)
		WoWkemon_Default_IntroOnLoad(self)
		WoWkemon_Default_UnitTTPOnLoad(self)
		WoWkemon_Default_AbilityTTPOnLoad(self,0)
		WoWkemon_Default_AbilityTTPOnLoad(self,1)
	end,
	onUnload = function(self)
		local frames = {
			"BattleFrames",
			-- "BagFrame",
			-- "SelectFrame",
			"AskBar",
			"PromptFrame",
			-- "Weather",
			-- "FightBar",
			-- "IntroFrame"
		}
		for i,j in pairs(frames) do self[j]:Hide() end
		self.loaded = false;
	end,
	--Fires when WoWkemon, the main frame shows.
	--Only happens when a pet battle starts.
	onShow = function(self)
		self.Weather:Hide()
	end,
	--The following function is called
	--when a tooltip showing a pet's tooltip
	--is shown. See default theme for detailed example.
	--Note: Used to change the look of the tooltips.
	fixBattleTooltip = WoWkemon_Default_FixBattleTooltip,
	--Same as battle, but for abilities.
	fixBuffTooltip = WoWkemon_Default_FixBuffTooltip,
	--There are 5 frames in WoWkemon as the default. You are not required
	--to use all of them or even any of them, but they provide a simple
	--means of changing what the user sees through WoWkemon_Default_SetFrame:
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
	--		If you initialize this and hook its objects into WoWkemon_Default_Dialog(text),
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
					ank12x = function() return oself.AskBar.BG:GetWidth()*(737/1155) end,
					ank12y = function() return -1*oself.AskBar.BG:GetHeight()*(52/241) end,
					ank3 = "BOTTOMRIGHT",
					ank4 = "TOPLEFT",
					ank34x = function() return oself.AskBar.BG:GetWidth()*(916/1155) end,
					ank34y = function() return -1*oself.AskBar.BG:GetHeight()*(99/241) end,
					text = "FIGHT",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 55,
				},
				{
					ank1 = "TOPLEFT",
					ank2 = "TOPLEFT",
					ank12x = function() return oself.AskBar.BG:GetWidth()*(737/1155) end,
					ank12y = function() return -1*oself.AskBar.BG:GetHeight()*(146/241) end,
					ank3 = "BOTTOMRIGHT",
					ank4 = "TOPLEFT",
					ank34x = function() return oself.AskBar.BG:GetWidth()*(916/1155) end,
					ank34y = function() return -1*oself.AskBar.BG:GetHeight()*(191/241) end,
					text = "PASS",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 55,
				},
				{
					ank1 = "TOPLEFT",
					ank2 = "TOPLEFT",
					ank12x = function() return oself.AskBar.BG:GetWidth()*(954/1155) end,
					ank12y = function() return -1*oself.AskBar.BG:GetHeight()*(52/241) end,
					ank3 = "BOTTOMRIGHT",
					ank4 = "TOPLEFT",
					ank34x = function() return oself.AskBar.BG:GetWidth()*(1110/1155) end,
					ank34y = function() return -1*oself.AskBar.BG:GetHeight()*(99/241) end,
					--text = "₧₦",
					text = "SWAP",
					just = "LEFT",
					clrr = 0,
					clrg = 0,
					clrb = 0,
					fh = 35,
				},
				{
					ank1 = "TOPLEFT",
					ank2 = "TOPLEFT",
					ank12x = function() return oself.AskBar.BG:GetWidth()*(954/1155) end,
					ank12y = function() return -1*oself.AskBar.BG:GetHeight()*(146/241) end,
					ank3 = "BOTTOMRIGHT",
					ank4 = "TOPLEFT",
					ank34x = function() return oself.AskBar.BG:GetWidth()*(1110/1155) end,
					ank34y = function() return -1*oself.AskBar.BG:GetHeight()*(191/241) end,
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
				self.BG:SetTexture(_wd() .. "Textures\\Frames\\askbar.tga")
				self.BG:SetTexCoord(0,1,0,214/256);
				self.BG:SetAllPoints(self)
			end
			self.buttons = {}
			self.willdo = self:CreateFontString(nil,"ARTWORK")
			WoWkemon_Default_GiveTextShadow(self.willdo)
			self.willdo:SetTextColor(32/255,56/255,0,1);
			self.willdo:SetJustifyH("LEFT");
			self.willdo:SetJustifyV("TOP");
			self.willdo:SetWordWrap(true);
			for index,array in ipairs(self.AskButtons) do
				self.buttons[index] = CreateFrame("Button",nil, self);
				local button = self.buttons[index]
				button.text = button:CreateFontString(nil,"ARTWORK")
				button.text:SetFont(_wd() .. "Fonts\\04b03.TTF",30);
				button.text:SetAllPoints(button);
				button.text:SetText(array.text);
				button.text:SetTextColor(32/255,56/255,0,1);
				button.text:SetJustifyH(array.just);
				WoWkemon_Default_GiveTextShadow(button.text)
				button.icon = button:CreateTexture(nil, "ARTWORK");
				button.icon:SetTexture(_wd() .. "Textures\\arrow.tga")
				button.icon:SetTexCoord(0,20/25,0,1);
				button.icon:Hide();
				button:SetScript( "OnLeave", function(self)
					button.icon:Hide();
				end );
				button:SetScript( "OnEnter", function(self)
					button.icon:Show();
					ting()
				end );
				button:RegisterForClicks("LeftButtonUp")
				button:SetScript( "OnClick", function (s,button,down)
					WoWkemon_Default_AskClickHandler(s,button,down);
				end);
			end
			self.Select = CreateFrame("Frame",nil,self)
			self.Select.btns = {}
			for i=1,3 do
				self.Select.btns[i] = CreateFrame("Button",nil,self.Select)
				local button = self.Select.btns[i];
				button.bg = button:CreateTexture(nil, "BACKGROUND")
				button.bg:SetTexture(_wd() .. "Textures\\Select\\swapbg.tga")
				button.bg:SetTexCoord(0,1,0,206/256)
				button.bg:SetAllPoints(button)
				do--Name text
					button.name = button:CreateFontString(nil,"OVERLAY",2)
					button.name:SetTextColor(32/255,56/255,0,1);
					button.name:SetJustifyH("LEFT");
					button.name:SetJustifyV("TOP");
					WoWkemon_Default_GiveTextBrownShadow(button.name)
				end
				do--Level
					button.level = button:CreateFontString(nil,"OVERLAY",2)
					button.level:SetTextColor(32/255,56/255,0,1);
					button.level:SetJustifyH("RIGHT");
					button.level:SetJustifyV("TOP");
					WoWkemon_Default_GiveTextBrownShadow(button.level)
				end
				do--StatusBar setup
					button.hpbg = button:CreateTexture(nil,"OVERLAY",nil,2)
					button.hpbg:SetTexture(_wd() .. "Textures\\Battle\\hpbg.tga")
					button.hp = CreateFrame("StatusBar",nil,button)
					button.hp:SetFrameLevel(6)
					button.hp.barbg = button.hp:CreateTexture(nil,"OVERLAY",nil,3)
					button.hp.barbg:SetTexture(_wd() .. "Textures\\Battle\\barbg.tga")
					button.hp:SetStatusBarTexture(button.hp.barbg,"OVERLAY")
					button.hp:SetStatusBarColor(112/255,248/255,168/255,1)
					button.hp:SetMinMaxValues(1,100)
					button.hp:SetValue(100)
					button.pm = CreateFrame("PlayerModel",nil,button)
				end
				button:EnableMouse(true)
				button:SetScript("OnEnter", function(self)
					self.bg:SetTexture(_wd() .. "Textures\\Select\\swapbg-highlight.tga")
				end)
				button:SetScript("OnLeave", function(self)
					self.bg:SetTexture(_wd() .. "Textures\\Select\\swapbg.tga")
				end)
				button:RegisterForClicks("LeftButtonUp")
				button:SetScript("OnClick", function(self)
					if (self.petIndex) then
						local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, self.petIndex);
						local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, self.petIndex)
						if (health ~= 0) and (C_PetBattles.CanPetSwapIn(self.petIndex) == true) then
							C_PetBattles.ChangePet(self.petIndex)
							self:GetParent():Hide()
							WoWkemon_Default_ActionChosen()
							WoWkemon_Default_Dialog("Go! " .. name .. "!")
						else
							thunk()
						end
					end
				end)
			end
			self.Select:Hide()
			
			self.Fight = CreateFrame("Frame",nil,self)
			self.Fight.btns = {}
			for i=1,3 do
				self.Fight.btns[i] = CreateFrame("Button",nil,self.Fight)
				local button = self.Fight.btns[i];
				button.id = i;
				button.bg = button:CreateTexture(nil, "BACKGROUND")
				button.bg:SetTexture(_wd() .. "Textures\\Select\\swapbg.tga")
				button.bg:SetTexCoord(0,1,0,206/256)
				button.bg:SetAllPoints(button)
				do--Name text
					button.name = button:CreateFontString(nil,"OVERLAY",2)
					button.name:SetTextColor(32/255,56/255,0,1);
					button.name:SetJustifyH("LEFT");
					button.name:SetJustifyV("TOP");
					WoWkemon_Default_GiveTextBrownShadow(button.name)
				end
				do
					button.icon = button:CreateTexture(nil,"OVERLAY")
				end
				do--Name text
					button.cd = button:CreateFontString(nil,"OVERLAY",2)
					button.cd:SetTextColor(32/255,56/255,0,1);
					button.cd:SetJustifyH("RIGHT");
					button.cd:SetJustifyV("BOTTOM");
					WoWkemon_Default_GiveTextBrownShadow(button.cd)
				end
				do--Name text
					button.type = button:CreateFontString(nil,"OVERLAY",2)
					button.type:SetTextColor(32/255,56/255,0,1);
					button.type:SetJustifyH("LEFT");
					button.type:SetJustifyV("BOTTOM");
					WoWkemon_Default_GiveTextBrownShadow(button.type)
				end
				button:EnableMouse(true)
				button:SetScript("OnEnter", function(self)
					WoWkemon_Default_AbilityTTPAttach("TOPLEFT",self,"TOPRIGHT")
					WoWkemon_Default_AbilityTTPLoadForAbility(LE_BATTLE_PET_ALLY,C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY),self.id)
					WoWkemon_Default_AbilityTTPShow()
					self.bg:SetTexture(_wd() .. "Textures\\Select\\swapbg-highlight.tga")
				end)
				button:SetScript("OnLeave", function(self)
					WoWkemon_Default_AbilityTTPHide()
					self.bg:SetTexture(_wd() .. "Textures\\Select\\swapbg.tga")
				end)
				button:RegisterForClicks("LeftButtonUp")
				button:SetScript("OnClick", function(self)
					if (self.abi) then
						if (self.iu == true) then
							C_PetBattles.UseAbility(self.abi)
							self:GetParent():Hide()
							WoWkemon_Default_ActionChosen()
						else
							thunk()
						end
					end
				end)
			end
			self.Fight:Hide()

			self.trap = CreateFrame("Button",nil,self)
			local trap = self.trap;
			trap.bg = trap:CreateTexture(nil,"ARTWORK")
			trap.bg:SetTexture(_wd() .. "Textures\\trap.tga")
			trap.s = 1;
			trap.bg:SetTexCoord(0,1,0,72/128)
			trap.bg:SetAllPoints(trap)
			trap:RegisterForClicks("LeftButtonUp")
			trap:Hide()
			trap:SetScript( "OnClick", function (s,button,down)
				WoWkemon_Default_ActionChosen()
				s:Hide()
				WoWkemon_Default_Dialog(string.upper(UnitName("player")) .. " used\na WOWKe BALL!")
				C_PetBattles.UseTrap();
			end);
			trap.cnt = 0;
			trap:SetScript( "OnUpdate", function (s,elapsed)
				if ((s.cnt % 10) == 0) then
					if (s.s == 1) then
						s.bg:SetTexture(_wd() .. "Textures\\trap-highlight.tga")
						s.s = 0;
					else
						s.bg:SetTexture(_wd() .. "Textures\\trap.tga")
						s.s = 1;
					end
				end
				s.cnt = s.cnt + 1;
			end);
			self.init = true;
			WoWkemon_Default_UnitTTPOnLoad(WoWkemon["Default"],0)
		elseif (num == 1) then
			if (self.AskBar) then
				local self = self.AskBar
				self:SetPoint("BOTTOM",UIParent,"BOTTOM")
				self:SetSize((GetScreenHeight()*(4/3)*(800/1440)), (214/1024)*(GetScreenHeight()*(4/3)*(800/1440)))
				-- self.FG:SetPoint("TOPLEFT",self,"TOP",(50/800)*self:GetWidth(),0)
				-- self.FG:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT")
				self.willdo:SetPoint("TOPLEFT",self,"TOPLEFT",(62/1155)*self:GetWidth(),-1*(51/241)*self:GetHeight());
				self.willdo:SetPoint("BOTTOMRIGHT",self,"TOPLEFT",(650/1155)*self:GetWidth(),-1*(217/241)*self:GetHeight());
				self.willdo:SetFont(_wd() .. "Fonts\\04b03.TTF",(43/241)*self:GetHeight());
				for i=1,(43/241)*self:GetHeight() do self.willdo:SetTextHeight(i); end
				self.willdo:SetText("Minfernal casts cool log!\nCrit! 500 hp!")
				for index,array in ipairs(self.AskButtons) do
					local button = self.buttons[index];
					button:SetPoint(array.ank1, self.BG, array.ank2, array.ank12x(), array.ank12y());
					button:SetPoint(array.ank3, self.BG, array.ank4, array.ank34x(), array.ank34y());
					button.text:SetFont(_wd() .. "Fonts\\04b03.TTF",(30/167)*self:GetHeight());
					for i=1,(30/167)*self:GetHeight() do button.text:SetTextHeight(i) end
					button.icon:SetHeight(button.text:GetStringHeight()-(8/167)*self:GetHeight());
					button.icon:SetWidth((button.text:GetStringHeight()-(8/167)*self:GetHeight())*(20/25));
					button.icon:SetPoint("RIGHT",button,"LEFT",(-5/800)*self:GetWidth(),0);
				end
				local abh, abw = self:GetHeight(),self:GetWidth();
				for i=1,3 do
					local button = self.Select.btns[i];
					button:SetSize((766/1155)*abw*0.75,(154/241)*abh*0.75)
					if (i == 1) then
						button:SetPoint("BOTTOMLEFT",self,"TOPLEFT",0,abh*(9/241))
					else
						button:SetPoint("BOTTOMLEFT",self.Select.btns[i-1],"TOPLEFT",0,abh*(9/241))
					end
					local bh, bw = button:GetHeight(),button:GetWidth()
					do--Level
						button.name:SetFont(_wd() .. "Fonts\\04b03.TTF",(148/603)*bh);
						button.name:SetPoint("TOPLEFT",button,"TOPLEFT",(bw*(662/3000)),-1*(bh*(149/603)))
						button.name:SetText("Minfernal")
						for i=1,(148/603)*bh do button.name:SetTextHeight(i); end
					end
					do--Level
						button.level:SetFont(_wd() .. "Fonts\\04b03.TTF",(148/603)*bh);
						button.level:SetPoint("TOPRIGHT",button,"TOPLEFT",(bw*(2855/3000)),-1*(bh*(149/603)))
						button.level:SetText("Lv:25")
						for i=1,(148/603)*bh do button.level:SetTextHeight(i); end
					end
					do--StatusBar setup
						button.hpbg:SetPoint("TOPLEFT",button,"TOPLEFT",(1030/3000)*bw,(-368/603)*bh)
						button.hpbg:SetPoint("BOTTOMRIGHT",button,"TOPLEFT",(2889/3000)*bw,(-484/603)*bh)
						button.hp:SetPoint("TOPLEFT",button,"TOPLEFT",(1324/3000)*bw,(-407/603)*bh)
						button.hp:SetPoint("BOTTOMRIGHT",button,"TOPLEFT",(2850/3000)*bw,(-445/603)*bh)	
					end
					button.pm:SetPoint("TOPLEFT",button,"TOPLEFT",(78/3000)*bw,(-78/603)*bh)
					button.pm:SetPoint("BOTTOMRIGHT",button,"TOPLEFT",(520/3000)*bw,(-520/603)*bh)
				end
				for i=1,3 do
					local button = self.Fight.btns[i];
					button:SetSize((766/1155)*abw*0.75,(154/241)*abh*0.75)
					if (i == 1) then
						button:SetPoint("BOTTOMLEFT",self,"TOPLEFT",0,abh*(9/241))
					else
						button:SetPoint("BOTTOMLEFT",self.Fight.btns[i-1],"TOPLEFT",0,abh*(9/241))
					end
					local bh, bw = button:GetHeight(),button:GetWidth()
					do--Level
						button.name:SetFont(_wd() .. "Fonts\\04b03.TTF",(148/603)*bh);
						button.name:SetPoint("TOPLEFT",button,"TOPLEFT",(bw*(662/3000)),-1*(bh*(149/603)))
						button.name:SetText("Minfernal")
						for i=1,(148/603)*bh do button.name:SetTextHeight(i); end
					end
					do--Level
						button.type:SetFont(_wd() .. "Fonts\\04b03.TTF",(148/603)*bh);
						button.type:SetPoint("BOTTOMLEFT",button,"TOPLEFT",(bw*(653/3000)),-1*(bh*(519/603)))
						for i=1,(148/603)*bh do button.type:SetTextHeight(i); end
					end
					do--Level
						button.cd:SetFont(_wd() .. "Fonts\\04b03.TTF",(148/603)*bh);
						button.cd:SetPoint("BOTTOMRIGHT",button,"TOPLEFT",(bw*(2855/3000)),-1*(bh*(519/603)))
						for i=1,(148/603)*bh do button.cd:SetTextHeight(i); end
					end
					button.icon:SetPoint("TOPLEFT",button,"TOPLEFT",(78/3000)*bw,(-78/603)*bh)
					button.icon:SetPoint("BOTTOMRIGHT",button,"TOPLEFT",(520/3000)*bw,(-520/603)*bh)
				end
				local trap = self.trap;
				trap:SetPoint("TOPLEFT",self,"TOPLEFT",(872/1155)*abw,(72/241)*abh)
				trap:SetPoint("BOTTOMRIGHT",self,"TOPLEFT",((872+252)/1155)*abw,0)
			end
			WoWkemon_Default_UnitTTPOnLoad(WoWkemon["Default"],1)
		elseif (num == 2) then
		end
	end,
	--Used to update the ask bar in different ways
	updateAskBar = function(self,text)
		WoWkemon_Default_UpdateAskBar(text);
	end,
	--Initializes the DialogBar
	initDialogBar = function(self,num)
		
	end,
	dialog = WoWkemon_Default_Dialog,
	--Initializes the FightBar
	initFightBar = function(self,num)
		
	end,
	--Called when the fight bar is shown
	--Update abilities here
	fightBarOnShow = WoWkemon_Default_UpdateAbilities,
	--Initializes the BagFrame
	initBagFrame = function() end,
	--Initializes the SelectFrame
	initSelectFrame = function() end,
	selectFrameOnShow = function(self)
	end,
	--Initializes the unit frames
	initUnitFrames = function(self,num)
		local oself = self;
		if (num == 0) then
			self.BattleFrames = CreateFrame("Frame",nil,self)
			local self = self.BattleFrames
			self:SetAllPoints(UIParent)
			self.Ally = CreateFrame("Frame","WoWkemon_Default_Ally",self)
			do--Ally Frame
				local Ally = self.Ally
				Ally:SetFrameLevel(5)
				Ally:SetClampedToScreen(true)
				Ally:SetPoint("TOPLEFT",UIParent,"CENTER")
				do--BG setup
					Ally.bg = Ally:CreateTexture(nil,"OVERLAY",nil,0)
					Ally.bg:SetTexture(_wd() .. "Textures\\Battle\\ally.tga")
					Ally.bg:SetTexCoord(0,1,0,333/512)
					Ally.bg:SetAllPoints(Ally);
				end	
				do--Level
					Ally.level = Ally:CreateFontString(nil,"OVERLAY",2)
					Ally.level:SetTextColor(32/255,56/255,0,1);
					Ally.level:SetJustifyH("RIGHT");
					Ally.level:SetJustifyV("TOP");
					WoWkemon_Default_GiveTextBrownShadow(Ally.level)
				end
				do--Name text
					Ally.name = Ally:CreateFontString(nil,"OVERLAY",2)
					Ally.name:SetTextColor(32/255,56/255,0,1);
					Ally.name:SetJustifyH("LEFT");
					Ally.name:SetJustifyV("TOP");
					WoWkemon_Default_GiveTextBrownShadow(Ally.name)
				end
				do--Name text
					Ally.move = Ally:CreateFontString(nil,"OVERLAY",2)
					Ally.move:SetTextColor(255,255,255,1);
					Ally.move:SetJustifyH("LEFT");
					Ally.move:SetJustifyV("CENTER");
					Ally.move:Hide();
				end
				do--StatusBar setup
					Ally.hpbg = Ally:CreateTexture(nil,"OVERLAY",nil,2)
					Ally.hpbg:SetTexture(_wd() .. "Textures\\Battle\\hpbg.tga")

					Ally.hp = CreateFrame("StatusBar",nil,Ally)
					Ally.hp:SetFrameLevel(6)
					Ally.hp.barbg = Ally.hp:CreateTexture(nil,"OVERLAY",nil,3)
					Ally.hp.barbg:SetTexture(_wd() .. "Textures\\Battle\\barbg.tga")
					Ally.hp:SetStatusBarTexture(Ally.hp.barbg,"OVERLAY")
					Ally.hp:SetStatusBarColor(112/255,248/255,168/255,1)
					Ally.hp:SetMinMaxValues(1,100)
					Ally.hp:SetValue(100)
				end
				do--StatusBar setup
					Ally.xp = CreateFrame("StatusBar",nil,Ally)
					Ally.xp:SetFrameLevel(6)
					Ally.xp.barbg = Ally.xp:CreateTexture(nil,"OVERLAY",nil,4)
					Ally.xp.barbg:SetTexture(_wd() .. "Textures\\Battle\\barbg.tga")
					Ally.xp:SetStatusBarTexture(Ally.xp.barbg,"OVERLAY")
					Ally.xp:SetStatusBarColor(64/255,200/255,248/255,1)
					Ally.xp:SetMinMaxValues(1,100)
					Ally.xp:SetValue(100)
				end
				do--Health text
					Ally.health = Ally:CreateFontString(nil,"OVERLAY",2)
					Ally.health:SetTextColor(32/255,56/255,0,1);
					Ally.health:SetJustifyH("RIGHT");
					Ally.health:SetJustifyV("BOTTOM");
					WoWkemon_Default_GiveTextBrownShadow(Ally.health)
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
					Ally:SetScript("OnDragStart", function(self)
						self:StartMoving()
					end);
					Ally:SetScript("OnDragStop", function(self)
						self:StopMovingOrSizing()
					end);
				end
				do--Sets up the pokeballs
					Ally.pbks = CreateFrame("Frame",nil,Ally)
					local pbks = Ally.pbks
					pbks.bg = pbks:CreateTexture(nil,"ARTWORK",nil,1)
					pbks.bg:SetTexture(_wd() .. "Textures\\Battle\\pkbg.tga")
					pbks.bg:SetTexCoord(0,1,0,39/64)
					pbks.bg:SetAllPoints(pbks)
					Ally.pbs = {}
					for i=1,3 do
						Ally.pbs[i] = CreateFrame("Frame",nil,pbks)
						local ball = Ally.pbs[i];
						ball.petOwner = LE_BATTLE_PET_ALLY
						ball:EnableMouse(true)
						do
							ball.dead = ball:CreateTexture(nil,"ARTWORK",nil,2)
							ball.dead:SetTexture(_wd() .. "Textures\\Battle\\pkbl-dead.tga")
							ball.dead:SetAllPoints(ball)
							ball.dead:Hide()
						end
						do
							ball.normal = ball:CreateTexture(nil,"ARTWORK",nil,2)
							ball.normal:SetTexture(_wd() .. "Textures\\Battle\\pkbl.tga")
							ball.normal:SetAllPoints(ball)
							ball.normal:Hide()
						end
						do
							ball.highlight = ball:CreateTexture(nil,"ARTWORK",nil,2)
							ball.highlight:SetTexture(_wd() .. "Textures\\Battle\\pkbl-highlight.tga")
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
								-- PetBattleUnitTooltip_Attach(PetBattlePrimaryUnitTooltip, P, self, RP, 0, 0);
								-- PetBattleUnitTooltip_UpdateForUnit(PetBattlePrimaryUnitTooltip, self.petOwner, self.petIndex);
								-- PetBattlePrimaryUnitTooltip:Show();
								WoWkemon_Default_UnitTTPAttach(P,self,RP)
								WoWkemon_Default_UnitTTPLoadForUnit(LE_BATTLE_PET_ALLY,self.petIndex)
								WoWkemon_Default_UnitTTPShow()
							end
						end);
						ball:SetScript("OnLeave", function(self)
							-- PetBattlePrimaryUnitTooltip:Hide();
							WoWkemon_Default_UnitTTPHide()
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
				WoWkemon_Default_GenerateBuffFrames(Ally)
				Ally.petOwner = LE_BATTLE_PET_ALLY
			end
			self.Enemy = CreateFrame("Frame","WoWkemon_Default_Enemy",self)
			do--Enemy Frame
				local Enemy = self.Enemy
				Enemy:SetFrameLevel(3)
				Enemy:SetClampedToScreen(true) 
				do--BG setup
					Enemy.bg = Enemy:CreateTexture(nil,"OVERLAY",nil,0)
					Enemy.bg:SetTexture(_wd() .. "Textures\\Battle\\enemy.tga")
					Enemy.bg:SetTexCoord(0,1007/1024,0,1)
					Enemy.bg:SetAllPoints(Enemy);
				end	
				do--Level
					Enemy.level = Enemy:CreateFontString(nil,"OVERLAY",2)
					Enemy.level:SetTextColor(32/255,56/255,0,1);
					Enemy.level:SetJustifyH("RIGHT");
					Enemy.level:SetJustifyV("TOP");
					WoWkemon_Default_GiveTextBrownShadow(Enemy.level)
				end
				do--Name text
					Enemy.name = Enemy:CreateFontString(nil,"OVERLAY",2)
					Enemy.name:SetTextColor(32/255,56/255,0,1);
					Enemy.name:SetJustifyH("LEFT");
					Enemy.name:SetJustifyV("TOP");
					WoWkemon_Default_GiveTextBrownShadow(Enemy.name)
				end
				do--StatusBar setup
					Enemy.hpbg = Enemy:CreateTexture(nil,"OVERLAY",nil,2)
					Enemy.hpbg:SetTexture(_wd() .. "Textures\\Battle\\hpbg.tga")

					Enemy.hp = CreateFrame("StatusBar",nil,Enemy)
					Enemy.hp:SetFrameLevel(4)
					Enemy.hp.barbg = Enemy.hp:CreateTexture(nil,"OVERLAY",nil,3)
					Enemy.hp.barbg:SetTexture(_wd() .. "Textures\\Battle\\barbg.tga")
					Enemy.hp:SetStatusBarTexture(Enemy.hp.barbg,"OVERLAY")
					Enemy.hp:SetStatusBarColor(112/255,248/255,168/255,1)
					Enemy.hp:SetMinMaxValues(1,100)
					Enemy.hp:SetValue(100)
					
				end
				do--Rarity
					Enemy.rare = Enemy:CreateTexture(nil,"OVERLAY",2)
					Enemy.rare:SetTexture(_wd() .. "Textures\\Icons\\rarity.tga")
					local r, g, b, hex = GetItemQualityColor(2)

					Enemy.rare:SetVertexColor(r,g,b)
				end	
				do--Name text
					Enemy.move = Enemy:CreateFontString(nil,"OVERLAY",2)
					Enemy.move:SetTextColor(255,255,255,1);
					Enemy.move:SetJustifyH("RIGHT");
					Enemy.move:SetJustifyV("CENTER");
					Enemy.move:Hide();
				end
				do--Sets up dragging
					Enemy:EnableMouse(true)
					Enemy:RegisterForDrag("RightButton")
					Enemy:SetMovable(true)
					Enemy:SetUserPlaced(true)
					Enemy:SetScript("OnEnter", function(self)
						self.move:Show();
					end);
					Enemy:SetScript("OnLeave", function(self)
						self.move:Hide();
					end);
					Enemy:SetScript("OnDragStart", function(self)
						self:StartMoving()
					end);
					Enemy:SetScript("OnDragStop", function(self)
						self:StopMovingOrSizing()
					end);
				end
				do--Sets up the pokeballs
					Enemy.pbks = CreateFrame("Frame",nil,Enemy)
					local pbks = Enemy.pbks
					pbks.bg = pbks:CreateTexture(nil,"ARTWORK",nil,1)
					pbks.bg:SetTexture(_wd() .. "Textures\\Battle\\pkbg.tga")
					pbks.bg:SetTexCoord(0,1,0,39/64)
					pbks.bg:SetAllPoints(pbks)
					Enemy.pbs = {}
					for i=1,3 do
						Enemy.pbs[i] = CreateFrame("Frame",nil,pbks)
						local ball = Enemy.pbs[i];
						ball.petOwner = LE_BATTLE_PET_ENEMY
						ball:EnableMouse(true)
						do
							ball.dead = ball:CreateTexture(nil,"ARTWORK",nil,2)
							ball.dead:SetTexture(_wd() .. "Textures\\Battle\\pkbl-dead.tga")
							ball.dead:SetAllPoints(ball)
							ball.dead:Hide()
						end
						do
							ball.normal = ball:CreateTexture(nil,"ARTWORK",nil,2)
							ball.normal:SetTexture(_wd() .. "Textures\\Battle\\pkbl.tga")
							ball.normal:SetAllPoints(ball)
							ball.normal:Hide()
						end
						do
							ball.highlight = ball:CreateTexture(nil,"ARTWORK",nil,2)
							ball.highlight:SetTexture(_wd() .. "Textures\\Battle\\pkbl-highlight.tga")
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
								WoWkemon_Default_UnitTTPAttach(P,self,RP)
								WoWkemon_Default_UnitTTPLoadForUnit(LE_BATTLE_PET_ENEMY,self.petIndex)
								WoWkemon_Default_UnitTTPShow()
							end
						end);
						ball:SetScript("OnLeave", function(self)
							WoWkemon_Default_UnitTTPHide()
						end);
					end
				end
				do--Sets up the buff notification
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
				end
				WoWkemon_Default_GenerateBuffFrames(Enemy)
				Enemy.petOwner = LE_BATTLE_PET_ENEMY
			end
			self.Ally:SetPoint("TOPLEFT",self,"CENTER")
			self.Enemy:SetPoint("BOTTOMRIGHT",self,"CENTER")
			-- self:SetScript("OnShow", function(self) WoWkemon_Default_BattleAllyFixText(self) end)
		elseif (num == 1) then
			if (self.BattleFrames) then
				local self = self.BattleFrames
				local Ally = self.Ally
				do--Ally Frame					
					local abw = self:GetParent().AskBar:GetWidth();
					local abh = self:GetParent().AskBar:GetHeight()
					Ally:SetSize(((180/241)*abh)*(716/233),(180/241)*abh)
					local ah = Ally:GetHeight();
					local aw = Ally:GetWidth();
					--3000
					--976
					do--Level
						Ally.level:SetFont(_wd() .. "Fonts\\04b03.TTF",(170/976)*ah);
						Ally.level:SetPoint("TOPRIGHT",Ally,"TOPRIGHT",-1*(aw*(234/3000)),-1*(ah*(146/976)))
						--Ally.level:SetSize((65/343)*Ally:GetWidth(),(28/119)*Ally:GetHeight());
						for i=1,(170/976)*ah do Ally.level:SetTextHeight(i); end
					end
					do--Name text
						Ally.name:SetFont(_wd() .. "Fonts\\04b03.TTF",(170/976)*ah);
						Ally.name:SetPoint("TOPLEFT",Ally,"TOPLEFT",(aw*(419/3000)),-1*(ah*(146/976)))
						for i=1,(170/976)*ah do Ally.name:SetTextHeight(i); end
					end
					
					do--StatusBar setup
						--1131,-419
						--817,-377
						Ally.hpbg:SetPoint("TOPLEFT",Ally,"TOPLEFT",(817/3000)*aw,(-377/976)*ah)
						Ally.hpbg:SetPoint("BOTTOMRIGHT",Ally,"TOPLEFT",(2806/3000)*aw,(-502/976)*ah)
						Ally.hp:SetPoint("TOPLEFT",Ally,"TOPLEFT",(1131/3000)*aw,(-419/976)*ah)
						Ally.hp:SetPoint("BOTTOMRIGHT",Ally,"TOPLEFT",(2764/3000)*aw,(-460/976)*ah)	
					end
					do--StatusBar setup
						Ally.xp:SetPoint("TOPLEFT",Ally,"TOPLEFT",(725/3000)*aw,(-867/976)*ah)
						Ally.xp:SetPoint("BOTTOMRIGHT",Ally,"TOPLEFT",(2819/3000)*aw,(-929/976)*ah)
					end
					do--Health text
						Ally.health:SetFont(_wd() .. "Fonts\\04b03.TTF",(170/976)*ah);
						Ally.health:SetPoint("BOTTOMRIGHT",Ally,"BOTTOMRIGHT",-1*(307/3000)*aw,(241/976)*ah)
						for i=1,(170/976)*ah do Ally.health:SetTextHeight(i); end
					end
					do
						Ally.pbks:SetPoint("TOPLEFT",Ally,"TOPLEFT",(490/3000)*aw,(205/976)*ah)
						Ally.pbks:SetPoint("BOTTOMRIGHT",Ally,"TOPLEFT",(1139/3000)*aw,0)
						--1000
						--316
						local pkh = Ally.pbks:GetHeight()
						local pkw = Ally.pbks:GetWidth()
						local pbanc = {
							{
								x1 = (97/1000)*pkw,
								y1 = -1*(90/316)*pkh,
								x2 = (257/1000)*pkw,
								y2 = -1*(250/316)*pkh,
							},
							{
								x1 = (419/1000)*pkw,
								y1 = -1*(90/316)*pkh,
								x2 = (579/1000)*pkw,
								y2 = -1*(250/316)*pkh,
							},
							{
								x1 = (742/1000)*pkw,
								y1 = -1*(90/316)*pkh,
								x2 = (902/1000)*pkw,
								y2 = -1*(250/316)*pkh,
							},
						}
						for i=1,3 do
							local ball = Ally.pbs[i];
							ball:SetPoint("TOPLEFT",Ally.pbks,"TOPLEFT",pbanc[i].x1,pbanc[i].y1)
							ball:SetPoint("BOTTOMRIGHT",Ally.pbks,"TOPLEFT",pbanc[i].x2,pbanc[i].y2)
						end
					end
					do--Name text
						Ally.move:SetFont(_wd() .. "Fonts\\04b03.TTF",(170/976)*ah,"OUTLINE");
						Ally.move:SetPoint("TOPLEFT",Ally.pbks,"TOPRIGHT",5,0)
						Ally.move:SetText("|cFFffd700Right drag to move.|r")
						for i=1,(170/976)*ah do Ally.move:SetTextHeight(i); end
					end
					do--Sets up the buff notification
						local bpn = Ally.bpn
						bpn:SetPoint("TOPLEFT",Ally,"TOPLEFT",(431/3000)*aw,(-560/976)*ah)
						bpn:SetPoint("BOTTOMRIGHT",Ally,"TOPLEFT",(800/3000)*aw,(-761/976)*ah)
					end
				end
				do--Ally Frame
					local Enemy = self.Enemy
					local abh = self:GetParent().AskBar:GetHeight()
					--Enemy:SetSize((696/716)*Ally:GetWidth(),(177/233)*Ally:GetHeight())
					Enemy:SetSize((650/716)*Ally:GetWidth(),(177/233)*Ally:GetHeight())
					local ah = Enemy:GetHeight();
					local aw = Enemy:GetWidth();
					--3000
					--763
					do--Level
						Enemy.level:SetFont(_wd() .. "Fonts\\04b03.TTF",(170/976)*ah);
						Enemy.level:SetPoint("TOPRIGHT",Enemy,"TOPRIGHT",-1*(aw*(392/3000)),-1*(ah*(152/763)))
						--Enemy.level:SetSize((65/343)*Enemy:GetWidth(),(28/119)*Enemy:GetHeight());
						for i=1,(170/976)*ah do Enemy.level:SetTextHeight(i); end
					end
					do--Name text
						Enemy.name:SetFont(_wd() .. "Fonts\\04b03.TTF",(170/976)*ah);
						Enemy.name:SetPoint("TOPLEFT",Enemy,"TOPLEFT",(aw*(176/3000)),-1*(ah*(152/763)))
						for i=1,(170/976)*ah do Enemy.name:SetTextHeight(i); end
					end
					do--Rarity
						Enemy.rare:SetSize((170/976)*ah,(170/976)*ah)
					end	
					do--StatusBar setup
						--1131,-419
						--817,-377
						Enemy.hpbg:SetPoint("TOPLEFT",Enemy,"TOPLEFT",(595/3000)*aw,(-401/763)*ah)
						Enemy.hpbg:SetPoint("BOTTOMRIGHT",Enemy,"TOPLEFT",(2641/3000)*aw,(-529/763)*ah)
						Enemy.hp:SetPoint("TOPLEFT",Enemy,"TOPLEFT",(918/3000)*aw,(-444/763)*ah)
						Enemy.hp:SetPoint("BOTTOMRIGHT",Enemy,"TOPLEFT",(2598/3000)*aw,(-496/763)*ah)
					end
					do
						Enemy.pbks:SetPoint("TOPLEFT",Enemy,"TOPLEFT",(1922/3000)*aw,(211/764)*ah)
						Enemy.pbks:SetPoint("BOTTOMRIGHT",Enemy,"TOPLEFT",(2589/3000)*aw,0)
						--1000
						--316
						local pkh = Enemy.pbks:GetHeight()
						local pkw = Enemy.pbks:GetWidth()
						local pbanc = {
							{
								x1 = (97/1000)*pkw,
								y1 = -1*(90/316)*pkh,
								x2 = (257/1000)*pkw,
								y2 = -1*(250/316)*pkh,
							},
							{
								x1 = (419/1000)*pkw,
								y1 = -1*(90/316)*pkh,
								x2 = (579/1000)*pkw,
								y2 = -1*(250/316)*pkh,
							},
							{
								x1 = (742/1000)*pkw,
								y1 = -1*(90/316)*pkh,
								x2 = (902/1000)*pkw,
								y2 = -1*(250/316)*pkh,
							},
						}
						for i=1,3 do
							local ball = Enemy.pbs[i];
							ball:SetPoint("TOPLEFT",Enemy.pbks,"TOPLEFT",pbanc[i].x1,pbanc[i].y1)
							ball:SetPoint("BOTTOMRIGHT",Enemy.pbks,"TOPLEFT",pbanc[i].x2,pbanc[i].y2)
						end
					end
					do--Name text
						Enemy.move:SetFont(_wd() .. "Fonts\\04b03.TTF",(170/976)*ah,"OUTLINE");
						Enemy.move:SetPoint("TOPRIGHT",Enemy.pbks,"TOPLEFT",-5,0)
						Enemy.move:SetText("|cFFffd700Right drag to move.|r")
						for i=1,(170/976)*ah do Enemy.move:SetTextHeight(i); end
					end
					do--Sets up the buff notification
						local bpn = Enemy.bpn
						bpn:SetPoint("TOPLEFT",Enemy,"TOPLEFT",(153/3000)*aw,(-401/763)*ah)
						bpn:SetPoint("BOTTOMRIGHT",Enemy,"TOPLEFT",(503/3000)*aw,(-529/763)*ah)
					end
				end
			end
		elseif (num == 2) then
			-- if (self.Ally) then self.Ally:SetPoint("TOPLEFT",self,"CENTER") end
			-- if (self.Enemy) then self.Enemy:SetPoint("TOPLEFT",self,"CENTER",self.Enemy:GetWidth()*-1,self.Enemy:GetHeight()*-1) end
		end
	end,
	updateUnitFrames = WoWkemon_Default_UpdateUnitFrames,
	initTimer = function(self,num)
		if (num == 0) then
			self.Timer = CreateFrame("Frame",nil,self)
			local self = self.Timer
			do--Creates the time fontstring
				self.time = self:CreateFontString(nil,"OVERLAY",3)
				self.time:SetPoint("TOPRIGHT",self:GetParent():GetParent(),"TOPRIGHT");
				self.time:SetFont(_wd() .. "Fonts\\04b03.TTF",60,"OUTLINE");
				WoWkemon_Default_GiveTextShadow(self.time)
				self.time:SetTextColor(1,1,1,1);
				self.time:SetJustifyH("RIGHT");
				self.time:SetJustifyV("TOP");
				self.time:SetWordWrap(true);
				for i=1,55 do self.time:SetTextHeight(i); end
			end
			self:SetScript("OnUpdate", function(self) WoWkemon_Default_UpdateTimer(self) end)
		else
			-- Resolution-based calculations
		end
	end,
	updateTimer = WoWkemon_Default_UpdateTimer,
	updateTimerValues = WoWkemon_Default_UpdateTimerValues,
	turnComplete = function()
		WoWkemon_Default_TurnComplete()
	end,
}
WoWkemon_RegisterTheme(default)