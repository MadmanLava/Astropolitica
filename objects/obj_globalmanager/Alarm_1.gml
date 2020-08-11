/// @desc Readable framerate
global.midFPS = fps_real;
alarm[1] = 20;

if(!global.paused and global.genStage = gen.completed and scr_chance(1))
{
	var text = scr_tickerjokes();
	
	scr_addToQueue(text, c_white);
}