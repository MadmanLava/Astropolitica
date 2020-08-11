if(timer == 0)
{
	instance_destroy();
}
else
{
	timer--;
	
	image_alpha = timer/60;
	image_xscale = 2 * (30/timer);
	image_yscale = 2 * (30/timer);
}