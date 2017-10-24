local parsedAbilityInfo;
function WoWkemon_ParseText(abilityInfo, unparsed)
	parsedAbilityInfo = abilityInfo;
	local parsed = string.gsub(unparsed, "%b[]", WoWkemon_ParseExpression);
	return parsed;
end

local parserEnv = {
	--Constants
	SELF = "self",
	ENEMY = "enemy",
	AURAWEARER = "aurawearer",
	AURACASTER = "auracaster",
	AFFECTED = "affected",

	--Proc types (for use in getProcIndex)
	PROC_ON_APPLY = PET_BATTLE_EVENT_ON_APPLY,
	PROC_ON_DAMAGE_TAKEN = PET_BATTLE_EVENT_ON_DAMAGE_TAKEN,
	PROC_ON_DAMAGE_DEALT = PET_BATTLE_EVENT_ON_DAMAGE_DEALT,
	PROC_ON_HEAL_TAKEN = PET_BATTLE_EVENT_ON_HEAL_TAKEN,
	PROC_ON_HEAL_DEALT = PET_BATTLE_EVENT_ON_HEAL_DEALT,
	PROC_ON_AURA_REMOVED = PET_BATTLE_EVENT_ON_AURA_REMOVED,
	PROC_ON_ROUND_START = PET_BATTLE_EVENT_ON_ROUND_START,
	PROC_ON_ROUND_END = PET_BATTLE_EVENT_ON_ROUND_END,
	PROC_ON_TURN = PET_BATTLE_EVENT_ON_TURN,
	PROC_ON_ABILITY = PET_BATTLE_EVENT_ON_ABILITY,
	PROC_ON_SWAP_IN = PET_BATTLE_EVENT_ON_SWAP_IN,
	PROC_ON_SWAP_OUT = PET_BATTLE_EVENT_ON_SWAP_OUT,

	--We automatically populate with state constants as well in the form STATE_%s

	--Utility functions
	ceil = math.ceil,
	floor = math.floor,
	abs = math.abs,
	min = math.min,
	max = math.max,
	cond = function(conditional, onTrue, onFalse) if ( conditional ) then return onTrue; else return onFalse; end end,
	clamp = function(value, minClamp, maxClamp) return min(max(value, minClamp), maxClamp); end,

	--Data fetching functions
	unitState = function(stateID, target)
				if ( not target ) then
					target = "default";
				end
				return parsedAbilityInfo:GetState(stateID, target);
			end,
	unitPower = function(target)
				if ( not target ) then
					target = "default";
				end
				return parsedAbilityInfo:GetAttackStat(target);
			end,
	unitSpeed = function(target)
				if ( not target ) then
					target = "default";
				end
				return parsedAbilityInfo:GetSpeedStat(target);
			end,
	unitMaxHealth = function(target)
				if ( not target ) then
					target = "default";
				end
				return parsedAbilityInfo:GetMaxHealth(target);
			end,
	unitHealth = function(target)
				if ( not target ) then
					target = "default";
				end
				return parsedAbilityInfo:GetHealth(target);
			end,
	unitIsAlly = function(target)
				if ( not target ) then
					target = "default";
				end
				return parsedAbilityInfo:GetPetOwner(target) == LE_BATTLE_PET_ALLY;
			end,
	unitHasAura = function(auraID, target)
				if ( not target ) then
					target = "default";
				end
				return parsedAbilityInfo:HasAura(auraID, target);
			end,
	unitPetType = function(target)
				if ( not target ) then
					target = "default";
				end
				return parsedAbilityInfo:GetPetType(target);
			end,
	isInBattle = function()
				return parsedAbilityInfo:IsInBattle();
			end,
	numTurns = function(abilityID)
				if ( not abilityID ) then
					abilityID = parsedAbilityInfo:GetAbilityID();
				end
				local id, name, icon, maxCooldown, description, numTurns = C_PetBattles.GetAbilityInfoByID(abilityID);
				return numTurns;
			end,
	currentCooldown = function()
				return parsedAbilityInfo:GetCurrentCooldown();
			end,
	maxCooldown = function(abilityID)
				if ( not abilityID ) then
					abilityID = parsedAbilityInfo:GetAbilityID();
				end
				local id, name, icon, maxCooldown, description, numTurns = C_PetBattles.GetAbilityInfoByID(abilityID);
				return maxCooldown;
			end,
	abilityPetType = function(abilityID)
				if ( not abilityID ) then
					abilityID = parsedAbilityInfo:GetAbilityID();
				end
				local id, name, icon, maxCooldown, description, numTurns, petType = C_PetBattles.GetAbilityInfoByID(abilityID);
				return petType;
			end,
	petTypeName = function(petType)
				return _G["BATTLE_PET_DAMAGE_NAME_"..petType]
			end,
	remainingDuration = function()
				return parsedAbilityInfo:GetRemainingDuration();
			end,
	getProcIndex = function(procType, abilityID)
				if ( not abilityID ) then
					abilityID = parsedAbilityInfo:GetAbilityID();
				end
				local turnIndex = C_PetBattles.GetAbilityProcTurnIndex(abilityID, procType);
				if ( not turnIndex ) then
					error("No such proc type: "..tostring(procType));
				end
				return turnIndex;
			end,
	abilityName = function(abilityID)
				if ( not abilityID ) then
					abilityID = parsedAbilityInfo:GetAbilityID();
				end
				local id, name, icon, maxCooldown, description, numTurns, petType = C_PetBattles.GetAbilityInfoByID(abilityID);
				return name;
			end,
	abilityHasHints = function(abilityID)
				if ( not abilityID ) then
					abilityID = parsedAbilityInfo:GetAbilityID();
				end
				local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID(abilityID);
				return petType and not noStrongWeakHints;
			end,
	padState = function(stateID, target)
				if ( not target ) then
					target = "default";
				end
				return parsedAbilityInfo:GetPadState(stateID, target);
			end,
	weatherState = function(stateID)
				return parsedAbilityInfo:GetWeatherState(stateID);
			end,
	abilityStateMod = function(stateID, abilityID)
				if ( not abilityID ) then
					abilityID = parsedAbilityInfo:GetAbilityID();
				end
				return C_PetBattles.GetAbilityStateModification(abilityID, stateID);
			end,
};

