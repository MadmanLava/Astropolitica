if(global.genStage != gen.completed)
{
	exit;
}

if(global.drawPolarGrid)
{
	
	var polarColor = make_color_rgb(50, 50, 50)
	var radius = global.genRadius;
	
	draw_circle_color(25000, 25000, radius, polarColor, polarColor, true);
	draw_circle_color(25000, 25000, radius * (2/3), polarColor, polarColor, true);
	draw_circle_color(25000, 25000, radius/3, polarColor, polarColor, true);
	
	//Straight
	draw_line_color(25000, 25000 - radius, 25000, 25000 + radius, polarColor, polarColor);
	draw_line_color(25000 - radius, 25000, 25000 + radius, 25000, polarColor, polarColor);
	
	//45 degree
	draw_line_color((25000 - radius*cos(45*(pi/180))), (25000 - radius*sin(45*(pi/180))), (25000 + radius*cos(45*(pi/180))), (25000 + radius*sin(45*(pi/180))), polarColor, polarColor);
	draw_line_color((25000 - radius*cos(135*(pi/180))), (25000 - radius*sin(45*(pi/180))), (25000 + radius*cos(135*(pi/180))), (25000 + radius*sin(45*(pi/180))), polarColor, polarColor);
	
}

if(global.drawLanes)
{
	vertex_submit(v_buff, pr_linelist, -1);
}