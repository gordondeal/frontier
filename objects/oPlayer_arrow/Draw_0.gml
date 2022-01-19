//var camX = view_xport[0];
//var camY = view_yport[0];
var camX = camera_get_view_x(view_camera);
var camY = camera_get_view_y(view_camera);

//////shadows
surface_set_target(arrowSurf);
draw_clear_alpha(0, 0);
draw_sprite_ext(sArrow, 0, x - camX, y - camY, 1, 1, image_angle, image_blend, 1);

surface_reset_target();

//////draw surface

draw_surface_ext(arrowSurf, camX, camY, 1, 1, 0, c_white, 1);

//show_debug_message("player coords: " + string(oPlayer.x) + ", " + string(oPlayer.y));
//show_debug_message("camera coords: " + string(camX) + ", " + string(camY));
