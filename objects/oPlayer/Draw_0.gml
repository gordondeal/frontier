//arrow surface
if(!surface_exists(playerSurf)){
	playerSurf = surface_create(global.width, global.height);
}

drawX = round(x);
drawY = round(y);

var camX = camera_get_view_x(view_camera);
var camY = camera_get_view_y(view_camera);

//////shadows
surface_set_target(playerSurf);
draw_clear_alpha(0, 0);
//draw_sprite_ext(sArrow, 0, x - camX, y - camY, 1, 1, image_angle, image_blend, 1);

angleAdjust = aimDir - (moveDir*45);
angleAdjust = angleAdjust < 24 ? angleAdjust : angleAdjust - 360;
angleAdjust *= 0.7;

if(bowState != -1){
	
	draw_sprite_ext(farArm[bowState, moveDir], image_index, drawX - camX, drawY-16 - camY, image_xscale, image_yscale, image_angle + angleAdjust, image_blend, image_alpha);
}
draw_sprite(sprite_index, image_index, drawX - camX, drawY - camY);
if(bowState != -1){
	//angleAdjust = aimDir - (moveDir*45);
	show_debug_message(angleAdjust);
	draw_sprite_ext(nearArm[bowState, moveDir], image_index, drawX - camX, drawY-16 - camY, image_xscale, image_yscale, image_angle + angleAdjust, image_blend, image_alpha);
}

surface_reset_target();

//////draw surface

draw_surface_ext(playerSurf, camX, camY, 1, 1, 0, c_white, 1);