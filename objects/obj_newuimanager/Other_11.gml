/// @desc Draw UI

#region Setup
draw_set_font(fnt_defaultverysmall);
scribble_draw_set_box_align(fa_left, fa_middle);
scribble_draw_set_wrap(-1, 290, -1, false)

var boxHei = string_height("M") + 5;
var tabColor1 = make_color_rgb(200, 200, 200);
var tabColor2 = make_color_rgb(150, 150, 150);
var tabColor3 = make_color_rgb(100, 100, 100);

#endregion

#region Left
if(!surface_exists(uiSurfLeft))
{
	uiSurfLeft = surface_create(300, uiSurfLeftHeight);
}

surface_set_target(uiSurfLeft);

//Clear the surface to make way
draw_clear_alpha(c_white, 0);

#region Variables
var bhl = 0;
var tempListL = ds_list_create();

var offMouseY = window_mouse_get_y() - uiSurfLeftScroll;

if(mousex < 300 and mouse_check_button_released(mb_left))
{
	var doMouse = true;
}
else
{
	var doMouse = false;
}

#endregion

#region Tabs
var offset = 0;
var i = 0;
repeat(6)
{
	//Input
	if(doMouse and offMouseY < 50 and (mousex > offset and mousex < offset + 50))
	{
		scr_nine_slice(spr_basicBox_9slice, 50 * menuLeft, bhl, 50, 50, true, c_white);
		menuLeft = i;
		audio_play_sound(sfx_select, -1, false);
	}
	
	//Color
	var tempTabCol = c_white;
	if(menuLeft == i)
	{
		tempTabCol = c_yellow;
	}
	
	//Draw
	scr_nine_slice(spr_basicBox_9slice, offset, bhl, 50, 50, true, tempTabCol);
	
	offset += 50;
	i++
}

bhl += 50;
#endregion

//Header
scr_datumbox(0, bhl, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]" + global.galaxyName + " Galaxy", 300, 1, spr_basicBoxHeader_9slice);
bhl += boxHei;

#region Galactic Overview
if(menuLeft == 0)
{
	ds_list_add(tempListL, "# of Stars: " + string(global.genStarCount),
	"# of Planets: " + string(global.genPlanetCount),
	"# of Countries: " + string(global.genFactionCount),
	"Seed: " + string(global.seed),
	"Generation Time: " + string(global.generationTime/1000) + " seconds"
	);
	
	bhl += scr_datumList(0, bhl, 300, boxHei, tempListL);
	
	ds_list_clear(tempListL);
}
#endregion

surface_reset_target();
ds_list_destroy(tempListL);

#endregion

#region Right
if(!surface_exists(uiSurfRight))
{
	uiSurfRight = surface_create(300, uiSurfRightHeight);
}
surface_set_target(uiSurfRight);

//Clear the surface to make way
draw_clear_alpha(c_white, 0);

#region Variables
var bhr = 0;
var bx = 0;

var offMouseY = window_mouse_get_y() - uiSurfRightScroll;

if(!freezeInput and mousex > rightBound and mouse_check_button_released(mb_left))
{
	var doMouse = true;
}
else
{
	var doMouse = false;
}

#endregion

