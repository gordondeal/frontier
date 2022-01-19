//camera
view_enabled = true;
view_visible[0] = true;

//width = 480;
//height = 270;
//scale = 3;

var cam = camera_create_view(0, 0, global.width, global.height, 0, -1, -1, -1, global.width/2, global.height/2);
view_set_camera(0, cam);

//window_set_size(width*scale, height*scale);
//surface_resize(application_surface, width*scale, height*scale);
//display_set_gui_size(width, height);

//tileset
global.Tiles_Walls = layer_tilemap_get_id("Tiles_Walls");

camera_set_view_pos(view_camera[0], oPlayer.x-global.width/2, oPlayer.y-global.height/2);

//load
if(ds_exists(global.loadMap, ds_type_map)){
	loadGame();
}