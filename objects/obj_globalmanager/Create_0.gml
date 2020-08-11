show_debug_overlay(false);

global.midFPS = 0;
alarm[1] = 20;

#region Meta
global.version = "Alpha 0.5.2.2";
global.discordLink = "https://discord.gg/vDyHgMd"
global.trelloLink = "https://trello.com/b/3YWRP21m/astropolitica"
#endregion

date_set_timezone(timezone_local);

global.currentSplash = "Splash text failed to load!";
global.guideText = "Error!";

randomize();

scr_enums();
scr_loadNames();
scr_loadCustom();
scr_loadSplashes();
gml_pragma("global", "scr_startScribble()")

global.cleanupMode = false;

#region Pre-generation Settings
global.genMode = 0;
global.starCount = 1000;
global.starGenCap = 4;
global.starGenSpeed = 60;
global.maxFailedTries = 20;
global.galaxyRadius = 25000;
global.pruneRadius = 200;
global.laneRadius = 250;
global.centerRadNode = true;
global.densityRadius = 0;
global.densityNodes = 0;
global.densityFactor = 0;

global.seed = irandom_range(0, 10000);
global.seedTemp = global.seed;

global.forcedExtraPlanets = 0;

global.remnantChance = 3;

global.planetHabitabilityBonus = 0;

global.factionCount = 10;
global.vanityChance = 10;
global.pregenFactionCount = 0;
#endregion

#region Generation
global.genStage = gen.inactive;
global.genRadius = 0;
global.furthestSystem = pointer_null;
global.genHyperlaneCount = 0;
global.genFactionCount = 0;
global.factionsPlaced = 0;
global.genExsolCount = 0;
global.lanesPruned = false;
global.avgLaneCount = global.genHyperlaneCount/global.starCount;

global.galaxyName = "Some Galaxy";
global.generationTime = 0;
#endregion

#region Star Info
global.genStarCount = 0
global.genPlanetCount = 0;
global.starsDone = 0;
global.lanesDone = 0;
global.planetsDone = 0;
global.avgPlanetCount = 0;
global.rareStarCount = 0;
global.eStarCount = 0;
global.systemList = ds_list_create();
global.emptySystemList = ds_list_create();

#region Star Classes
global.classOCount = 0;
global.classBCount = 0;
global.classACount = 0;
global.classFCount = 0;
global.classGCount = 0;
global.classKCount = 0;
global.classMCount = 0;
global.classWCount = 0;
global.classDCount = 0;

//Special
global.neutronCount = 0;
global.blackholeCount = 0;

#endregion

#endregion

#region Display Options
global.drawStars = false;
global.drawLanes = false;
global.drawShips = false;
global.drawCountryNames = false;
global.drawPolarGrid = false;
global.drawBorders = true;

#endregion

#region Camera
cam = view_get_camera(0);
global.camX = camera_get_view_x(cam);
global.camY = camera_get_view_y(cam);
global.camWid = camera_get_view_width(cam);
global.camHei = camera_get_view_height(cam);
#endregion

#region Costs

#region Shipyard
global.shipyardCost = ds_map_create();
global.shipyardCost[? "metal"] = 30;
global.shipyardCost[? "rareElements"] = 20;
global.shipyardCost[? "crystal"] = 5;
global.shipyardCost[? "alloys"] = 15
global.shipyardCost[? "nanotech"] = 5;
global.shipyardCost[? "advancedComponents"] = 10;
#endregion

#region Dyson Array
global.dysonCost = ds_map_create();
global.dysonCost[? "metal"] = 20;
global.dysonCost[? "rareElements"] = 20;
global.dysonCost[? "crystal"] = 10;
//global.dysonCost[? "alloys"] = 30;
#endregion

#region Mining Post
global.miningCost = ds_map_create();
global.miningCost[? "metal"] = 20;
global.miningCost[? "rareElements"] = 20;
global.miningCost[? "gas"] = 10;
#endregion

#endregion

#region Particles
global.particleSystem = part_system_create_layer(layer_get_id("Particles"), true);
//starfield stars
global.starParticle = part_type_create();
part_type_shape(global.starParticle, pt_shape_flare);
part_type_size(global.starParticle, 0.5, 2, 0, 0.1);
part_type_scale(global.starParticle, 0.05, 0.05);
//part_type_color_hsv(global.starParticle, 0, 255, 0, 75, 255, 255);
part_type_color1(global.starParticle, c_white);
part_type_alpha3(global.starParticle, 0, 1, 0);
part_type_speed(global.starParticle, 1, 1.2, 0, 0);
part_type_direction(global.starParticle, 135, 45, 0, 0);
//part_type_orientation(global.starParticle, 0, 0, 0, 0, 0);
//part_type_blend(global.starParticle, 0);
part_type_life(global.starParticle, 300, 300);

global.starEmitter = part_emitter_create(global.particleSystem);
part_emitter_region(global.starEmitter, global.starParticle, 0, global.camWid+540, 0, global.camHei+540, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(global.particleSystem, global.starEmitter, global.starParticle, 10);

alarm[0] = room_speed*2;

#endregion