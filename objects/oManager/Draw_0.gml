 //vars
var camX = camera_get_view_x(view_camera);
var camY = camera_get_view_y(view_camera);

//shadows
surface_set_target(shadowSurf);
draw_clear_alpha(0, 0);

with(all){
	var listPos = ds_list_find_index(other.noShadow, object_index);
	
	if(listPos == -1){
		//shadow size
		var shWidth = 10;
		
		var shHeight = shWidth*0.5;
		
		var shX = x - camX;
		var shY = y - camY + 9;
		
		//draw
		draw_ellipse(
			shX - shWidth,
			shY - shHeight,
			shX + shWidth - 1,
			shY + shHeight - 1,
			0
		);
	}
}

surface_reset_target();

//draw surface
var shColor = c_black;
var shAlpha = 0.1;
//draw_surface(shadowSurf, camX, camY);
draw_surface_ext(shadowSurf, camX, camY, 1, 1, 0, shColor, shAlpha);