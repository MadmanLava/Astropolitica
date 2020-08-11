#region Variable establishment
display_set_gui_maximize();
//draw_set_halign(fa_center);
//draw_set_valign(fa_center);

var mw = display_get_gui_width();
var mh = display_get_gui_height();

var cx = mw/2;
var cy = mh/2;

var mousex = window_mouse_get_x();
var mousey = window_mouse_get_y();

var boxw = (mw - 250)/4;
var boxh = (mh/10)

var bx = 50;
var by = mh - boxh - 50;

var bx2 = bx + boxw;
var by2 = by + boxh;

var textx = bx + (boxw/2)
var texty = (boxh/2) + by;
var textScale = (mw/1920) / 2;
var increment = 0;

var boxColor = c_white;

#endregion

#region Main Menu
if(menu == 1)
{
	//scribble sets
	
	//Title
	
	draw_set_font(fnt_title);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_text(cx, 100, "ASTROPOLITICA");
	draw_text_transformed(cx, 175, global.version, 0.5, 0.5, 0);
	draw_text_transformed(cx, 250, global.currentSplash, 0.5, 0.5, 0);
	
	scribble_draw_set_box_align(fa_center, fa_middle);
	//scribble_draw(cx, 100, "[fnt_title][scale,2]ASTROPOLITICA");
	//scribble_draw(cx, 175, "[fnt_title]" + global.version);
	//scribble_draw(cx, 250, "[fnt_title][scale,0.75]" + global.currentSplash);
	
	#region Buttons
	//scribble
	scribble_draw_set_transform(textScale, textScale, 0);
	
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			menu = 2;
			audio_play_sound(sfx_select, -1, false);
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor);
	scribble_draw(textx, texty, "[fnt_title]Start");
	
	textx += (50 + boxw);
	bx += (50 + boxw);
	
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			//menu = 3;
			//buttonHold = true;
			audio_play_sound(sfx_select, -1, false);
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor);
	scribble_draw(textx, texty, "[fnt_title]Discrete Tools");

	textx += (50 + boxw);
	bx += (50 + boxw);
	
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			menu = 4;
			audio_play_sound(sfx_select, -1, false);
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion

	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor);
	scribble_draw(textx, texty, "[fnt_title]Options");
	textx += (50 + boxw);
	bx += (50 + boxw);
	
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			game_end();
			audio_play_sound(sfx_select, -1, false);
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor);
	scribble_draw(textx, texty, "[fnt_title]Quit");
	textx += (50 + boxw);
	bx += (50 + boxw);
	
	#endregion

	#region Discord + Trello buttons

	//Discord
	draw_sprite(spr_discord, 0, 50, mh-250);
	if(point_in_rectangle(mousex, mousey, 50, mh-250, 114, mh-186) and mouse_check_button_released(mb_left))
	{
		url_open(global.discordLink)
		show_debug_message("discord");
	}
	
	//Trello
	draw_sprite(spr_trello, 0, 124, mh-250);
	if(point_in_rectangle(mousex, mousey, 124, mh-250, 188, mh-186) and mouse_check_button_released(mb_left))
	{
		url_open(global.trelloLink)
		show_debug_message("trello");
	}
	
	#endregion
}
#endregion

