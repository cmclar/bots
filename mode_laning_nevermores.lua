function GetDesire()
end

function OnStart()
  --unit:ActionPush_MoveToLocation(-4380, -3900, 0);
end

function OnEnd()
end

--------------------------------------------------------------------------------

local fountainLocation = Vector(-5923.0, -5337.0, 384.0);
local fountainRadius = 400.0;
local riverLocation = Vector(-4380, -3900, 0);

--------------------------------------------------------------------------------

function Think()
  local npcBot = GetBot();

  local angle = math.rad(math.fmod(npcBot:GetFacing()+30, 360)); -- Calculate next position's angle
  local newLocation = Vector(fountainLocation.x+fountainRadius*math.cos(angle), fountainLocation.y+fountainRadius*math.sin(angle), fountainLocation.z);
  npcBot:Action_MoveToLocation(riverLocation);
  DebugDrawLine(fountainLocation, newLocation, 255, 0, 0);

end
