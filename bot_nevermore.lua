
--------------------------------------------------------------------------------

local oldLoc = Vector(0,0,0);
local abilitiesToLevel = {
	"nevermore_necromastery";
	"nevermore_shadowraze1";
	"nevermore_shadowraze1";
	"nevermore_necromastery";
	"nevermore_shadowraze1";
	"nevermore_necromastery";
	"nevermore_shadowraze1";
	"nevermore_necromastery";
	"nevermore_requiem";
	"nevermore_dark_lord";
	"nevermore_requiem";
	"nevermore_dark_lord";
	"nevermore_dark_lord";
	"nevermore_dark_lord";
	"nevermore_requiem";
			};

local tableItemsToBuy = {
	"item_circlet";
  "item_slippers";
  "item_recipe_wraith_band";
	"item_bottle";
	"item_boots";
	"item_ring_of_aquila";
	"item_boots_of_elves";
	"item_gloves";
	"item_shadow_blade";
	"item_hurricane_pike";
	"item_black_king_bar";
	"item_ultimate_orb";
	"item_recipe_silver_edge";
	"item_ultimate_scepter";
	"item_satanic";
	"item_moon_shard";
		  };

local itemcount = 1;

local hpDelta = nil;
local prevHealth = 550;
local secondTime = 0;
local moveTime = 0;
local lowesthp = 550;

--------------------------------------------------------------------------------

function Think()
    local npcBot = GetBot();
    local creepCount = 0;

    Leveling(npcBot);

    ItemLogic(npcBot);

    QueryMove(npcBot);

    QueryAttack(npcBot);

		QueryDeny(npcBot);

end

--------------------------------------------------------------------------------

function Leveling(npcBot)
  local abilityPoints = npcBot:GetAbilityPoints();
  local nextAbility = abilitiesToLevel[1];
  if abilityPoints > 0 then
    npcBot:ActionImmediate_LevelAbility(nextAbility);
    table.remove( abilitiesToLevel, 1 );
  end
end

--------------------------------------------------------------------------------

function ItemLogic(npcBot)
  local sNextItem = tableItemsToBuy[1];
  if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
  then
    npcBot:ActionImmediate_PurchaseItem( sNextItem );
    table.remove( tableItemsToBuy, 1 );
  end

  local courierAvail = IsCourierAvailable();
  local courier = GetCourier(0);

  if npcBot:GetStashValue() > 0 and courier:DistanceFromFountain() == 0 then
    npcBot:ActionImmediate_Courier( courier, COURIER_ACTION_TAKE_AND_TRANSFER_ITEMS );
  end
end

--------------------------------------------------------------------------------

function QueryMove(npcBot)
  local midLoc = GetLaneFrontLocation( TEAM_RADIANT, LANE_MID, -150 );
  if DotaTime() > moveTime or DotaTime() < 0 then  -- or npcBot:WasRecentlyDamagedByCreep(0.3)
    oldLoc = midLoc;
    npcBot:Action_MoveToLocation(midLoc);
		moveTime = DotaTime() + 1;
  end

  DebugDrawLine(npcBot:GetLocation(), midLoc, 255, 0, 0);
end

--------------------------------------------------------------------------------

function QueryAttack(npcBot)
  local weakest_creep = nil;
  local gameTime = DotaTime();

  for _,creep in pairs(npcBot:GetNearbyLaneCreeps(1600, true)) do
    local creep_hp = creep:GetHealth();
    if weakest_creep == nil then
       weakest_creep = creep;
    end
    if creep:GetHealth() <= weakest_creep:GetHealth() then
        weakest_creep = creep;
        if gameTime >= secondTime then
          if prevHealth ~= nil then
            hpDelta = prevHealth - creep:GetHealth();
          end
          secondTime = gameTime + 1;
          prevHealth = creep:GetHealth();
        end
    end
  end

  if weakest_creep ~= nil then
		DebugDrawLine(npcBot:GetLocation(), weakest_creep:GetLocation(), 0, 255, 0);
		if weakest_creep:GetHealth() < (npcBot:GetAttackDamage() + hpDelta * npcBot:GetSecondsPerAttack() + hpDelta * (GetUnitToUnitDistance( npcBot, weakest_creep ) / npcBot:GetAttackProjectileSpeed())) then
      npcBot:Action_AttackUnit(weakest_creep, true);
      prevHealth = nil;
    end
  end
end

--------------------------------------------------------------------------------

function QueryDeny(npcBot)
  local weakest_creep = nil;
  local gameTime = DotaTime();

  for _,creep in pairs(npcBot:GetNearbyLaneCreeps(1600, false)) do
    local creep_hp = creep:GetHealth();
    --(npcBot:GetLocation(), creep:GetLocation(), 0, 255, 255);
    if weakest_creep == nil then
       weakest_creep = creep;
    end
    if creep:GetHealth() <= weakest_creep:GetHealth() then
        weakest_creep = creep;
        if gameTime >= secondTime then
          if prevHealth ~= nil then
            hpDelta = prevHealth - creep:GetHealth();
          end
          secondTime = gameTime + 1;
          prevHealth = creep:GetHealth();
        end
    end
  end

  if weakest_creep ~= nil then
		DebugDrawLine(npcBot:GetLocation(), weakest_creep:GetLocation(), 0, 0, 255);
    if weakest_creep:GetHealth() < (npcBot:GetAttackDamage() + hpDelta * npcBot:GetSecondsPerAttack() + hpDelta * (GetUnitToUnitDistance( npcBot, weakest_creep ) / npcBot:GetAttackProjectileSpeed())) then
      npcBot:Action_AttackUnit(weakest_creep, true);
      prevHealth = nil;
    end
  end
end



--------------------------------------------------------------------------------
