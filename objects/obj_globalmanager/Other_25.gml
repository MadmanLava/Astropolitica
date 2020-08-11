/// @desc Reset

global.genRadius = 0;
global.genHyperlaneCount = 0;
global.genFactionCount = 0;
global.factionsPlaced = 0;
global.genExsolCount = 0;
global.genStage = gen.inactive;
global.lanesPruned = false;

global.genStarCount = 0;
global.genPlanetCount = 0;
global.starsDone = 0;
global.lanesDone = 0;
global.planetsDone = 0;
global.avgPlanetCount = 0;
global.rareStarCount = 0;
global.eStarCount = 0;
global.classOCount = 0;
global.classBCount = 0;
global.classACount = 0;
global.classFCount = 0;
global.classGCount = 0;
global.classKCount = 0;
global.classMCount = 0;
global.classWCount = 0;
global.classDCount = 0;
global.neutronCount = 0;
global.blackholeCount = 0;

ds_list_clear(global.systemList);
ds_list_clear(global.emptySystemList);