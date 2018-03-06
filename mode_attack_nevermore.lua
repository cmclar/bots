function Think()
  local function DoLastHitThink(creeps, unit)
    -- do laning/last hit/deny
    for _, creep in ipairs(creeps) do
      if creep:GetHealth() < unit:GetAttackDamage() and (creep:GetTeam() == bit.bxor(GetTeam(), 1)
          or #creep:GetNearbyHeroes(1300, true)) then
        unit.lastInput[1] = DotaTime() / 3600

      unit:ActionPush_MoveToLocation(creep:GetLocation())
      unit:ActionPush_AttackUnit(creep, true)
      end
    end
  end
end
