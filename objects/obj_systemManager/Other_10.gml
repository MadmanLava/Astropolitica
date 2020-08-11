/// @desc Build vertex buffer

vertex_begin(starBuff, starFormat);

var i = 0;
repeat(global.genStarCount)
{
	var target = instance_find(obj_system, i).id;
	//var tarID = target.seq_id;
	var tarX = target.seq_x/128;
	var tarY = target.seq_y/128;
	
	var tarCenterX = target.x;
	var tarCenterY = target.y;
	
	var tarTLX = tarCenterX-32;
	var tarTLY = tarCenterY-32;
	
	var tarTRX = tarCenterX+32;
	var tarTRY = tarCenterY-32;
	
	var tarBLX = tarCenterX-32;
	var tarBLY = tarCenterY+32;
	
	var tarBRX = tarCenterX+32;
	var tarBRY = tarCenterY+32;
	
	//Triangle 1
	vertex_position(starBuff, tarTLX, tarTLY);
	vertex_texcoord(starBuff, 0, 0);
	vertex_float2(starBuff, tarX, tarY);
	
	vertex_position(starBuff, tarBLX, tarBLY);
	vertex_texcoord(starBuff, 0, 1);
	vertex_float2(starBuff, tarX, tarY);
	
	vertex_position(starBuff, tarBRX, tarBRY);
	vertex_texcoord(starBuff, 1, 1);
	vertex_float2(starBuff, tarX, tarY);
	
	//Triangle 2
	vertex_position(starBuff, tarBRX, tarBRY);
	vertex_texcoord(starBuff, 1, 1);
	vertex_float2(starBuff, tarX, tarY);
	
	vertex_position(starBuff, tarTRX, tarTRY);
	vertex_texcoord(starBuff, 1, 0);
	vertex_float2(starBuff, tarX, tarY);
	
	vertex_position(starBuff, tarTLX, tarTLY);
	vertex_texcoord(starBuff, 0, 0);
	vertex_float2(starBuff, tarX, tarY);
	
	i++
}

vertex_end(starBuff);