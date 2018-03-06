local tableItemsToBuy = {
	"item_tango";
	"item_wraith_band";
	"item_bottle";
	"item_boots"; --treads
	"item_ring_of_aquila";
	"item_boots_of_elves"; --treads
	"item_gloves";  --treads
	"item_shadow_blade";  --silver
	"item_hurricane_pike";
	"item_black_king_bar";
	"item_ultimate_orb";  --silver
	"item_recipe_silver_edge";  --silver
	"item_ultimate_scepter";
	"item_satanic";
	"item_moon_shard";
			};


----------------------------------------------------------------------------------------------------

function ItemPurchaseThink()

	local npcBot = GetBot();

	if ( #tableItemsToBuy == 0 )
	then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end

	local sNextItem = tableItemsToBuy[1];

	npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );

	if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
	then
		npcBot:ActionImmediate_PurchaseItem( sNextItem );
		table.remove( tableItemsToBuy, 1 );
	end

end
