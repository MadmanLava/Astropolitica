/// @desc Full Monthly Update
if(owner == pointer_null)
{
	exit;
}

#region Population Pull
	
	#region Reset
	population = 0;
	maxPopulation = 0;
	growthRate = 0;
	happiness = 0;
	crime = 0;
	rockyCount = 0;
	
	colonists = 0;
	
	#endregion
	
	var i = 0;
	repeat(planetCount)
	{
		var targetPlanet = ds_list_find_value(planetList, i);
		if(targetPlanet.type == "Gas Giant")
		{
			
			i++;
			continue;
		}
		
		population += targetPlanet.population;
		maxPopulation += targetPlanet.maxPopulation;
		colonists += targetPlanet.colonists;
		
		growthRate += targetPlanet.growthRate;
		happiness += targetPlanet.happiness;
		crime += targetPlanet.crime;
		rockyCount++;
		
		i++;
	}
	
	#region Averages
	if(rockyCount > 0)
	{
		growthRate = growthRate/rockyCount;
		happiness = happiness/rockyCount;
		crime = crime/rockyCount;
	}
	
	#endregion
	
	#endregion
	
#region Value Pull
	
	var ownerValue = owner.value;
	ds_map_copy(value, ownerValue);
	
	#endregion

#region Economic Pull
	
	#region Reset
	var z = 0;

	///Income
	var asize = ds_map_size(income);
	var s = ds_map_find_first(income);
	for(z = 0; z < asize; z++)
	{
		ds_map_set(income, s, 0);
		s = ds_map_find_next(income, s);
	}

	///Upkeep
	asize = ds_map_size(upkeep);
	s = ds_map_find_first(upkeep);
	for(z = 0; z < asize; z++)
	{
		ds_map_set(upkeep, s, 0);
		s = ds_map_find_next(upkeep, s);
	}
	
	///Desired Resources
	asize = ds_map_size(desired);
	s = ds_map_find_first(desired);
	for(z = 0; z < asize; z++)
	{
		ds_map_set(desired, s, 0);
		s = ds_map_find_next(desired, s);
	}
	
	#endregion
	
	var i = 0;
	repeat(planetCount)
	{
		var targetPlanet = ds_list_find_value(planetList, i);
		if(targetPlanet.type == "Gas Giant")
		{
			income[? "gas"] += targetPlanet.resources[? "gas"];
		}
		else
		{
			var natRes = targetPlanet.resources;
			var tUpkeep = targetPlanet.upkeep;
			var produc = targetPlanet.productivity;
			
			#region Income
			income[? "energy"] += (natRes[? "energy"] * produc[? "energy"]);
			income[? "metal"] += (natRes[? "metal"] * produc[? "metal"]);
			income[? "rareElements"] += (natRes[? "rareElements"] * produc[? "rareElements"]);
			income[? "gas"] += (natRes[? "gas"] * produc[? "gas"]);
			income[? "crystal"] += (natRes[? "crystal"] * produc[? "crystal"]);
			income[? "radioactives"] += (natRes[? "radioactives"] * produc[? "radioactives"]);
			income[? "food"] += (natRes[? "food"] * produc[? "food"]) + 0.1;
	
			income[? "alloys"] += (natRes[? "alloys"] * produc[? "alloys"]);
			income[? "consumerGoods"] += (natRes[? "consumerGoods"] * produc[? "consumerGoods"]);
			income[? "nanotech"] += (natRes[? "nanotech"] * produc[? "nanotech"]);
			income[? "advancedComponents"] += (natRes[? "advancedComponents"] * produc[? "advancedComponents"]);
			#endregion
			
			#region Upkeep
			upkeep[? "energy"] += tUpkeep[? "energy"];
			upkeep[? "metal"] += tUpkeep[? "metal"];
			upkeep[? "rareElements"] += tUpkeep[? "rareElements"];
			upkeep[? "gas"] += tUpkeep[? "gas"];
			upkeep[? "crystal"] += tUpkeep[? "crystal"];
			upkeep[? "radioactives"] += tUpkeep[? "radioactives"];
			upkeep[? "food"] += tUpkeep[? "food"];
			
			upkeep[? "alloys"] += tUpkeep[? "alloys"];
			upkeep[? "consumerGoods"] += tUpkeep[? "consumerGoods"];
			upkeep[? "nanotech"] += tUpkeep[? "nanotech"];
			upkeep[? "advancedComponents"] += tUpkeep[? "advancedComponents"];
			#endregion
			
		}
		i++;
	}
	
	#endregion

#region Spaceborne Production

	#region Dyson Array
	if(dysonLevel > 0)
	{
		//Production
		dysonEnergy = (luminosity * dysonLevel);
		dysonGas = (((wind + size)/2) * dysonLevel);
	
		income[? "energy"] += dysonEnergy;
		income[? "gas"] += dysonGas;
	}
	else
	{
		dysonEnergy = 0;
		dysonGas = 0;
	}
	#endregion

	#region Mining
	if(miningLevel > 0)
	{
		if(asteroidBelt)
		{
			var tempAst = 2;
		}
		else
		{
			var tempAst = 1;
		}
		//Production
		miningMetal = (asteroidDensity * miningLevel * (metal/3)) * tempAst;
		miningRE = ((asteroidDensity * miningLevel * (rareElements/3)) * tempAst)/2;
		miningRadio = ((asteroidDensity * miningLevel * (radioactives/3)) * tempAst)/10;
	
		income[? "metal"] += miningMetal;
		income[? "rareElements"] += miningRE;
		income[? "radioactives"] += miningRadio;
	}
	else
	{
		miningMetal = 0;
		miningRE = 0;
		miningRadio = 0;
	}
	#endregion

	#region Exotic
	if(exoticLevel > 0)
	{
		if(type == "Neutron Star")
		{
			exoticNeutron = 0;
			income[? "neutronium"] = 0;
		}
		else if(type == "Class E")
		{
			exoticError = 0;
			income[? "erronogen"] = 0;
		}
	}
	else
	{
		exoticNeutron = 0;
		exoticError = 0;
	}
	#endregion

#endregion
	