#region Generator Settings
if(menu == 2)
{
	#region setup
	draw_set_font(fnt_defaultsmall);
	draw_set_halign(fa_left);
	draw_set_valign(fa_center);
	
	var boxw = 750;
	var boxh = mh;

	var bx = cx - boxw/2;
	var by = cy - boxh/2;
	
	var bx2 = bx + boxw;
	var by2 = by + boxh;

	var suby = 0;
	var subh = string_height("M") + 5;
	
	if(genMenuOpen)
	{
		var altColor = c_gray;
	}
	else
	{
		var altColor = c_white;
	}
	scribble_draw_reset();
	scribble_draw_set_box_align(fa_left, fa_middle);
	#endregion

	//Box
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, c_white)
	suby = by + 50 + subh;
	
	#region Galaxy Settings
	if(genMenu == "Galaxy Settings")
	{
		#region Seed
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Seed: " + string(global.seed), 10000, 1, spr_basicBox_9slice);
		
		if(!genMenuOpen)
		{
			global.seed = scr_button(bx + boxw-90, suby, subh, subh, spr_button_9slice, true, "value", true, global.seed, mousex, mousey, 1, 0, 10000);
			
			global.seed = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-400, spr_sliderGrab, 1, global.seed, 0, 10000, true, bx + boxw - 15, irandom_range(0, 10000)))
		}
		
		suby += subh-1;
		#endregion
		
		#region Generation Mode
		if(global.genMode == 0)
		{
			var modeText = "Normal"
		}
		else if(global.genMode == 1)
		{
			var modeText = "Tree"
		}
		
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Generation Mode: " + modeText, 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			global.genMode = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.genMode, mousex, mousey, 1, 0, 1);
		}
		
		suby += subh-1;
		#endregion
		
		#region Galaxy Radius
		//scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Galactic Radius: " + string(global.galaxyRadius), altColor, 10000, 1, spr_basicBox_9slice, altColor)
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Galactic Radius: " + string(global.galaxyRadius), 10000, 1, spr_basicBox_9slice);
		if(!genMenuOpen)
		{
			//global.galaxyRadius = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", true, global.galaxyRadius, mousex, mousey, 100, 2500, 25000);
			global.galaxyRadius = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.galaxyRadius, 2500, 25000, true, bx + boxw - 15, 10000))
		}
	
		suby += subh-1;
		#endregion
		
		#region Star Count
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Star Count: " + string(global.starCount), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.starCount = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", true, global.starCount, mousex, mousey, 50, global.factionCount, 10000);
			global.starCount = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.starCount, global.factionCount*2, 10000, true, bx + boxw - 15, 1000));
		}
	
		suby += subh-1;
		#endregion
	
		#region Star Gen Speed
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Star Gen Multiplier: " + string(global.starGenSpeed), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.starGenSpeed = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.starGenSpeed, mousex, mousey, 2, 10, 20);
			global.starGenSpeed = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.starGenSpeed, 10, 30, true, bx + boxw - 15, 20));
		}
	
		suby += subh-1;
		#endregion
	
		#region Neighbor Generation Cap
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Maximum Star Children: " + string(global.starGenCap), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.starGenCap = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.starGenCap, mousex, mousey, 1, 1, 10);
			global.starGenCap = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.starGenCap, 1, 10, true, bx + boxw - 15, 4));
		}
	
		suby += subh-1;
		#endregion
	
		#region Maximum Failed Tries
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Max Failed Star Children: " + string(global.maxFailedTries), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.maxFailedTries = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.maxFailedTries, mousex, mousey, 10, 30, 90);
			global.maxFailedTries = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.maxFailedTries, 20, 90, true, bx + boxw - 15, 20));
		}
	
		suby += subh-1;
		#endregion
	
		#region Lane Radius
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Star Proximity: " + string(global.laneRadius), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.laneRadius = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", true, global.laneRadius, mousex, mousey, 5, 250, 1000);
			global.laneRadius = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.laneRadius, 250, 1000, true, bx + boxw - 15, 250));
			global.pruneRadius = global.laneRadius - 50;
		}
	
		suby += subh-1;
		#endregion
		
		#region Center Density Node
		
		if(global.centerRadNode)
		{
			var centerText = "True";
		}
		else
		{
			var centerText = "False";
		}
		
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Place Density Node At Center: " + centerText, 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			global.centerRadNode = scr_button(bx2 - (subh), suby, subh, subh, spr_button_9slice, true, "toggle", false, global.centerRadNode, mousex, mousey, 0, 0, 0);
		}
		
		suby += subh-1;
		#endregion
		
		#region Density Node Count
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "# of Density Nodes: " + string(global.densityNodes), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.densityNodes = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.densityNodes, mousex, mousey, 1, 0, 10);
			global.densityNodes = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.densityNodes, 0, 10, true, bx + boxw - 15, 0));
		}
		
		suby += subh-1;
		#endregion
		
		#region Density Node Radius
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Density Placement Radius: " + string(global.densityRadius), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.densityRadius = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", true, global.densityRadius, mousex, mousey, 50, global.galaxyRadius/8, global.galaxyRadius);
			global.densityRadius = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.densityRadius, 0, global.galaxyRadius, true, bx + boxw - 15, 0));
		}
		
		suby += subh-1;
		#endregion
		
		#region Density Factor
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Density Factor: " + string(global.densityFactor), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.densityFactor = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", true, global.densityFactor, mousex, mousey, 5, -(floor(global.laneRadius*2)), floor(global.laneRadius*4));
			global.densityFactor = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.densityFactor, -(floor(global.laneRadius*2)), floor(global.laneRadius*4), true, bx + boxw - 15, 0));
		}
		
		suby += subh-1;
		#endregion
	}
	#endregion
	
	#region System Settings
	if(genMenu == "System Settings")
	{
		#region Forced extra planets
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Forced Additional Planets: " + string(global.forcedExtraPlanets), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.forcedExtraPlanets = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.forcedExtraPlanets, mousex, mousey, 1, 0, 10);
			global.forcedExtraPlanets = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.forcedExtraPlanets, 0, 10, true, bx + boxw - 15, 0));
		}
		#endregion
	}
	
	#endregion
	
	#region Star Settings
	if(genMenu == "Star Settings")
	{
		#region Remnant chance
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Stellar Remnant Chance: " + string(global.remnantChance), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.remnantChance = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.remnantChance, mousex, mousey, 1, 0, 50);
			global.remnantChance = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.remnantChance, 0, 50, true, bx + boxw - 15, 3));
		}
		#endregion
	}
	
	#endregion
	
	#region Planet Settings
	if(genMenu == "Planet Settings")
	{
		#region Habitability bonus
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Habitability Modifier: " + string(global.planetHabitabilityBonus), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.planetHabitabilityBonus = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.planetHabitabilityBonus, mousex, mousey, 1, -10, 10);
			global.planetHabitabilityBonus = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.planetHabitabilityBonus, -10, 10, true, bx + boxw - 15, 0));
		}
		
		#endregion
	}
	
	#endregion
	
	#region Faction Settings
	if(genMenu == "Country Settings")
	{
		#region Faction Count
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Countries: " + string(global.factionCount), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.factionCount = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.factionCount, mousex, mousey, 1, 1, 100);
			global.factionCount = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.factionCount, 1, 100, true, bx + boxw - 15, 10));
		}
	
		suby += subh-1;
		#endregion
		
		#region Vanity Name Chance
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Vanity Name Chance: " + string(global.vanityChance), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.factionCount = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.factionCount, mousex, mousey, 1, 1, 100);
			global.vanityChance = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.vanityChance, 0, 100, true, bx + boxw - 15, 10));
		}
		#endregion
		
		#region Pregen Faction Count
		/*
		scr_datumboxold(bx, suby, boxw, subh, true, altColor, "Pregenerated Countries: " + string(global.pregenFactionCount), 10000, 1, spr_basicBox_9slice)
		if(!genMenuOpen)
		{
			//global.pregenFactionCount = scr_button(bx2 - (subh*2), suby, subh, subh, spr_button_9slice, true, "value", false, global.pregenFactionCount, mousex, mousey, 1, 0, global.factionCount);
			global.pregenFactionCount = floor(scr_slider(bx + 300, suby + subh/2 - 2, mousex, mousey, boxw-350, spr_sliderGrab, 1, global.pregenFactionCount, 0, global.factionCount, true, bx + boxw - 15, 10));
		}
	
		suby += subh-1;
		*/
		#endregion
	}
	
	#endregion
	
	#region Gameplay Settings
	if(genMenu == "Gameplay Settings")
	{
		
	}
	
	#endregion
	
	#region Start and back
	draw_set_halign(fa_center);
	//Start
	if(point_in_rectangle(mousex, mousey, bx2, 0, bx2+100, 50))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			part_emitter_clear(global.particleSystem, global.starEmitter)
			random_set_seed(global.seed);
			global.generationTime = current_time;
			global.genStage = gen.preStars;
			room_goto(simroom);
			audio_play_sound(sfx_select, -1, false);
		}
	}
	else
	{
		boxColor = c_white;
	}
	
	scr_nine_slice(spr_basicBox_9slice, bx2, 0, 100, 50, true, boxColor);
	draw_text(bx2 + 50, 25, "START");
	
	//Back
	if(point_in_rectangle(mousex, mousey, bx2, 50, bx2+100, 100))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			menu = 1;
			audio_play_sound(sfx_select, -1, false);
		}
	}
	else
	{
		boxColor = c_white;
	}
	
	scr_nine_slice(spr_basicBox_9slice, bx2, 50, 100, 50, true, boxColor);
	draw_text(bx2 + 50, 75, "BACK");
	
	#endregion
	
	#region Header and dropdown
	scr_nine_slice(spr_basicBoxHeader_9slice, bx, 0, boxw, 50, true, c_white);
	draw_text(bx + boxw/2, 25, "GENERATION SETTINGS");
	
	var tempQueue = ds_queue_create();
	ds_queue_copy(tempQueue, genMenuQueue);
	var drop = scr_dropdown(bx, by + 50, boxw, subh, spr_basicBoxHeader_9slice, spr_basicBox_9slice, c_gray, c_white, c_yellow, tempQueue, fnt_defaultsmall, c_white, 1, genMenu, genMenuOpen)
	if(!is_string(drop))
	{
		if(drop == true)
		{
			genMenuOpen = true;
		}
		else if(drop == false)
		{
			genMenuOpen = false;
		}
	}
	else
	{
		genMenuOpen = false;
		switch(drop)
		{
			case "Galaxy Settings":
				genMenu = "Galaxy Settings";
				break;
			case "System Settings":
				genMenu = "System Settings";
				break;
			case "Star Settings":
				genMenu = "Star Settings";
				break;
			case "Planet Settings":
				genMenu = "Planet Settings";
				break;
			case "Country Settings":
				genMenu = "Country Settings";
				break;
			case "Gameplay Settings":
				genMenu = "Gameplay Settings";
				break;
		}
	}
	
	#endregion

}
#endregion

