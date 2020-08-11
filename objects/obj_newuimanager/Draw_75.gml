if(room == simroom)
{

#region Camera Updates
camerax = camera_get_view_x(camera);
cameray = camera_get_view_y(camera);

camWid = camera_get_view_width(camera);
camHei = camera_get_view_height(camera);

guiScale = 1 //900 / window_get_height();
//display_set_gui_maximize(1, 1, 0, 0)

#endregion

#region Common Variables
winW = window_get_width();
winH = window_get_height();

mousex = window_mouse_get_x();
mousey = window_mouse_get_y();

var boxColor = c_white;

//Left
leftBound = 300//((winW - winH) / 2);

//Right
rightBound = (winW - leftBound);//(winW - leftBound);

#endregion

#region Camera Movement Lock
if(mousex < leftBound or mousex > rightBound)
{
	obj_camera.movementAllowed = false;
}
else
{
	obj_camera.movementAllowed = true;
}

#endregion

#region Pause Menu

if(pauseMenu)
{
	var pausew = 300;
	var pauseh = 450;
	
	var pausex = ((winW / 2) - (pausew/2));
	var pausey = ((winH / 2) - (pauseh/2));
	
	var pauseColor = c_white;
	
	scr_nine_slice(spr_basicBox_9slice, pausex, pausey, pausew, pauseh, true, c_white);
	
	#region Buttons
	var buttonWidth = 250;
	var buttonHeight = 50;
	
	var buttonPosX = pausex + ((pausew - buttonWidth)/2);
	var buttonPosY = pausey + ((pausew - buttonWidth)/2);
	var buttonInc = 75;
	
	#region Set draws
	if(draw_get_font() != fnt_default)
	{
		draw_set_font(fnt_default);
	}
	if(draw_get_halign() != fa_middle)
	{
		draw_set_halign(fa_middle);
	}
	if(draw_get_valign() != fa_middle)
	{
		draw_set_valign(fa_middle);
	}
	
	#endregion
	
	#region Save
	
	#region Input
	if(point_in_rectangle(mousex, mousey, buttonPosX, buttonPosY, buttonPosX + buttonWidth, buttonPosY + buttonHeight))
	{
		pauseColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			
		}
	}
	else
	{
		pauseColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, buttonPosX, buttonPosY, buttonWidth, buttonHeight, true, pauseColor)
	draw_text_transformed(buttonPosX + (buttonWidth/2), buttonPosY + (buttonHeight/2), "SAVE", guiScale, guiScale, 0)
	buttonPosY = buttonPosY + buttonInc;
	
	#endregion
	
	#region Load
	
	#region Input
	if(point_in_rectangle(mousex, mousey, buttonPosX, buttonPosY, buttonPosX + buttonWidth, buttonPosY + buttonHeight))
	{
		pauseColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			
		}
	}
	else
	{
		pauseColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, buttonPosX, buttonPosY, buttonWidth, buttonHeight, true, pauseColor)
	draw_text_transformed(buttonPosX + (buttonWidth/2), buttonPosY + (buttonHeight/2), "LOAD", guiScale, guiScale, 0)
	buttonPosY = buttonPosY + buttonInc;
	
	#endregion
	
	#region Options
	
	#region Input
	if(point_in_rectangle(mousex, mousey, buttonPosX, buttonPosY, buttonPosX + buttonWidth, buttonPosY + buttonHeight))
	{
		pauseColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			
		}
	}
	else
	{
		pauseColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, buttonPosX, buttonPosY, buttonWidth, buttonHeight, true, pauseColor)
	draw_text_transformed(buttonPosX + (buttonWidth/2), buttonPosY + (buttonHeight/2), "OPTIONS", guiScale, guiScale, 0)
	buttonPosY = buttonPosY + buttonInc;
	
	#endregion
	
	#region Quit
	
	#region Input
	if(point_in_rectangle(mousex, mousey, buttonPosX, buttonPosY, buttonPosX + buttonWidth, buttonPosY + buttonHeight))
	{
		pauseColor = c_yellow;
		if(mouse_check_button_released(mb_left))
		{
			scr_cleanup();
			room_goto(mainmenu);
			with(obj_mainmenu)
			{
				menu = 1;
				ds_grid_clear(scroll, 0);
			}
		}
	}
	else
	{
		pauseColor = c_white;
	}
	#endregion
	
	scr_nine_slice(spr_basicBox_9slice, buttonPosX, buttonPosY, buttonWidth, buttonHeight, true, pauseColor)
	draw_text_transformed(buttonPosX + (buttonWidth/2), buttonPosY + (buttonHeight/2), "QUIT", guiScale, guiScale, 0)
	buttonPosY = buttonPosY + buttonInc;
	
	#endregion
	
	#endregion
}