#region Upkeep

	#region System
	if(type != "Neutron Star" and type != "Black Hole" and type != "Supermassive Black Hole")
	{
		var baseEnergy = 1;
		var baseFood = 0;
	}
	else
	{
		var baseEnergy = 0;
		var baseFood = 0;
	}

	#endregion

	#region Shipyard
	if(shipyardLevel > 0)
	{
		//Upkeep
		shipyardEnergyUpkeep = shipyardLevel*4;
		shipyardMetalUpkeep = shipyardLevel*2;
		shipyardREUpkeep = shipyardLevel/2;
		shipyardGasUpkeep = shipyardLevel;
		shipyardFoodUpkeep = shipyardLevel/10;
	
		income[? "energy"] -= shipyardEnergyUpkeep;
		income[? "metal"] -= shipyardMetalUpkeep;
		income[? "rareElements"] -= shipyardREUpkeep;
		income[? "gas"] -= shipyardGasUpkeep;
		income[? "food"] -= shipyardFoodUpkeep;
	}
	else
	{
		shipyardEnergyUpkeep = 0;
		shipyardMetalUpkeep = 0;
		shipyardREUpkeep = 0;
		shipyardGasUpkeep = 0;
		shipyardFoodUpkeep = 0;
	}
	#endregion

	#region Dyson Array
	if(dysonLevel > 0)
	{
		dysonCrystalUpkeep = dysonLevel/5;
		dysonFoodUpkeep = dysonLevel/10;
	
		income[? "crystal"] -= dysonCrystalUpkeep;
		income[? "food"] -= dysonFoodUpkeep;
	}
	else
	{
		dysonCrystalUpkeep = 0;
		dysonFoodUpkeep = 0;
	}
	#endregion

	#region Mining
	if(miningLevel > 0)
	{
		miningEnergyUpkeep = miningLevel;
		miningGasUpkeep = miningLevel/5;
		miningFoodUpkeep = miningLevel/10;
	
		income[? "energy"] -= miningEnergyUpkeep;
		income[? "gas"] -= miningGasUpkeep;
		income[? "food"] -= miningFoodUpkeep;
	
	}
	else
	{
		miningEnergyUpkeep = 0;
		miningGasUpkeep = 0;
		miningFoodUpkeep = 0;
	}
	#endregion

	#region Exotic

	#endregion
	
	#region Apply
	upkeep[? "energy"] += shipyardEnergyUpkeep + miningEnergyUpkeep + baseEnergy;
	upkeep[? "metal"] += shipyardMetalUpkeep;
	upkeep[? "rareElements"] += shipyardREUpkeep;
	upkeep[? "gas"] += shipyardGasUpkeep + miningGasUpkeep;
	upkeep[? "crystal"] += dysonCrystalUpkeep;
	upkeep[? "radioactives"] += 0;
	upkeep[? "food"] += shipyardFoodUpkeep + miningFoodUpkeep + dysonFoodUpkeep + baseFood;
	upkeep[? "neutronium"] += 0;
	upkeep[? "erronogen"] += 0;
	
	upkeep[? "alloys"] += 0;
	upkeep[? "consumerGoods"] += 0;
	upkeep[? "nanotech"] += 0;
	upkeep[? "advancedComponents"] += 0;
	
	#endregion

	#endregion
	
#region Apply Income
	var z = 0;

	///Income
	var asize = ds_map_size(income);
	var s = ds_map_find_first(income);
	var e = ds_map_find_first(upkeep);
	for(z = 0; z < asize; z++)
	{
		income[? s] -= upkeep[? e];
		s = ds_map_find_next(income, s);
		e = ds_map_find_next(upkeep, e);
	}
	
	#endregion

#region Calculate Stockpile
stockpile[? "energy"] += income[? "energy"];
stockpile[? "metal"] += income[? "metal"];
stockpile[? "rareElements"] += income[? "rareElements"];
stockpile[? "gas"] += income[? "gas"];
stockpile[? "crystal"] += income[? "crystal"];
stockpile[? "radioactives"] += income[? "radioactives"];
stockpile[? "food"] += income[? "food"];

stockpile[? "alloys"] += income[? "alloys"];
stockpile[? "consumerGoods"] += income[? "consumerGoods"];
stockpile[? "nanotech"] += income[? "nanotech"];
stockpile[? "advancedComponents"] += income[? "advancedComponents"];

stockpile[? "neutronium"] += income[? "neutronium"];
stockpile[? "erronogen"] += income[? "erronogen"];

#region Clamp values
var clampTarget = ds_map_find_first(stockpile);
if(ds_map_find_value(stockpile, clampTarget) < 0)
{
	ds_map_set(stockpile, clampTarget, 0)
}
repeat(ds_map_size(stockpile)-1)
{
	clampTarget = ds_map_find_next(stockpile, clampTarget);
	if(ds_map_find_value(stockpile, clampTarget) < 0)
	{
		ds_map_set(stockpile, clampTarget, 0)
	}
}
#endregion

#endregion

#region Upkeep Consequences
var popUpkeepPenalty = 0;

if(stockpile[? "food"] == 0)
{
	popUpkeepPenalty = 0;

	var i = 0;
	repeat(planetCount)
	{
		var targetPlanet = ds_list_find_value(planetList, i);
		
		targetPlanet.popFoodUpkeepPenalty = popUpkeepPenalty;
		
		i++;
	}
}
else
{
	var i = 0;
	repeat(planetCount)
	{
		var targetPlanet = ds_list_find_value(planetList, i);
		
		targetPlanet.popFoodUpkeepPenalty = 1;
		
		i++;
	}
}

#endregion

#region Determine Quotas

//if(type != "Neutron Star" and type != "Black Hole" and type != "Supermassive Black Hole")
//{

