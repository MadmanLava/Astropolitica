var leftBound = 300;
var rightBound = (winW - leftBound);

if(!global.cleanupMode and mousex > leftBound and mousex < rightBound)
{
	if(!obj_debugconsole.consoleOpen and global.genStage == gen.completed)
	{
		click = collision_circle(mouse_x, mouse_y, 9, obj_system, false, true);
		if(click != noone)
		{
			if(click.owner != pointer_null)
			{
				selected = pointer_null;
				selectedPlanet = pointer_null;
				scr_openInspector(click.owner.id, "faction", false);
				audio_play_sound(sfx_select, -1, false);
			}
		}
		else
		{
			selected = pointer_null;
			selectedPlanet = pointer_null;
			selectedFaction = pointer_null;
			interference = false;
			
			event_user(1);
		}
	}
}