/// @desc Reset

//Clear grid
ds_grid_destroy(lanePairs);
lanePairs = ds_grid_create(2, 0);

//destroy buffer
vertex_delete_buffer(v_buff);
v_buff = vertex_create_buffer();