#region Income

	#region Energy
	incomeQuota[? "energy"] = upkeep[? "energy"] * (1 + (0.5 * shipyardLevel) + (0.25 * miningLevel)) - value[? "energy"];
	clamp(incomeQuota[? "energy"], 1, 10000);
	
	#endregion
	
	#region Metal
	incomeQuota[? "metal"] = 1 + (upkeep[? "metal"] * 2) * (1 + (0.5 * shipyardLevel)) - value[? "metal"];
	
	#endregion
	
	#region Rare Elements
	incomeQuota[? "rareElements"] = 1 + (upkeep[? "rareElements"] * 2) * (1 + (0.5 * shipyardLevel)) - value[? "rareElements"];
	
	#endregion
	
	#region Gas
	incomeQuota[? "gas"] = 1 + (upkeep[? "gas"] * 2) * (1 + (0.15 * miningLevel)) - value[? "gas"];
	
	#endregion
	
	#region Crystal
	incomeQuota[? "crystal"] = 1 + (upkeep[? "crystal"] * 2) * (1 + (0.5 * shipyardLevel) + (0.15 * dysonLevel)) - value[? "crystal"];
	
	#endregion
	
	#region Radioactives
	incomeQuota[? "radioactives"] = (upkeep[? "radioactives"] * 1.5) - value[? "radioactives"];
	
	#endregion
	
	#region Food
	incomeQuota[? "food"] = (upkeep[? "food"] * 2) - value[? "food"];
	
	#endregion
	
	#region Alloys
	incomeQuota[? "alloys"] = (upkeep[? "alloys"] * (1 + (0.5 * shipyardLevel))) - value[? "alloys"];
	
	#endregion
	
	#region Consumer Goods
	incomeQuota[? "consumerGoods"] = (upkeep[? "consumerGoods"] * 1.5) - value[? "consumerGoods"];
	
	#endregion
	
	#region Nanotech
	incomeQuota[? "nanotech"] = (upkeep[? "nanotech"] * (1 + (0.15 * shipyardLevel))) - value[? "nanotech"];
	
	#endregion
	
	#region Advanced Components
	incomeQuota[? "advancedComponents"] = (upkeep[? "advancedComponents"] * (1 + (0.5 * shipyardLevel))) - value[? "advancedComponents"];
	
	#endregion

#endregion

#region Stockpile

	#region Energy
	stockQuota[? "energy"] = upkeep[? "energy"] * 5 * (1 + shipyardLevel/2 + miningLevel/4);
	
	#endregion
	
	#region Metal
	stockQuota[? "metal"] = upkeep[? "metal"] * 5 * (1 + shipyardLevel);
	
	#endregion
	
	#region Rare Elements
	stockQuota[? "rareElements"] = upkeep[? "rareElements"] * 5 * (1 + shipyardLevel);
	
	#endregion
	
	#region Gas
	stockQuota[? "gas"] = upkeep[? "gas"] * 5 * (1 + shipyardLevel/2 + miningLevel/2);
	
	#endregion
	
	#region Crystal
	stockQuota[? "crystal"] = upkeep[? "crystal"] * 5 * (1 + shipyardLevel/4 + dysonLevel/2);
	
	#endregion
	
	#region Radioactives
	stockQuota[? "radioactives"] = upkeep[? "radioactives"] * 5 * (1 + miningLevel/4);
	
	#endregion
	
	#region Food
	stockQuota[? "food"] = upkeep[? "food"] * 5;
	
	#endregion
	
	#region Alloys
	stockQuota[? "alloys"] = upkeep[? "alloys"] * 5 * (1 + shipyardLevel);
	
	#endregion
	
	#region Consumer Goods
	stockQuota[? "consumerGoods"] = upkeep[? "consumerGoods"] * 5 * (1 + shipyardLevel/8);
	
	#endregion
	
	#region Nanotech
	stockQuota[? "nanotech"] = upkeep[? "nanotech"] * 5 * (1 + shipyardLevel/4);
	
	#endregion
	
	#region Advanced Components
	stockQuota[? "advancedComponents"] = upkeep[? "advancedComponents"] * 5 * (1 + shipyardLevel/2);
	
	#endregion

#endregion

//}

#endregion

#region Infrastructure Development

