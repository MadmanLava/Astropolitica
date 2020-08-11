list = ds_list_create();
draw = true;

genDone = false;

camX = global.camX;
camY = global.camY;
camWid = global.camWid;
camHei = global.camHei;

//Build vertex buffer

vertex_format_begin();
vertex_format_add_position();
vertex_format_add_texcoord();
vertex_format_add_custom(vertex_type_float2, vertex_usage_color);
starFormat = vertex_format_end();

starBuff = vertex_create_buffer();

tex = sprite_get_texture(spr_system, 0);

dataSurf = surface_create(128, 128);