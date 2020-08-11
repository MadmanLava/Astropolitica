#region Generation Data
detailDone = false;
placed = false;
claimActive = false;

#endregion

camera = view_camera;
oldcamerawidth = camera_get_view_width(camera);
failedList = ds_list_create();

#region Cosmetic
name = "blarg"
baseName = "blarg"
baseWidth = 0;
color1 = c_white;
color2 = c_white;
drawName = true;

#endregion

#region Government
authority = "Democratic";
govType = "Democratic Republic";

	#region Leader
	leader = pointer_null;
	leaderName = choose("B. Larg", "F. Action", "C. Ountry", "P. Resident", "W. R. Monger", "L. Eader", "P. Laceholder");
	leaderTitle = "President";
	leaderSelection = "";
	leaderApproval = 1;
	leaderPower = 0.5;
	leaderCorruption = 0;
	leaderGoal = "";
	leaderPolicy = "";
	leaderInertia = 0;

	#endregion

	#region Legislature
	legiSelection = "";
	legiApproval = 1;
	legiPower = 0.5;
	legiCorruption = 0;
	legiPolicy = "";
	legiInertia = 0;
	
	#endregion

#endregion

#region Behavioral Weights
expansion = 0.5;
aggression = 0.5;
xenophobia = 0.5;
tradeInterest = 0.5;

#endregion

#region Foreign Policy
opinion = ds_map_create();
neighbors = ds_list_create();
refugeesAllowed = ds_list_create();
closedBorders = ds_list_create();
tradeAgreements = pointer_null;
naps = ds_list_create();
alliances = ds_list_create();

#endregion

#region Territory
systems = 0;
systemList = ds_list_create();
planets = 0;
planetList = ds_list_create();

targetSystem = pointer_null;
targetSystemHost = pointer_null;
targetPlanetPopsNeeded = 0;

borderSystemList = ds_list_create();
capitolSystem = pointer_null;
capitolPlanet = pointer_null;
colonizationAllowed = true;
averageCenterX = 0;
averageCenterY = 0;
furthestSystem = pointer_null;
averageRadius = 0;

shipyardLocations = ds_list_create();

cCost = 1000;

#endregion

#region Demographics
population = 0;
maxPopulation = 0;
growthRate = 0;
happiness = 0;
crime = 0;

colonists = 0;
colonistPriority = ds_priority_create();

popGrowthBonus = 0;
popUpkeepBonus = 0;
popHappinessBonus = 0;

#endregion

#region Freedoms
genocideAllowed = false;
livingStandards = 0;
liberty = 10;
justice = 0;
criticism = 10;
criticismLevel = 0;

#endregion

#region Religion
hasStateReligion = false;
religionName = "";
mandatory = false;
tolerance = 10;
adherence = 0;

#endregion

#region Budget
budget = 10000;
socialSpending = 0.25;
navalSpending = 0.75;
armySpending = 0;

socialBudget = 0;
navalBudget = 0;
armyBudget = 0;

#endregion

#region Economy
taxRate = 0.15;
taxesCollected = 0;

adminCosts = 0;

wealth = 0;
forcedEmployment = false;

#region Resource Values
value = ds_map_create();
	
value[? "energy"] = 2;
value[? "metal"] = 2;
value[? "rareElements"] = 3;
value[? "gas"] = 2;
value[? "crystal"] = 2.5;
value[? "radioactives"] = 7;
value[? "food"] = 2.5;
value[? "neutronium"] = 20;
value[? "erronogen"] = 100;
	
value[? "alloys"] = 5;
value[? "consumerGoods"] = 3;
value[? "nanotech"] = 8;
value[? "advancedComponents"] = 5;

#endregion

#region Stockpile
stockpile = ds_map_create();
	
stockpile[? "energy"] = 0;
stockpile[? "metal"] = 0;
stockpile[? "rareElements"] = 0;
stockpile[? "gas"] = 0;
stockpile[? "crystal"] = 0;
stockpile[? "radioactives"] = 0;
stockpile[? "food"] = 0;
stockpile[? "neutronium"] = 0;
stockpile[? "erronogen"] = 0;
	
stockpile[? "alloys"] = 0;
stockpile[? "consumerGoods"] = 0;
stockpile[? "nanotech"] = 0;
stockpile[? "advancedComponents"] = 0;
	
#endregion
	
#region Income
income = ds_map_create();
	
income[? "energy"] = 0;
income[? "metal"] = 0;
income[? "rareElements"] = 0;
income[? "gas"] = 0;
income[? "crystal"] = 0;
income[? "radioactives"] = 0;
income[? "food"] = 0;
income[? "neutronium"] = 0;
income[? "erronogen"] = 0;
	
income[? "alloys"] = 0;
income[? "consumerGoods"] = 0;
income[? "nanotech"] = 0;
income[? "advancedComponents"] = 0;
	
#endregion

#region Upkeep
upkeep = ds_map_create();

upkeep[? "energy"] = 0;
upkeep[? "metal"] = 0;
upkeep[? "rareElements"] = 0;
upkeep[? "gas"] = 0;
upkeep[? "crystal"] = 0;
upkeep[? "radioactives"] = 0;
upkeep[? "food"] = 0;
upkeep[? "neutronium"] = 0;
upkeep[? "erronogen"] = 0;
	
upkeep[? "alloys"] = 0;
upkeep[? "consumerGoods"] = 0;
upkeep[? "nanotech"] = 0;
upkeep[? "advancedComponents"] = 0;

#endregion

#region Average Resources Spent
spent = ds_map_create();

