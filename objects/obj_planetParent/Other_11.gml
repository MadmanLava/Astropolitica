/// @desc Final Monthly Step

if(owner == pointer_null or type != "Gas Giant")
{
	exit;
}

#region Industry Upkeep

	#region Alloys
	if(alloyLevel > 0)
	{
		resources[? "alloys"] = (2 * alloyLevel);
		
		upkeep[? "energy"] += alloyLevel*1.5;
		upkeep[? "metal"] += alloyLevel;
		upkeep[? "rareElements"] += alloyLevel/2
		upkeep[? "gas"] += alloyLevel/2;
	}
	
	#endregion
	
	#region Consumer Goods
	if(cgLevel > 0)
	{
		resources[? "consumerGoods"] = (5 * (1 + (0.2 * cgLevel)));
		
		upkeep[? "energy"] += cgLevel;
		upkeep[? "metal"] += cgLevel/4;
		upkeep[? "rareElements"] += cgLevel/4;
		upkeep[? "gas"] += cgLevel/4;
		upkeep[? "crystal"] += cgLevel/4;
	}
	
	#endregion
	
	#region Nanotech
	if(nanoLevel > 0)
	{
		resources[? "nanotech"] = (1 + (0.2 * nanoLevel));
		
		upkeep[? "energy"] += nanoLevel*2;
		upkeep[? "metal"] += nanoLevel*2;
		upkeep[? "rareElements"] += nanoLevel;
		upkeep[? "gas"] += nanoLevel/4;
		upkeep[? "crystal"] += nanoLevel/2;
	}
	
	#endregion
	
	#region Advanced Components
	if(acLevel > 0)
	{
		resources[? "advancedComponents"] = (1 + (0.2 * acLevel));
		
		upkeep[? "energy"] += acLevel*1.75;
		upkeep[? "metal"] += acLevel*1.5;
		upkeep[? "rareElements"] += acLevel;
		upkeep[? "crystal"] += acLevel;
		upkeep[? "nanotech"] += acLevel/5;
	}
	
	#endregion
	
#endregion

#region Event Checks


#endregion