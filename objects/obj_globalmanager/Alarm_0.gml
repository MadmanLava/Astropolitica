/// @desc star particles

if(room == mainmenu)
{
	part_emitter_region(global.starEmitter, global.starParticle, 0, global.camWid+540, 0, global.camHei+540, ps_shape_rectangle, ps_distr_linear);
	part_emitter_stream(global.particleSystem, global.starEmitter, global.starParticle, 10);
	alarm[0] = room_speed*2;
}
