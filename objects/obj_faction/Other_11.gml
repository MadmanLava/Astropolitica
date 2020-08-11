/// @desc Monthly update

#region Trade

#region Find list
i = 0;
var desireList = ds_list_create();
var target = pointer_null;
repeat(systems)
{
	target = ds_list_find_value(systemList, i)
	if(target.desiresResources)
	{
		ds_list_add(desireList, target);
	}
	
	i++
}

#endregion

if(ds_list_size(desireList) > 0)
{
	var i = 0;
	repeat(ds_list_size(desireList))
	{
		var target = ds_list_find_value(desireList, i);
		var want = target.desired;
		
		#region Energy
		if(ds_map_exists(want, "energy"))
		{
			if(!ds_priority_empty(energyRanking))
			{
				var subTarget = ds_priority_find_max(energyRanking);
				var temp = ds_priority_find_priority(energyRanking, subTarget);
			
				if(subTarget.id != target.id and temp > 0 and temp > want[? "energy"] and subTarget.infraSavingFor == "")
				{
					target.stockpile[? "energy"] += want[? "energy"]
					subTarget.stockpile[? "energy"] -= want[? "energy"];
					ds_priority_change_priority(energyRanking, subTarget, subTarget.stockpile[? "energy"] - subTarget.stockQuota[? "energy"]);

				}
			}
		}
		#endregion
		
		#region Metal
		if(ds_map_exists(want, "metal"))
		{
			if(!ds_priority_empty(metalRanking))
			{
				var subTarget = ds_priority_find_max(metalRanking);
				var temp = ds_priority_find_priority(metalRanking, subTarget);
			
				if(subTarget.id != target.id and temp > 0 and temp > want[? "metal"] and subTarget.infraSavingFor == "")
				{
					target.stockpile[? "metal"] += want[? "metal"]
					subTarget.stockpile[? "metal"] -= want[? "metal"];
					ds_priority_change_priority(metalRanking, subTarget, subTarget.stockpile[? "metal"]);

				}
			}
		}
		#endregion
		
		#region Rare Elements
		if(ds_map_exists(want, "rareElements"))
		{
			if(!ds_priority_empty(RERanking))
			{
				var subTarget = ds_priority_find_max(RERanking);
				var temp = subTarget.stockpile[? "rareElements"] - subTarget.stockQuota[? "rareElements"];
			
				if(subTarget != target and temp > 0 and temp > want[? "rareElements"] and subTarget.infraSavingFor == "")
				{
					target.stockpile[? "rareElements"] += want[? "rareElements"]
					subTarget.stockpile[? "rareElements"] -= want[? "rareElements"];
					ds_priority_change_priority(RERanking, subTarget, subTarget.stockpile[? "rareElements"]);

				}
			}
		}
		#endregion
		
		#region Gas
		if(ds_map_exists(want, "gas"))
		{
			if(!ds_priority_empty(gasRanking))
			{
				var subTarget = ds_priority_find_max(gasRanking);
				var temp = ds_priority_find_priority(gasRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "gas"] and subTarget.infraSavingFor != "mining")
				{
					target.stockpile[? "gas"] += want[? "gas"]
					subTarget.stockpile[? "gas"] -= want[? "gas"];
					ds_priority_change_priority(gasRanking, subTarget, subTarget.stockpile[? "gas"]);

				}
			}
		}
		#endregion
		
		#region Crystal
		if(ds_map_exists(want, "crystal"))
		{
			if(!ds_priority_empty(crystalRanking))
			{
				var subTarget = ds_priority_find_max(crystalRanking);
				var temp = ds_priority_find_priority(crystalRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "crystal"])
				{
					target.stockpile[? "crystal"] += want[? "crystal"]
					subTarget.stockpile[? "crystal"] -= want[? "crystal"];
					ds_priority_change_priority(crystalRanking, subTarget, subTarget.stockpile[? "crystal"] and subTarget.infraSavingFor != "dyson");

				}
			}
		}
		#endregion
		
		#region Food
		if(ds_map_exists(want, "food"))
		{
			if(!ds_priority_empty(foodRanking))
			{
				var subTarget = ds_priority_find_max(foodRanking);
				var temp = ds_priority_find_priority(foodRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "food"])
				{
					target.stockpile[? "food"] += want[? "food"]
					subTarget.stockpile[? "food"] -= want[? "food"];
					ds_priority_change_priority(foodRanking, subTarget, subTarget.stockpile[? "food"]);

				}
			}
		}
		#endregion
		
		#region Alloys
		if(ds_map_exists(want, "alloys"))
		{
			if(!ds_priority_empty(alloysRanking))
			{
				var subTarget = ds_priority_find_max(alloysRanking);
				var temp = ds_priority_find_priority(alloysRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "alloys"])
				{
					target.stockpile[? "alloys"] += want[? "alloys"]
					subTarget.stockpile[? "alloys"] -= want[? "alloys"];
					ds_priority_change_priority(alloysRanking, subTarget, subTarget.stockpile[? "alloys"]);

				}
			}
		}
		#endregion
		
		#region Consumer Goods
		if(ds_map_exists(want, "consumerGoods"))
		{
			if(!ds_priority_empty(consumerRanking))
			{
				var subTarget = ds_priority_find_max(consumerRanking);
				var temp = ds_priority_find_priority(consumerRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "consumerGoods"])
				{
					target.stockpile[? "consumerGoods"] += want[? "consumerGoods"]
					subTarget.stockpile[? "consumerGoods"] -= want[? "consumerGoods"];
					ds_priority_change_priority(consumerRanking, subTarget, subTarget.stockpile[? "consumerGoods"]);

				}
			}
		}
		#endregion
		
		#region Nanotech
		if(ds_map_exists(want, "nanotech"))
		{
			if(!ds_priority_empty(nanoRanking))
			{
				var subTarget = ds_priority_find_max(nanoRanking);
				var temp = ds_priority_find_priority(nanoRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "nanotech"])
				{
					target.stockpile[? "nanotech"] += want[? "nanotech"]
					subTarget.stockpile[? "nanotech"] -= want[? "nanotech"];
					ds_priority_change_priority(nanoRanking, subTarget, subTarget.stockpile[? "nanotech"]);

				}
			}
		}
		#endregion
		
		#region Advanced Components
		if(ds_map_exists(want, "advancedComponents"))
		{
			if(!ds_priority_empty(advancedRanking))
			{
				var subTarget = ds_priority_find_max(advancedRanking);
				var temp = ds_priority_find_priority(advancedRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "advancedComponents"])
				{
					target.stockpile[? "advancedComponents"] += want[? "advancedComponents"]
					subTarget.stockpile[? "advancedComponents"] -= want[? "advancedComponents"];
					ds_priority_change_priority(advancedRanking, subTarget, subTarget.stockpile[? "advancedComponents"]);

				}
			}
		}
		#endregion
		
		i++
	}
}
ds_list_destroy(desireList);

