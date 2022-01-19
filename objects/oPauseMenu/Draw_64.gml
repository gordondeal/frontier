var guiW = display_get_gui_width();
var guiH = display_get_gui_height();

//draw black rect
draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(0, 0, guiW, guiH, 0);
draw_set_alpha(1);
draw_set_color(c_white);

//draw menu
menuX = 32;
menuY = 32;

for(var i = 0; i < menuOptions; i++){
	//alpha
	if(i != menuSelected) draw_set_alpha(0.7);
	
	//draw
	draw_set_font(ftDialogue);
	draw_text(menuX, menuY + 32*i, menuText[i]);
	
	//reset
	draw_set_alpha(1);
}