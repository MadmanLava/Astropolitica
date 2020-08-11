mousex = window_mouse_get_x();
mousey = window_mouse_get_y();

menu = 1;
buttonHold = false;

genMenuQueue = ds_queue_create();
ds_queue_enqueue(genMenuQueue, "Galaxy Settings", "System Settings", "Star Settings", "Planet Settings", "Country Settings", "Gameplay Settings");
genMenu = "Galaxy Settings";
genMenuOpen = false;

#region Scrolling
scrollSpeed = 16;
scroll = 0;

guideScroll = 0;

#endregion

#region Flag Designer
flag = ds_map_create();

flag[? "shape"] = "square";

flag[? "baseColor"] = c_gray;

flag[? "emblem1"] = spr_flagBlank;
flag[? "emblempos1"] = 0;
flag[? "emblemColor1"] = c_white;

flag[? "emblem2"] = spr_flagBlank;
flag[? "emblempos2"] = 0;
flag[? "emblemColor2"] = c_white;

flag[? "emblem3"] = spr_flagBlank;
flag[? "emblempos3"] = 0;
flag[? "emblemColor3"] = c_white;

flagTab = 1;

flagBright = 0;
flagBright2 = 0;

flagColorSlider1 = ds_map_create();

flagColorSlider1[? "red"] = 128;
flagColorSlider1[? "green"] = 128;
flagColorSlider1[? "blue"] = 128;

flagColorSlider2 = ds_map_create();

flagColorSlider2[? "red"] = 255;
flagColorSlider2[? "green"] = 255;
flagColorSlider2[? "blue"] = 255;

scrollSpeed = 64;

flagScroll1 = 0;
flagScroll2 = 0;
flagScroll3 = 0;

#endregion