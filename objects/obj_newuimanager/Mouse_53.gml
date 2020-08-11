var leftBound = 300;
var rightBound = (winW - leftBound);

if(interference and (selected != pointer_null or selectedPlanet != pointer_null or selectedFaction != pointer_null))
{
	rightBound -= 300;
}

if(!global.cleanupMode and !obj_debugconsole.consoleOpen and global.genStage == gen.completed)
{
	if(mousex > leftBound and mousex < rightBound)
	{
		click = collision_circle(mouse_x, mouse_y, 9, obj_system, false, true);
		if(click != noone)
		{
			selectedPlanet = pointer_null;
			selectedFaction = pointer_null;
			scr_openInspector(click, "system", false);
			audio_play_sound(sfx_select, -1, false);
		}
		else
		{
			selected = pointer_null;
			selectedPlanet = pointer_null;
			selectedFaction = pointer_null;
			interference = false;
			
		}
	}
		
	event_user(1);
}