#endregion

#region Date data

if(showUI)
{
	draw_set_halign(fa_right);
	draw_set_font(fnt_defaultsmall);

	//Vars
	var dateString = "Current Date: (" + string(global.currentDay) + "/" + string(global.currentMonth) + "/" + string(global.currentYear) + ")";
	var dateWidth = string_width(dateString);
	var dateHeight = string_height(dateString);

	//Box
	scr_nine_slice(spr_basicBox_9slice, rightBound - dateWidth - 10, 0, dateWidth + 10, dateHeight + 5, true, boxColor)

	//Text
	draw_text(rightBound - 5, dateHeight/2, dateString);
	//scribble_draw(rightBound-5, dateHeight/2, dateString);

#region FPS
if(showUI)
{
	draw_set_halign(fa_left);
	draw_text(rightBound - 175, dateHeight*2, "FPS: " + string(fps));
	draw_text(rightBound - 175, dateHeight*3, "FPS(slow): " + string(global.midFPS));
	draw_text(rightBound - 175, dateHeight*4, "FPS(real): " + string(fps_real));
}

#endregion

#endregion

#region Game Speed
//box
var speedBoxWidth = string_width("Game Speed: 1 day per ## game ticks")+10;
var speedBoxHeight = string_height("M")+5;
scr_nine_slice(spr_basicBox_9slice, 300, 0, speedBoxWidth, speedBoxHeight, true, c_white);

//text
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(305, speedBoxHeight/2, "Game Speed: 1 day per " + string(global.gameSpeed) + " game ticks");

//slider
global.gameSpeed = floor(scr_slider(316, speedBoxHeight*1.5, mousex, mousey, speedBoxWidth-32, spr_sliderGrab, 1, global.gameSpeed, 1, 30, false, 0, 1));

//paused
if(global.paused)
{
	draw_set_halign(fa_center);
	draw_text_color(winW/2, speedBoxHeight/2, "PAUSED", c_red, c_red, c_red, c_red, 1);
}

//debug time stuff
if(global.stuck)
{
	draw_set_halign(fa_center);
	draw_text_color(winW/2, speedBoxHeight/2 + 30, "STUCK", c_red, c_red, c_red, c_red, 1);
}

}
#endregion

#region System Hover-over
draw_set_font(fnt_debug);
draw_set_halign(fa_left);

if(hover != pointer_null)
{
	var borderText = "";
	if(hover.border)
	{
		borderText = "Border System"
	}
	
	draw_text(mousex + 20, mousey, hover.name + "\n" + hover.ownerName + "\n" + hover.type + "\n" + borderText);
	//scribble_draw(mousex + 20, mousey, hover.name + "\n" + hover.ownerName + "\n" + hover.type + "\n" + borderText);
}

#endregion

#region Surface-Bound

#region Recreate Surfaces
if(!surface_exists(uiSurfRight) or !surface_exists(uiSurfLeft))
{
	uiSurfLeft = surface_create(300, uiSurfLeftHeight);
	uiSurfRight = surface_create(300, uiSurfRightHeight);
	event_user(1);
}