if(type != "Neutron Star" and type != "Black Hole" and type != "Supermassive Black Hole")
{

#region Saving
if(infraSavingFor != "")
{
	#region Dyson
	if(infraSavingFor == "dyson")
	{
		var cost = global.dysonCost;
	
		if(
		dysonLevel != 10 and
		stockpile[? "metal"] > (cost[? "metal"] * (dysonLevel + 1)) and 
		stockpile[? "rareElements"] > (cost[? "rareElements"] * (dysonLevel + 1)) and 
		stockpile[? "crystal"] > (cost[? "crystal"] * (dysonLevel + 1))
		)
		{
			stockpile[? "metal"] -= (cost[? "metal"] * (dysonLevel + 1));
			stockpile[? "rareElements"] -= (cost[? "rareElements"] * (dysonLevel + 1));
			stockpile[? "crystal"] -= (cost[? "crystal"] * (dysonLevel + 1));
		
			dysonLevel ++;
			
			
			infraLastAction = "Upgraded Dyson Array";
			infraSavingFor = "";
			quotaDeficiency = false;
		}
		else if(
		(income[? "energy"] > incomeQuota[? "energy"] and
		stockpile[? "energy"] > stockQuota[? "energy"]) and
		(income[? "gas"] > incomeQuota[? "gas"] and
		stockpile[? "gas"] > stockQuota[? "gas"])
		)
		{
			infraSavingFor = "";
			quotaDeficiency = false;
		}
		else
		{
			desired[? "metal"] += (cost[? "metal"] * (dysonLevel + 1)) - stockpile[? "metal"];
			desired[? "rareElements"] += (cost[? "rareElements"] * (dysonLevel + 1)) - stockpile[? "rareElements"];
			desired[? "crystal"] += (cost[? "crystal"] * (dysonLevel + 1)) - stockpile[? "crystal"];
			quotaDeficiency = true;
			//infraLastAction = "Saving for Dyson Array";
		}
	}
	#endregion
	
	#region Mining
	else if(infraSavingFor == "mining")
	{
		var cost = global.miningCost;
		
		if(
		miningLevel != 10 and
		stockpile[? "metal"] > (cost[? "metal"] * (miningLevel + 1)) and
		stockpile[? "rareElements"] > (cost[? "rareElements"] * (miningLevel + 1)) and 
		stockpile[? "gas"] > (cost[? "gas"] * (miningLevel + 1))
		)
		{
			stockpile[? "metal"] -= (cost[? "metal"] * (miningLevel + 1));
			stockpile[? "rareElements"] -= (cost[? "rareElements"] * (miningLevel + 1));
			stockpile[? "gas"] -= (cost[? "gas"] * (miningLevel + 1));
		
			miningLevel ++;
		
			
			infraLastAction = "Upgraded Mining Post";
			infraSavingFor = "";
			quotaDeficiency = false;
		}
		else if(
		(income[? "metal"] > incomeQuota[? "metal"] and
		stockpile[? "metal"] > stockQuota[? "metal"]) and
		(income[? "rareElements"] > incomeQuota[? "rareElements"] and
		stockpile[? "rareElements"] > stockQuota[? "rareElements"]) and
		(income[? "crystal"] > incomeQuota[? "crystal"] and
		stockpile[? "crystal"] > stockQuota[? "crystal"]) and
		(income[? "radioactives"] > incomeQuota[? "radioactives"] and
		stockpile[? "radioactives"] > stockQuota[? "radioactives"])
		)
		{
			infraSavingFor = "";
			quotaDeficiency = false;
		}
		else
		{
			desired[? "metal"] += (cost[? "metal"] * (miningLevel + 1)) - stockpile[? "metal"];
			desired[? "rareElements"] += (cost[? "rareElements"] * (miningLevel + 1)) - stockpile[? "rareElements"];
			desired[? "gas"] += (cost[? "gas"] * (miningLevel + 1)) - stockpile[? "gas"];
			quotaDeficiency = true;
			//infraLastAction = "Saving for Mining Post";
		}
	}
	#endregion
}
else
{

#endregion

	#region Identify most needed resources

	var resQueue = ds_priority_create();
	quotaDeficiency = false;

	#region Energy
	if(income[? "energy"] <= 0)
	{
		ds_priority_add(resQueue, "energy", (3000 + upkeep[? "energy"]));
		quotaDeficiency = true;
	}
	else if(income[? "energy"] < incomeQuota[? "energy"])
	{
		ds_priority_add(resQueue, "energy", (1050 - dysonLevel + upkeep[? "energy"]));
		quotaDeficiency = true;
	}
	else if(stockpile[? "energy"] < stockQuota[? "energy"])
	{
		ds_priority_add(resQueue, "energy", (500 - dysonLevel + upkeep[? "energy"]));
		quotaDeficiency = true;
	}
	else
	{
		ds_priority_add(resQueue, "energy", -1*(stockpile[? "energy"]));
	}
	#endregion

	#region Gas
	if(income[? "gas"] < 0)
	{
		ds_priority_add(resQueue, "gas", (2000 + upkeep[? "gas"]));
		quotaDeficiency = true;
	}
	else if(income[? "gas"] < incomeQuota[? "gas"])
	{
		ds_priority_add(resQueue, "gas", 1000 - dysonLevel + upkeep[? "gas"]);
		quotaDeficiency = true;
	}
	else if(stockpile[? "gas"] < stockQuota[? "gas"])
	{
		ds_priority_add(resQueue, "gas", (500 - dysonLevel + upkeep[? "gas"]));
		quotaDeficiency = true;
	}
	else
	{
		ds_priority_add(resQueue, "gas", -1*(stockpile[? "gas"]));
	}
	#endregion

	#region Metal
	if(income[? "metal"] < 0)
	{
		ds_priority_add(resQueue, "metal", (2000 + upkeep[? "metal"]));
		quotaDeficiency = true;
	}
	else if(income[? "metal"] < incomeQuota[? "metal"])
	{
		ds_priority_add(resQueue, "metal", 1000 - miningLevel + upkeep[? "metal"]);
		quotaDeficiency = true;
	}
	else if(stockpile[? "metal"] < stockQuota[? "metal"])
	{
		ds_priority_add(resQueue, "metal", (500 - miningLevel + upkeep[? "metal"]));
		quotaDeficiency = true;
	}
	else
	{
		ds_priority_add(resQueue, "metal", -1*(stockpile[? "metal"]));
	}
	#endregion

	#region rareElements
	if(income[? "rareElements"] < 0)
	{
		ds_priority_add(resQueue, "rareElements", (2000 + upkeep[? "rareElements"]));
		quotaDeficiency = true;
	}
	else if(income[? "rareElements"] < incomeQuota[? "rareElements"])
	{
		ds_priority_add(resQueue, "rareElements", 1000 - miningLevel/2 + upkeep[? "rareElements"]);
		quotaDeficiency = true;
	}
	else if(stockpile[? "rareElements"] < stockQuota[? "rareElements"])
	{
		ds_priority_add(resQueue, "rareElements", (500 - miningLevel + upkeep[? "rareElements"]));
		quotaDeficiency = true;
	}
	else
	{
		ds_priority_add(resQueue, "rareElements", -1*(stockpile[? "rareElements"]));
	}
	#endregion

	#region Crystal
	if(income[? "crystal"] < 0)
	{
		ds_priority_add(resQueue, "crystal", (2000 + upkeep[? "crystal"]));
		quotaDeficiency = true;
	}
	else if(income[? "crystal"] < incomeQuota[? "crystal"])
	{
		ds_priority_add(resQueue, "crystal", (1000 - miningLevel + upkeep[? "crystal"]));
		quotaDeficiency = true;
	}
	else if(stockpile[? "crystal"] < stockQuota[? "crystal"])
	{
		ds_priority_add(resQueue, "crystal", (500 - miningLevel + upkeep[? "crystal"]));
		quotaDeficiency = true;
	}
	else
	{
		ds_priority_add(resQueue, "crystal", -1*(stockpile[? "crystal"]));
	}
	#endregion

	#region Radioactives
	if(income[? "radioactives"] < 0)
	{
		ds_priority_add(resQueue, "radioactives", (2000 + upkeep[? "radioactives"]));
		quotaDeficiency = true;
	}
	else if(income[? "radioactives"] < incomeQuota[? "radioactives"])
	{
		ds_priority_add(resQueue, "radioactives", 1000 - miningLevel + upkeep[? "radioactives"]);
		quotaDeficiency = true;
	}
	else if(stockpile[? "radioactives"] < stockQuota[? "radioactives"])
	{
		ds_priority_add(resQueue, "radioactives", (500 - miningLevel + upkeep[? "radioactives"]));
		quotaDeficiency = true;
	}
	else
	{
		ds_priority_add(resQueue, "radioactives", -1*(stockpile[? "radioactives"]));
	}
	#endregion

	#region Food
	if(income[? "food"] < 0)
	{
		ds_priority_add(resQueue, "food", (2000 + upkeep[? "food"]));
		quotaDeficiency = true;
	}
	else if(income[? "food"] < incomeQuota[? "food"])
	{
		ds_priority_add(resQueue, "food", (1000 + upkeep[? "food"]));
		quotaDeficiency = true;
	}
	else if(stockpile[? "food"] < stockQuota[? "food"])
	{
		ds_priority_add(resQueue, "food", (500 + upkeep[? "food"]));
		quotaDeficiency = true;
	}
	else
	{
		ds_priority_add(resQueue, "food", -1*(stockpile[? "food"]));
	}
	#endregion

	#region Alloys
	if(income[? "alloys"] < 0)
	{
		ds_priority_add(resQueue, "alloys", (2000 + upkeep[? "alloys"]));
		quotaDeficiency = true;
	}
	else if(income[? "alloys"] < incomeQuota[? "alloys"])
	{
		ds_priority_add(resQueue, "alloys", (1000 + upkeep[? "alloys"]));
		quotaDeficiency = true;
	}
	else if(stockpile[? "alloys"] < stockQuota[? "alloys"])
	{
		ds_priority_add(resQueue, "alloys", (500 + upkeep[? "alloys"]));
		quotaDeficiency = true;
	}
	else
	{
		ds_priority_add(resQueue, "alloys", -1*(stockpile[? "alloys"]));
	}
	#endregion

	#region Consumer Goods
	if(income[? "consumerGoods"] < 0)
	{
		ds_priority_add(resQueue, "consumerGoods", (2000 + upkeep[? "consumerGoods"]));
		quotaDeficiency = true;
	}
	else if(income[? "consumerGoods"] < incomeQuota[? "consumerGoods"])
	{
		ds_priority_add(resQueue, "consumerGoods", (1000 + upkeep[? "consumerGoods"]));
		quotaDeficiency = true;
	}
	else if(stockpile[? "consumerGoods"] < stockQuota[? "consumerGoods"])
	{
		ds_priority_add(resQueue, "consumerGoods", (500 + upkeep[? "consumerGoods"]));
		quotaDeficiency = true;
	}
	else
	{
		ds_priority_add(resQueue, "consumerGoods", -1*(stockpile[? "consumerGoods"]));
	}
	#endregion

	#region Nanotech
	if(income[? "nanotech"] < 0)
	{
		ds_priority_add(resQueue, "nanotech", (2000 + upkeep[? "nanotech"]));
		quotaDeficiency = true;
	}
	else if(upkeep[? "nanotech"] > incomeQuota[? "nanotech"])
	{
		ds_priority_add(resQueue, "nanotech", 1000 + upkeep[? "nanotech"])
		quotaDeficiency = true;
	}
	else if(stockpile[? "nanotech"] < stockQuota[? "nanotech"])
	{
		ds_priority_add(resQueue, "nanotech", (500 + upkeep[? "nanotech"]));
		quotaDeficiency = true;
	}
	else if(upkeep[? "nanotech"] > 0)
	{
		ds_priority_add(resQueue, "nanotech", upkeep[? "nanotech"]);
	}
	#endregion

	#region Advanced Components
	if(income[? "advancedComponents"] < 0)
	{
		ds_priority_add(resQueue, "advancedComponents", (2000 + upkeep[? "advancedComponents"]));
		quotaDeficiency = true;
	}
	if(income[? "advancedComponents"] < incomeQuota[? "advancedComponents"])
	{
		ds_priority_add(resQueue, "advancedComponents", (1000 + upkeep[? "advancedComponents"]));
		quotaDeficiency = true;
	}
	else if(stockpile[? "advancedComponents"] < stockQuota[? "advancedComponents"])
	{
		ds_priority_add(resQueue, "advancedComponents", (500 + upkeep[? "advancedComponents"]));
		quotaDeficiency = true;
	}
	else
	{
		ds_priority_add(resQueue, "advancedComponents", -1*(stockpile[? "advancedComponents"]));
	}
	#endregion

	#endregion
	
	infraLastAction = "";
	
	#region Actions
	var done = false;
	do
	{
		if(!ds_priority_empty(resQueue))
		{
			var topRes = ds_priority_find_max(resQueue);
			infraDebug = topRes + " " + string(ds_priority_find_priority(resQueue, topRes));
		}
		else
		{
			break;
		}
	
		#region Energy
		if(topRes == "energy")
		{
			var cost = global.dysonCost;
	
			if(
			dysonLevel != 10 and
			stockpile[? "metal"] > (cost[? "metal"] * (dysonLevel + 1)) and 
			stockpile[? "rareElements"] > (cost[? "rareElements"] * (dysonLevel + 1)) and 
			stockpile[? "crystal"] > (cost[? "crystal"] * (dysonLevel + 1))
			)
			{
				stockpile[? "metal"] -= (cost[? "metal"] * (dysonLevel + 1));
				stockpile[? "rareElements"] -= (cost[? "rareElements"] * (dysonLevel + 1));
				stockpile[? "crystal"] -= (cost[? "crystal"] * (dysonLevel + 1));
		
				dysonLevel ++;
				infraLastAction = "Upgrade Dyson Array";
				
				done = true;
			}

			else
			{
				i = 0;
				
				var candidateList = ds_priority_create();
				repeat(planetCount)
				{
					targetPlanet = ds_list_find_value(planetList, i);
					if(targetPlanet.powerLevel < 10 and targetPlanet.population > 0 and targetPlanet.type != "Gas Giant")
					{
						ds_priority_add(candidateList, targetPlanet, (targetPlanet.resources[? "energy"] - (targetPlanet.powerLevel*4)));
					}
					i++;
				}
	
				if(!ds_priority_empty(candidateList))
				{
					//var bestCandidate = ds_priority_find_max(candidateList);
					
					i = 0;
					repeat(ds_priority_size(candidateList))
					{
						bestCandidate = ds_priority_delete_max(candidateList);
						if(
						stockpile[? "energy"] > (1 * bestCandidate.powerLevel+1) and
						stockpile[? "metal"] > (20 * bestCandidate.powerLevel+1) and
						stockpile[? "crystal"] > (10 * bestCandidate.powerLevel+1)
						)
						{
							stockpile[? "energy"] -= (1 * bestCandidate.powerLevel+1);
							stockpile[? "metal"] -= (20 * bestCandidate.powerLevel+1);
							stockpile[? "crystal"] -= (10 * bestCandidate.powerLevel+1);
							
							bestCandidate.powerLevel++;
							infraLastAction = "Upgraded energy on " + bestCandidate.name;
							done = true;
							break;
						}
						else if(dysonLevel < 10)
						{
							//show_debug_message("Dyson time!");
							
							infraDebug = "Saving for Dyson Array";
							infraSavingFor = "dyson";
							done = true;
							break;
						}
						else if(dysonLevel == 10)
						{
							desired[? "energy"] += (1 * bestCandidate.powerLevel+1) - stockpile[? "energy"];
							desired[? "metal"] += (20 * bestCandidate.powerLevel+1) - stockpile[? "metal"];
							desired[? "crystal"] += (10 * bestCandidate.powerLevel+1) - stockpile[? "crystal"];
							show_debug_message("Dyson is maxed out!");
							done = true;
							break;
						}
						i++
					}
				}
				
				else
				{
					var cost = global.dysonCost;
					
					if(
					dysonLevel != 10 and
					stockpile[? "metal"] > (cost[? "metal"] * (dysonLevel + 1)) and 
					stockpile[? "rareElements"] > (cost[? "rareElements"] * (dysonLevel + 1)) and 
					stockpile[? "crystal"] > (cost[? "crystal"] * (dysonLevel + 1))
					)
					{
						stockpile[? "metal"] -= (cost[? "metal"] * (dysonLevel + 1));
						stockpile[? "rareElements"] -= (cost[? "rareElements"] * (dysonLevel + 1));
						stockpile[? "crystal"] -= (cost[? "crystal"] * (dysonLevel + 1));
		
						dysonLevel ++;
						infraLastAction = "Upgraded Dyson Array";
		
						
						done = true;
					}
					else
					{
						infraDebug = "Saving for Dyson Array";
						infraSavingFor = "dyson";
						done = true;
					}
				}
				
				ds_priority_destroy(candidateList);
				done = true;
			}
		}
		#endregion

		#region Gas
		if(topRes == "gas")
		{
			var cost = global.dysonCost;
	
			if(
			dysonLevel != 10 and
			stockpile[? "metal"] > (cost[? "metal"] * (dysonLevel + 1)) and 
			stockpile[? "rareElements"] > (cost[? "rareElements"] * (dysonLevel + 1)) and 
			stockpile[? "crystal"] > (cost[? "crystal"] * (dysonLevel + 1))
			)
			{
				stockpile[? "metal"] -= (cost[? "metal"] * (dysonLevel + 1));
				stockpile[? "rareElements"] -= (cost[? "rareElements"] * (dysonLevel + 1));
				stockpile[? "crystal"] -= (cost[? "crystal"] * (dysonLevel + 1));
				
				infraLastAction = "Upgraded Dyson Array";
				dysonLevel ++;
		
				
				done = true;
			}
			else
			{
				infraDebug = "Saving for Dyson";
				infraSavingFor = "dyson";
				done = true;
			}
		}

		#endregion

		#region Mining
		else if(topRes == "metal" or topRes == "rareElements" or topRes == "crystal" or topRes == "radioactives")
		{
			var cost = global.miningCost;
	
			if(
			miningLevel != 10 and
			stockpile[? "metal"] > (cost[? "metal"] * (miningLevel + 1)) and
			stockpile[? "rareElements"] > (cost[? "rareElements"] * (miningLevel + 1)) and 
			stockpile[? "gas"] > (cost[? "gas"] * (miningLevel + 1))
			)
			{
				stockpile[? "metal"] -= (cost[? "metal"] * (miningLevel + 1));
				stockpile[? "rareElements"] -= (cost[? "rareElements"] * (miningLevel + 1));
				stockpile[? "gas"] -= (cost[? "gas"] * (miningLevel + 1));
					
				infraLastAction = "Upgraded Mining Post";
				miningLevel ++;
					
				
				done = true;
			}
			else
			{
				i = 0;
				var candidateList = ds_priority_create();
				repeat(planetCount)
				{
					targetPlanet = ds_list_find_value(planetList, i);
					if(targetPlanet.miningLevel < 10 and targetPlanet.population > 0 and targetPlanet.type != "Gas Giant")
					{
						ds_priority_add(candidateList, targetPlanet, (targetPlanet.resources[? "metal"] + targetPlanet.resources[? "rareElements"] + targetPlanet.resources[? "crystal"] + targetPlanet.resources[? "radioactives"] - (targetPlanet.miningLevel*4)));
					}
					i++;
				}
	
				if(!ds_priority_empty(candidateList))
				{
					i = 0;
					repeat(ds_priority_size(candidateList))
					{
						var bestCandidate = ds_priority_delete_max(candidateList);
						if(
						stockpile[? "energy"] > (2 * bestCandidate.miningLevel+1) and
						stockpile[? "metal"] > (30 * bestCandidate.miningLevel+1) and
						stockpile[? "gas"] > (10 * bestCandidate.miningLevel+1)
						)
						{
							stockpile[? "energy"] -= (2 * bestCandidate.miningLevel+1);
							stockpile[? "metal"] -= (30 * bestCandidate.miningLevel+1);
							stockpile[? "gas"] -= (10 * bestCandidate.miningLevel+1);
							
							bestCandidate.miningLevel++;
							infraLastAction = "Upgraded mining on " + bestCandidate.name;
							done = true;
							break;
						}
						
						else if(miningLevel < 10)
						{
							infraDebug = "Saving for Mining Post";
							infraSavingFor = "mining";
							done = true;
							break;
						}
						else if(miningLevel == 10)
						{
							desired[? "energy"] += (2 * bestCandidate.miningLevel+1) - stockpile[? "energy"];
							desired[? "metal"] += (30 * bestCandidate.miningLevel+1) - stockpile[? "metal"];
							desired[? "gas"] += (10 * bestCandidate.miningLevel+1) - stockpile[? "gas"];
							show_debug_message("Mining is maxed out!!");
							done = true;
							break;
						}
						i++
					}
				}
				else
				{
					var cost = global.miningCost;
	
					if(
					miningLevel != 10 and
					stockpile[? "metal"] > (cost[? "metal"] * (miningLevel + 1)) and stockpile[? "rareElements"] > (cost[? "rareElements"] * (miningLevel + 1)) and stockpile[? "gas"] > (cost[? "gas"] * (miningLevel + 1))
					)
					{
						stockpile[? "metal"] -= (cost[? "metal"] * (miningLevel + 1));
						stockpile[? "rareElements"] -= (cost[? "rareElements"] * (miningLevel + 1));
						stockpile[? "gas"] -= (cost[? "gas"] * (miningLevel + 1));
						
						
						infraLastAction = "Upgraded Mining Post";
						miningLevel ++;
		
						done = true;
					}
					else
					{
						infraDebug = "Saving for Mining Post";
						infraSavingFor = "mining";
						done = true;
					}
				}
		
				ds_priority_destroy(candidateList);
				done = true;
			}
		}
		#endregion

		#region Food
		else if(topRes == "food")
		{
			i = 0;
			var candidateList = ds_priority_create();
			repeat(planetCount)
			{
				targetPlanet = ds_list_find_value(planetList, i);
				if(targetPlanet.agriLevel < 10 and targetPlanet.population > 0 and targetPlanet.type != "Gas Giant")
				{
					ds_priority_add(candidateList, targetPlanet, (targetPlanet.resources[? "food"] - (targetPlanet.agriLevel*4)));
				}
				i++;
			}
	
			if(!ds_priority_empty(candidateList))
			{
				repeat(ds_priority_size(candidateList))
				{
					var bestCandidate = ds_priority_delete_max(candidateList);
					if(
					stockpile[? "energy"] > (3 * bestCandidate.agriLevel+1) and
					stockpile[? "metal"] > (20 * bestCandidate.agriLevel+1)
					)
					{
						stockpile[? "energy"] -= (3 * bestCandidate.agriLevel+1);
						stockpile[? "metal"] -= (20 * bestCandidate.agriLevel+1);
						bestCandidate.agriLevel++;
						infraLastAction = "Upgraded agriculture on " + bestCandidate.name;
						ds_priority_destroy(candidateList);
						done = true;
						break;
					}
				}
			}
		}
		#endregion

		#region Alloys
		else if(topRes == "alloys")
		{
			i = 0;
			var candidateList = ds_priority_create();
			repeat(planetCount)
			{
				targetPlanet = ds_list_find_value(planetList, i);
				if(targetPlanet.alloyLevel < 10 and targetPlanet.population > 0 and targetPlanet.type != "Gas Giant")
				{
					ds_priority_add(candidateList, targetPlanet, (targetPlanet.alloyLevel*4));
				}
				i++;
			}
	
			if(!ds_priority_empty(candidateList))
			{
				repeat(ds_priority_size(candidateList))
				{
					bestCandidate = ds_priority_delete_min(candidateList);
					if(
					stockpile[? "energy"] > (4 * bestCandidate.alloyLevel+1) and
					stockpile[? "metal"] > (50 * bestCandidate.alloyLevel+1) and
					stockpile[? "rareElements"] > (15 * bestCandidate.alloyLevel+1)
					)
					{
						stockpile[? "energy"] -= (4 * bestCandidate.alloyLevel+1);
						stockpile[? "metal"] -= (50 * bestCandidate.alloyLevel+1);
						stockpile[? "rareElements"] -= (15 * bestCandidate.alloyLevel+1);
						bestCandidate.alloyLevel++;
						infraLastAction = "Upgraded Alloy Production on " + bestCandidate.name;
						ds_priority_destroy(candidateList);
						done = true;
						break;
					}
				}
			}
		}
		#endregion

		#region Consumer Goods
		else if(topRes == "consumerGoods")
		{
			i = 0;
			var candidateList = ds_priority_create();
			repeat(planetCount)
			{
				targetPlanet = ds_list_find_value(planetList, i);
				if(targetPlanet.cgLevel < 10 and targetPlanet.population > 0 and targetPlanet.type != "Gas Giant")
				{
					ds_priority_add(candidateList, targetPlanet, (targetPlanet.cgLevel*4));
				}
				i++;
			}
	
			if(!ds_priority_empty(candidateList))
			{
				repeat(ds_priority_size(candidateList))
				{
					bestCandidate = ds_priority_delete_min(candidateList);
					if(
					stockpile[? "energy"] > (5 * bestCandidate.cgLevel+1) and
					stockpile[? "metal"] > (40 * bestCandidate.cgLevel+1) and
					stockpile[? "rareElements"] > (5 * bestCandidate.cgLevel+1)
					)
					{
						stockpile[? "energy"] -= (5 * bestCandidate.cgLevel+1);
						stockpile[? "metal"] -= (40 * bestCandidate.cgLevel+1);
						stockpile[? "rareElements"] -= (5 * bestCandidate.cgLevel+1);
						bestCandidate.cgLevel++;
						infraLastAction = "Upgraded Consumer Goods Production on " + bestCandidate.name;
						ds_priority_destroy(candidateList);
						done = true;
						break;
					}
				}
			}
		}
		#endregion

		#region Nanotech
		else if(topRes == "nanotech")
		{
			i = 0;
			var candidateList = ds_priority_create();
			repeat(planetCount)
			{
				targetPlanet = ds_list_find_value(planetList, i);
				if(targetPlanet.nanoLevel < 10 and targetPlanet.population > 0 and targetPlanet.type != "Gas Giant")
				{
					ds_priority_add(candidateList, targetPlanet, (targetPlanet.nanoLevel*4));
				}
				i++;
			}
	
			if(!ds_priority_empty(candidateList))
			{
				repeat(ds_priority_size(candidateList))
				{
					bestCandidate = ds_priority_delete_min(candidateList);
					if(
					stockpile[? "energy"] > (5 * bestCandidate.nanoLevel+1) and
					stockpile[? "metal"] > (50 * bestCandidate.nanoLevel+1) and
					stockpile[? "rareElements"] > (20 * bestCandidate.nanoLevel+1)
					)
					{
						stockpile[? "energy"] -= (5 * bestCandidate.nanoLevel+1);
						stockpile[? "metal"] -= (50 * bestCandidate.nanoLevel+1);
						stockpile[? "rareElements"] -= (20 * bestCandidate.nanoLevel+1);
						bestCandidate.nanoLevel++;
						infraLastAction = "Upgraded Nanotech Production on " + bestCandidate.name;
						ds_priority_destroy(candidateList);
						done = true;
						break;
					}
				}
			}
		}
		#endregion

		#region Advanced Components
		else if(topRes == "advancedComponents")
		{
			i = 0;
			var candidateList = ds_priority_create();
			repeat(planetCount)
			{
				targetPlanet = ds_list_find_value(planetList, i);
				if(targetPlanet.acLevel < 10 and targetPlanet.population > 0 and targetPlanet.type != "Gas Giant")
				{
					ds_priority_add(candidateList, targetPlanet, (targetPlanet.acLevel*4));
				}
				i++;
			}
	
			if(!ds_priority_empty(candidateList))
			{
				repeat(ds_priority_size(candidateList))
				{
					bestCandidate = ds_priority_delete_min(candidateList);
					if(
					stockpile[? "energy"] > (5 * bestCandidate.acLevel+1) and
					stockpile[? "metal"] > (50 * bestCandidate.acLevel+1) and
					stockpile[? "rareElements"] > (10 * bestCandidate.acLevel+1)
					)
					{
						stockpile[? "energy"] -= (5 * bestCandidate.acLevel+1);
						stockpile[? "metal"] -= (50 * bestCandidate.acLevel+1);
						stockpile[? "rareElements"] -= (10 * bestCandidate.acLevel+1);
						bestCandidate.acLevel++;
						infraLastAction = "Upgraded Advanced Component Production on " + bestCandidate.name;
						ds_priority_destroy(candidateList);
						done = true;
						break;
					}
				}
			}
		}
		#endregion
	done = true;
	}
	until(done)

	#endregion

	//Cleanup
	ds_priority_destroy(resQueue);
}
}
#endregion

