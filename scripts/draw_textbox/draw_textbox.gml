// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_textbox(string, characters){
	var str = string_copy(string, 1, characters);
	var maxW = 128;
	var strW = string_width_ext(string, -1, maxW);
	var strH = string_height_ext(string, -1, maxW);
	
	//arrow
	var aX = x - camera_get_view_x(view_camera);
	var aY = y - (sprite_height/2 + 8) - camera_get_view_y(view_camera);
	
	//textbox
	var margin = 8;
	var tbW = strW + margin*2;
	var tbH = strH + margin*2;
	var tbX = aX - tbW/2;
	var tbY= aY - tbH;
	
	//draw arrow
	draw_sprite(sTextarrow, 0, aX, aY);
	
	//draw textbox
	draw_9slice(tbX, tbY, tbW, tbH, sTextbox, 0);
	
	//draw text
	draw_set_color(c_black);
	draw_text_ext(tbX + margin, tbY + margin, str, -1, strW);
	draw_set_color(c_white);
}