spent[? "energy"] = 0;
spent[? "metal"] = 0;
spent[? "rareElements"] = 0;
spent[? "gas"] = 0;
spent[? "crystal"] = 0;
spent[? "radioactives"] = 0;
spent[? "food"] = 0;
spent[? "neutronium"] = 0;
spent[? "erronogen"] = 0;
	
spent[? "alloys"] = 0;
spent[? "consumerGoods"] = 0;
spent[? "nanotech"] = 0;
spent[? "advancedComponents"] = 0;

#endregion

#region Rankings
energyRanking = ds_priority_create();

metalRanking = ds_priority_create();

RERanking = ds_priority_create();

gasRanking = ds_priority_create();

crystalRanking = ds_priority_create();

radioRanking = ds_priority_create();

foodRanking = ds_priority_create();

alloysRanking = ds_priority_create();

nanoRanking = ds_priority_create();

consumerRanking = ds_priority_create();

advancedRanking = ds_priority_create();

#endregion

#endregion

#region Military
conscription = false;
warPolicy = "Unrestricted"
atWar = ds_list_create();
navalPower = 0;
armyPower = 0;

#endregion

#region Decisionmaking

#region Demographics
demoPlan = ds_map_create();
demoPlan[? "population"] = 0.5;
demoPlan[? "growthRate"] = 0.05;
demoPlan[? "happiness"] = 0.5;
demoPlan[? "crime"] = 0.001;

#endregion

#region Economy
#region Income
ecoPlanIncome = ds_map_create();
ecoPlanIncome[? "energy"] = 0;
ecoPlanIncome[? "metal"] = 0;
ecoPlanIncome[? "rareElements"] = 0;
ecoPlanIncome[? "gas"] = 0;
ecoPlanIncome[? "crystal"] = 0;
ecoPlanIncome[? "radioactives"] = 0;
ecoPlanIncome[? "food"] = 0;
ecoPlanIncome[? "plasma"] = 0;
ecoPlanIncome[? "neutronium"] = 0;
ecoPlanIncome[? "erronogen"] = 0;
	
ecoPlanIncome[? "alloys"] = 0;
ecoPlanIncome[? "consumerGoods"] = 0;
ecoPlanIncome[? "nanotech"] = 0;
ecoPlanIncome[? "advancedComponents"] = 0;

#endregion

#region Stockpile
ecoPlanStockpile = ds_map_create();
ecoPlanStockpile[? "energy"] = 0;
ecoPlanStockpile[? "metal"] = 0;
ecoPlanStockpile[? "rareElements"] = 0;
ecoPlanStockpile[? "gas"] = 0;
ecoPlanStockpile[? "crystal"] = 0;
ecoPlanStockpile[? "radioactives"] = 0;
ecoPlanStockpile[? "food"] = 0;
ecoPlanStockpile[? "plasma"] = 0;
ecoPlanStockpile[? "neutronium"] = 0;
ecoPlanStockpile[? "erronogen"] = 0;
	
ecoPlanStockpile[? "alloys"] = 0;
ecoPlanStockpile[? "consumerGoods"] = 0;
ecoPlanStockpile[? "nanotech"] = 0;
ecoPlanStockpile[? "advancedComponents"] = 0;

#endregion

#endregion

#endregion

#region Custom Factions(disabled)
/*
if(global.pregenFactionsAllowed and scr_chance(0) and ds_list_size(global.customFacList) > 0)
{
	detailDone = true;
	
	var holder = scr_randFromList(global.customFacList);
	var handle = file_text_open_read(working_directory + "/customfactions/" + holder);
	
	var text = "";
	while(!file_text_eof(handle))
	{
		text += file_text_readln(handle);
	}
	file_text_close(handle);
	
	var facJson = json_decode(text);
	
	name = facJson[? "name"];
	var color1_temp = facJson[? "color1"]
	var color2_temp = facJson[? "color2"]
	
	#region Parse Color
	color = make_color_rgb(string_copy(color1_temp, 1, 3), string_copy(color1_temp, 4, 3), string_copy(color1_temp, 7, 3));
	color2= make_color_rgb(string_copy(color2_temp, 1, 3), string_copy(color2_temp, 4, 3), string_copy(color2_temp, 7, 3));
	
	#endregion
	
	authority = facJson[? "authority"]
	govType = facJson[? "government"]
	
	aggression = facJson[? "aggression"]
	xenophobia = facJson[? "xenophobia"]
	expansion = facJson[? "expansion"]
	
	hasStateReligion = facJson[? "hasReligion"]
	religionName = facJson[? "religionName"]
	tolerance = facJson[? "tolerance"]
	
	socialSpending = facJson[? "socialSpending"]
	navalSpending = facJson[? "navalSpending"]
	armySpending = facJson[? "armySpending"]
	
	conscription = facJson[? "conscription"]
	warPolicy = facJson[? "warPolicy"]
	
	taxRate = facJson[? "taxRate"]
	forcedEmploy = facJson[? "forcedEmployment"]
	slavery = facJson[? "slavery"]
	
	liberty = facJson[? "liberty"]
	genocideAllowed = facJson[? "genocideAllowed"]
	allowRefugees = facJson[? "refugeesWelcome"]
	
	var holderPos = ds_list_find_index(global.customFacList, holder);
	ds_list_delete(global.customFacList, holderPos);
	
}
*/
#endregion

#region Milestones
milestones = ds_map_create();

milestones[? "colony1"] = false;
milestones[? "colony2"] = false;
milestones[? "colony3"] = false;

#endregion

event_user(4);
//e