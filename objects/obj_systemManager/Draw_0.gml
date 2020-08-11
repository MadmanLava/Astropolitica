if(draw and genDone and global.drawStars)
{
	if(!surface_exists(dataSurf))
	{
		dataSurf = surface_create(128, 128);
		show_debug_message("Recreated the star drawing data surface!");
		with(obj_systemParent)
		{
			event_user(13);
		}
	}
	
	var surfTex = surface_get_texture(dataSurf);
	var sampler = shader_get_sampler_index(shd_stars, "dataSurf");
	texture_set_stage(sampler, surfTex);
	
	shader_set(shd_stars);
	vertex_submit(starBuff, pr_trianglelist, tex);
	shader_reset();
}