#endregion

#region Input

#region Scroll

#region Right
if(mousex > rightBound)
{
	if(mouse_wheel_up())
	{
		uiSurfRightScroll += scrollSpeed;
		
		if(uiSurfRightScroll > 0)
		{
			uiSurfRightScroll = 0;
		}
	}
	else if(mouse_wheel_down())
	{
		uiSurfRightScroll -= scrollSpeed;
	}
}
#endregion


#endregion

if(mouse_check_button_released(mb_left) and (mousex < 300 or mousex > rightBound))
{
	event_user(1);
}

#endregion

#region Draw Surfaces
if(showUI)
{
	//Left
	scr_nine_slice(spr_basicBox_9slice, 0, 0, 300, camHei-1, true, c_white);
	//draw_surface_part(uiSurfLeft, 0, uiSurfLeftScroll, 300, global.camHei, 0, 0);
	draw_surface(uiSurfLeft, 0, uiSurfLeftScroll);
	
	//Right
	scr_nine_slice(spr_basicBox_9slice, rightBound, 0, 300, camHei-1, true, c_white);
	//draw_surface_part(uiSurfRight, 0, uiSurfRightScroll, 300, global.camHei, rightBound, 0);
	draw_surface(uiSurfRight, rightBound, uiSurfRightScroll);
	
}
#endregion

#endregion