#region Desired Resources
desiresResources = false;
var z = 0;

var asize = ds_map_size(stockpile);
var s = ds_map_find_first(stockpile);
var e = ds_map_find_first(stockQuota);
var d = ds_map_find_first(desired);

for(z = 0; z < asize; z++)
{
	if(ds_map_find_value(stockpile, s) < ds_map_find_value(stockQuota, e))
	{
		desired[? d] += ds_map_find_value(stockQuota, e) - ds_map_find_value(stockpile, s);
		desiresResources = true;
		
	}
	else
	{
		desired[? d] = 0;
	}
	
	s = ds_map_find_next(stockpile, s);
	e = ds_map_find_next(stockQuota, e);
	d = ds_map_find_next(desired, d);
}
	
#endregion

#region Resource Ranking

#region Energy

var temp = stockpile[? "energy"] - stockQuota[? "energy"];

if(is_undefined(ds_priority_find_priority(owner.energyRanking, id)))
{
	if(temp > 0)
	{
		ds_priority_add(owner.energyRanking, id, temp);
	}
}
else
{
	if(temp > 0)
	{
		ds_priority_change_priority(owner.energyRanking, id, temp);
	}
}
#endregion

#region Metal
if(is_undefined(ds_priority_find_priority(owner.metalRanking, id)))
{
	ds_priority_add(owner.metalRanking, id, stockpile[? "metal"] - stockQuota[? "energy"]);
}
else
{
	ds_priority_change_priority(owner.metalRanking, id, stockpile[? "metal"] - stockQuota[? "energy"]);
}
#endregion

