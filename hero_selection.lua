BotList = {"npc_dota_hero_nevermore",
			"npc_dota_hero_drow_ranger",
			"npc_dota_hero_drow_ranger",
			"npc_dota_hero_drow_ranger",
			"npc_dota_hero_crystal_maiden",}

function Think()


	if ( GetTeam() == TEAM_RADIANT )
	then
		print( "selecting radiant" );

    local IDs=GetTeamPlayers(GetTeam());
		for i,id in pairs(IDs) do
			if IsPlayerBot(id) then
				SelectHero(id,BotList[i]);
			end
		end

	elseif ( GetTeam() == TEAM_DIRE )
	then
		print( "selecting dire" );


		local IDs=GetTeamPlayers(GetTeam());
		for i,id in pairs(IDs) do
			if IsPlayerBot(id) then
				SelectHero(id,BotList[2]);
			end
		end

	end
end
