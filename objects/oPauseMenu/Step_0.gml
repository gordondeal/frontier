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

//sound
if(menuSelected != menuSelectedPrev){
	audio_play_sound(sndMenu, 1, false);
}

//select
if(keyboard_check_pressed(vk_enter) or gamepad_button_check_pressed(global.gp, gp_face1)){
	switch(menuSelected){
		case op.resume:
			instance_activate_all();
			global.pause = false;
			instance_destroy();
		break;
		case op.save:
			//create map
			var map = ds_map_create();
			
			//reactivate player
			instance_activate_object(oPlayer);
			
			//save player info
			map[? "x"] = oPlayer.x;
			map[? "y"] = oPlayer.y;
			map[? "hp"] = oPlayer.hp;
			map[? "stamina"] = oPlayer.stamina;
			
			//save inventory
			map[? "inv"] = ds_list_write(global.inv);
			
			//save world info
			map[? "room"] = room;
			map[? "time"] = global.time;
			
			//save map and delete it
			ds_map_secure_save(map, "savefile");
			ds_map_destroy(map);
			
			//deactivate player
			instance_deactivate_object(oPlayer);
			
			//text
			menuText[op.save] = "Game Saved.";
			alarm[0] = 30;
		break;
		case op.quit:
			game_restart();
		break;
	}
}