menuSelectedPrev = menuSelected;

//menu navigation
var menuMove = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
if(gamepad_is_connected(global.gp)){
	lyaxis = gamepad_axis_value(global.gp, gp_axislv);
	if (lyaxis > 0 and reset == 1){
		menuMove = 1;
		reset = 0;
	}
	if (lyaxis < 0 and reset == 1){
		menuMove = -1;
		reset = 0;
	}
	if (lyaxis == 0) reset = 1; 
}
menuSelected += menuMove;

if(menuSelected >= menuOptions) menuSelected = 0;
if(menuSelected < 0) menuSelected = menuOptions - 1;

if(menuSelected != menuSelectedPrev){
	audio_play_sound(sndMenu, 1, false);
}

//select
if(keyboard_check_pressed(vk_enter) or gamepad_button_check_pressed(global.gp, gp_face1)){
	switch(menuSelected){
		case mp.newGame:
			room_goto(rmWorld);
			
			//add oManager
			instance_create_layer(0, 0, "Instances", oManager);
		break;
		case mp.load:
			if(file_exists("savefile")){
				//load map
				global.loadMap = ds_map_secure_load("savefile");
				
				//change room
				var loadRoom = global.loadMap[? "room"];
				room_goto(loadRoom);
				
				//add oManager
				instance_create_layer(0, 0, "Instances", oManager);
			} else {
				menuText[mp.load] = "No save found.";
				alarm[0] = 30;
			}
		break;
		case mp.quit:
			game_end();
		break;
	}
}