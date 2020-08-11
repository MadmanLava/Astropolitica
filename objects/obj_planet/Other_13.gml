/// @desc Full Monthly Update
if(owner == pointer_null or type == "Gas Giant")
{
	exit;
}

#region Reset Upkeep
upkeep[? "energy"] = 0;
upkeep[? "metal"] = 0;
upkeep[? "rareElements"] = 0;
upkeep[? "gas"] = 0;
upkeep[? "crystal"] = 0;
upkeep[? "radioactives"] = 0;
upkeep[? "food"] = 0;
	
upkeep[? "alloys"] = 0;
upkeep[? "consumerGoods"] = 0;
upkeep[? "nanotech"] = 0;
upkeep[? "advancedComponents"] = 0;
#endregion

#region Population
maxPopulation = baseMaxPop*(1 + (0.1 * urbanLevel));
	
popRatio = (population/maxPopulation);
var growthFactor = ((maxPopulation - population) / maxPopulation);
growthFactor = growthRate * growthFactor;
growthFactor = happiness * growthFactor;

population += (population * growthFactor) * popFoodUpkeepPenalty;
	
#endregion

#region Calculate Upkeep
popFoodUpkeep = (population/500);
popCGUpkeep = (population/500);

upkeep[? "food"] += popFoodUpkeep;
upkeep[? "consumerGoods"] += popCGUpkeep;
#endregion

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
	var agriProduc = baseProductivity + (0.15 * agriLevel);
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

#region Industry

	#region Alloys
	if(alloyLevel > 0)
	{
		resources[? "alloys"] = 3 * (1 + 0.5 * alloyLevel);
		
		upkeep[? "energy"] += alloyLevel*1.5;
		upkeep[? "metal"] += alloyLevel;
		upkeep[? "rareElements"] += alloyLevel/2
		upkeep[? "gas"] += alloyLevel/2;
	}
	
	#endregion
	
	#region Consumer Goods
	if(cgLevel > 0)
	{
		resources[? "consumerGoods"] = 4 * (1 + 0.5 * cgLevel);
		
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
		resources[? "nanotech"] = 1 * (1 + 0.5 * nanoLevel);
		
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
		resources[? "advancedComponents"] = 2 * (1 + 0.5 * acLevel);
		
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