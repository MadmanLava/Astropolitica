/// @description Detail generation

if(!detailDone)
{
	var golden_ratio_conjugate = 0.618033988749895
	//Cosmetic
	var tempHue = random_range(0, 1)
	tempHue += golden_ratio_conjugate
	tempHue = (tempHue mod 1) * 255;
	color1 = make_color_hsv(tempHue, 255, 255);
	
	color2 = make_color_hsv(color_get_hue(color1), 200, 200);

	#region Government
	//Broad
	authority = choose("Democratic", "Oligarchic", "Authoritarian", "Theocratic");

	///Specific Government Type
	if(authority == "Democratic")
	{
		govType = choose("Direct Democracy", "Democratic Republic", "Constitutional Monarchy");
	}

	if(authority == "Oligarchic")
	{
		govType = choose("Oligarchic Republic", "Oligarchic Council");
	}

	if(authority == "Authoritarian")
	{
		govType = choose("Absolute Monarchy", "Dictatorship", "Military Dictatorship", "Military Junta");
	}

	if(authority == "Theocratic")
	{
		govType = choose("Theocratic Republic", "Theocratic Council", "Theocratic Monarchy");
	}
	#endregion
	
	var nameHolder = scr_namegenerator("faction", authority, govType, scr_chance(10), scr_chance(global.vanityChance));
	baseName = string_copy(nameHolder, 1, string_pos("|", nameHolder)-1);
	draw_set_font(fnt_defaultlarge);
	baseWidth = string_width(baseName);
	name = string_copy(nameHolder, string_pos("|", nameHolder)+1, (string_length(nameHolder) - string_pos("|", nameHolder)));
	
	detailDone = true;
}