-- Dynamic fetching functions
local effectParamStrings = {C_PetBattles.GetAllEffectNames()};
for i = 1, #effectParamStrings do
	parserEnv[effectParamStrings[i]] = 
		function(turnIndex, effectIndex, abilityID)
			if ( not abilityID ) then
				abilityID = parsedAbilityInfo:GetAbilityID();
			end
			local value = C_PetBattles.GetAbilityEffectInfo(abilityID, turnIndex, effectIndex, effectParamStrings[i]);
			if ( not value ) then
				error("No such attribute: "..effectParamStrings[i]);
			end
			return value;
		end;
end

-- Fill out the environment with all states (format: STATE_%s)
C_PetBattles.GetAllStates(parserEnv);
	

--Alias helpers
local function FormatDamageHelper(baseDamage, attackType, defenderType)
	local output = "";
	local multi = C_PetBattles.GetAttackModifier(attackType, defenderType);

	if ( multi > 1 ) then 
		output = GREEN_FONT_COLOR_CODE..math.floor(baseDamage * multi)..FONT_COLOR_CODE_CLOSE;
		if (ENABLE_COLORBLIND_MODE == 1) then
			output = output.."|Tinterface\\petbattles\\battlebar-abilitybadge-strong-small:0|t";
		end
		return output;
	elseif ( multi < 1 ) then 
		output = RED_FONT_COLOR_CODE..math.floor(baseDamage * multi)..FONT_COLOR_CODE_CLOSE;
		if (ENABLE_COLORBLIND_MODE == 1) then
			output = output.."|Tinterface\\petbattles\\battlebar-abilitybadge-weak-small:0|t";
		end
		return output;
	end
	
	return math.floor(baseDamage);
end

local function FormatHealingHelper(baseHeal, healingDone, healingTaken)
	local output = "";

	local doneMulti = (healingDone / 100)
	local takenMulti = (healingTaken / 100);
	
	local finalHeal = baseHeal + baseHeal * doneMulti;
	finalHeal = finalHeal + finalHeal * takenMulti;

	local finalMulti = finalHeal / baseHeal;

	if ( finalMulti > 1 ) then 
		output = GREEN_FONT_COLOR_CODE..math.floor(baseHeal * finalMulti)..FONT_COLOR_CODE_CLOSE;
		if (ENABLE_COLORBLIND_MODE == 1) then
			output = output.."|Tinterface\petbattles\battlebar-abilitybadge-strong-small:0|t";
		end
		return output;
	elseif( finalMulti < 1 ) then 
		output = RED_FONT_COLOR_CODE..math.floor(baseHeal * finalMulti)..FONT_COLOR_CODE_CLOSE;
		if (ENABLE_COLORBLIND_MODE == 1) then
			output = output.."|Tinterface\petbattles\battlebar-abilitybadge-weak-small:0|t";
		end
		return output;
	end

	return math.floor(baseHeal);
