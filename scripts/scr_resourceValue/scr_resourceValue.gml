///@function scr_resourceValue(faction)
///@arg faction

var faction = argument0;

var stockpile = faction.stockpile;
var income = faction.income;
var upkeep = faction.upkeep;
var spent = faction.spent;

var value = ds_map_create();
var res = "";

	#region Energy
	res = "energy";
	
	var stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
	var incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

	value[? res] = 0.5 * stockFactor * incomeFactor;
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Metal
	res = "metal";
	
	stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
	incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

	value[? res] = 0.5 * stockFactor * incomeFactor;
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Rare Elements
	res = "rareElements";
	
	stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
	incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

	value[? res] = 1 * stockFactor * incomeFactor;
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Gas
	res = "gas";
	
	stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
	incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

	value[? res] = 1 * stockFactor * incomeFactor;
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Crystal
	res = "crystal";
	
	stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
	incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

	value[? res] = 1 * stockFactor * incomeFactor;
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Radioactives
	res = "radioactives";
	
	if(upkeep[? res] != 0)
		{
		stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
		incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

		value[? res] = 1 * stockFactor * incomeFactor;
	}
	else if(income[? res] > 0)
	{
		value[? res] = 1 + spent[? res]/(global.monthsPast + 1)
	}
	else
	{
		value[? res] = 1;
	}
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Food
	res = "food";
	
	stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
	incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

	value[? res] = 1 * stockFactor * incomeFactor;
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Neutronium
	res = "neutronium";
	
	if(upkeep[? res] != 0)
	{
		stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
		incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

		value[? res] = 5 * stockFactor * incomeFactor;
	}
	else if(income[? res] > 0)
	{
		value[? res] = 5/(income[? res]);
	}
	else
	{
		value[? res] = 5;
	}
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Erronogen
	
	res = "erronogen";
	
	if(upkeep[? res] != 0)
	{
		stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
		incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

		value[? res] = 10 * stockFactor * incomeFactor;
	}
	else if(income[? res] > 0)
	{
		value[? res] = 10/(income[? res]);
	}
	else
	{
		value[? res] = 10;
	}
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Alloys
	res = "alloys";
	
	if(upkeep[? res] > 0)
	{
		stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
		incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

		value[? res] = 1 * stockFactor * incomeFactor;
	}
	else if(income[? res] > 0)
	{
		value[? res] = 1 + spent[? res]/(global.monthsPast + 1)
	}
	else
	{
		value[? res] = 1;
	}
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Consumer Goods
	res = "consumerGoods";
	
	stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
	incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

	value[? res] = 1 * stockFactor * incomeFactor;
	
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Nanotech
	res = "nanotech";
	
	if(upkeep[? res] != 0)
	{
		stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
		incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

		value[? res] = 2.5 * stockFactor * incomeFactor;
	}
	else if(income[? res] > 0)
	{
		value[? res] = 2.5 + spent[? res]/(global.monthsPast + 1)
	}
	else
	{
		value[? res] = 2.5;
	}
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	#region Advanced Components
	res = "advancedComponents";
	
	if(upkeep[? res] != 0)
	{
		stockFactor = ( ((upkeep[? res] * 12) + 0.1) / (stockpile[? res] + 0.1) );
	
		incomeFactor = (upkeep[? res] + 0.1 / (income[? res] + upkeep[? res] + 0.1));

		value[? res] = 2 * stockFactor * incomeFactor;
	}
	else if(income[? res] > 0)
	{
		value[? res] = 2 + spent[? res]/(global.monthsPast + 1)
	}
	else
	{
		value[? res] = 2;
	}
	
	clamp(value[? res], 0.1, 1000);
	#endregion
	
	return(value);
	ds_map_destroy(value);