#region Discrete Tools
if(menu == 3)
{
	var optionsCount = 7;
	boxColor = c_white;
	boxw = 400;
	boxh = 100;
	increment = boxh/2;
	bx = cx - boxw/2;
	by = cy - (boxh * (optionsCount) + (increment*optionsCount-1))/2
	draw_set_font(fnt_title);
	
	#region Name Generator
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor)
	draw_text_transformed(bx + boxw/2, by + boxh/2, "NAME GENERATOR", textScale*(2/3), textScale*(2/3), 0)
	by += boxh + increment;
	#endregion
	
	#region Flag Designer
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			menu = 6;
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor)
	draw_text_transformed(bx + boxw/2, by + boxh/2, "FLAG DESIGNER", textScale*(2/3), textScale*(2/3), 0)
	by += boxh + increment;
	#endregion
	
	#region Country Designer
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor)
	draw_text_transformed(bx + boxw/2, by + boxh/2, "COUNTRY DESIGNER", textScale*(2/3), textScale*(2/3), 0)
	by += boxh + increment;
	#endregion
	
	#region System Designer
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor)
	draw_text_transformed(bx + boxw/2, by + boxh/2, "SYSTEM DESIGNER", textScale*(2/3), textScale*(2/3), 0)
	by += boxh + increment;
	#endregion
	
	#region Battle Simulator
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor)
	draw_text_transformed(bx + boxw/2, by + boxh/2, "BATTLE SIMULATOR", textScale*(2/3), textScale*(2/3), 0)
	by += boxh + increment;
	#endregion
	
	#region Mod Loader
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor)
	draw_text_transformed(bx + boxw/2, by + boxh/2, "MOD LOADER", textScale*(2/3), textScale*(2/3), 0)
	by += boxh + increment;
	#endregion
	
	#region Back
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left) and !buttonHold)
		{
			menu = 1;
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor)
	draw_text_transformed(bx + boxw/2, by + boxh/2, "BACK", textScale*(2/3), textScale*(2/3), 0)
	by += boxh + increment;
	#endregion
}

