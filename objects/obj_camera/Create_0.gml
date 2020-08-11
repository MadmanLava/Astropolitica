//Camera Handles
camera = view_camera;

//Camera Scalars
panbase = 6;
panspeed = panbase;

global.camScroll = 1;
scrollspeed = 32;

//Mouse Variables
mousescrollspeed = 90;
mouseholderx = 0;
mouseholdery= 0;

movementAllowed = true;

panning = false;

//Background Adjustment
currentlayer = layer_get_id("Starfield");
background = layer_background_get_id(currentlayer);
layer_background_xscale(background, 0.4);
layer_background_yscale(background, 0.4); 
