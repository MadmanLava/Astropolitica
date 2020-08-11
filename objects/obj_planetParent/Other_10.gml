/// @desc Daily Update
if(owner == pointer_null or type == "Gas Giant")
{
	exit;
}
daysSinceSettlement++;

#region Precalculations
if(global.currentDay == 20)
{
	#region Reset Upkeep
	
	var z = 0;

	///Income
	var asize = ds_map_size(upkeep);
	var s = ds_map_find_first(upkeep);
	for(z = 0; z < asize; z++)
	{
		ds_map_set(upkeep, s, 0);
		s = ds_map_find_next(upkeep, s);
	}

	#endregion
}
else if(global.currentDay == 21)
{
	#region Population
	maxPopulation = baseMaxPop*(1 + (0.1 * urbanLevel) + owner.popGrowthBonus);
	happiness = 0.25 + owner.popHappinessBonus;
	if(happiness > 5)
	{
		happiness = 5;
	}
	
	popRatio = (population/maxPopulation);
	var growthFactor = ((maxPopulation - population) / maxPopulation);
	growthFactor = growthRate * growthFactor;
	growthFactor = happiness * growthFactor;

	population += (population * growthFactor) * popFoodUpkeepPenalty;
	
	#region Calculate Upkeep
	popFoodUpkeep = (population/500);
	popCGUpkeep = (population/1000);

	upkeep[? "food"] = popFoodUpkeep / (1 + owner.popUpkeepBonus);
	upkeep[? "consumerGoods"] = popCGUpkeep / (1 + owner.popUpkeepBonus);
	#endregion
	
	#endregion
	
}
else if(global.currentDay == 22)
{
	#region Immigration Willingness
	if((population/maxPopulation) > 0.001 and daysSinceSettlement > 30)
	{
		colonists = population/50;
	}
	else
	{
		colonists = 0;
	}
		
	if(is_undefined(ds_priority_find_priority(owner.colonistPriority, id)))
	{
		ds_priority_add(owner.colonistPriority, id, colonists);
	}
	else
	{
		ds_priority_change_priority(owner.colonistPriority, id, colonists);
	}
	
	#endregion
	
}
else if(global.currentDay == 23)
{
	#region Industrial Production
	if(alloyLevel > 0)
	{
		resources[? "alloys"] = 3 * (1 + 0.5 * alloyLevel);
		
		upkeep[? "energy"] += alloyLevel*1.5;
		upkeep[? "metal"] += alloyLevel;
		upkeep[? "rareElements"] += alloyLevel/2
		upkeep[? "gas"] += alloyLevel/2;
	}
	if(cgLevel > 0)
	{
		resources[? "consumerGoods"] = 3 * (1 + 0.5 * cgLevel);
		
		upkeep[? "energy"] += cgLevel;
		upkeep[? "metal"] += cgLevel/4;
		upkeep[? "rareElements"] += cgLevel/4;
		upkeep[? "gas"] += cgLevel/4;
		upkeep[? "crystal"] += cgLevel/4;
	}
	if(nanoLevel > 0)
	{
		resources[? "nanotech"] = 1 * (1 + 0.5 * nanoLevel);
		
		upkeep[? "energy"] += nanoLevel*2;
		upkeep[? "metal"] += nanoLevel*2;
		upkeep[? "rareElements"] += nanoLevel;
		upkeep[? "gas"] += nanoLevel/4;
		upkeep[? "crystal"] += nanoLevel/2;
	}
	if(acLevel > 0)
	{
		resources[? "advancedComponents"] = 2 * (1 + 0.5 * acLevel);
		
		upkeep[? "energy"] += acLevel*1.75;
		upkeep[? "metal"] += acLevel*1.5;
		upkeep[? "rareElements"] += acLevel;
		upkeep[? "crystal"] += acLevel;
		upkeep[? "nanotech"] += acLevel/5;
	}
	
	#endregion
}
else if(global.currentDay == 24)
{
	#region Productivity Calculation
	if(population > 0)
	{
		var happyFactor = (0.5 - happiness);
		var crimeFactor = (0.05 * (crime * 10));
		var popFactor = (0.05 * (popRatio * 10));
	
		baseProductivity = (0.5 - happyFactor - crimeFactor + popFactor + (0.1 * infraLevel));
		baseProductivity = clamp(baseProductivity, 0.1, 5);
			
		var powerProduc = baseProductivity + (0.15 * powerLevel);
		var miningProduc = baseProductivity + (0.15 * miningLevel);
		var agriProduc = baseProductivity + (0.3 * agriLevel);
		var urbanProduc = baseProductivity + (0.15 * urbanLevel);
			
		productivity[? "energy"] = powerProduc;
		productivity[? "metal"] = miningProduc;
		productivity[? "rareElements"] = miningProduc;
		productivity[? "gas"] = miningProduc;
		productivity[? "crystal"] = miningProduc;
		productivity[? "radioactives"] = miningProduc;
		productivity[? "food"] = agriProduc;

		productivity[? "alloys"] = urbanProduc;
		productivity[? "consumerGoods"] = urbanProduc;
		productivity[? "nanotech"] = urbanProduc;
		productivity[? "advancedComponents"] = urbanProduc;
	}
	else
	{
		baseProductivity = 0;
	}
	#endregion
}

#endregion