#region Interference Menu
if(!pauseMenu and interference and (selected != pointer_null or selectedPlanet != pointer_null or selectedFaction != pointer_null))
{
	#region Setup and Variables
	var bxWid = 300;
	var bxHei = 500;
	
	var bx = rightBound - 300;
	var by = dateHeight * 4;
	
	var bxOff = 0;
	
	var boxHei = string_height("M") + 5;
	var boxInc = 0;
	
	var tabColor1 = make_color_rgb(200, 200, 200);
	var tabColor2 = make_color_rgb(150, 150, 150);
	var tabColor3 = make_color_rgb(100, 100, 100);
	
	#endregion
	
	#region Draw
	//Box
	//scr_nine_slice(spr_basicBox_9slice, bx, by, bxWid, bxHei, true, c_white);
	
	//Header
	scr_datumboxcolor(bx, by, bxWid, 30, true, c_white, "EDIT VALUES", c_white, 10000, 1, spr_basicBoxHeader_9slice, c_white)
	boxInc += 25;
	
	#region System Values
	if(menuRight == 0 and selected != pointer_null)
	{
		#region Infrastructure
		scr_datumboxcolor(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, tabColor1, "INFRASTRUCTURE", c_white, 10000, 1, spr_basicBoxHeader_9slice, c_white)
		boxInc += boxHei;
		
		bxOff = 10;
		
		#region Shipyard Level
		scr_datumboxcolor(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, tabColor2, "SHIPYARD LEVEL", c_white, 10000, 1, spr_basicBoxHeader_9slice, c_white)
		boxInc += boxHei;
		
		//button
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, string(selected.shipyardLevel), 10000, 1, spr_basicBox_9slice);
		selected.shipyardLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selected.shipyardLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Dyson Level
		scr_datumboxcolor(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, tabColor2, "DYSON LEVEL", c_white, 10000, 1, spr_basicBoxHeader_9slice, c_white)
		boxInc += boxHei;
		
		//button
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, string(selected.dysonLevel), 10000, 1, spr_basicBox_9slice);
		selected.dysonLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selected.dysonLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Mining Level
		scr_datumboxcolor(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, tabColor2, "MINING LEVEL", c_white, 10000, 1, spr_basicBoxHeader_9slice, c_white)
		boxInc += boxHei;
		
		//button
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, string(selected.miningLevel), 10000, 1, spr_basicBox_9slice);
		selected.miningLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selected.miningLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		bxOff = 0;
		
		#endregion
		
		#region Resource Stockpile
		scr_datumboxcolor(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, tabColor1, "RESOURCE STOCKPILE", c_white, 10000, 1, spr_basicBoxHeader_9slice, c_white)
		boxInc += boxHei;
		
		var stock = selected.stockpile;
		
		bxOff = 10;
		
		#region Energy
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_energy][] Energy: " + string(stock[? "energy"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "energy"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "energy"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		#region Metal
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_metal][] Metal: " + string(stock[? "metal"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "metal"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "metal"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		#region Rare Elements
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_rareElements][] Rare Elements: " + string(stock[? "rareElements"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "rareElements"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "rareElements"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		#region Crystal
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_crystal][] Crystal: " + string(stock[? "crystal"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "crystal"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "crystal"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		#region Gas
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_gas][] Gas: " + string(stock[? "gas"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "gas"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "gas"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		#region Radioactives
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_radioactives][] Radioactives: " + string(stock[? "radioactives"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "radioactives"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "radioactives"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		#region Food
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_food][] Food: " + string(stock[? "food"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "food"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "food"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		#region Consumer Goods
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_consumerGoods][] Consumer Goods: " + string(stock[? "consumerGoods"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "consumerGoods"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "consumerGoods"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		#region Nanotech
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_nanotech][] Nanotech: " + string(stock[? "nanotech"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "nanotech"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "nanotech"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		#region Advanced Components
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_advancedComponents][] Advanced Components: " + string(stock[? "advancedComponents"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "advancedComponents"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "advancedComponents"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		#region Alloys
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_alloys][] Alloys: " + string(stock[? "alloys"]), 10000, 1, spr_basicBox_9slice);
		selected.stockpile[? "alloys"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, stock[? "alloys"], mousex, mousey, 1, 0, 100000000);
		boxInc += boxHei;
		
		#endregion
		
		bxOff = 0;
		
		#endregion
	}
	#endregion
	
	#region Planet
	else if(menuRight == 1 and selectedPlanet != pointer_null)
	{
		#region Traits
		scr_datumboxcolor(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, tabColor1, "TRAITS", c_white, 10000, 1, spr_basicBoxHeader_9slice, c_white)
		boxInc += boxHei;
		
		bxOff = 10;
		
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Size: " + string(selectedPlanet.size), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.size = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.size, mousex, mousey, 1, 1, 10);
		boxInc += boxHei;
		
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Habitability: " + string(selectedPlanet.habitability), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.habitability = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.habitability, mousex, mousey, 1, 1, 10);
		boxInc += boxHei;
		
		bxOff = 0;
		
		#endregion
		
		#region Resources
		scr_datumboxcolor(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, tabColor1, "NATURAL RESOURCES", c_white, 10000, 1, spr_basicBoxHeader_9slice, c_white)
		boxInc += boxHei;
		
		bxOff = 10;
		
		#region Energy
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_energy][] Energy: " + string(selectedPlanet.resources[? "energy"]), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.resources[? "energy"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.resources[? "energy"], mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Metal
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_metal][] Metal: " + string(selectedPlanet.resources[? "metal"]), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.resources[? "metal"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.resources[? "metal"], mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Rare Elements
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_rareElements][] Rare Elements: " + string(selectedPlanet.resources[? "rareElements"]), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.resources[? "rareElements"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.resources[? "rareElements"], mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Gas
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_gas][] Gas: " + string(selectedPlanet.resources[? "gas"]), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.resources[? "gas"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.resources[? "gas"], mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Crystal
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_crystal][] Crystal: " + string(selectedPlanet.resources[? "crystal"]), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.resources[? "crystal"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.resources[? "crystal"], mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Radioactives
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_radioactives][] Radioactives: " + string(selectedPlanet.resources[? "radioactives"]), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.resources[? "radioactives"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.resources[? "radioactives"], mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Food
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "[scale, 0.5][spr_food][] Food: " + string(selectedPlanet.resources[? "food"]), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.resources[? "food"] = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.resources[? "food"], mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		bxOff = 0;
		
		#endregion
		
		#region Infrastructure
		scr_datumboxcolor(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, tabColor1, "INFRASTRUCTURE", c_white, 10000, 1, spr_basicBoxHeader_9slice, c_white)
		boxInc += boxHei;
		
		bxOff = 10;
		
		#region General Infrastructure
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Transport: " + string(selectedPlanet.infraLevel), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.infraLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.infraLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Urban Infrastructure
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Urbanization: " + string(selectedPlanet.urbanLevel), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.urbanLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.urbanLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Power
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Power Generation: " + string(selectedPlanet.powerLevel), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.powerLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.powerLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Mining
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Mining: " + string(selectedPlanet.miningLevel), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.miningLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.miningLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Agri
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Agriculture: " + string(selectedPlanet.agriLevel), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.agriLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.agriLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Alloy
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Alloy: " + string(selectedPlanet.alloyLevel), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.alloyLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.alloyLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Consumer Goods
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Consumer Goods: " + string(selectedPlanet.cgLevel), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.cgLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.cgLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region Nanotech
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Nanotech: " + string(selectedPlanet.nanoLevel), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.nanoLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.nanoLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		#region AC level
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Advanced Components: " + string(selectedPlanet.acLevel), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.acLevel = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", false, selectedPlanet.acLevel, mousex, mousey, 1, 0, 10);
		boxInc += boxHei;
		
		#endregion
		
		bxOff = 0;
		#endregion
		
		#region Demographics
		scr_datumboxcolor(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, tabColor1, "DEMOGRAPHICS", c_white, 10000, 1, spr_basicBoxHeader_9slice, c_white)
		boxInc += boxHei;
		
		bxOff = 10;
		
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Population: " + string(selectedPlanet.population), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.population = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, selectedPlanet.population, mousex, mousey, 0.5, 0, 10000000);
		boxInc += boxHei;
		
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Base Max. Population: " + string(selectedPlanet.baseMaxPop), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.baseMaxPop = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, selectedPlanet.baseMaxPop, mousex, mousey, 0.5, 0.1, 10000000);
		boxInc += boxHei;
		
		scr_datumbox(bx + bxOff, by + boxInc, bxWid-bxOff, boxHei, true, c_white, "Growth Rate: " + string(selectedPlanet.growthRate), 10000, 1, spr_basicBox_9slice);
		selectedPlanet.growthRate = scr_button(bx + bxWid-50, by+boxInc, boxHei, boxHei, spr_menuButton, false, "value", true, selectedPlanet.growthRate, mousex, mousey, 0.05, 0, 10);
		boxInc += boxHei;
		
		bxOff = 0;
		
		#endregion
	}
	#endregion
	
	#region Country
	else if(menuRight == 2 and selectedFaction != pointer_null)
	{
		
	}
	#endregion
	
	#endregion
}

