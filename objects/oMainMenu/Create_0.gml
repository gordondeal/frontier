global.loadMap = -1;

//menu
 enum mp{ 
	newGame, 
	load, 
	quit 
}

menuText[mp.newGame] = "New";
menuText[mp.load] = "Load";
menuText[mp.quit] = "Quit";

menuSelected = 0;
menuOptions = array_length(menuText);
menuSelectedPrev = 0;

global.width = 426;
global.height = 240;
global.scale = 4;

window_set_size(global.width*global.scale, global.height*global.scale);
surface_resize(application_surface, global.width*global.scale, global.height*global.scale);
display_set_gui_size(global.width, global.height);
display_reset(0, false);

room_width = global.width;
room_height = global.height;

reset = 1;
lyaxis = 0;
gamepad_set_axis_deadzone(0, 0.25);