end

--Aliases
parserEnv.OnlyInBattle = function(text) if ( parserEnv.isInBattle() ) then return text else return ""; end end;
parserEnv.School = function(abilityID) return parserEnv.petTypeName(parserEnv.abilityPetType(abilityID)); end;
parserEnv.SumStates = function(stateID, target)
	if ( parserEnv.unitPetType(target) == 7 ) then --Elementals aren't affected by weathers.
		return parserEnv.unitState(stateID, target) + parserEnv.padState(stateID, target);
	else
		return parserEnv.unitState(stateID, target) + parserEnv.padState(stateID, target) + parserEnv.weatherState(stateID);
	end
end;


--Attack aliases
parserEnv.AttackBonus = function() return (1 + 0.05 * parserEnv.unitPower()); end;
parserEnv.SimpleDamage = function(...) return parserEnv.points(...) * parserEnv.AttackBonus(); end;
parserEnv.StandardDamage = function(...)
	local turnIndex, effectIndex, abilityID = ...;
	return parserEnv.FormatDamage(parserEnv.SimpleDamage(...), abilityID);
end;
parserEnv.FormatDamage = function(baseDamage, abilityID)
	if ( parserEnv.isInBattle() and parserEnv.abilityHasHints(abilityID) ) then
		return FormatDamageHelper(baseDamage, parserEnv.abilityPetType(abilityID), parserEnv.unitPetType(parserEnv.AFFECTED));
	else
		return parserEnv.floor(baseDamage);
	end
end;

--Healing aliases
parserEnv.HealingBonus = function() return (1 + 0.05 * parserEnv.unitPower()); end;
parserEnv.SimpleHealing = function(...) return parserEnv.points(...) * parserEnv.HealingBonus(); end;
parserEnv.StandardHealing = function(...)
	return parserEnv.FormatHealing(parserEnv.SimpleHealing(...));
end;
parserEnv.FormatHealing = function(baseHealing)
	if ( parserEnv.isInBattle() ) then
		return FormatHealingHelper(baseHealing, parserEnv.SumStates(65), parserEnv.SumStates(66));
	else
		return parserEnv.floor(baseHealing);
	end
end;

--Don't allow designers to accidentally change the environment
local safeEnv = {};
setmetatable(safeEnv, { __index = parserEnv, __newindex = function() end });

function WoWkemon_ParseExpression(expression)
	--Load the expression, chopping off the [] on the side.
	local expr = loadstring("return ("..string.sub(expression, 2, -2)..")");
	if ( expr ) then
		--Set the environment up to restrict functions
		setfenv(expr, safeEnv);

		--Don't let designer errors cause us to stop execution
		local success, repl = pcall(expr);
		if ( success ) then
			if ( type(repl) == "number" ) then
				return math.floor(repl);	--We don't want to display any decimals.
			else
				return repl or "";
			end
		elseif ( IsGMClient() ) then
			local err = string.match(repl, ":%d+: (.*)");
			return "[DATA ERROR: "..err.."]";
		else
			return "DATA ERROR";
		end
	else
		return "PARSING ERROR";
	end
end
function WoWkemon_ParseAndReturn(expression)
	--Load the expression, chopping off the [] on the side.
	local expr = loadstring("return "..expression);
	if ( expr ) then
		--Set the environment up to restrict functions
		setfenv(expr, safeEnv);

		--Don't let designer errors cause us to stop execution
		local success, repl = pcall(expr);
		if ( success ) then
			if ( type(repl) == "number" ) then
				return math.floor(repl);	--We don't want to display any decimals.
			else
				return repl or "";
			end
		elseif ( IsGMClient() ) then
			local err = string.match(repl, ":%d+: (.*)");
			return "[DATA ERROR: "..err.."]";
		else
			local err = string.match(repl, ":%d+: (.*)");
			error(err)
			return "DATA ERROR";
		end
	else
		return "PARSING ERROR";
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