#endregion

#region Event Ticker
if(showUI)
{
	if(surface_exists(evSurface))
	{
		if(!global.paused)
		{
			event_user(0);
		}
		draw_surface(evSurface, 0, winH-200);
	}
	else
	{
		evSurface = surface_create(300, 200);
		event_user(0);
		draw_surface(evSurface, 0, winH-200);
	}
}

#region Scrolling
if(point_in_rectangle(mousex, mousey, 0, winH-200, 300, winH))
{
	if(mouse_wheel_down())
	{
		evScroll -= scrollSpeed;
		if(evScroll > 0)
		{
			evScroll = 0;
		}
		event_user(0);
	}
	else if(mouse_wheel_up())
	{
		evScroll += scrollSpeed;
		if(evScroll > 0)
		{
			evScroll = 0;
		}
		event_user(0);
	}
}
#endregion

#endregion

#region Map Settings

if(showUI)
{

var mapButtonSize = 64;
var mapButtonPosX = rightBound - mapButtonSize;
var mapButtonPosY = winH-mapButtonSize;
var mapButtonColor = c_white;
var iconOn = true;

#region Toggle Polar Grid

#region Input
if(point_in_rectangle(mousex, mousey, mapButtonPosX, mapButtonPosY, mapButtonPosX + mapButtonSize, mapButtonPosY + mapButtonSize))
{
	mapButtonColor = c_yellow;
	
	if(mouse_check_button_released(mb_left))
	{
		global.drawPolarGrid = toggle(global.drawPolarGrid, true);
		audio_play_sound(sfx_select, -1, false);
	}
}
else
{
	mapButtonColor = c_white;
}
#endregion

//Draw Box
scr_nine_slice(spr_tintedBox_9slice, mapButtonPosX, mapButtonPosY, mapButtonSize, mapButtonSize, true, mapButtonColor)

//Draw Icon
iconOn = toggle(global.drawPolarGrid, true);
draw_sprite(spr_drawPolarGrid, iconOn, mapButtonPosX + mapButtonSize/2, mapButtonPosY + mapButtonSize/2);
mapButtonPosX -= mapButtonSize;

#endregion

#region Toggle Faction Names

#region Input
if(point_in_rectangle(mousex, mousey, mapButtonPosX, mapButtonPosY, mapButtonPosX + mapButtonSize, mapButtonPosY + mapButtonSize))
{
	mapButtonColor = c_yellow;
	
	if(mouse_check_button_released(mb_left))
	{
		global.drawCountryNames = toggle(global.drawCountryNames, true);
		audio_play_sound(sfx_select, -1, false);
	}
}
else
{
	mapButtonColor = c_white;
}
#endregion

scr_nine_slice(spr_tintedBox_9slice, mapButtonPosX, mapButtonPosY, mapButtonSize, mapButtonSize, true, mapButtonColor)
//Draw Icon
iconOn = toggle(global.drawCountryNames, true);
draw_sprite(spr_drawCountryNames, iconOn, mapButtonPosX + mapButtonSize/2, mapButtonPosY + mapButtonSize/2);
mapButtonPosX -= mapButtonSize;

#endregion

#region Toggle Ships

#region Input
if(point_in_rectangle(mousex, mousey, mapButtonPosX, mapButtonPosY, mapButtonPosX + mapButtonSize, mapButtonPosY + mapButtonSize))
{
	mapButtonColor = c_yellow;
	
	if(mouse_check_button_released(mb_left))
	{
		global.drawShips = toggle(global.drawShips, true);
		audio_play_sound(sfx_select, -1, false);
	}
}
else
{
	mapButtonColor = c_white;
}
#endregion

scr_nine_slice(spr_tintedBox_9slice, mapButtonPosX, mapButtonPosY, mapButtonSize, mapButtonSize, true, mapButtonColor)
//Draw Icon
iconOn = toggle(global.drawShips, true);
draw_sprite(spr_drawShips, iconOn, mapButtonPosX + mapButtonSize/2, mapButtonPosY + mapButtonSize/2);
mapButtonPosX -= mapButtonSize;

#endregion

#region Toggle Lanes

#region Input
if(point_in_rectangle(mousex, mousey, mapButtonPosX, mapButtonPosY, mapButtonPosX + mapButtonSize, mapButtonPosY + mapButtonSize))
{
	mapButtonColor = c_yellow;
	
	if(mouse_check_button_released(mb_left))
	{
		global.drawLanes = toggle(global.drawLanes, true);
		audio_play_sound(sfx_select, -1, false);
	}
}
else
{
	mapButtonColor = c_white;
}
#endregion

scr_nine_slice(spr_tintedBox_9slice, mapButtonPosX, mapButtonPosY, mapButtonSize, mapButtonSize, true, mapButtonColor)
//Draw Icon
iconOn = toggle(global.drawLanes, true);
draw_sprite(spr_drawLanes, iconOn, mapButtonPosX + mapButtonSize/2, mapButtonPosY + mapButtonSize/2);
mapButtonPosX -= mapButtonSize;

#endregion

#region Toggle Stars

#region Input
if(point_in_rectangle(mousex, mousey, mapButtonPosX, mapButtonPosY, mapButtonPosX + mapButtonSize, mapButtonPosY + mapButtonSize))
{
	mapButtonColor = c_yellow;
	
	if(mouse_check_button_released(mb_left))
	{
		global.drawStars = toggle(global.drawStars, true);
		audio_play_sound(sfx_select, -1, false);
	}
}
else
{
	mapButtonColor = c_white;
}
#endregion

scr_nine_slice(spr_tintedBox_9slice, mapButtonPosX, mapButtonPosY, mapButtonSize, mapButtonSize, true, mapButtonColor)
//Draw Icon
iconOn = toggle(global.drawStars, true);
draw_sprite(spr_drawStars, iconOn, mapButtonPosX + mapButtonSize/2, mapButtonPosY + mapButtonSize/2);
mapButtonPosX -= mapButtonSize;

#endregion

}