#endregion

#region Leftover budget
//Upkeep
if(socialBudget > 0)
{
	var popCost = (socialBudget/population) * 3;
	if(popCost > 3)
	{
		popCost = 3;
	}
		
	popUpkeepBonus = (popCost);
	budget -= popCost * population;
	socialBudget -= popCost * population;
}
else
{
	popUpkeepBonus = 0;
}
	
//Growth
if(socialBudget > 0)
{
	var popCost = (socialBudget/population) * 2;
	if(popCost > 5)
	{
		popCost = 5;
	}
		
	popGrowthBonus = (popCost);
	budget -= popCost * population;
	socialBudget -= popCost * population;
}
else
{
	popGrowthBonus = 0;
}
	
//Happiness(leftover)
if(socialBudget > 0)
{
	var popCost = (socialBudget/population);
	if(popCost > 7)
	{
		popCost = 7;
	}
		
	popHappinessBonus = (popCost);
	budget -= popCost * population;
	socialBudget -= popCost * population;
}
else
{
	popHappinessBonus = 0;
}

#endregion

#region Taxes and Budgeting
budget += taxesCollected;
socialBudget = budget*socialSpending;
navalBudget = budget*navalSpending;
if(armySpending > 0)
{
	armyBudget = budget*armySpending;
}
else
{
	armyBudget = 0;
}

#region Administrative Costs
adminCosts = (systems * 5) + (planets * 2) + (population/1000);

budget -= adminCosts;
socialBudget -= adminCosts;

#endregion

#region Calculate new resource values
value = scr_resourceValue(id);

#endregion

#endregion