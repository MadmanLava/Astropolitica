#region Camera
camera = view_camera;
camerax = camera_get_view_x(camera);
cameray = camera_get_view_y(camera);

mousex = window_mouse_get_x();
mousey = window_mouse_get_y();

winW = window_get_width();
winH = window_get_height();

loadingBar = 0;

#endregion

#region UI Scale
window_set_min_width(1280);
window_set_min_height(720);

window_set_max_width(4096);
window_set_max_height(2304);

display_set_gui_size(window_get_width(), window_get_height());

#endregion

#region Navigation
pauseMenu = false;

interference = false;

freezeInput = false;

menuLeft = 0;
//Galactic Overview
//Factional Leaderboards
//
//
//
#region Leaderboards
leaderboard = ds_priority_create();
leaderboardOpen = false;
lbMode = "Population";

#endregion

#endregion

#region Selected
selected = pointer_null;
selectedPlanet = pointer_null;
selectedFaction = pointer_null;

hover = pointer_null;

#endregion

#region Event Queue
evSurface = surface_create(300, 200);
evQueue = ds_grid_create(2, 1);

evColors = ds_list_create();

evScroll = 0;

event_user(0)
#endregion

#region Debug
showUI = false;
guiScale = 1;

uiUpdateCount = 0;

#endregion

#region Star Type Information
starInfoList = ds_list_create();

//Class E
ds_list_add(starInfoList, "Class E stars are one of the greatest enigmas in the universe. What little that has been gleaned about these bizarre objects only raises more questions, as Class E stars appear to violate several natural laws.");

//Class O
ds_list_add(starInfoList, "Class O stars, AKA Blue Giants, are the most massive main-sequence stars in the universe. Extremely hot, massive and luminous, these stars shine a striking blue. Hot and short lived, they are unfavorable for planets and life.");

//Class B
ds_list_add(starInfoList, "Class B Stars");

//Class A
ds_list_add(starInfoList, "Class A stars");

//Class F
ds_list_add(starInfoList, "Class F stars");

//Class G
ds_list_add(starInfoList, "Class G stars, AKA Yellow Dwarfs, are the most life-favorable stars. Highly average in all aspects, Class G stars are mostly distinguished by their habitability.");

//Class K
ds_list_add(starInfoList, "Class K stars, AKA Orange Dwarfs, are relatively common. Though small and somewhat dim, Class K stars are favorable for the development of life.");

//Class M
ds_list_add(starInfoList, "Class M stars, AKA Red Dwarfs, are one of the most common in the universe. Small and dim, these planets bear poor prospects for life, but have immense lifespans.");

//Class W
ds_list_add(starInfoList, "Class W stars, AKA Wolf-Rayet stars, are among the shortest-lived stars in the universe. Burning through their fuel at an extremely rapid rate, their lifespans are very short. The gargantuan amount of material constantly emitted by these stars is unfavorable to planetary development.");

//Class D
ds_list_add(starInfoList, "Class D stars, AKA White Dwarfs, are solar remnants from the deaths of low-mass suns. Any planets they may have once had were destroyed during the sun's death.");

//Neutron Stars
ds_list_add(starInfoList, "A type of supernova remnant, Neutron Stars are the partially collapsed cores of large stars. Though a black hole has not formed, the gravitational forces binding this object together have crushed most subatomic particles in its makeup into a dense neutronium lattice, and stranger things may hide at it's core.");

//Black Holes
ds_list_add(starInfoList, "A type of supernova remnant, Black Holes are the fully collapsed cores of large stars. The sheer force of the gravitational collapse having overcome all barriers, a dense singularity has formed, with its enormous gravity and infitesimal size creating a small pocket of inescapable space.");

//Supermassive Black Holes
ds_list_add(starInfoList, "The centers of most galaxies, supermassive black holes are black holes that have swelled to an incomprehensibly obscene mass.");
#endregion

#region UI Maps

#region Right
menuRight = 0;

#region System Inspector(0)
//Tabs
sysInsTab = 0; //0: Astro, 1: Civ

#region Astrography(0)
sys = ds_map_create();
sys[? "over"] = true;
sys[? "sysInfo"] = true;
sys[? "starInfo"] = true;
sys[? "planInfo"] = true;
sys[? "planList"] = true;
sys[? "demo"] = true;
sys[? "infra"] = true;
	sys[? "infraShip"] = false;
		sys[? "infraShipUp"] = false;
	sys[? "infraDyson"] = false;
		sys[? "infraDysonOut"] = false;
		sys[? "infraDysonUp"] = false;
	sys[? "infraMining"] = false;
		sys[? "infraDysonOut"] = false;
		sys[? "infraMiningUp"] = false;
sys[? "res"] = true;
	sys[? "resStock"] = false;
	sys[? "resIncome"] = false;
	sys[? "resUpkeep"] = false;
	sys[? "resDesired"] = false;

#endregion

#endregion

#region Planet Inspector(1)
planet = ds_map_create();

planet[? "over"] = true;
planet[? "traits"] = true;
planet[? "gov"] = true;
planet[? "demo"] = true;
planet[? "infra"] = true;
planet[? "res"] = false;
	planet[? "resProduc"] = false;
	planet[? "resIncome"] = false;
	planet[? "resUpkeep"] = false;

#endregion

#region Faction Inspector(2)
faction = ds_map_create();

//faction[? "over"] = true;
faction[? "gov"] = true;
faction[? "demo"] = true;
faction[? "terr"] = true;
	faction[? "terrColo"] = true;
faction[? "budget"] = true;
faction[? "econ"] = true;
	faction[? "econValue"] = false;
	faction[? "econIncome"] = false;
	faction[? "econStock"] = false;
	faction[? "econUpkeep"] = false;
	//faction[? "econSpend"] = true;
faction[? "mil"] = true;
faction[? "pol"] = true;

#endregion

#endregion

#endregion

#region UI Surfaces

scrollSpeed = 32;

uiSurfLeftHeight = 2048;
uiSurfLeftScroll = 0;
uiSurfLeft = surface_create(300, uiSurfLeftHeight);

uiSurfRightHeight = 4096;
uiSurfRightScroll = 0;
uiSurfRight = surface_create(300, uiSurfRightHeight);

#endregion