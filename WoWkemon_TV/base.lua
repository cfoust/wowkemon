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
local function stime(seconds)

	if (seconds < 60) then
		return "< minute"
	elseif (seconds > 60) and (seconds < 3600) then
		return tostring(math.floor(seconds/60)) .. " minute(s)"
	elseif (seconds > 3600) then
		return math.floor(seconds/3600) .. " hour(s)"
	end
end
local function sysprint(text)
	print("|cffdaa520WOWKéTV: |r" .. text)
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
local function _wd() return "Interface\\AddOns\\WoWkemon_TV\\" end
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
function WoWkemon_StatusColors(statusBar, health, maxHealth)
	if ((health/maxHealth) >= .50) then
		statusBar:SetStatusBarColor(112/255,248/255,168/255,1)
	elseif ((health/maxHealth) >= .30) then
		statusBar:SetStatusBarColor(248/255,224/255,56/255,1)
	elseif ((health/maxHealth) < .30) then
		statusBar:SetStatusBarColor(248/255,88/255,56/255,1)
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
function WoWkemon_TV_OnLoad(self)
	self.init = false;
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
	self:RegisterEvent("PLAYER_LEAVING_WORLD");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("PET_BATTLE_AURA_APPLIED");
	self:RegisterEvent("PET_BATTLE_AURA_CANCELED");
	self:RegisterEvent("PET_BATTLE_AURA_CHANGED");
	self:RegisterEvent("PET_BATTLE_AURA_CHANGED");
	self:RegisterEvent("CHAT_MSG_ADDON");
	self:RegisterEvent("FRIENDLIST_UPDATE");
	self:RegisterEvent("CHAT_MSG_PET_BATTLE_INFO")
	for i,j in ipairs({"WKMNTVC","WKMNTVS","WKMNTVP",}) do
		RegisterAddonMessagePrefix(j)
	end

	function self:setUp(self,size)
		self:SetSize(size,(254/302)*size)
	end
	self:setUp(self,350)
	self:SetPoint("CENTER",UIParent,"CENTER")
	self:Show()
	self.connected = false;
	self.connecting = false;
	self.disconnecting = false;
	self.cserver = nil;
	self.clients = {}
	self:Hide()
	hooksecurefunc(C_PetBattles,"ForfeitGame", function(self)
		WoWkemon_TV:SendBattle("Got away safely!")
		end)
	hooksecurefunc(DEFAULT_CHAT_FRAME,"AddMessage",function(self,text)
		if (type(text) == "string") then
			if (text:match("named")) then
				WoWkemon_TV:removeclient(text:sub(18,-24));
			end
		end
		end)
	function self:DisconnectClients()
		if (self.clients) then
			for i,j in ipairs(self.clients) do
				SendAddonMessage("WKMNTVS","DISCONNECTION QUERY RECEIVED", "WHISPER",j)
				----print("SM:","WKMNTVS","DISCONNECTING PEERS")
			end
		end
	end
	function self:connect(target)
		--self:DisconnectClients()
		local fnd = false;
		if (self.clients) then
			for i,j in ipairs(self.clients) do
				----print(j .. " " .. target)
				if (j == target) then
					fnd = true;
					break;
				end
			end
		end
		self.disconnecting = false;
		self.connected = false;
		self:Hide()
		SendAddonMessage("WKMNTVC","CONNECTION: " .. UnitName("player"),"WHISPER",target)
		----print("SM:","WKMNTVC","CONNECTION")
		self.connecting = true;
		self.target = target;
	end
	function self:disconnect()
		if self.target and (self.connected == true) then
			SendAddonMessage("WKMNTVC","DISCONNECTION: " .. UnitName("player"), "WHISPER",self.target)
			----print("SM:","WKMNTVC","DISCONNECTION")
			self.disconnecting = true;
		end
	end
	function self:addclient(client)
		if (self.clients) then
			for _,j in ipairs(self.clients) do
				if (j == client) then
					return
				end
			end
			table.insert(self.clients,client)
		end
	end
	function self:removeclient(client)
		if (self.clients) then
			local new = {}
			for _,j in ipairs(self.clients) do
				if (j ~= client) then
					tabel.insert(new,j)
				end
			end
			wipe(self.clients)
			self.clients = new;
		end
	end
	function self:SendEvent(event)
		if (self.clients) then
			for i,j in ipairs(self.clients) do
				if (event == "PET_BATTLE_OPENING_START") then
					local petName,_ = C_PetBattles.GetName(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY));
					if C_PetBattles.IsWildBattle() then
						SendAddonMessage("WKMNTVS","event," .. event .. "," .. tostring(C_PetBattles.IsWildBattle()) .. "," .. petName, "WHISPER",j)
					else
						SendAddonMessage("WKMNTVS","event," .. event .. "," .. "nil" .. "," .. petName, "WHISPER",j)
					end
				elseif (event == "PET_BATTLE_OPENING_DONE") or (event == "PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE") then

				else
					SendAddonMessage("WKMNTVS","event," .. event, "WHISPER",j)
				end
			end
		end
	end
	function self:SendBattle(text)
		if (self.clients) then
			for i,j in ipairs(self.clients) do
				SendAddonMessage("WKMNTVS","battle," .. text, "WHISPER",j)
				----print("SM:","SENDING BATTLE")
			end
		end
	end
	function self:SendAttack(target,missed)
		if (self.clients) then
			for i,j in ipairs(self.clients) do
				if (missed) then
					SendAddonMessage("WKMNTVS","attack," .. target .. ",missed", "WHISPER",j)
				else
					SendAddonMessage("WKMNTVS","attack," .. target, "WHISPER",j)
				end
			end
		end
	end
	function self:SendUnitInfo()
		if (self.clients) then
			local array = "unit,"
			local function add(text)
				array = array .. tostring(text) .. ","
			end
			local ah,ahm = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY));
			local eh,ehm = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY));
			local an,_ = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY));
			local en,_ = C_PetBattles.GetName(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY));
			if (C_PetBattles.IsWildBattle()) then
				local opc = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)) - 1
				local r, g, b, hex = GetItemQualityColor(opc)
				if (hex) and (en) then
					en = en .. "|c" .. hex .. "☆" .. "|r"
				end
			end
			local xp, maxXp = C_PetBattles.GetXP(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY));
			local ab,eb;
			if (C_PetBattles.GetNumAuras(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)) ~= 0) and (C_PetBattles.GetNumAuras(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)) ~= nil) then
					for i=1, C_PetBattles.GetNumAuras(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)) do
						local auraID, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY), i);
						if (isBuff) then
							ab = "buff"
						elseif (not isBuff) then
							ab = "debuff"
						end
					end
			elseif (C_PetBattles.GetNumAuras(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)) == 0) then
				ab = "none"
			end
			if (C_PetBattles.GetNumAuras(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)) ~= 0) and (C_PetBattles.GetNumAuras(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)) ~= nil) then
					for i=1, C_PetBattles.GetNumAuras(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)) do
						local auraID, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY), i);
						if (isBuff) then
							eb = "buff"
						elseif (not isBuff) then
							eb = "debuff"
						end
					end
			elseif (C_PetBattles.GetNumAuras(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)) == 0) then
				eb = "none"
			end
			local al = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY));
			local el = C_PetBattles.GetLevel(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY));
			add(C_PetBattles.GetDisplayID(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)))
			add(C_PetBattles.GetDisplayID(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)))
			add(ah)
			add(ahm)
			add(eh)
			add(ehm)
			add(xp)
			add(maxXp)
			add(an)
			add(en)
			add(ab)
			add(eb)
			add(al)
			add(el)
			for i,j in ipairs(self.clients) do
				SendAddonMessage("WKMNTVS",array, "WHISPER",j)
				----print("SM:","WKMNTVS","SENDING UNITS")
			end
		end
	end
	
	self.friends = {}
	function self:UpdateFriends()
		wipe(self.friends)
		for i=1,GetNumFriends() do
			local name,_,_,_,connected,_,_,_ = GetFriendInfo(i);
			if (connected == 1) then
				SendAddonMessage("WKMNTVP","DOYOU","WHISPER",name)
			end
		end
		for k=1, BNGetNumFriends() do
			local _,_,_,_,_,_,client,isOnline,_,_,_,_,_,_,_,_ = BNGetFriendInfo(k);
			if (isOnline == true) and (client == "WoW") then
				for j=1, BNGetNumFriendToons(k) do
					local hasFocus, toonName, client, realmName, realmID, faction, race, class, guild, zoneName, level, gameText = BNGetFriendToonInfo(k, j);
					if (realmName == GetRealmName()) and (UnitFactionGroup("player") == faction) then
						SendAddonMessage("WKMNTVP","DOYOU","WHISPER",toonName)
					end
				end
			end
			
		end
	end
	function self:RegisterFriend(name,time)
		local ta = {}
		ta["name"] = name;
		ta["time"] = time;
		if (#self.friends > 0) then
			local fnd = false;
			for i,j in ipairs(self.friends) do
				if (j["name"] == name) then
					fnd = true;
				end
			end
			if (fnd == false) then
				table.insert(self.friends,ta)
			end
		else
			table.insert(self.friends,ta)
		end
	end
	do
		self:EnableMouse(true)
		self:RegisterForDrag("LeftButton")
		self:SetMovable(true)
		self:SetUserPlaced(true)
		self:SetClampedToScreen(true)
		self:SetScript("OnDragStart",function(self) self:StartMoving() end)
		self:SetScript("OnDragStop",function(self) self:StopMovingOrSizing() end)
		self:SetFrameLevel(6)
	end
	do--Art
		self.art = CreateFrame("Frame",nil,self)
		self.art:SetAllPoints(self)
		do
			self.bg = self.art:CreateTexture(nil,"OVERLAY",nil,5)
			self.bg:SetTexture(_wd() .. "Textures\\TV\\tv.tga")
			self.bg:SetTexCoord(0,1,0,431/512)
			self.bg:SetAllPoints(self.art)
			self.bg:Show()
		end
		do--Initializes buttons
			do
				self.plus = CreateFrame("Button",nil,self.art)
				self.plus:SetPoint("TOPLEFT",self,"TOPLEFT",(31/1000)*self:GetWidth(),-1*(144/842)*self:GetHeight())
				self.plus:SetPoint("BOTTOMRIGHT",self,"TOPLEFT",(70/1000)*self:GetWidth(),-1*(183/842)*self:GetHeight())
				self.plus.bg = self.plus:CreateTexture(nil,"OVERLAY",nil,6);
				self.plus.bg:SetAllPoints(self.plus)
				self.plus.bg:SetTexture(_wd() .. "Textures\\TV\\plus.tga")
				self.plus:EnableMouse(true)
				self.plus:RegisterForClicks("LeftButtonUp")
				self.plus:SetScript("OnClick",function(self,button,down)
					WoWkemon_TV:SetSizeDelta(30);
				end)
			end
			do
				self.minus = CreateFrame("Button",nil,self.art)
				self.minus:SetPoint("TOPLEFT",self,"TOPLEFT",(31/1000)*self:GetWidth(),-1*(187/842)*self:GetHeight())
				self.minus:SetPoint("BOTTOMRIGHT",self,"TOPLEFT",(70/1000)*self:GetWidth(),-1*(226/842)*self:GetHeight())
				self.minus.bg = self.minus:CreateTexture(nil,"OVERLAY",nil,6);
				self.minus.bg:SetAllPoints(self.minus)
				self.minus.bg:SetTexture(_wd() .. "Textures\\TV\\minus.tga")
				self.minus:EnableMouse(true)
				self.minus:RegisterForClicks("LeftButtonUp")
				self.minus:SetScript("OnClick",function(self,button,down)
					WoWkemon_TV:SetSizeDelta(-30);
				end)
			end
			do
				self.close = CreateFrame("Button",nil,self.art)
				self.close:SetPoint("TOPLEFT",self,"TOPLEFT",(31/1000)*self:GetWidth(),-1*(588/842)*self:GetHeight())
				self.close:SetPoint("BOTTOMRIGHT",self,"TOPLEFT",(70/1000)*self:GetWidth(),-1*(627/842)*self:GetHeight())
				self.close.bg = self.close:CreateTexture(nil,"OVERLAY",nil,6);
				self.close.bg:SetAllPoints(self.close)
				self.close.bg:SetTexture(_wd() .. "Textures\\TV\\close.tga")
				self.close:EnableMouse(true)
				self.close:RegisterForClicks("LeftButtonUp")
				self.close:SetScript("OnClick",function(self,button,down)
					WoWkemon_TV:disconnect()
					WoWkemon_TV:Hide()
				end)
			end
		end
		do
			self.art:SetClampedToScreen(true)
		end
	end
	do--RENDERING FRAME
		self.render = CreateFrame("Frame",nil,self)
		self.render:SetFrameLevel(5)
		self.render:SetPoint("TOPLEFT",self,"TOPLEFT",math.floor((46/512)*self:GetWidth()),-1*math.floor((46/431)*self:GetHeight()))
		self.render:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",-1*math.floor((53/512)*self:GetWidth()),math.floor((105/431)*self:GetHeight()))
		do--Default view (WoWkeTV)
			self.render.default = CreateFrame("Frame",nil,self.render)
			self.render.default:Show()
			self.render.default:SetAllPoints(self.render)
			do
				self.render.blank = self.render.default:CreateTexture(nil,"ARTWORK",nil,4)
				self.render.blank:SetTexture(25/255,25/255,42/255)
				self.render.blank:SetAllPoints(self.render)
				self.render.blank:Show()
				do
					self.render.default.text = self.render.default:CreateFontString(nil,"ARTWORK",5)
					local text = self.render.default.text;
					text:SetTextColor(1,1,1,1);
					text:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((87/431)*self:GetHeight()),"OUTLINE");
					for i=1,math.floor((87/431)*self:GetHeight()) do text:SetTextHeight(i) end
					text:SetAllPoints(self.render)
					text:SetJustifyV("CENTER")
					text:SetText("WOWKéTV")
					WoWkemon_GiveTextDarkShadow(text)
				end
				do
					self.render.default.spect = self.render.default:CreateFontString(nil,"ARTWORK",5)
					local text = self.render.default.spect;
					text:SetTextColor(1,1,1,1);
					text:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((60/431)*self:GetHeight()),"OUTLINE");
					for i=1,math.floor((60/431)*self:GetHeight()) do text:SetTextHeight(i) end
					text:SetAllPoints(self.render)
					text:SetJustifyV("BOTTOM")
					text:SetText("Spectating: name")
					WoWkemon_GiveTextDarkShadow(text)
				end
			end
		end
		do--Battle view
			self.render.battle = CreateFrame("Frame",nil,self.render)
			local battle = self.render.battle;
			battle:SetAllPoints(self.render)
			battle:Hide()
			-- do
			-- 	battle.blank = battle:CreateTexture(nil,"ARTWORK",nil,3)
			-- 	battle.blank:SetTexture(1,1,1)
			-- 	battle.blank:SetAllPoints(self.render)
			-- 	battle.blank:Show()
			-- end
			do
				battle.bg = battle:CreateTexture(nil,"ARTWORK",nil,3)
				local batbg = battle.bg;
				batbg:SetTexture(_wd() .. "Textures\\TV\\bgs.tga")
				batbg:SetPoint("TOPLEFT",self.render,"TOPLEFT")
				batbg:SetPoint("BOTTOMRIGHT",self.render,"BOTTOMRIGHT",0,((160-112)/160)*self.render:GetHeight())
				local bgnum = math.random(1,8)
				if (bgnum <= 4) then
					local rp,lp = ((bgnum*480)/2048),(((bgnum*480)-480)/2048);
					batbg:SetTexCoord(lp,rp,0,224/512)
				else
					local tn = bgnum-4;
					local rp,lp = ((tn*480)/2048),(((tn*480)-480)/2048);
					batbg:SetTexCoord(lp,rp,224/512,(224*2)/512)
				end
			end
			do--Ally frames
				self.Ally = {}
				local Ally = self.Ally
				do
					battle.allym = CreateFrame("PlayerModel",nil,battle)
					battle.allym:SetPoint("TOPLEFT",battle,"TOPLEFT",(31/240)*self.render:GetWidth(),-1*(60/160)*self.render:GetHeight())
					battle.allym:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(99/240)*self.render:GetWidth(),-1*(124/160)*self.render:GetHeight())
					-- battle.enemym:SetPoint("TOPLEFT",battle,"TOPLEFT",(1899/3000)*battle.bg:GetWidth(),-1*(347/1400)*battle.bg:GetHeight())
					-- battle.enemym:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(2550/3000)*battle.bg:GetWidth(),-1*(998/1400)*battle.bg:GetHeight())
					battle.allym.cache = nil;
					battle.allym:SetFrameLevel(9)
				end
				do--Level
					Ally.level = battle:CreateFontString(nil,"OVERLAY",5)
					Ally.level:SetFont(_wd() .. "Fonts\\pkmn.ttf",(120/1400)*battle.bg:GetHeight());
					Ally.level:SetPoint("TOPRIGHT",battle,"TOPRIGHT",-1*(237/3000)*battle.bg:GetWidth(),-1*(979/1400)*battle.bg:GetHeight())
					Ally.level:SetText("LvX");
					Ally.level:SetTextColor(64/255,64/255,64/255,1);
					Ally.level:SetJustifyH("RIGHT");
					Ally.level:SetJustifyV("TOP");
					WoWkemon_GiveTextBrownShadow(Ally.level)
					for i=1,(120/1400)*battle.bg:GetHeight() do Ally.level:SetTextHeight(i); end
				end
				do--Name text
					Ally.name = battle:CreateFontString(nil,"OVERLAY",5)
					Ally.name:SetFont(_wd() .. "Fonts\\pkmn.ttf",(120/1400)*battle.bg:GetHeight());
					Ally.name:SetPoint("TOPLEFT",battle,"TOPLEFT",(1800/3000)*battle.bg:GetWidth(),-1*(982/1400)*battle.bg:GetHeight())
					Ally.name:SetText("NAME");
					Ally.name:SetTextColor(64/255,64/255,64/255,1);
					Ally.name:SetJustifyH("LEFT");
					Ally.name:SetJustifyV("CENTER");
					WoWkemon_GiveTextBrownShadow(Ally.name)
					for i=1,(120/1400)*battle.bg:GetHeight() do Ally.name:SetTextHeight(i); end
				end
				do--StatusBar setup
					Ally.hp = CreateFrame("StatusBar",nil,battle)
					Ally.hp:SetPoint("TOPLEFT",battle,"TOPLEFT",(2175/3000)*battle.bg:GetWidth(),-1*(1137/1400)*battle.bg:GetHeight())
					Ally.hp:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(2774/3000)*battle.bg:GetWidth(),-1*(1161/1400)*battle.bg:GetHeight())
					Ally.hp.barbg = Ally.hp:CreateTexture(nil,"OVERLAY",nil,6)
					Ally.hp.barbg:SetTexture(_wd() .. "Textures\\Select\\barbg.tga")
					Ally.hp:SetStatusBarTexture(Ally.hp.barbg,"OVERLAY")
					Ally.hp:SetStatusBarColor(112/255,248/255,168/255,1)
					Ally.hp:SetMinMaxValues(1,100)
					Ally.hp:SetValue(100)
				end
				do--StatusBar setup
					Ally.xp = CreateFrame("StatusBar",nil,battle)
					Ally.xp:SetPoint("TOPLEFT",battle,"TOPLEFT",(1975/3000)*battle.bg:GetWidth(),-1*(1332/1400)*battle.bg:GetHeight())
					Ally.xp:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(2778/3000)*battle.bg:GetWidth(),-1*(1365/1400)*battle.bg:GetHeight())
					Ally.xp.barbg = Ally.xp:CreateTexture(nil,"OVERLAY",nil,6)
					Ally.xp.barbg:SetTexture(_wd() .. "Textures\\Battle\\barbg.tga")
					Ally.xp:SetStatusBarTexture(Ally.xp.barbg,"OVERLAY")
					Ally.xp:SetStatusBarColor(64/255,200/255,248/255,1)
					Ally.xp:SetMinMaxValues(1,100)
					Ally.xp:SetValue(100)
				end
				do--Health text
					Ally.health = battle:CreateFontString(nil,"OVERLAY",5)
					Ally.health:SetFont(_wd() .. "Fonts\\pkmn.ttf",(120/1400)*battle.bg:GetHeight());
					Ally.health:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(2749/3000)*battle.bg:GetWidth(),-1*(1320/1400)*battle.bg:GetHeight())
					Ally.health:SetText("100/ 100");
					Ally.health:SetTextColor(64/255,64/255,64/255,1);
					Ally.health:SetJustifyH("RIGHT");
					Ally.health:SetJustifyV("BOTTOM");
					WoWkemon_GiveTextBrownShadow(Ally.health)
					for i=1,(120/1400)*battle.bg:GetHeight() do Ally.health:SetTextHeight(i); end
				end
				do
					Ally.bpn = CreateFrame("Frame",nil,battle)
					local bpn = Ally.bpn
					bpn:SetPoint("TOPLEFT",battle,"TOPLEFT",(1775/3000)*battle.bg:GetWidth(),-1*(1200/1400)*battle.bg:GetHeight())
					bpn:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(2024/3000)*battle.bg:GetWidth(),-1*(1299/1400)*battle.bg:GetHeight())
					bpn.buff = bpn:CreateTexture(nil,"OVERLAY",nil,5)
					bpn.buff:SetAllPoints(bpn)
					bpn.buff:SetTexture(_wd() .. "Textures\\Battle\\buff.tga")
					bpn.buff:SetTexCoord(0,1,0,26/32)
					bpn.debuff = bpn:CreateTexture(nil,"OVERLAY",nil,5)
					bpn.debuff:SetAllPoints(bpn)
					bpn.debuff:SetTexture(_wd() .. "Textures\\Battle\\debuff.tga")
					bpn.debuff:SetTexCoord(0,1,0,26/32)
					bpn.buff:Hide()
					bpn.debuff:Hide()
				end
			end
			do--enemy frames
				do
					battle.enemym = CreateFrame("PlayerModel",nil,battle)
					battle.enemym:SetPoint("TOPLEFT",battle,"TOPLEFT",(1899/3000)*battle.bg:GetWidth(),-1*(347/1400)*battle.bg:GetHeight())
					battle.enemym:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(2550/3000)*battle.bg:GetWidth(),-1*(998/1400)*battle.bg:GetHeight())
					battle.enemym.cache = nil;
				end
				self.Enemy = {}
				local Enemy = self.Enemy
				do--Level
					Enemy.level = battle:CreateFontString(nil,"OVERLAY",5)
					Enemy.level:SetFont(_wd() .. "Fonts\\pkmn.ttf",(120/1400)*battle.bg:GetHeight());
					Enemy.level:SetPoint("TOPRIGHT",battle,"TOPLEFT",(1226/3000)*battle.bg:GetWidth(),-1*(260/1400)*battle.bg:GetHeight())
					Enemy.level:SetText("LvX");
					Enemy.level:SetTextColor(64/255,64/255,64/255,1);
					Enemy.level:SetJustifyH("RIGHT");
					Enemy.level:SetJustifyV("TOP");
					WoWkemon_GiveTextBrownShadow(Enemy.level)
					for i=1,(120/1400)*battle.bg:GetHeight() do Enemy.level:SetTextHeight(i); end
				end
				do--Name text
					Enemy.name = battle:CreateFontString(nil,"OVERLAY",5)
					Enemy.name:SetFont(_wd() .. "Fonts\\pkmn.ttf",(120/1400)*battle.bg:GetHeight());
					Enemy.name:SetPoint("TOPLEFT",battle,"TOPLEFT",(249/3000)*battle.bg:GetWidth(),-1*(261/1400)*battle.bg:GetHeight())
					Enemy.name:SetText("NAME");
					Enemy.name:SetTextColor(64/255,64/255,64/255,1);
					Enemy.name:SetJustifyH("LEFT");
					Enemy.name:SetJustifyV("CENTER");
					WoWkemon_GiveTextBrownShadow(Enemy.name)
					for i=1,(120/1400)*battle.bg:GetHeight() do Enemy.name:SetTextHeight(i); end
				end
				do--StatusBar setup
					Enemy.hp = CreateFrame("StatusBar",nil,battle)
					Enemy.hp:SetPoint("TOPLEFT",battle,"TOPLEFT",(650/3000)*battle.bg:GetWidth(),-1*(412/1400)*battle.bg:GetHeight())
					Enemy.hp:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(1249/3000)*battle.bg:GetWidth(),-1*(436/1400)*battle.bg:GetHeight())
					Enemy.hp.barbg = Enemy.hp:CreateTexture(nil,"OVERLAY",nil,6)
					Enemy.hp.barbg:SetTexture(_wd() .. "Textures\\Select\\barbg.tga")
					Enemy.hp:SetStatusBarTexture(Enemy.hp.barbg,"OVERLAY")
					Enemy.hp:SetStatusBarColor(112/255,248/255,168/255,1)
					Enemy.hp:SetMinMaxValues(1,100)
					Enemy.hp:SetValue(100)
				end
				do
					Enemy.bpn = CreateFrame("Frame",nil,battle)
					local bpn = Enemy.bpn
					bpn:SetPoint("TOPLEFT",battle,"TOPLEFT",(203/3000)*battle.bg:GetWidth(),-1*(376/1400)*battle.bg:GetHeight())
					bpn:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(446/3000)*battle.bg:GetWidth(),-1*(473/1400)*battle.bg:GetHeight())
					bpn.buff = bpn:CreateTexture(nil,"OVERLAY",nil,5)
					bpn.buff:SetAllPoints(bpn)
					bpn.buff:SetTexture(_wd() .. "Textures\\Battle\\buff.tga")
					bpn.buff:SetTexCoord(0,1,0,26/32)
					bpn.debuff = bpn:CreateTexture(nil,"OVERLAY",nil,5)
					bpn.debuff:SetAllPoints(bpn)
					bpn.debuff:SetTexture(_wd() .. "Textures\\Battle\\debuff.tga")
					bpn.debuff:SetTexCoord(0,1,0,26/32)
					bpn.buff:Show()
					bpn.debuff:Hide()
				end
			end
			do--Battle frames
				battle.frames = battle:CreateTexture(nil,"ARTWORK",nil,4)
				local frames = battle.frames;
				frames:SetTexture(_wd() .. "Textures\\TV\\battleframes.tga")
				frames:SetPoint("TOPLEFT",self.render,"TOPLEFT")
				frames:SetPoint("BOTTOMRIGHT",self.render.battle.bg,"BOTTOMRIGHT")
				frames:SetTexCoord(0,240/256,0,112/128)
			end
			do
				self.dialog = CreateFrame("Frame",nil,battle)
				local dialog = self.dialog
				dialog:SetFrameLevel(10)
				dialog:SetPoint("TOPLEFT",battle.bg,"BOTTOMLEFT")
				dialog:SetPoint("BOTTOMRIGHT",self.render,"BOTTOMRIGHT")
				do
					local dbg = battle:CreateTexture(nil,"ARTWORK",nil,3);
					dbg:SetAllPoints(dialog)
					dbg:SetTexture(_wd() .. "Textures\\Frames\\emdialog.tga")
					dbg:SetTexCoord(0,1,0,0.79296875);
				end
				do
					dialog.text = dialog:CreateFontString(nil,"OVERLAY",4)
					local text = dialog.text;
					text:SetFont(_wd() .. "Fonts\\pkmn.ttf",(12/48)*dialog:GetHeight());
					text:SetPoint("TOPLEFT",dialog,"TOPLEFT",(16/160)*dialog:GetWidth(),-1*(12/48)*dialog:GetHeight())
					text:SetPoint("BOTTOMRIGHT",dialog,"BOTTOMRIGHT",-1*(16/160)*dialog:GetWidth(),(12/48)*dialog:GetHeight())
					text:SetText("...");
					text:SetTextColor(248/255,248/255,248/255,1);
					WoWkemon_GiveTextDarkEmShadow(text)
					text:SetJustifyH("LEFT");
					text:SetJustifyV("TOP");
					text:SetWordWrap(true)
					text:Show()
					for i=1,(12/48)*dialog:GetHeight() do text:SetTextHeight(i); end
				end
				function self:Attack(target,miss)
					local Ally,Enemy = self.Ally,self.Enemy;
					--8/10 Getting Attacked
					--11/12 is sideways
					--16 is attack
					--131 die
					if (target == "ENEMY") then
						local am = battle.allym
						local em = battle.enemym
						am.ag = am:CreateAnimationGroup()
						am.anims = {}
						am.anims[1] = am.ag:CreateAnimation("Translation")
						am.anims[1]:SetOffset((10/240)*self.render:GetWidth(),(10/160)*self.render:GetHeight())
						am.anims[1]:SetDuration(1.0)
						am.anims[1]:SetOrder(1)
						am.anims[1]:SetSmoothing("NONE")
						am.anims[1]:SetScript("OnPlay", function(self)
							if (am.dead == false) then
								am:SetAnimation(16,1)
							end
							if (miss) then
							else
								if (em.dead == false) then
									em:SetAnimation(10,1)
								end
							end
						end)
						am.anims[1]:SetScript("OnFinished", function(self)
							if (em.dead == false) then
								em:SetAnimation(742,0)
							end
							if (am.dead == false) then
								am:SetAnimation(742,0)
							end
						end)
						am.ag:SetLooping("NONE")
						am.ag:Play()
					elseif (target == "ALLY") then
						local am = battle.enemym
						local em = battle.allym
						am.ag = am:CreateAnimationGroup()
						am.anims = {}
						am.anims[1] = am.ag:CreateAnimation("Translation")
						am.anims[1]:SetOffset((10/240)*self.render:GetWidth(),(10/160)*self.render:GetHeight())
						am.anims[1]:SetDuration(1.0)
						am.anims[1]:SetOrder(1)
						am.anims[1]:SetSmoothing("NONE")
						am.anims[1]:SetScript("OnPlay", function(self)
							if (miss) then
							else
								if (em.dead == false) then
									em:SetAnimation(10,1)
								end
							end
							if (am.dead == false) then
								am:SetAnimation(16,1)
							end
						end)
						am.anims[1]:SetScript("OnFinished", function(self)
							if (em.dead == false) then
								em:SetAnimation(742,0)
							end
							if (am.dead == false) then
								am:SetAnimation(742,0)
							end
						end)
						am.ag:SetLooping("NONE")
						am.ag:Play()
					end
				end
				function self:UpdateUnitFrames(ah,amh,eh,emh,axp,amxp,an,en,ab,eb,al,el)
					local Ally = self.Ally;
					Ally.hp:SetMinMaxValues(0,amh)
					Ally.hp:SetValue(ah)
					WoWkemon_StatusColors(Ally.hp,ah,amh)
					Ally.xp:SetMinMaxValues(0,amxp)
					Ally.xp:SetValue(axp)
					an = an:gsub("'","")
					local tn = an:gsub("|c[A-Za-z0-9]+","");
					tn = tn:gsub("|r","")
					if (tn:len() > 15) then Ally.name:SetText(abbreviate(an)) else Ally.name:SetText(an) end
					Ally.health:SetText(ah .. "/ " .. amh)
					if (ab == "buff") then 
						Ally.bpn.debuff:Hide();
						Ally.bpn.buff:Show();
					elseif (ab == "debuff") then
						Ally.bpn.debuff:Show();
						Ally.bpn.buff:Hide();
					else
						Ally.bpn.debuff:Hide();
						Ally.bpn.buff:Hide();
					end
					Ally.level:SetText("Lv" .. al);
					local am = battle.allym
					if (ah == "0") then
						am.dead = true;
						am:SetAnimation(6, 0);
					else
						am.dead = false;
					end
					local Enemy = self.Enemy;
					Enemy.hp:SetMinMaxValues(0,emh)
					Enemy.hp:SetValue(eh)
					WoWkemon_StatusColors(Enemy.hp,eh,emh)
					en = en:gsub("'","")
					tn = en:gsub("|c[A-Za-z0-9]+","");
					tn = tn:gsub("|r","")
					if (tn:len() > 15) then Enemy.name:SetText(abbreviate(en)) else Enemy.name:SetText(en) end
					if (eb == "buff") then 
						Enemy.bpn.debuff:Hide();
						Enemy.bpn.buff:Show();
					elseif (eb == "debuff") then
						Enemy.bpn.debuff:Show();
						Enemy.bpn.buff:Hide();
					else
						Enemy.bpn.debuff:Hide();
						Enemy.bpn.buff:Hide();
					end
					Enemy.level:SetText("Lv" .. el);
					local am = battle.enemym
					if (eh == "0") then
						am.dead = true;
						am:SetAnimation(6, 0);
					else
						am.dead = false;
					end
				end
				function self:BattleText(text)
					dialog.text:SetText(text)
				end
				function self:SetModels(ally,enemy)
					--131 dead
					if (ally) then
						local am = battle.allym;
						if (am.cache == ally) then
						elseif (am.cache ~= ally) then
							-- am.animg = am:CreateAnimationGroup()
							-- am.anims = {}
							-- am:SetAlpha(0)
							-- am.anims[1] = am.animg:CreateAnimation("Alpha")
							-- am.anims[1]:SetChange(1)
							-- am.anims[1]:SetDuration(0.5)
							-- am.anims[1]:SetOrder(1)
							-- am.anims[1]:SetSmoothing("NONE")
							-- am.anims[1]:SetScript("OnPlay", function(self)
							am:SetDisplayInfo(ally);
							am.cache = ally
							am.model = am:GetModel()
							am:SetRotation((3*math.pi)/4);
							am:SetDoBlend(false);
							if (am.dead == false) then
								am:SetAnimation(742, 0);
							end
							-- end)
							-- am.anims[1]:SetScript("OnFinished", function(self)
							-- 	am:SetAlpha(1)
							-- 	--print("Finished, setting alpha to 1")
							-- end)
							-- am.animg:SetLooping("NONE")
							-- am.animg:Play()
						end
					end
					if (enemy) then
						local em = battle.enemym;
						if (em.cache == enemy) then
							
						elseif (em.cache ~= enemy) then
							em:SetDisplayInfo(enemy);
							em.cache = enemy
							em.model = em:GetModel()
							em:SetRotation(-1*(math.pi/4));
							em:SetDoBlend(false);
							if (em.dead == false) then
								em:SetAnimation(742, 0);
							end
						end
					end
				end
			end
		end
		
		local render = self.render
		function render:ShowDefault()
			render.default.hide = render.default:CreateAnimationGroup()
			render.default.hide.alpha = render.default.hide:CreateAnimation("Alpha")
			local ganim = render.default.hide.alpha
			ganim:SetChange(1)
			ganim:SetDuration(0.5)
			ganim:SetOrder(1)
			ganim:SetSmoothing("NONE")
			render.default.hide:SetLooping("NONE")
			render.default.hide:SetScript("OnFinished", function(self)
				render.default:SetAlpha(1)
			end);
			render.default.hide:SetScript("OnPlay", function(self)
				render.default:SetAlpha(0)
			end);
			render.battle.hide = render.battle:CreateAnimationGroup()
			render.battle.hide.alpha = render.battle.hide:CreateAnimation("Alpha")
			local fanim = render.battle.hide.alpha
			fanim:SetChange(-1)
			fanim:SetDuration(0.5)
			fanim:SetOrder(1)
			fanim:SetSmoothing("NONE")
			render.battle.hide:SetLooping("NONE")
			render.battle.hide:SetScript("OnFinished", function(self)
				render.battle:SetAlpha(0)
				render.default:SetAlpha(1)
				render.battle:Hide()
			end);
			render.battle.hide:SetScript("OnPlay", function(self)
				render.battle:SetAlpha(1)
				render.default:SetAlpha(0)
				render.default.hide:Play()
			end);
			render.battle.hide:Play()
		end
		function render:ShowBattle()
			render.battle.hide = render.battle:CreateAnimationGroup()
			render.battle.hide.alpha = render.battle.hide:CreateAnimation("Alpha")
			local ganim = render.battle.hide.alpha
			ganim:SetChange(1)
			ganim:SetDuration(0.5)
			ganim:SetOrder(1)
			ganim:SetSmoothing("NONE")
			render.battle.hide:SetLooping("NONE")
			render.battle.hide:SetScript("OnFinished", function(self)
				render.battle:SetAlpha(1)
			end);
			render.battle.hide:SetScript("OnPlay", function(self)
				render.battle:SetAlpha(0)
			end);
			render.default.hide = render.default:CreateAnimationGroup()
			render.default.hide.alpha = render.default.hide:CreateAnimation("Alpha")
			local fanim = render.default.hide.alpha
			fanim:SetChange(-1)
			fanim:SetDuration(0.5)
			fanim:SetOrder(1)
			fanim:SetSmoothing("NONE")
			render.default.hide:SetLooping("NONE")
			render.default.hide.alpha:SetScript("OnFinished", function(self)
				render.battle:SetAlpha(1)
				render.default:SetAlpha(0)
			end);
			render.default.hide:SetScript("OnPlay", function(self)
				render.battle:SetAlpha(1)
				render.default:SetAlpha(0)
				render.battle:Show()
				render.battle.hide:Play()
				local batbg = render.battle.bg;
				local bgnum = math.random(1,8)
				if (bgnum <= 4) then
					local rp,lp = ((bgnum*480)/2048),(((bgnum*480)-480)/2048);
					batbg:SetTexCoord(lp,rp,0,224/512)
				else
					local tn = bgnum-4;
					local rp,lp = ((tn*480)/2048),(((tn*480)-480)/2048);
					batbg:SetTexCoord(lp,rp,224/512,(224*2)/512)
				end
			end);
			render.default.hide:Play()
		end
		function self:Spectate(name)
			local text = self.render.default.spect;
			text:SetText(name)
			text:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((60/431)*self:GetHeight()),"OUTLINE");
			for i=1,math.floor((60/431)*self:GetHeight()) do text:SetTextHeight(i) end
			while (text:IsTruncated() == true) do
				text:SetTextHeight(text:GetStringHeight()-1)
			end
		end
		function self:UpdateResolution()
			local self = WoWkemon_TV
			if (self.init == true) then
				self.render:SetPoint("TOPLEFT",self,"TOPLEFT",math.floor((46/512)*self:GetWidth()),-1*math.floor((46/431)*self:GetHeight()))
				self.render:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",-1*math.floor((53/512)*self:GetWidth()),math.floor((105/431)*self:GetHeight()))
				local text = self.render.default.text;
				text:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((87/431)*self:GetHeight()),"OUTLINE");
				for i=1,math.floor((87/431)*self:GetHeight()) do text:SetTextHeight(i) end
				local battle = self.render.battle;
				local batbg = battle.bg;
				batbg:SetPoint("TOPLEFT",self.render,"TOPLEFT")
				batbg:SetPoint("BOTTOMRIGHT",self.render,"BOTTOMRIGHT",0,((160-112)/160)*self.render:GetHeight())
				local Ally = self.Ally
				battle.allym:SetPoint("TOPLEFT",battle,"TOPLEFT",(31/240)*self.render:GetWidth(),-1*(60/160)*self.render:GetHeight())
				battle.allym:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(99/240)*self.render:GetWidth(),-1*(124/160)*self.render:GetHeight())
				Ally.level:SetFont(_wd() .. "Fonts\\pkmn.ttf",(120/1400)*battle.bg:GetHeight());
				Ally.level:SetPoint("TOPRIGHT",battle,"TOPRIGHT",-1*(237/3000)*battle.bg:GetWidth(),-1*(979/1400)*battle.bg:GetHeight())
				for i=1,(120/1400)*battle.bg:GetHeight() do Ally.level:SetTextHeight(i); end
				Ally.name:SetFont(_wd() .. "Fonts\\pkmn.ttf",(120/1400)*battle.bg:GetHeight());
				Ally.name:SetPoint("TOPLEFT",battle,"TOPLEFT",(1800/3000)*battle.bg:GetWidth(),-1*(982/1400)*battle.bg:GetHeight())
				for i=1,(120/1400)*battle.bg:GetHeight() do Ally.name:SetTextHeight(i); end
				Ally.hp:SetPoint("TOPLEFT",battle,"TOPLEFT",(2175/3000)*battle.bg:GetWidth(),-1*(1137/1400)*battle.bg:GetHeight())
				Ally.hp:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(2774/3000)*battle.bg:GetWidth(),-1*(1161/1400)*battle.bg:GetHeight())
				Ally.xp:SetPoint("TOPLEFT",battle,"TOPLEFT",(1975/3000)*battle.bg:GetWidth(),-1*(1332/1400)*battle.bg:GetHeight())
				Ally.xp:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(2778/3000)*battle.bg:GetWidth(),-1*(1365/1400)*battle.bg:GetHeight())
				Ally.health:SetFont(_wd() .. "Fonts\\pkmn.ttf",(120/1400)*battle.bg:GetHeight());
				Ally.health:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(2749/3000)*battle.bg:GetWidth(),-1*(1320/1400)*battle.bg:GetHeight())
				for i=1,(120/1400)*battle.bg:GetHeight() do Ally.health:SetTextHeight(i); end
				local bpn = Ally.bpn
				bpn:SetPoint("TOPLEFT",battle,"TOPLEFT",(1775/3000)*battle.bg:GetWidth(),-1*(1200/1400)*battle.bg:GetHeight())
				bpn:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(2024/3000)*battle.bg:GetWidth(),-1*(1299/1400)*battle.bg:GetHeight())
				battle.enemym:SetPoint("TOPLEFT",battle,"TOPLEFT",(130/240)*self.render:GetWidth(),-1*(16/160)*self.render:GetHeight())
				battle.enemym:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(209/240)*self.render:GetWidth(),-1*(81/160)*self.render:GetHeight())
				local Enemy = self.Enemy
				Enemy.level:SetFont(_wd() .. "Fonts\\pkmn.ttf",(120/1400)*battle.bg:GetHeight());
				Enemy.level:SetPoint("TOPRIGHT",battle,"TOPLEFT",(1226/3000)*battle.bg:GetWidth(),-1*(260/1400)*battle.bg:GetHeight())
				for i=1,(120/1400)*battle.bg:GetHeight() do Enemy.level:SetTextHeight(i); end
				Enemy.name:SetFont(_wd() .. "Fonts\\pkmn.ttf",(120/1400)*battle.bg:GetHeight());
				Enemy.name:SetPoint("TOPLEFT",battle,"TOPLEFT",(249/3000)*battle.bg:GetWidth(),-1*(261/1400)*battle.bg:GetHeight())
				for i=1,(120/1400)*battle.bg:GetHeight() do Enemy.name:SetTextHeight(i); end
				Enemy.hp:SetPoint("TOPLEFT",battle,"TOPLEFT",(650/3000)*battle.bg:GetWidth(),-1*(412/1400)*battle.bg:GetHeight())
				Enemy.hp:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(1249/3000)*battle.bg:GetWidth(),-1*(436/1400)*battle.bg:GetHeight())
				local bpn = Enemy.bpn
				bpn:SetPoint("TOPLEFT",battle,"TOPLEFT",(203/3000)*battle.bg:GetWidth(),-1*(376/1400)*battle.bg:GetHeight())
				bpn:SetPoint("BOTTOMRIGHT",battle,"TOPLEFT",(446/3000)*battle.bg:GetWidth(),-1*(473/1400)*battle.bg:GetHeight())
				local dialog = self.dialog
				local text = dialog.text;
				text:SetFont(_wd() .. "Fonts\\pkmn.ttf",(12/48)*dialog:GetHeight());
				text:SetPoint("TOPLEFT",dialog,"TOPLEFT",(16/160)*dialog:GetWidth(),-1*(12/48)*dialog:GetHeight())
				text:SetPoint("BOTTOMRIGHT",dialog,"BOTTOMRIGHT",-1*(16/160)*dialog:GetWidth(),(12/48)*dialog:GetHeight())
				for i=1,(12/48)*dialog:GetHeight() do text:SetTextHeight(i); end
				self.plus:SetPoint("TOPLEFT",self,"TOPLEFT",(31/1000)*self:GetWidth(),-1*(144/842)*self:GetHeight())
				self.plus:SetPoint("BOTTOMRIGHT",self,"TOPLEFT",(70/1000)*self:GetWidth(),-1*(183/842)*self:GetHeight())
				self.minus:SetPoint("TOPLEFT",self,"TOPLEFT",(31/1000)*self:GetWidth(),-1*(187/842)*self:GetHeight())
				self.minus:SetPoint("BOTTOMRIGHT",self,"TOPLEFT",(70/1000)*self:GetWidth(),-1*(226/842)*self:GetHeight())
				self.close:SetPoint("TOPLEFT",self,"TOPLEFT",(31/1000)*self:GetWidth(),-1*(588/842)*self:GetHeight())
				self.close:SetPoint("BOTTOMRIGHT",self,"TOPLEFT",(70/1000)*self:GetWidth(),-1*(627/842)*self:GetHeight())
				local text = self.render.default.spect;
				text:SetFont(_wd() .. "Fonts\\pkmn.ttf",math.floor((60/431)*self:GetHeight()),"OUTLINE");
				for i=1,math.floor((60/431)*self:GetHeight()) do text:SetTextHeight(i) end
			end
		end
		function self:Resolute(size)
			self:setUp(self,size)
			self:UpdateResolution()
		end
		function self:SetSizeDelta(delta)
			if ((self:GetWidth()+delta) > 220) and ((self:GetWidth()+delta) < 700) then self:Resolute(self:GetWidth()+delta) end
		end
	
	end
	self.sbtn = CreateFrame("Button",nil,FriendsTabHeaderSoRButton)
	self.sbtn:SetSize(FriendsTabHeaderSoRButton:GetWidth(),FriendsTabHeaderSoRButton:GetHeight())
	self.sbtn:SetPoint("RIGHT",FriendsTabHeaderSoRButton,"LEFT",-5,0)
	self.sbtn.bg = self.sbtn:CreateTexture(nil,"BACKGROUND");
	self.sbtn.bg:SetAllPoints(self.sbtn)
	self.sbtn.bg:SetTexture(_wd() .. "Textures\\TV\\sbutton-new.tga")
	self.sbtn:EnableMouse(true)
	self.sbtn:RegisterForClicks("LeftButtonUp")
	self.sbtn:SetScript("OnClick",function(self,button,down)
		local friendsmenu = CreateFrame("Frame", "WoWkemon_Dropdown")
		friendsmenu.displayMode = "MENU"
		UIDropDownMenu_Initialize(friendsmenu, function(self, level, menuList)	
			if (level == 1) then
				local info = UIDropDownMenu_CreateInfo();
				info.isTitle = 1
				info.text = "WOWKéMON Users Online (Click to spectate)"
				info.notCheckable = 1
				UIDropDownMenu_AddButton(info)
				if (#WoWkemon_TV.friends > 0) then
					for i,j in pairs(WoWkemon_TV.friends) do
						wipe(info)
						info = UIDropDownMenu_CreateInfo();
						info.disabled     = nil
						info.isTitle      = nil
						info.notCheckable = true
						if (j.time ~= "none") then
							info.text = j.name .. " |cFFb8860b(Last battled: " .. stime(tonumber(j.time)) .. " ago.)|r"
						else
							info.text = j.name .. " |cFFb8860bLast battled: Has not battled this session.|r"
						end
						info.func = function()
							WoWkemon_TV:connect(j.name)
						end
						UIDropDownMenu_AddButton(info)
					end
				else
					wipe(info)
					info = UIDropDownMenu_CreateInfo();
					info.disabled     = true
					info.isTitle      = true
					info.notCheckable = true
					info.text = "|cFF696969None online.|r"
					UIDropDownMenu_AddButton(info)
				end
				wipe(info)
				info = UIDropDownMenu_CreateInfo();
				info.disabled     = nil
				info.isTitle      = nil
				info.notCheckable = true
				info.text = "Custom player"
				info.func = function()
					StaticPopup_Show("WOWKEMON_CUSTOM");
				end
				UIDropDownMenu_AddButton(info)
				
			end
		end)
		ToggleDropDownMenu(1, nil, friendsmenu, self, 0, 0)
	end)
	FriendsTabHeaderSoRButton:HookScript("OnShow", function(self)
			WoWkemon_TV:UpdateFriends()
		end)
	self.init = true;
	do
		self.spectate = CreateFrame("Button",nil,UIParent)
		self.spectate:SetSize(40,40)
		self.spectate:SetPoint("TOP",UIParent,"TOP",0,-10)
		self.spectate.bg = self.spectate:CreateTexture(nil,"BACKGROUND");
		self.spectate.bg:SetAllPoints(self.spectate)
		self.spectate.bg:SetTexture(_wd() .. "Textures\\TV\\sbutton.tga")
		--self.spectate.bg:SetTexture(1,1,1)
		self.spectate.text = self.spectate:CreateFontString(nil,"ARTWORK",0,"OUTLINE")
		self.spectate.text:SetFont(_wd() .. "Fonts\\pkmn.ttf",self.spectate:GetHeight()+15);
		for i=1,self.spectate:GetHeight()+15 do self.spectate.text:SetTextHeight(i) end
		self.spectate.text:SetText("..");
		self.spectate.text:SetTextColor(0,0,0,1);
		self.spectate.text:SetPoint("CENTER",self.spectate,"CENTER",0,-1*(5/40)*self.spectate:GetHeight())
		self.spectate.text:SetJustifyV("CENTER")
		self.spectate:EnableMouse(true)
		self.spectate:SetScript("OnUpdate", function(self)
			if (WoWkemon_TV.clients) then
				if (#WoWkemon_TV.clients >= 1) then
					self:Show()
					self.text:SetText(#WoWkemon_TV.clients)
				else
					self:Hide()
				end
			else
				self:Hide()
			end
		end)
		self.spectate:SetScript( "OnEnter", function(self) 
			GameTooltip:SetOwner( self, "ANCHOR_CURSOR" )
			local specs = ""
			for i,j in ipairs(WoWkemon_TV.clients) do
				specs = specs .. "\n|cFFFFFFFF" .. j .. "|r"
			end
			GameTooltip:SetText( "Spectators:" .. specs)
		end )
		self.spectate:SetScript( "OnLeave", GameTooltip_Hide )
	end
end
function WoWkemon_TV_CombatLogEvent(unparsed)
	for i,j in pairs(OPA) do
		if unparsed:match(j) then
			return i;
		end
	end
end
function WoWkemon_TV_EnemyDead()
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY);
	local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ENEMY, activePet);
	return (health == 0);
end
function WoWkemon_TV_AllyAllDead()
	local sd = true
	for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) do
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, i);
		if (health ~= 0) then sd = false end
	end
	return sd;