#endregion

#region Loading Screen
if(global.genStage != gen.completed)
{
scr_nine_slice(spr_basicBox_9slice, 0, 0, window_get_width(), window_get_height(), true, c_white)
draw_set_halign(fa_center);
draw_set_font(fnt_default);
	
var stageText = "";
	
switch global.genStage
{		
	case gen.inactive:
	{
		stageText = "Generation Failure!";
		loadingBar = 0;
		
		break;
	}
	
	case gen.preStars:
	{
		stageText = "Setting up...";
			
		break;
	}
		
	case gen.placeStars:
	{
		stageText = "Placing stars...\n" + string(global.genStarCount);
		loadingBar = global.genStarCount/global.starCount;
			
		break;
	}
		
	case gen.calcLanes:
	{
		stageText = "Generating hyperlanes...\n" + string(global.genHyperlaneCount) + " hyperlanes generated, " + string(global.lanesDone) + " stars have generated their lanes.";
		loadingBar = 1 + (global.lanesDone/global.genStarCount);
			
		break;
	}
		
	case gen.pruneLanes:
	{
		stageText = "Finalizing hyperlanes...";
			
		break;
	}
		
	case gen.detailStars:
	{
		stageText = "Generating star detail...\n" + string(global.starsDone) + " stars done.";
		loadingBar = 3 + ((global.starsDone/global.genStarCount)/2);
			
		break;
	}
		
	case gen.detailPlanets:
	{
		stageText = "Generating planet detail...\n" + string(global.planetsDone) + " planets done.";
		loadingBar = 4 + ((global.planetsDone/global.genPlanetCount)/2);
			
		break;
	}
		
	case gen.placeFactions:
	{
		stageText = "Placing countries...\n" + string(global.factionsPlaced) + " countries placed.";
		loadingBar = 5 + (global.factionsPlaced/global.genFactionCount);
			
		break;
	}
		
	case gen.finalize:
	{
		stageText = "Finalizing...";
			
		break;
	}
}
	
draw_set_font(fnt_title);
draw_text_ext_transformed(window_get_width()/2, (window_get_height()/2)-60, "Generating...", -1, 10000, 0.5, 0.5, 0);
draw_set_font(fnt_default);

draw_text_ext_transformed(window_get_width()/2, (window_get_height()/2) + 30, stageText, -1, 10000, 1, 1, 0);
	
#region Loading Bar
scr_nine_slice(spr_basicBox_9slice, window_get_width()/2 - 200, window_get_height()/2 + 100, 400, 25, true, c_white);
scr_nine_slice(spr_loadingbar_9slice, window_get_width()/2 - 200, window_get_height()/2 + 100, (400 * loadingBar/6), 25, true, c_white);
draw_text_ext_transformed(window_get_width()/2, (window_get_height()/2) + 150, string(round((loadingBar/6) * 100)) + "%", -1, 10000, 1, 1, 0);
	
#endregion
}
#endregion

}