///@desc Clean up all game values to unclog memory and ready the game to be reset properly
///@func scr_cleanup()

//Halt game
global.paused = true;
global.cleanupMode = true;

#region Destroy temporary objects
//Destroy Ships
instance_destroy(obj_colonyShip);

//Destroy Planets
instance_destroy(obj_planet);

//Destroy Systems
instance_destroy(obj_system);

//Destroy Factions
instance_destroy(obj_faction);

//Destroy density nodes
instance_destroy(obj_densitynode);

#endregion

#region Clean out name lists
ds_list_destroy(global.namePrefixes);
ds_list_destroy(global.nameRoots);
ds_list_destroy(global.nameSuffixes);
ds_list_destroy(global.nameGreaterPrefixes);
ds_list_destroy(global.demoNames);
ds_list_destroy(global.oligNames);
ds_list_destroy(global.authNames);
ds_list_destroy(global.theoNames);

#endregion

#region Reset permanent objects

//Reset Global Manager
with(obj_globalmanager)
{
	event_user(15);
}

//Reset UI manager
with(obj_newuimanager)
{
	event_user(15);
}

//Reset Camera
with(obj_camera)
{
	event_user(15);
}

//Reset Timelord
with(obj_timelord)
{
	event_user(15);
}

//Reset Generation Manager
with(obj_generationmanager)
{
	event_user(15);
}

//Reset Draw Manager
with(obj_drawmanager)
{
	event_user(15);
}

//Reset System Manager
with(obj_systemManager)
{
	event_user(15);
}

#endregion

global.cleanupMode = false;