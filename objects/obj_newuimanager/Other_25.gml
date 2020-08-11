/// @desc Cleanup event.
showUI = false;
pauseMenu = false;

loadingBar = 0;

leftScroll = 0;
rightScroll = 0;

menuLeft = 0;
menuRight = 0;

leaderboardOpen = false;
lbMode = "Population";

selected = pointer_null;
selectedPlanet = pointer_null;
selectedFaction = pointer_null;
hover = pointer_null;

ds_grid_destroy(evQueue);
evQueue = ds_grid_create(2, 0);

surface_free(evSurface);
ds_list_clear(evColors);