#endregion

#region Options
if(menu == 4)
{
	draw_set_halign(fa_center);
	var optionsCount = 2;
	boxColor = c_white;
	boxw = 400;
	boxh = 100;
	increment = boxh/2;
	bx = cx - boxw/2;
	by = cy - (boxh * (optionsCount) + (increment*optionsCount-1))/2
	draw_set_font(fnt_title);
	
	//Guide
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		
		if(mouse_check_button_released(mb_left))
		{
			menu = -2;
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor)
	draw_text_transformed(bx + boxw/2, by + boxh/2, "GUIDE", textScale*(2/3), textScale*(2/3), 0)
	by += boxh + increment;
	
	//Back
	#region Input
	if(point_in_rectangle(mousex, mousey, bx, by, bx + boxw, by + boxh))
	{
		boxColor = c_yellow;
		if(mouse_check_button_released(mb_left) and !buttonHold)
		{
			menu = 1;
		}
	}
	else
	{
		boxColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, bx, by, boxw, boxh, true, boxColor)
	draw_text_transformed(bx + boxw/2, by + boxh/2, "BACK", textScale*(2/3), textScale*(2/3), 0)
	by += boxh + increment;
	
}

#endregion

#region Guide
if(menu == -2)
{
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(fnt_defaultsmall);
	scribble_draw_set_box_align(fa_left, fa_center)
	
	//vars
	var guideWid = 1000;
	var xPos = cx-(guideWid/2);
	var textPos = 35 + guideScroll;
	
	//scroll input
	if(mouse_wheel_down())
	{
		guideScroll -= scrollSpeed;
	}
	else if(mouse_wheel_up() and guideScroll < 0)
	{
		guideScroll += scrollSpeed;
	}
	
	//box
	scr_nine_slice(spr_basicBox_9slice, xPos, 0, guideWid, mh, true, c_white);
	
	//back button
	var backCol = c_white;
	if(point_in_rectangle(mousex, mousey, cx+(guideWid/2), 0, cx+(guideWid/2)+ 70, 50))
	{
		backCol = c_yellow;
		
		if(mouse_check_button_released(mb_left))
		{
			menu = 4;
			draw_set_halign(fa_center);
			draw_set_valign(fa_center);
		}
	}
	scr_datumbox(cx+(guideWid/2), 0, 70, 50, true, backCol, "[scale, 0.5][fnt_title]BACK", 1000, 1, spr_basicBox_9slice);
	
	//Text
	scr_datumbox(xPos, textPos-35, guideWid, 30, true, c_white, "[scale, 0.5][fnt_title]GENERAL GAME GUIDE", 1000, 1, spr_basicBoxHeader_9slice)
	draw_text_ext(xPos + 5, textPos, global.guideText, -1, 960)
}