#region Rare Elements
if(is_undefined(ds_priority_find_priority(owner.RERanking, id)))
{
	ds_priority_add(owner.RERanking, id, stockpile[? "rareElements"] - stockQuota[? "rareElements"]);
}
else
{
	ds_priority_change_priority(owner.RERanking, id, stockpile[? "rareElements"] - stockQuota[? "rareElements"]);
}
#endregion

#region Gas
if(is_undefined(ds_priority_find_priority(owner.gasRanking, id)))
{
	ds_priority_add(owner.gasRanking, id, stockpile[? "gas"] - stockQuota[? "gas"]);
}
else
{
	ds_priority_change_priority(owner.gasRanking, id, stockpile[? "gas"] - stockQuota[? "gas"]);
}
#endregion

#region Crystal
if(is_undefined(ds_priority_find_priority(owner.crystalRanking, id)))
{
	ds_priority_add(owner.crystalRanking, id, stockpile[? "crystal"] - stockQuota[? "crystal"]);
}
else
{
	ds_priority_change_priority(owner.crystalRanking, id, stockpile[? "crystal"] - stockQuota[? "crystal"]);
}
#endregion

#region Radioactives
if(is_undefined(ds_priority_find_priority(owner.radioRanking, id)))
{
	ds_priority_add(owner.radioRanking, id, stockpile[? "radioactives"] - stockQuota[? "radioactives"]);
}
else
{
	ds_priority_change_priority(owner.radioRanking, id, stockpile[? "radioactives"] - stockQuota[? "radioactives"]);
}
#endregion

