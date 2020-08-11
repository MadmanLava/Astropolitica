#region Data Storage
draw_set_circle_precision(32);

//Pair List, each row is a pair of system ids
lanePairs = ds_grid_create(2, 0);

//Vertex Buffer
v_buff = vertex_create_buffer();

//Lane format
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_color();
lane_format = vertex_format_end()
#endregion