#endregion

#region Discrete Tools UI

#region Name Generator
if(menu == 5)
{
	
}

#endregion
/*
#region Flag Designer
if(menu == 6)
{

	draw_set_font(fnt_defaultsmall);
	draw_set_halign(fa_left);
	draw_set_valign(fa_center);
	
	var boxw = 128;
	var boxh = mh;

	var bx = cx - boxw/2;
	var by = cy - boxh/2;
	
	var bx2 = bx + boxw;
	var by2 = by + boxh;
	
	var drawColor = c_white;
	var subh = string_height("M") + 5;
	
	//Base box
	var x3 = cx-boxw*2.5;
	var offY3 = 0 + flagScroll3;
	scr_nine_slice(spr_basicBox_9slice, x3, by, boxw, boxh, true, c_white)
	
	#region Emblem Options
	var i = 0;
	
	#region Scrolling
	if(point_in_rectangle(mousex, mousey, x3, by, (x3) + boxw, mh))
	{
		if(mouse_wheel_down())
		{
			flagScroll3 = flagScroll3 - scrollSpeed;
		}
		else if(mouse_wheel_up())
		{
			flagScroll3 = flagScroll3 + scrollSpeed;
		}
		
		//Limit
		if(flagScroll3 > 0)
		{
			flagScroll3 = 0;
		}
	}
	#endregion
	
	#region Blank
	draw_sprite(spr_flagBlank, -1, (x3) + 64, offY3 + 64)
	
	#region Input
	if(point_in_rectangle(mousex, mousey, x3, offY3, x3 + boxw/2, offY3 + boxw/2))
	{
		drawColor = c_yellow;
		
		if(mouse_check_button_released(mb_left))
		{
			flag[? ("emblem" + string(flagTab))] = spr_flagBlank;
			flag[? ("emblemPos" + string(flagTab))] = 0;
		}
	}
	else
	{
		drawColor = c_white;
	}
	
	#endregion
	
	draw_sprite_ext(spr_selectorboxsmall, -1, (x3) + 32, offY3 + 32, 1, 1, 0, drawColor, 1);
	
	offY3 += 64;
	
	#endregion
	
	#region Round Elements
	i = 0;
	repeat((sprite_get_width(spr_flagSetRound)/128))
	{
		#region Input
		if(point_in_rectangle(mousex, mousey, x3, offY3, x3 + boxw/2, offY3 + boxw/2))
		{
			drawColor = c_yellow;
		
			if(mouse_check_button_released(mb_left))
			{
				flag[? ("emblem" + string(flagTab))] = spr_flagSetRound;
				flag[? ("emblempos" + string(flagTab))] = i;
			}
		}
		else
		{
			drawColor = c_white;
		}
	
		#endregion
		
		draw_sprite_part_ext(spr_flagSetRound, -1, (i * 128), 0, 128, 128, (x3), offY3, 0.5, 0.5, c_white, 1);
		draw_sprite_ext(spr_selectorboxsmall, -1, (x3) + 32, offY3 + 32, 1, 1, 0, drawColor, 1);
		
		offY3 += 64;
		i++
	}
	
	#endregion
	
	#endregion
	
	#region Crosses
	i = 0;
	repeat((sprite_get_width(spr_flagSetCross)/128))
	{
		#region Input
		if(point_in_rectangle(mousex, mousey, x3, offY3, x3 + boxw/2, offY3 + boxw/2))
		{
			drawColor = c_yellow;
		
			if(mouse_check_button_released(mb_left))
			{
				flag[? ("emblem" + string(flagTab))] = spr_flagSetCross;
				flag[? ("emblempos" + string(flagTab))] = i;
			}
		}
		else
		{
			drawColor = c_white;
		}
	
		#endregion
		
		draw_sprite_part_ext(spr_flagSetCross, -1, (i * 128), 0, 128, 128, (x3), offY3, 0.5, 0.5, c_white, 1);
		draw_sprite_ext(spr_selectorboxsmall, -1, (x3) + 32, offY3 + 32, 1, 1, 0, drawColor, 1);
		
		offY3 += 64;
		i++
	}
	
	#region 4 point star
	i = 0;
	repeat((sprite_get_width(spr_flagSetFourstar)/128))
	{
		#region Input
		if(point_in_rectangle(mousex, mousey, x3, offY3, x3 + boxw/2, offY3 + boxw/2))
		{
			drawColor = c_yellow;
		
			if(mouse_check_button_released(mb_left))
			{
				flag[? ("emblem" + string(flagTab))] = spr_flagSetFourstar;
				flag[? ("emblempos" + string(flagTab))] = i;
			}
		}
		else
		{
			drawColor = c_white;
		}
	
		#endregion
		
		draw_sprite_part_ext(spr_flagSetFourstar, -1, (i * 128), 0, 128, 128, (x3), offY3, 0.5, 0.5, c_white, 1);
		draw_sprite_ext(spr_selectorboxsmall, -1, (x3) + 32, offY3 + 32, 1, 1, 0, drawColor, 1);
		
		offY3 += 64;
		i++
	}
	
	#endregion
	
	#endregion
	
	#region Options Box
	//Base box
	scr_nine_slice(spr_basicBox_9slice, cx-boxw*2, by, boxw*5, boxh, true, c_white)
	
	//Header
	scr_datumbox(cx-boxw*2, by, boxw*3, subh, true, c_white, "FLAG DESIGNER", 10000, 1, spr_basicBoxHeader_9slice);
	
	#region Tabs
	
	#region Input
	if(point_in_rectangle(mousex, mousey, cx-boxw*2, by+subh, cx-boxw, by+subh*2))
	{
		drawColor = c_yellow;
		
		if(mouse_check_button_released(mb_left))
		{
			flagTab = 1;
			
			flagColorSlider2[? "red"] = color_get_red(flag[? "emblemColor1"]);
			flagColorSlider2[? "green"] = color_get_green(flag[? "emblemColor1"]);
			flagColorSlider2[? "blue"] = color_get_blue(flag[? "emblemColor1"]);
		}
	}
	else
	{
		drawColor = c_white;
	}
	#endregion
	
	scr_datumbox(cx-boxw*2, by+subh, boxw, subh, true, drawColor, "Layer 1", 10000, 1, spr_basicBoxHeader_9slice);
	
	draw_sprite_part_ext(flag[? "emblem1"], -1, flag[? "emblempos1"] * 128, 0, 128, 128, cx-boxw*2 + 32, by+subh*(1.625) + 16, 0.5, 0.5, flag[? "emblemColor1"], 1);
	//draw_sprite_ext(flag[? "emblem1"], -1, (cx-boxw*1.5), by+subh*3.25, 0.5, 0.5, 0, flag[? "emblemColor1"], 1);
	draw_sprite_ext(spr_selectorboxsmall, -1, (cx-boxw*1.5), by+subh*3.25, 1, 1, 0, c_white, 1);
	
	#region Input
	if(point_in_rectangle(mousex, mousey, cx-boxw, by+subh, cx, by+subh*2))
	{
		drawColor = c_yellow;
		
		if(mouse_check_button_released(mb_left))
		{
			flagTab = 2;
			
			flagColorSlider2[? "red"] = color_get_red(flag[? "emblemColor2"]);
			flagColorSlider2[? "green"] = color_get_green(flag[? "emblemColor2"]);
			flagColorSlider2[? "blue"] = color_get_blue(flag[? "emblemColor2"]);
		}
	}
	else
	{
		drawColor = c_white;
	}
	#endregion
	
	scr_datumbox(cx-boxw, by+subh, boxw, subh, true, drawColor, "Layer 2", 10000, 1, spr_basicBoxHeader_9slice);
	
	draw_sprite_part_ext(flag[? "emblem2"], -1, flag[? "emblempos2"] * 128, 0, 128, 128, cx-boxw + 32, by+subh*(1.625) + 16, 0.5, 0.5, flag[? "emblemColor2"], 1);
	//draw_sprite_ext(flag[? "emblem2"], -1, (cx-boxw*0.5), by+subh*3.25, 0.5, 0.5, 0, flag[? "emblemColor2"], 1);
	draw_sprite_ext(spr_selectorboxsmall, -1, (cx-boxw*0.5), by+subh*3.25, 1, 1, 0, c_white, 1);
	
	#region Input
	if(point_in_rectangle(mousex, mousey, cx, by+subh, cx+boxw, by+subh*2))
	{
		drawColor = c_yellow;
		
		if(mouse_check_button_released(mb_left))
		{
			flagTab = 3;
			
			flagColorSlider2[? "red"] = color_get_red(flag[? "emblemColor3"]);
			flagColorSlider2[? "green"] = color_get_green(flag[? "emblemColor3"]);
			flagColorSlider2[? "blue"] = color_get_blue(flag[? "emblemColor3"]);
		}
	}
	else
	{
		drawColor = c_white;
	}
	#endregion
	
	scr_datumbox(cx, by+subh, boxw, subh, true, drawColor, "Layer 3", 10000, 1, spr_basicBoxHeader_9slice);
	
	draw_sprite_part_ext(flag[? "emblem3"], -1, flag[? "emblempos3"] * 128, 0, 128, 128, cx + 32, by+subh*(1.625) + 16, 0.5, 0.5, flag[? "emblemColor3"], 1);
	//draw_sprite_ext(flag[? "emblem3"], -1, (cx-boxw*-0.5), by+subh*3.25, 0.5, 0.5, 0, flag[? "emblemColor3"], 1);
	draw_sprite_ext(spr_selectorboxsmall, -1, (cx-boxw*-0.5), by+subh*3.25, 1, 1, 0, c_white, 1);
	
	#endregion
	
	#region Color Sliders
	
	#region Base Color
	var slideY = by + 136;
	var slideInc = 50;
	
	//Header
	scr_datumbox(cx-boxw*2, slideY, boxw*5, subh, true, c_white, "Background Color", 10000, 1, spr_basicBoxHeader_9slice);
	slideY += slideInc;
	
	#region Red Slider
	flagColorSlider1[? "red"] = scr_slider(cx-boxw, slideY, mousex, mousey, 500, spr_system, 0.5, color_get_red(flag[? "baseColor"]), 0, 255, false, 0);
	
	scr_datumbox(cx-boxw*2 +10, slideY-subh/2 + 2, boxw-20, subh, true, c_white, "Red: " + string(floor(flagColorSlider1[? "red"])), 1000, 1, spr_basicBox_9slice);
	slideY += slideInc;
	#endregion
	
	#region Green Slider
	flagColorSlider1[? "green"] = scr_slider(cx-boxw, slideY, mousex, mousey, 500, spr_system, 0.5, color_get_green(flag[? "baseColor"]), 0, 255, false, 0);
	
	scr_datumbox(cx-boxw*2 +10, slideY-subh/2 + 2, boxw-20, subh, true, c_white, "Green: " + string(floor(flagColorSlider1[? "green"])), 1000, 1, spr_basicBox_9slice);
	slideY += slideInc;
	#endregion
	
	#region Blue Slider
	flagColorSlider1[? "blue"] = scr_slider(cx-boxw, slideY, mousex, mousey, 500, spr_system, 0.5, color_get_blue(flag[? "baseColor"]), 0, 255, false, 0);
	
	scr_datumbox(cx-boxw*2 +10, slideY-subh/2 + 2, boxw-20, subh, true, c_white, "Blue: " + string(floor(flagColorSlider1[? "blue"])), 1000, 1, spr_basicBox_9slice);
	slideY += slideInc;
	#endregion
	
	#region Brightness adjust
	flagBright = scr_slider(cx-boxw, slideY, mousex, mousey, 500, spr_system, 0.5, 5, 0, 10, false, 0) - 5
	
	#region Apply
	if(flagBright != 0)
	{	
		flagColorSlider1[? "red"] += flagBright;
		
		if(flagColorSlider1[? "red"] < 0)
		{
			flagColorSlider1[? "red"] = 0;
		}
		else if(flagColorSlider1[? "red"] > 255)
		{
			flagColorSlider1[? "red"] = 255;
		}
		
		flagColorSlider1[? "green"] += flagBright;
		if(flagColorSlider1[? "green"] < 0)
		{
			flagColorSlider1[? "green"] = 0;
		}
		else if(flagColorSlider1[? "green"] > 255)
		{
			flagColorSlider1[? "green"] = 255;
		}
		
		flagColorSlider1[? "blue"] += flagBright;
		if(flagColorSlider1[? "blue"] < 0)
		{
			flagColorSlider1[? "blue"] = 0;
		}
		else if(flagColorSlider1[? "blue"] > 255)
		{
			flagColorSlider1[? "blue"] = 255;
		}
	}
	#endregion
	
	scr_datumbox(cx-boxw*2 +10, slideY-subh/2 + 2, boxw-20, subh, true, c_white, "Brightness", 1000, 1, spr_basicBox_9slice);
	
	slideY += slideInc;
	
	#endregion
	
	//Calc color
	flag[? "baseColor"] = make_color_rgb(flagColorSlider1[? "red"], flagColorSlider1[? "green"], flagColorSlider1[? "blue"]);
	
	#endregion
	
	#region Layer Colors
	
	//Header
	scr_datumbox(cx-boxw*2, slideY, boxw*5, subh, true, c_white, "Layer " + string(flagTab), 10000, 1, spr_basicBoxHeader_9slice);
	slideY += slideInc;
	
	#region Red Slider
	flagColorSlider2[? "red"] = scr_slider(cx-boxw, slideY, mousex, mousey, 500, spr_system, 0.5, color_get_red(flag[? ("emblemColor" + string(flagTab))]), 0, 255, false, 0);
	
	scr_datumbox(cx-boxw*2 +10, slideY-subh/2 + 2, boxw-20, subh, true, c_white, "Red: " + string(floor(flagColorSlider2[? "red"])), 1000, 1, spr_basicBox_9slice);
	slideY += slideInc;
	#endregion
	
	#region Green Slider
	flagColorSlider2[? "green"] = scr_slider(cx-boxw, slideY, mousex, mousey, 500, spr_system, 0.5, color_get_green(flag[? ("emblemColor" + string(flagTab))]), 0, 255, false, 0);
	
	scr_datumbox(cx-boxw*2 +10, slideY-subh/2 + 2, boxw-20, subh, true, c_white, "Green: " + string(floor(flagColorSlider2[? "green"])), 1000, 1, spr_basicBox_9slice);
	slideY += slideInc;
	#endregion
	
	#region Blue Slider
	flagColorSlider2[? "blue"] = scr_slider(cx-boxw, slideY, mousex, mousey, 500, spr_system, 0.5, color_get_blue(flag[? ("emblemColor" + string(flagTab))]), 0, 255, false, 0);
	
	scr_datumbox(cx-boxw*2 +10, slideY-subh/2 + 2, boxw-20, subh, true, c_white, "Blue: " + string(floor(flagColorSlider2[? "blue"])), 1000, 1, spr_basicBox_9slice);
	slideY += slideInc;
	#endregion
		
	#region Brightness adjust
	flagBright2 = scr_slider(cx-boxw, slideY, mousex, mousey, 500, spr_system, 0.5, 5, 0, 10, false, 0) - 5
		
	#region Apply
	if(flagBright2 != 0)
	{	
		flagColorSlider2[? "red"] += flagBright2;
		
		if(flagColorSlider2[? "red"] < 0)
		{
			flagColorSlider2[? "red"] = 0;
		}
		else if(flagColorSlider2[? "red"] > 255)
		{
			flagColorSlider2[? "red"] = 255;
		}
		
		flagColorSlider2[? "green"] += flagBright2;
		if(flagColorSlider2[? "green"] < 0)
		{
			flagColorSlider2[? "green"] = 0;
		}
		else if(flagColorSlider2[? "green"] > 255)
		{
			flagColorSlider2[? "green"] = 255;
		}
		
		flagColorSlider2[? "blue"] += flagBright2;
		if(flagColorSlider2[? "blue"] < 0)
		{
			flagColorSlider2[? "blue"] = 0;
		}
		else if(flagColorSlider2[? "blue"] > 255)
		{
			flagColorSlider2[? "blue"] = 255;
		}
	}
	#endregion
	
	scr_datumbox(cx-boxw*2 +10, slideY-subh/2 + 2, boxw-20, subh, true, c_white, "Brightness", 1000, 1, spr_basicBox_9slice);
	
	slideY += slideInc;
	
	#endregion
	
	//Apply color
	flag[? ("emblemColor" + string(flagTab))] = make_color_rgb(flagColorSlider2[? "red"], flagColorSlider2[? "green"], flagColorSlider2[? "blue"]);
	
	#endregion
	
	#endregion
	
	#region Show flag
	draw_sprite_ext(spr_flagBackground, -1, cx + boxw*2, 68, 1, 1, 0, flag[? "baseColor"], 1);
	
	draw_sprite_part_ext(flag[? "emblem1"], -1, flag[? "emblempos1"] * 128, 0, 128, 128, cx + boxw*1.5, 4, 1, 1, flag[? "emblemColor1"], 1);
	
	draw_sprite_part_ext(flag[? "emblem2"], -1, flag[? "emblempos2"] * 128, 0, 128, 128, cx + boxw*1.5, 4, 1, 1, flag[? "emblemColor2"], 1);
	
	draw_sprite_part_ext(flag[? "emblem3"], -1, flag[? "emblempos3"] * 128, 0, 128, 128, cx + boxw*1.5, 4, 1, 1, flag[? "emblemColor3"], 1);
	
	draw_sprite_ext(spr_selectorbox, -1, cx + boxw*2, 68, 1, 1, 0, c_white, 1);
	
	#endregion

}

#endregion

#endregion
*/
#endregion
buttonHold = false;