if(menuRight == 0 and selected != pointer_null)
{
	#region System Inspector
	//Header
	scr_datumbox(bx, 0, 300, boxHei*2, true, tabColor1, "[fnt_defaultsmall]" + string_upper(selected.name), 290, 1, spr_basicBoxHeader_9slice);
	bhr += boxHei*2;
		
	var tempList = ds_list_create();
		
	//var dayString = string(selected.daysSinceSettlement mod 30);
	var monthString = string((selected.daysSinceSettlement div 30) mod 12);
	var yearString = string(selected.daysSinceSettlement div 360);
		
	#region Basic
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]OVERVIEW", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "over"] = toggle(sys[? "over"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(sys[? "over"])
	{
		
		//Owner
		//scribble_draw_set_blend(selected.ownerColor, 1);
		if(selected.owner != pointer_null)
		{
		var ownCol = "[" + string(selected.owner.id) + "]"
		scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "Owner: " + ownCol + selected.ownerName, 290, 1, spr_basicBox_9slice);
		}
		else
		{
			scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "Unsettled", 290, 1, spr_basicBox_9slice);
		}
		//scribble_draw_set_blend(c_white, 1);
		
		if(doMouse)
		{
			if(selected.owner != pointer_null and offMouseY > bhr and offMouseY < bhr + boxHei)
			{
				scr_openInspector(selected.owner, "faction", true);
				surface_reset_target();
				audio_play_sound(sfx_select, -1, false);
				exit;
			}
		}
		
	bhr += boxHei;
		
	ds_list_add(tempList, "Settled for: " + yearString + " years, " + monthString + " months");
		
	if(selected.capitol)
	{
		ds_list_add(tempList, "Capitol System");
	}
	if(selected.border)
	{
		ds_list_add(tempList, "Border System");
	}
		
	bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
	ds_list_clear(tempList);
	
	}
	
	#endregion
		
	#region System Info
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]SYSTEM DATA", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "sysInfo"] = toggle(sys[? "sysInfo"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
		
	if(sys[? "sysInfo"])
	{
		ds_list_add(tempList,
		"Age: " + string(selected.age) + " million years",
		"Hyperlane Count: " + string(selected.hyperlaneCount),
		"Asteroid Density: " + string(selected.asteroidDensity),
		"[scale, 0.5][spr_metal][] Metal: " + string(selected.metal),
		"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(selected.rareElements),
		"[scale, 0.5][spr_radioactives][] Radioactives: " + string(selected.radioactives)
		);
		
		bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
		ds_list_clear(tempList);
	}
		
	#endregion
		
	#region Star Info
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]STAR DATA", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "starInfo"] = toggle(sys[? "starInfo"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(sys[? "starInfo"])
	{
		ds_list_add(tempList, 
		"Type: " + selected.type, 
		"Size: " + string(selected.size), 
		"Mass: " + string(selected.mass), 
		"Luminosity: " + string(selected.luminosity),
		"Solar Wind: " + string(selected.wind),
		"Supernova Risk: " + string(selected.supernovaRisk)
		);
		
		bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
		ds_list_clear(tempList);
	}
		
	#endregion
		
	#region Planet Info
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]PLANET DATA", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "planInfo"] = toggle(sys[? "planInfo"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
		
	if(sys[? "planInfo"])
	{
		ds_list_add(tempList,
		"Planet Count: " + string(selected.planetCount),
		"Habitable Planets: " + string(selected.habitablePlanetCount),
		);
		
		bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
		ds_list_clear(tempList);
	}
		
	#endregion
		
	#region Planet List
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]PLANET LIST", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "planList"] = toggle(sys[? "planList"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(sys[? "planList"])
	{
	
	#region Planet Names
		
	var i = 0;
	var tempBHR = bhr;
	repeat(ds_list_size(selected.planetList))
	{
		var targ = ds_list_find_value(selected.planetList, i);
		var habString = "[#9e0000][fnt_defaultverysmallbold]Uninhabitable";
			
		if(targ.habitability >= 10)
		{
			habString = "[c_blue][fnt_defaultverysmallbold]Perfect Habitability";
		}
		else if(targ.habitability > 6)
		{
			habString = "[c_green][fnt_defaultverysmallbold]High Habitability";
		}
		else if(targ.habitability > 3)
		{
			habString = "[c_yellow][fnt_defaultverysmallbold]Moderate Habitability";
		}
		else if(targ.habitability > 0)
		{
			habString = "[c_red][fnt_defaultverysmallbold]Low Habitability";
		}
			
		ds_list_add(tempList, targ.name + " - " + habString);
		i++;
			
		if(doMouse and offMouseY > tempBHR and offMouseY < tempBHR + boxHei)
		{
			scr_openInspector(targ, "planet", true);
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			exit;
		}
		tempBHR += boxHei;
	}
		
	#endregion
	
	bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
	ds_list_clear(tempList);
	
	}
		
	#endregion
		
	#region Demographics
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]DEMOGRAPHICS", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "demo"] = toggle(sys[? "demo"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(sys[? "demo"])
	{
	
	ds_list_add(tempList,
	"Population: " + string(selected.population) + " million",
	"Max Population: " + string(selected.maxPopulation) + " million",
	"Eligible Colonists: " + string(selected.colonists) + " million",
	"Average Growth Rate: " + string(selected.growthRate),
	"Average Happiness: " + string(selected.happiness),
	);
	
	bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
	ds_list_clear(tempList);
	
	}
	#endregion
		
	#region Infrastructure
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]INFRASTRUCTURE", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "infra"] = toggle(sys[? "infra"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
		
	if(sys[? "infra"])
	{
		
	bx = 10;
		
	#region Shipyard
	if(selected.shipyardLevel != 0)
	{
		scr_datumbox(bx, bhr, 289, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]SHIPYARD", 290, 1, spr_basicBoxHeader_9slice);
		
		#region Header Input
		if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
		{
			sys[? "infraShip"] = toggle(sys[? "infraShip"], true);
		
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			freezeInput = true;
			event_user(1);
			exit;
		}
		#endregion
	
		bhr += boxHei;
		
		if(sys[? "infraShip"])
		{
		
		ds_list_add(tempList, "Level: " + string(selected.shipyardLevel),
		"Task: " + selected.shipyardStatus);
		if(selected.shipyardStatus != "Idle")
		{
			ds_list_add(tempList, "Time Remaining: " + string(selected.shipyardTimeElapsed - selected.shipyardTask[? "time"]) + " days");
		}
			
		bhr += scr_datumList(bx, bhr, 289, boxHei, tempList);
		ds_list_clear(tempList);
			
		bx = 20;
		
		#region Upkeep
		scr_datumbox(bx, bhr, 279, boxHei, true, tabColor3, "[fnt_defaultverysmallbold]UPKEEP", 290, 1, spr_basicBoxHeader_9slice);
		
		#region Header Input
		if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
		{
			sys[? "infraShipUp"] = toggle(sys[? "infraShipUp"], true);
		
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			freezeInput = true;
			event_user(1);
			exit;
		}
		#endregion
		
		bhr += boxHei;
			
		if(sys[? "infraShipUp"])
		{
			ds_list_add(tempList,
			"[scale, 0.5][spr_energy][] Energy: " + string(selected.shipyardEnergyUpkeep),
			"[scale, 0.5][spr_metal][] Metal: " + string(selected.shipyardMetalUpkeep),
			"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(selected.shipyardREUpkeep),
			"[scale, 0.5][spr_gas][] Gas: " + string(selected.shipyardGasUpkeep),
			"[scale, 0.5][spr_food][] Food: " + string(selected.shipyardFoodUpkeep),
			);
			
			bhr += scr_datumList(bx+10, bhr, 279, boxHei, tempList);
			ds_list_clear(tempList);
		}
		
		#endregion
		
		bx = 10;
		
		}
	}
		
	#endregion
		
	#region Dyson Array
	if(selected.dysonLevel > 0)
	{
		scr_datumbox(bx, bhr, 300 - bx, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]DYSON ARRAY", 290, 1, spr_basicBoxHeader_9slice);
		
		#region Header Input
		if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
		{
			sys[? "infraDyson"] = toggle(sys[? "infraDyson"], true);
		
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			freezeInput = true;
			event_user(1);
			exit;
		}
		#endregion
		
		bhr += boxHei;
		
		if(sys[? "infraDyson"])
		{
		
		//Level
		scr_datumbox(bx, bhr, 300 - bx, boxHei, true, c_white, "Level: " + string(selected.dysonLevel), 290, 1, spr_basicBox_9slice);
		bhr += boxHei;
			
		bx = 20;
		#region Output
		scr_datumbox(bx, bhr, 279, boxHei, true, tabColor3, "[fnt_defaultverysmallbold]OUTPUT", 290, 1, spr_basicBoxHeader_9slice);
		
		#region Header Input
		if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
		{
			sys[? "infraDysonOut"] = toggle(sys[? "infraDysonOut"], true);
		
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			freezeInput = true;
			event_user(1);
			exit;
		}
		#endregion
		
		bhr += boxHei;
		
		if(sys[? "infraDysonOut"])
		{
			ds_list_add(tempList,
			"[scale, 0.5][spr_energy][] Energy: " + string(selected.dysonEnergy),
			"[scale, 0.5][spr_gas][] Gas: " + string(selected.dysonGas)
			);
			
			bhr += scr_datumList(bx+10, bhr, 279, boxHei, tempList);
			ds_list_clear(tempList);
		}
			
		#endregion
			
		#region Upkeep
		scr_datumbox(bx, bhr, 279, boxHei, true, tabColor3, "[fnt_defaultverysmallbold]UPKEEP", 290, 1, spr_basicBoxHeader_9slice);
		
		#region Header Input
		if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
		{
			sys[? "infraDysonUp"] = toggle(sys[? "infraDysonUp"], true);
		
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			freezeInput = true;
			event_user(1);
			exit;
		}
		#endregion
		
		bhr += boxHei;
		
		if(sys[? "infraDysonUp"])
		{
			ds_list_add(tempList,
			"[scale, 0.5][spr_crystal][] Crystal: " + string(selected.dysonCrystalUpkeep),
			"[scale, 0.5][spr_food][] Food: " + string(selected.dysonFoodUpkeep)
			);
			
			bhr += scr_datumList(bx+10, bhr, 279, boxHei, tempList);
			ds_list_clear(tempList);
		}
			
		#endregion
			
		bx = 10;
			
		ds_list_clear(tempList);
		
		}
	}
		
	#endregion
		
	#region Mining Post
	if(selected.miningLevel > 0)
	{
		scr_datumbox(bx, bhr, 289, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]MINING POST", 290, 1, spr_basicBoxHeader_9slice);
		
		#region Header Input
		if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
		{
			sys[? "infraMining"] = toggle(sys[? "infraMining"], true);
		
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			freezeInput = true;
			event_user(1);
			exit;
		}
		#endregion
		
		bhr += boxHei;
		
		if(sys[? "infraMining"])
		{
		
		//Level
		scr_datumbox(bx, bhr, 300 - bx, boxHei, true, c_white, "Level: " + string(selected.miningLevel), 290, 1, spr_basicBox_9slice);
		bhr += boxHei;
			
		bx = 20;
		#region Output
		scr_datumbox(bx, bhr, 279, boxHei, true, tabColor3, "[fnt_defaultverysmallbold]OUTPUT", 290, 1, spr_basicBoxHeader_9slice);
		
		#region Header Input
		if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
		{
			sys[? "infraMiningOut"] = toggle(sys[? "infraMiningOut"], true);
		
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			freezeInput = true;
			event_user(1);
			exit;
		}
		#endregion
		
		bhr += boxHei;
		
		if(sys[? "infraMiningOut"])
		{
			ds_list_add(tempList,
			"[scale, 0.5][spr_metal][] Metal: " + string(selected.miningMetal),
			"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(selected.miningRE),
			"[scale, 0.5][spr_radioactives][] Radioactives: " + string(selected.miningRadio)
			);
			
			bhr += scr_datumList(bx+10, bhr, 279, boxHei, tempList);
			ds_list_clear(tempList);
		}
		
		#endregion
			
		#region Upkeep
		scr_datumbox(bx, bhr, 279, boxHei, true, tabColor3, "[fnt_defaultverysmallbold]UPKEEP", 290, 1, spr_basicBoxHeader_9slice);
		
		#region Header Input
		if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
		{
			sys[? "infraMiningUp"] = toggle(sys[? "infraMiningUp"], true);
		
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			freezeInput = true;
			event_user(1);
			exit;
		}
		#endregion
		
		bhr += boxHei;
		
		if(sys[? "infraMiningUp"])
		{
			ds_list_add(tempList,
			"[scale, 0.5][spr_energy][] Energy: " + string(selected.miningEnergyUpkeep),
			"[scale, 0.5][spr_gas][] Gas: " + string(selected.miningGasUpkeep),
			"[scale, 0.5][spr_food][] Food: " + string(selected.miningFoodUpkeep)
			);
			
			bhr += scr_datumList(bx+10, bhr, 279, boxHei, tempList);
			ds_list_clear(tempList);
		}
			
		#endregion
			
		bx = 10;
			
		ds_list_clear(tempList);
		
		}
	}
		
	#endregion
		
	bx = 0;
		
	}
		
	ds_list_clear(tempList);
	#endregion
		
	#region Resources
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]RESOURCES", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "res"] = toggle(sys[? "res"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(sys[? "res"])
	{
	
	bx += 10;
	
	#region Stockpile
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]RESOURCE STOCKPILE", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "resStock"] = toggle(sys[? "resStock"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
		
	if(sys[? "resStock"])
	{
		var stock = selected.stockpile;
			
		ds_list_add(tempList,
		"[scale, 0.5][spr_energy][] Energy: " + string(stock[? "energy"]),
		"[scale, 0.5][spr_metal][] Metal: " + string(stock[? "metal"]),
		"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(stock[? "rareElements"]),
		"[scale, 0.5][spr_gas][] Gas: " + string(stock[? "gas"]),
		"[scale, 0.5][spr_crystal][] Crystal: " + string(stock[? "crystal"]),
		"[scale, 0.5][spr_radioactives][] Radioactives: " + string(stock[? "radioactives"]),
		"[scale, 0.5][spr_food][] Food: " + string(stock[? "food"]),
		"[scale, 0.5][spr_alloys][] Alloys: " + string(stock[? "alloys"]),
		"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(stock[? "consumerGoods"]),
		"[scale, 0.5][spr_nanotech][] Nanotech: " + string(stock[? "nanotech"]),
		"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(stock[? "advancedComponents"])
		)
			
		bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
		ds_list_clear(tempList);
	}
		
	#endregion
		
	#region Income
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]RESOURCE INCOME", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "resIncome"] = toggle(sys[? "resIncome"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
		
	if(sys[? "resIncome"])
	{
		var income = selected.income;
			
		ds_list_add(tempList,
		"[scale, 0.5][spr_energy][] Energy: " + string(income[? "energy"]),
		"[scale, 0.5][spr_metal][] Metal: " + string(income[? "metal"]),
		"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(income[? "rareElements"]),
		"[scale, 0.5][spr_gas][] Gas: " + string(income[? "gas"]),
		"[scale, 0.5][spr_crystal][] Crystal: " + string(income[? "crystal"]),
		"[scale, 0.5][spr_radioactives][] Radioactives: " + string(income[? "radioactives"]),
		"[scale, 0.5][spr_food][] Food: " + string(income[? "food"]),
		"[scale, 0.5][spr_alloys][] Alloys: " + string(income[? "alloys"]),
		"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(income[? "consumerGoods"]),
		"[scale, 0.5][spr_nanotech][] Nanotech: " + string(income[? "nanotech"]),
		"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(income[? "advancedComponents"])
		)
			
		bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
		ds_list_clear(tempList);
	}
		
	#endregion
		
	#region Upkeep
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]RESOURCE UPKEEP", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "resUpkeep"] = toggle(sys[? "resUpkeep"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
		
	if(sys[? "resUpkeep"])
	{
		var up = selected.upkeep;
			
		ds_list_add(tempList,
		"[scale, 0.5][spr_energy][] Energy: " + string(up[? "energy"]),
		"[scale, 0.5][spr_metal][] Metal: " + string(up[? "metal"]),
		"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(up[? "rareElements"]),
		"[scale, 0.5][spr_gas][] Gas: " + string(up[? "gas"]),
		"[scale, 0.5][spr_crystal][] Crystal: " + string(up[? "crystal"]),
		"[scale, 0.5][spr_radioactives][] Radioactives: " + string(up[? "radioactives"]),
		"[scale, 0.5][spr_food][] Food: " + string(up[? "food"]),
		"[scale, 0.5][spr_alloys][] Alloys: " + string(up[? "alloys"]),
		"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(up[? "consumerGoods"]),
		"[scale, 0.5][spr_nanotech][] Nanotech: " + string(up[? "nanotech"]),
		"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(up[? "advancedComponents"])
		)
			
		bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
		ds_list_clear(tempList);
	}
		
	#endregion
		
	#region Desired
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]RESOURCES DESIRED", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		sys[? "resDesired"] = toggle(sys[? "resDesired"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
		
	if(sys[? "resDesired"])
	{
		var need = selected.desired;
			
		ds_list_add(tempList,
		"[scale, 0.5][spr_energy][] Energy: " + string(need[? "energy"]),
		"[scale, 0.5][spr_metal][] Metal: " + string(need[? "metal"]),
		"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(need[? "rareElements"]),
		"[scale, 0.5][spr_gas][] Gas: " + string(need[? "gas"]),
		"[scale, 0.5][spr_crystal][] Crystal: " + string(need[? "crystal"]),
		"[scale, 0.5][spr_radioactives][] Radioactives: " + string(need[? "radioactives"]),
		"[scale, 0.5][spr_food][] Food: " + string(need[? "food"]),
		"[scale, 0.5][spr_alloys][] Alloys: " + string(need[? "alloys"]),
		"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(need[? "consumerGoods"]),
		"[scale, 0.5][spr_nanotech][] Nanotech: " + string(need[? "nanotech"]),
		"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(need[? "advancedComponents"])
		)
			
		bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
		ds_list_clear(tempList);
	}
		
	#endregion
		
	ds_list_clear(tempList);
	
	}
	#endregion
		
	ds_list_destroy(tempList);
		
	#endregion

}
else if(menuRight == 1 and selectedPlanet != pointer_null)
{
	#region Planet Inspector
	//Header
	scr_datumbox(bx, 0, 300, boxHei*2, true, tabColor1, "[fnt_defaultsmall]Planet " + string_upper(selectedPlanet.name), 290, 1, spr_basicBoxHeader_9slice);
	bhr += boxHei*2;
	
	#region Ownership/Basic
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]OWNERSHIP", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		planet[? "over"] = toggle(planet[? "over"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	var tempList = ds_list_create();
	
	if(planet[? "over"])
	{
		
		//var dayString = string(selected.daysSinceSettlement mod 30);
		var monthString = string((selectedPlanet.daysSinceSettlement div 30) mod 12);
		var yearString = string(selectedPlanet.daysSinceSettlement div 360);
	
		if(selectedPlanet.owner != pointer_null)
		{
		var ownCol = "[" + string(selectedPlanet.owner.id) + "]"
		scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "Owner: " + ownCol + selectedPlanet.ownerName, 290, 1, spr_basicBox_9slice);
		}
		else
		{
			scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "Unsettled", 290, 1, spr_basicBox_9slice);
		}
		
		#region Input
		if(doMouse)
		{
			if(selectedPlanet.owner != pointer_null and offMouseY > bhr and offMouseY < bhr + boxHei)
			{
				scr_openInspector(selectedPlanet.owner, "faction", true);
				surface_reset_target();
				audio_play_sound(sfx_select, -1, false);
				exit;
			}
		}
		#endregion
		
		bhr += boxHei;
	
		ds_list_add(tempList,
		selectedPlanet.type + " Planet",
		"System: " + selectedPlanet.system.name,
		"Settled for: " + yearString + " years, " + monthString + " months"
		);
	
		if(selectedPlanet.capitol)
		{
			ds_list_add(tempList, "Capitol System");
		}
	
		if(selectedPlanet.occupier != pointer_null)
		{
			ds_list_add(tempList, "Occupied by " + selectedPlanet.occupier.name);
		}
		
		bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
		ds_list_clear(tempList);
	
	}
	
	#endregion
	
	#region Planetary Traits
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]PLANETARY TRAITS", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		planet[? "traits"] = toggle(planet[? "traits"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(planet[? "traits"])
	{
	
		if(selectedPlanet.type != "Gas Giant")
		{
			ds_list_add(tempList,
			"Position: " + string(selectedPlanet.pos),
			"Distance: " + string(selectedPlanet.distance),
			"Size: " + string(selectedPlanet.size),
			"Density: " + string(selectedPlanet.density),
			"Day Length: " + string(selectedPlanet.dayLength),
			"Tectonic Activity: " + string(selectedPlanet.tectonicActivity),
			"Volcanic Activity: " + string(selectedPlanet.volcanicActivity),
			"Terrain Roughness: " + string(selectedPlanet.terrainRoughness),
			"Magnetic Field: " + string(selectedPlanet.magneticField),
			"Temperature: " + string(selectedPlanet.temperature),
			"Atmospheric Density: " + string(selectedPlanet.atmoDensity),
			"Atmospheric Breathability: " + string(selectedPlanet.atmoBreathability),
			"Oceanic Coverage: " + string(selectedPlanet.oceanCoverage),
			"Useable Water: " + string(selectedPlanet.useableWater),
			"Weather: " + string(selectedPlanet.weather),
			"Habitability: "+ string(selectedPlanet.habitability)
			);
		}
		else //shortened list for only relevant details
		{
			ds_list_add(tempList,
			"Position: " + string(selectedPlanet.pos),
			"Distance: " + string(selectedPlanet.distance),
			"Size: " + string(selectedPlanet.size),
			"Density: " + string(selectedPlanet.density),
			"Day Length: " + string(selectedPlanet.dayLength),
			"Magnetic Field: " + string(selectedPlanet.magneticField),
			"Temperature: " + string(selectedPlanet.temperature),
			"Weather: " + string(selectedPlanet.weather)
			);
		}
	
	}
		
	bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
	ds_list_clear(tempList);
	
	#endregion
	
	//Only relevant to rocky planets
	if(selectedPlanet.type != "Gas Giant")
	{
	
	#region Government
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]GOVERNMENT/POLITICS", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		planet[? "gov"] = toggle(planet[? "gov"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(planet[? "gov"])
	{
		ds_list_add(tempList,
		"Executive Approval: " + string(selectedPlanet.leaderApproval*100) + "%",
		"Legislative Approval: " + string(selectedPlanet.legiApproval*100) + "%",
		"Corruption: " + string(selectedPlanet.corruption*100) + "%"
		);
		
		bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
		ds_list_clear(tempList);
	}
	
	#endregion
	
	#region Demographics
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]DEMOGRAPHICS", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		planet[? "demo"] = toggle(planet[? "demo"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(planet[? "demo"])
	{
	
		ds_list_add(tempList,
		"Population: " + string(selectedPlanet.population) + " million",
		"Potential Colonists: " + string(selectedPlanet.colonists) + " million",
		"Base Max Pop: " + string(selectedPlanet.baseMaxPop) + " million",
		"Max Population: " + string(selectedPlanet.maxPopulation) + " million",
		"Growth Rate: " + string(selectedPlanet.growthRate*100) + "%",
		"Happiness: " + string(selectedPlanet.happiness*100) + "%",
		"Crime: " + string(selectedPlanet.crime*100) + "%",
		"Population: " + string(selectedPlanet.population)
		);
		
		bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
		ds_list_clear(tempList);
	
	}
	
	#endregion
	
	#region Infrastructure
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]INFRASTRUCTURE", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		planet[? "infra"] = toggle(planet[? "infra"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(planet[? "infra"])
	{
	
		ds_list_add(tempList,
		"Infrastructure: Level " + string(selectedPlanet.infraLevel),
		"Urbanization: Level " + string(selectedPlanet.urbanLevel),
		"Power Generation: Level " + string(selectedPlanet.powerLevel),
		"Mining: Level " + string(selectedPlanet.miningLevel),
		"Agriculture: Level " + string(selectedPlanet.agriLevel),
	
		"Alloy Foundries: Level " + string(selectedPlanet.alloyLevel),
		"Consumer Factories: Level " + string(selectedPlanet.cgLevel),
		"Nanotech Synthesizers: Level " + string(selectedPlanet.nanoLevel),
		"Advanced Manufacturing: Level " + string(selectedPlanet.acLevel)
		);
		
		bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
		ds_list_clear(tempList);
	
	}
	
	#endregion
	
	#region Resources
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]RESOURCES", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		planet[? "res"] = toggle(planet[? "res"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	bx += 10;
	
	if(planet[? "res"])
	{
	
	#region Productivity
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]PRODUCTIVITY", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		planet[? "resProduc"] = toggle(planet[? "resProduc"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(planet[? "resProduc"])
	{
		var prod = selectedPlanet.productivity;
			
		ds_list_add(tempList,
		"[scale, 0.5][spr_energy][] Energy: " + string(prod[? "energy"]*100) + "%",
		"[scale, 0.5][spr_metal][] Metal: " + string(prod[? "metal"]*100) + "%",
		"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(prod[? "rareElements"]*100) + "%",
		"[scale, 0.5][spr_gas][] Gas: " + string(prod[? "gas"]*100) + "%",
		"[scale, 0.5][spr_crystal][] Crystal: " + string(prod[? "crystal"]*100) + "%",
		"[scale, 0.5][spr_radioactives][] Radioactives: " + string(prod[? "radioactives"]*100) + "%",
		"[scale, 0.5][spr_food][] Food: " + string(prod[? "food"]*100) + "%",
		"[scale, 0.5][spr_alloys][] Alloys: " + string(prod[? "alloys"]*100) + "%",
		"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(prod[? "consumerGoods"]*100) + "%",
		"[scale, 0.5][spr_nanotech][] Nanotech: " + string(prod[? "nanotech"]*100) + "%",
		"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(prod[? "advancedComponents"]*100) + "%"
		)
			
		bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
		ds_list_clear(tempList);
	}
	
	#endregion
	
	#region Income
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]INCOME", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		planet[? "resIncome"] = toggle(planet[? "resIncome"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(planet[? "resIncome"])
	{
		var income = selectedPlanet.resources;
			
		ds_list_add(tempList,
		"[scale, 0.5][spr_energy][] Energy: " + string(income[? "energy"]),
		"[scale, 0.5][spr_metal][] Metal: " + string(income[? "metal"]),
		"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(income[? "rareElements"]),
		"[scale, 0.5][spr_gas][] Gas: " + string(income[? "gas"]),
		"[scale, 0.5][spr_crystal][] Crystal: " + string(income[? "crystal"]),
		"[scale, 0.5][spr_radioactives][] Radioactives: " + string(income[? "radioactives"]),
		"[scale, 0.5][spr_food][] Food: " + string(income[? "food"]),
		"[scale, 0.5][spr_alloys][] Alloys: " + string(income[? "alloys"]),
		"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(income[? "consumerGoods"]),
		"[scale, 0.5][spr_nanotech][] Nanotech: " + string(income[? "nanotech"]),
		"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(income[? "advancedComponents"])
		)
			
		bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
		ds_list_clear(tempList);
	}
		
	#endregion
	
	#region Upkeep
	//Header
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]RESOURCE UPKEEP", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		if(planet[? "resUpkeep"])
		{
			planet[? "resUpkeep"] = false;
		}
		else
		{
			planet[? "resUpkeep"] = true;
		}
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
		
	if(planet[? "resUpkeep"])
	{
		var up = selectedPlanet.upkeep;
			
		ds_list_add(tempList,
		"[scale, 0.5][spr_energy][] Energy: " + string(up[? "energy"]),
		"[scale, 0.5][spr_metal][] Metal: " + string(up[? "metal"]),
		"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(up[? "rareElements"]),
		"[scale, 0.5][spr_gas][] Gas: " + string(up[? "gas"]),
		"[scale, 0.5][spr_crystal][] Crystal: " + string(up[? "crystal"]),
		"[scale, 0.5][spr_radioactives][] Radioactives: " + string(up[? "radioactives"]),
		"[scale, 0.5][spr_food][] Food: " + string(up[? "food"]),
		"[scale, 0.5][spr_alloys][] Alloys: " + string(up[? "alloys"]),
		"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(up[? "consumerGoods"]),
		"[scale, 0.5][spr_nanotech][] Nanotech: " + string(up[? "nanotech"]),
		"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(up[? "advancedComponents"])
		)
			
		bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
		ds_list_clear(tempList);
	}
		
	#endregion
	
	}
	
	#endregion
	
	}
	//Cleanup
	ds_list_destroy(tempList);
	
	#endregion

}
else if(menuRight == 2 and selectedFaction != pointer_null)
{
	#region Country Inspector
	//Header
	scribble_draw_set_blend(selectedFaction.color1, 1);
	scr_datumbox(bx, 0, 300, boxHei*2, true, tabColor1, "[fnt_defaultsmall]" + string_upper(selectedFaction.name), 290, 1, spr_basicBoxHeader_9slice);
	bhr += boxHei*2;
	scribble_draw_set_blend(c_white, 1);
		
	var tempList = ds_list_create();
		
	#region Government
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]GOVERNMENT", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		faction[? "gov"] = toggle(faction[? "gov"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(faction[? "gov"])
	{
	
	ds_list_add(tempList, 
	"Type: " + selectedFaction.authority, 
	"Structure: " + selectedFaction.govType,
	"Leader: " + selectedFaction.leaderTitle + " " + selectedFaction.leaderName
	);
		
	bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
	ds_list_clear(tempList);
	
	}
		
	#endregion
		
	#region Territory
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]TERRITORY", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		faction[? "terr"] = toggle(faction[? "terr"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(faction[? "terr"])
	{
	
	#region Input
	if(doMouse)
	{
		//Capitol System
		if(offMouseY > bhr and offMouseY < bhr + boxHei)
		{
			scr_openInspector(selectedFaction.capitolSystem, "system", true);
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			exit;
			
		}
		//Capitol Planet
		else if(offMouseY > bhr + boxHei and offMouseY < bhr + boxHei*2)
		{
			scr_openInspector(selectedFaction.capitolPlanet, "planet", true);
			surface_reset_target();
			audio_play_sound(sfx_select, -1, false);
			exit;
			
		}
	}
	#endregion
	
	ds_list_add(tempList, 
	"Capitol System: " + selectedFaction.capitolSystem.name, 
	"Capitol Planet: " + selectedFaction.capitolPlanet.name,
	"Controlled Systems: " + string(selectedFaction.systems),
	"Controlled Planets: " + string(selectedFaction.planets)
	);
		
	bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
	ds_list_clear(tempList);
	
	bx += 10;
	
	#region Colonization
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]COLONIZATION", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		faction[? "terrColo"] = toggle(faction[? "terrColo"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(faction[? "terrColo"])
	{
		ds_list_add(tempList, 
		"Available Colonists: " + string(selectedFaction.colonists) + " million",
		"Colonists Wanted: " + string(selectedFaction.targetPlanetPopsNeeded) + " million",
		"Colony Ship Cost: " + string(selectedFaction.cCost)
		);
		
		bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
		ds_list_clear(tempList);
	}
	#endregion
	
	bx -= 10;
	
	}
	
	#endregion
		
	#region Demographics
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]DEMOGRAPHICS", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		faction[? "demo"] = toggle(faction[? "demo"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(faction[? "demo"])
	{
		
	ds_list_add(tempList, 
	"Population: " + string(selectedFaction.population) + " million",
	"Max. Population: " + string(selectedFaction.maxPopulation) + " million",
	"Growth Bonus: " + string(selectedFaction.popGrowthBonus * 100) + "%",
	"Upkeep Bonus: " + string(selectedFaction.popUpkeepBonus * 100) + "%",
	"Happiness Bonus: " + string(selectedFaction.popHappinessBonus * 100) + "%"
	);
		
	bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
	ds_list_clear(tempList);
	
	}
	
	#endregion
			
	#region Budget
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]BUDGETING", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		faction[? "budget"] = toggle(faction[? "budget"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(faction[? "budget"])
	{
		
	ds_list_add(tempList, 
	"Budget: " + string(selectedFaction.budget),
	"Social Spending: " + string(selectedFaction.socialSpending * 100) + "%",
	"Naval Spending: " + string(selectedFaction.navalSpending * 100) + "%",
	"Army Spending: " + string(selectedFaction.armySpending * 100) + "%",
	"Social Budget: " + string(selectedFaction.socialBudget),
	"Naval Budget: " + string(selectedFaction.navalBudget),
	"Army Budget: " + string(selectedFaction.armyBudget)
	);
		
	bhr += scr_datumList(bx, bhr, 300, boxHei, tempList);
	ds_list_clear(tempList);
	
	}
	
	#endregion
	
	#region Economy
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor1, "[fnt_defaultverysmallbold]ECONOMY", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		faction[? "econ"] = toggle(faction[? "econ"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(faction[? "econ"])
	{
	
	bx += 10;
	
	#region Resource Valuation
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]VALUATION", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		faction[? "econValue"] = toggle(faction[? "econValue"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(faction[? "econValue"])
	{
	
	var val = selectedFaction.value;
			
	ds_list_add(tempList,
	"[scale, 0.5][spr_energy][] Energy: " + string(val[? "energy"]),
	"[scale, 0.5][spr_metal][] Metal: " + string(val[? "metal"]),
	"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(val[? "rareElements"]),
	"[scale, 0.5][spr_gas][] Gas: " + string(val[? "gas"]),
	"[scale, 0.5][spr_crystal][] Crystal: " + string(val[? "crystal"]),
	"[scale, 0.5][spr_radioactives][] Radioactives: " + string(val[? "radioactives"]),
	"[scale, 0.5][spr_food][] Food: " + string(val[? "food"]),
	"[scale, 0.5][spr_alloys][] Alloys: " + string(val[? "alloys"]),
	"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(val[? "consumerGoods"]),
	"[scale, 0.5][spr_nanotech][] Nanotech: " + string(val[? "nanotech"]),
	"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(val[? "advancedComponents"])
	)
			
	bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
	ds_list_clear(tempList);
	
	}
	
	#endregion
	
	#region Stockpile
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]STOCKPILE", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		faction[? "econStock"] = toggle(faction[? "econStock"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(faction[? "econStock"])
	{
	
	var stock = selectedFaction.stockpile;
			
	ds_list_add(tempList,
	"[scale, 0.5][spr_energy][] Energy: " + string(stock[? "energy"]),
	"[scale, 0.5][spr_metal][] Metal: " + string(stock[? "metal"]),
	"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(stock[? "rareElements"]),
	"[scale, 0.5][spr_gas][] Gas: " + string(stock[? "gas"]),
	"[scale, 0.5][spr_crystal][] Crystal: " + string(stock[? "crystal"]),
	"[scale, 0.5][spr_radioactives][] Radioactives: " + string(stock[? "radioactives"]),
	"[scale, 0.5][spr_food][] Food: " + string(stock[? "food"]),
	"[scale, 0.5][spr_alloys][] Alloys: " + string(stock[? "alloys"]),
	"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(stock[? "consumerGoods"]),
	"[scale, 0.5][spr_nanotech][] Nanotech: " + string(stock[? "nanotech"]),
	"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(stock[? "advancedComponents"])
	)
			
	bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
	ds_list_clear(tempList);
	
	}
	
	#endregion
	
	#region Income
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]INCOME", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		faction[? "econIncome"] = toggle(faction[? "econIncome"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(faction[? "econIncome"])
	{
	
	var inc = selectedFaction.income;
			
	ds_list_add(tempList,
	"[scale, 0.5][spr_energy][] Energy: " + string(inc[? "energy"]),
	"[scale, 0.5][spr_metal][] Metal: " + string(inc[? "metal"]),
	"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(inc[? "rareElements"]),
	"[scale, 0.5][spr_gas][] Gas: " + string(inc[? "gas"]),
	"[scale, 0.5][spr_crystal][] Crystal: " + string(inc[? "crystal"]),
	"[scale, 0.5][spr_radioactives][] Radioactives: " + string(inc[? "radioactives"]),
	"[scale, 0.5][spr_food][] Food: " + string(inc[? "food"]),
	"[scale, 0.5][spr_alloys][] Alloys: " + string(inc[? "alloys"]),
	"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(inc[? "consumerGoods"]),
	"[scale, 0.5][spr_nanotech][] Nanotech: " + string(inc[? "nanotech"]),
	"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(inc[? "advancedComponents"])
	)
			
	bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
	ds_list_clear(tempList);
	
	}
	
	#endregion
	
	#region Upkeep
	scr_datumbox(bx, bhr, 300, boxHei, true, tabColor2, "[fnt_defaultverysmallbold]UPKEEP", 290, 1, spr_basicBoxHeader_9slice);
	
	#region Header Input
	if(doMouse and offMouseY > bhr and offMouseY < bhr + boxHei)
	{
		faction[? "econUpkeep"] = toggle(faction[? "econUpkeep"], true);
		
		surface_reset_target();
		audio_play_sound(sfx_select, -1, false);
		freezeInput = true;
		event_user(1);
		exit;
	}
	#endregion
	
	bhr += boxHei;
	
	if(faction[? "econUpkeep"])
	{
	
	var up = selectedFaction.upkeep;
			
	ds_list_add(tempList,
	"[scale, 0.5][spr_energy][] Energy: " + string(up[? "energy"]),
	"[scale, 0.5][spr_metal][] Metal: " + string(up[? "metal"]),
	"[scale, 0.5][spr_rareElements][] Rare Elements: " + string(up[? "rareElements"]),
	"[scale, 0.5][spr_gas][] Gas: " + string(up[? "gas"]),
	"[scale, 0.5][spr_crystal][] Crystal: " + string(up[? "crystal"]),
	"[scale, 0.5][spr_radioactives][] Radioactives: " + string(up[? "radioactives"]),
	"[scale, 0.5][spr_food][] Food: " + string(up[? "food"]),
	"[scale, 0.5][spr_alloys][] Alloys: " + string(up[? "alloys"]),
	"[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(up[? "consumerGoods"]),
	"[scale, 0.5][spr_nanotech][] Nanotech: " + string(up[? "nanotech"]),
	"[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(up[? "advancedComponents"])
	)
			
	bhr += scr_datumList(bx, bhr, 300 - bx, boxHei, tempList)
			
	ds_list_clear(tempList);
	
	}
	
	#endregion
	
	bx -= 10;
	
	}
	
	#endregion
	
	//Cleanup
	ds_list_destroy(tempList);
		
	#endregion

}
surface_reset_target();
#endregion

uiUpdateCount ++;
freezeInput = false;
show_debug_message("Updated the UI!(" + string(uiUpdateCount) + ")");