#region Food
if(is_undefined(ds_priority_find_priority(owner.foodRanking, id)))
{
	ds_priority_add(owner.foodRanking, id, stockpile[? "food"] - stockQuota[? "food"]);
}
else
{
	ds_priority_change_priority(owner.foodRanking, id, stockpile[? "food"] - stockQuota[? "food"]);
}
#endregion

#region Alloys
if(is_undefined(ds_priority_find_priority(owner.alloysRanking, id)))
{
	ds_priority_add(owner.alloysRanking, id, stockpile[? "alloys"] - stockQuota[? "alloys"]);
}
else
{
	ds_priority_change_priority(owner.alloysRanking, id, stockpile[? "alloys"] - stockQuota[? "alloys"]);
}
#endregion

#region Nanotech
if(is_undefined(ds_priority_find_priority(owner.nanoRanking, id)))
{
	ds_priority_add(owner.nanoRanking, id, stockpile[? "nanotech"] - stockQuota[? "nanotech"]);
}
else
{
	ds_priority_change_priority(owner.nanoRanking, id, stockpile[? "nanotech"] - stockQuota[? "nanotech"]);
}
#endregion

#region Consumer Goods
if(is_undefined(ds_priority_find_priority(owner.consumerRanking, id)))
{
	ds_priority_add(owner.consumerRanking, id, stockpile[? "consumerGoods"] - stockQuota[? "consumerGoods"]);
}
else
{
	ds_priority_change_priority(owner.consumerRanking, id, stockpile[? "consumerGoods"] - stockQuota[? "consumerGoods"]);
}
#endregion

#region Advanced Components
if(is_undefined(ds_priority_find_priority(owner.advancedRanking, id)))
{
	ds_priority_add(owner.advancedRanking, id, stockpile[? "advancedComponents"] - stockQuota[? "advancedComponents"]);
}
else
{
	ds_priority_change_priority(owner.advancedRanking, id, stockpile[? "advancedComponents"] - stockQuota[? "advancedComponents"]);
}
#endregion

#endregion