end
function WoWkemon_TV_EnemyAllDead()
	local sd = true
	for i=1,C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY) do
		local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, i);
		if (health ~= 0) then sd = false end
	end
	return sd;
end
function WoWkemon_TV_AllyAlmostDead()
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
function WoWkemon_TV_TurnComplete()
	local self = WoWkemon
	local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY);
	local health,maxHealth = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, activePet), C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, activePet);
	if (health == 0) then
		if (WoWkemon_TV_EnemyAllDead() == false) and (WoWkemon_TV_AllyAllDead() == false) then
			if (WoWkemon_TV_AllyAlmostDead() == true) then
			else
				local name,_ = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY));
				WoWkemon_TV:SendBattle(name .. " fainted! " .. UnitName("player") .. " is selecting a new one.")
			end
		elseif (WoWkemon_TV_AllyAllDead() == true) then
			WoWkemon_TV:SendBattle("Lost the battle!")
		end
	else
		if (WoWkemon_TV_EnemyDead() == true) and (WoWkemon_TV_EnemyAllDead() == false) then
			WoWkemon_TV:SendBattle(UnitName("player") .. " is selecting a pet.")
		elseif (WoWkemon_TV_EnemyAllDead() == true) then
			WoWkemon_TV:SendBattle("Won the battle!")
		else
			WoWkemon_TV:SendBattle(UnitName("player") .. " is deciding what to do.")
		end
	end
