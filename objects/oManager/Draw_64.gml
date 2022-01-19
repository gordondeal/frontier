 if(global.pause) exit;

//lighting surface
surface_set_target(lightSurf);

draw_clear(c_white);

//evening
var eveningDist = time_difference(eveningTime, global.time, 24);
var eveningAlpha = max(0, eveningSpread - eveningDist)/eveningSpread;

draw_set_color(eveningColor);
draw_set_alpha(eveningAlpha);
draw_rectangle(0, 0, global.width, global.height, false);
draw_set_color(c_white);
draw_set_alpha(1);

//night
var nightAlpha;
if(global.time > nightTimeA and global.time < nightTimeB){
	nightAlpha = 1;
} else {
	var nightDistA = time_difference(nightTimeA, global.time, 24);
	var nightDistB = time_difference(nightTimeB, global.time, 24);
	var nightDist = min(nightDistA, nightDistB);
	nightAlpha = max(0, nightSpread - nightDist)/nightSpread;
}

draw_set_color(nightColor);
draw_set_alpha(nightAlpha);
draw_rectangle(0, 0, global.width, global.height, false);
draw_set_color(c_white);
draw_set_alpha(1);

//lights
gpu_set_blendmode(bm_add);

with(oLight){
	var drawX = x - camera_get_view_x(view_camera);
	var drawY = y - camera_get_view_y(view_camera);
	
	draw_circle_color(drawX, drawY, lightRadius, c_lime, c_black, 0);
}

gpu_set_blendmode(bm_normal);

surface_reset_target();

//draw lighting
if(room == rmWorld){
	gpu_set_blendmode_ext(bm_zero, bm_src_color);
	draw_surface(lightSurf, 0, 0);
	gpu_set_blendmode(bm_normal);
}

//show time
draw_set_font(ftDialogue);
draw_text(32, 64, "Time: " + string(global.time));

//healthbar
hpShow = lerp(hpShow, oPlayer.hp, 0.2);

var hpWidth = (hpShow/100)*sprite_get_width(sHealthbar);
var hpHeight = sprite_get_height(sHealthbar);

draw_sprite(sHealthbar, 1, 4, 4);
draw_sprite_part(sHealthbar, 0, 0, 0, hpWidth, hpHeight, 4, 4);

//stamina
var stWidth = (oPlayer.stamina/100)*sprite_get_width(sStaminabar);
var stHeight = sprite_get_height(sStaminabar);

draw_sprite(sStaminabar, 1, 4, 4*2 + hpHeight);
draw_sprite_part(sStaminabar, 0, 0, 0, stWidth, stHeight, 4, 4*2 + hpHeight);