end
function WoWkemon_TV_OnEvent(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...;
	if (event == "PET_BATTLE_OVER") then
		self:SendEvent(event)
		self.tsb = time();
	elseif (event == "PET_BATTLE_OPENING_START") then
		self:SendEvent(event)
	elseif (event == "PET_BATTLE_OPENING_DONE") then
		self:SendEvent(event)
		self:UpdateResolution()
		if (C_PetBattles.IsWildBattle() == true) then
			local petName,_ = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY));
			self:SendBattle("Go! " .. petName .. "!")
		end
	elseif (event == "PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE") then
		WoWkemon_TV_TurnComplete()
	elseif (event == "DISPLAY_SIZE_CHANGED") then
		self:UpdateResolution()
	elseif (event == "PLAYER_LEAVING_WORLD") then
		
		self:DisconnectClients()
	elseif (event == "CHAT_MSG_PET_BATTLE_COMBAT_LOG") then
		lovas = {...}
		np = tostring(lovas[1])
		if (WoWkemon_TV_CombatLogEvent(np)) then
			if (WoWkemon_TV_CombatLogEvent(np):match("PET_BATTLE_COMBAT_LOG_DAMAGE")) then
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
				if (petOwner == LE_BATTLE_PET_ALLY) then
					self:SendAttack("ENEMY")
				elseif (petOwner == LE_BATTLE_PET_ENEMY) then
					self:SendAttack("ALLY")
				end
				local crit = 0;
				if (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_DAMAGE_STRONG") or (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_DAMAGE_CRIT") then crit = 1; elseif (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_DAMAGE_WEAK") then crit = -1; end
				local petName,_ = C_PetBattles.GetName(petOwner, C_PetBattles.GetActivePet(petOwner));
				if (petName) then
					petName = petName:gsub("'","")
					if (crit == 1) then
						self:SendBattle(petName .. " used " .. string.upper(an) .. "! It was super effective!")
					elseif (crit == -1) then
						self:SendBattle(petName .. " used " .. string.upper(an) .. "! It was not very effective...")
					else
						self:SendBattle(petName .. " used " .. string.upper(an) .. "!")
					end
				end
			end
			if (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_PAD_AURA_APPLIED") or (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_AURA_APPLIED") then
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
					self:SendBattle(petName .. " used " .. string.upper(an) .. "!")
				end
			end
			if (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_WEATHER_AURA_APPLIED") then
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
					self:SendBattle(petName .. " used " .. string.upper(an) .. "!")
				end	
				--end
			end
			if (WoWkemon_TV_CombatLogEvent(np):match("TRAP")) then
				self:SendBattle()
				if (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_TRAP_MISS") then
					self:SendBattle(string.upper(UnitName("player")) .. " used\na WOWKé BALL! But it failed...")
				elseif (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_TRAP_HIT") then
					local petName,_ = C_PetBattles.GetName(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY));
					self:SendBattle(UnitName("player") .. " caught wild " .. petName .. "!")
				end
			end
			if (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_MISS") or (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_DODGE") or (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_BLOCKED") then
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
				self:SendBattle(petName .. " used " .. string.upper(an) .. "! But it missed...")
				if (petOwner == LE_BATTLE_PET_ALLY) then
					self:SendAttack("ENEMY","missed")
				elseif (petOwner == LE_BATTLE_PET_ENEMY) then
					self:SendAttack("ALLY","missed")
				end
			end
			if (WoWkemon_TV_CombatLogEvent(np) == "PET_BATTLE_COMBAT_LOG_PET_SWITCHED") then
				local petOwner;
				if np:match(PET_BATTLE_COMBAT_LOG_YOUR_LOWER) then petOwner = LE_BATTLE_PET_ALLY elseif np:match(PET_BATTLE_COMBAT_LOG_ENEMY_LOWER) then petOwner = LE_BATTLE_PET_ENEMY; end
				if np:match(PET_BATTLE_COMBAT_LOG_YOUR_LOWER) then
					local petName,_ = C_PetBattles.GetName(petOwner, C_PetBattles.GetActivePet(petOwner));
					self:SendBattle("Go! " .. petName .. "!")
				elseif np:match(PET_BATTLE_COMBAT_LOG_ENEMY_LOWER) then
					local petName,_ = C_PetBattles.GetName(petOwner, C_PetBattles.GetActivePet(petOwner));
					if (C_PetBattles.IsWildBattle() == true) then
						self:SendBattle(petName .. " jumps forward!")
					else
						self:SendBattle("Enemy sent out " .. petName .. "!")
					end
				end
			end
		end
	elseif (event == "CHAT_MSG_ADDON") then
		if (arg1 == "WKMNTVC") then
			----print(arg1,arg2)
			if arg2:match("DISCONNECTION") then
				SendAddonMessage("WKMNTVS","DISCONNECTION QUERY RECEIVED", "WHISPER",arg4)
				self:removeclient(arg4)
				sysprint(arg4 .. " disconnected from you.")
				--print("SM:","WKMNTVS","DISCONNECTION QUERY RECEIVED")
			elseif arg2:match("CONNECTION") then
				SendAddonMessage("WKMNTVS","CONNECTION QUERY RECEIVED", "WHISPER",arg4)
				--print("SM:","WKMNTVS","CONNECTION QUERY RECEIVED")
				self:addclient(arg4)
				sysprint(arg4 .. " is now spectating your pet battles.")
			end
		elseif (arg1 == "WKMNTVS") then
			----print(arg1,arg2)
			local array = split(arg2,",")
			if (self.connecting == true) and (arg2 == "CONNECTION QUERY RECEIVED") then
			self.connecting = false;
			self.connected = true;
				--TV.render:ShowDefault()
				self:Spectate(arg4)
				self:Show()
				----print("HIDING TV")
			elseif (arg2 == "DISCONNECTION QUERY RECEIVED") then
			self.disconnecting = false;
			self.connected = false;
			self.connecting = false;
				--TV.render:ShowDefault()
				self:Hide()
				----print("SHOWING TV")
			elseif array then
				if (array[2] == "PET_BATTLE_OPENING_START") then
				self.render:ShowBattle()
					if (array[3] ~= "nil") then
						self:BattleText("Wild " .. array[4] .. " appeared!")
					else
						self:BattleText("Enemy would like to battle!")
					end
				elseif (array[2] == "PET_BATTLE_OVER") then
				self.render:ShowDefault()
				elseif (array[1] == "battle") then
					self:BattleText(array[2])
				elseif (array[1] == "attack") then
					if (array[3] == "missed") then
						self:Attack(array[2],"missed")
					else
						self:Attack(array[2])
					end
				elseif (array[1] == "unit") then
					local AllyModel,EnemyModel,AllyHealth,AllyMaxHealth,EnemyHealth,EnemyMaxHealth,AllyExp,AllyMaxExp = array[2],array[3],array[4],array[5],array[6],array[7],array[8],array[9];
					local AllyName,EnemyName,AllyBuffs,EnemyBuffs,AllyLevel,EnemyLevel = array[10],array[11],array[12],array[13],array[14],array[15];
					self:SetModels(array[2],array[3])
					self:UpdateUnitFrames(AllyHealth,AllyMaxHealth,EnemyHealth,EnemyMaxHealth,AllyExp,AllyMaxExp,AllyName,EnemyName,AllyBuffs,EnemyBuffs,AllyLevel,EnemyLevel);
				end
			end
		elseif (arg1 == "WKMNTVP") then
			--print(arg1,arg2)
			if (arg2 == "DOYOU") then
				if (self.tsb) then
					SendAddonMessage("WKMNTVP","IDO," .. tostring(time()-self.tsb),"WHISPER",arg4)
				else
					SendAddonMessage("WKMNTVP","IDO," .. "none","WHISPER",arg4)
				end
			elseif (arg2:match("IDO")) then
				local array = split(arg2,",")
				self:RegisterFriend(arg4,array[2])
			end
			
		end
	elseif (event == "FRIENDLIST_UPDATE") then
		self:UpdateFriends()
	end
	if (event ~= "CHAT_MSG_ADDON") then
		self:SendUnitInfo()
	end
end
StaticPopupDialogs["WOWKEMON_CUSTOM"] = {
    text = "Type the name of player to spectate",
    button1 = "Connect",
    button2 = "Cancel",
    OnAccept = function(self)
        WoWkemon_TV:connect(self.editBox:GetText())
    end,
    OnCancel = function (self)

    end,
    OnUpdate = function (self)
        
    end,
    timeout = 0,
    whileDead = 1,
    exclusive = 1,
    showAlert = 1,
    hideOnEscape = 1,
    hasEditBox = 1,
    maxLetters = 32,
    OnShow = function(self)
        self.button1:Disable();
        self.button2:Enable();
        self.editBox:SetFocus();
    end,
    OnHide = function(self)

    end,
    EditBoxOnEnterPressed = function(self)
        if ( self:GetParent().button1:IsEnabled() ) then
             WoWkemon_TV:connect(self:GetParent().editBox:GetText())
             self:GetParent():Hide()
        end
    end,
    EditBoxOnTextChanged = function (self)
        local parent = self:GetParent();
        if (parent.editBox:GetText():len() ~= 0) then
            parent.button1:Enable();
        else
            parent.button1:Disable();
        end
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide();
    end
};
