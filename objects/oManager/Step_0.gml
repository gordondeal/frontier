//pause
if(keyboard_check_pressed(vk_escape) or gamepad_button_check_pressed(global.gp, gp_start)){
	//toggle
	global.pause = !global.pause;
	
	//pause
	if(global.pause){
		//deactivate
		instance_deactivate_all(true);
		
		//pause menu
		instance_create_layer(0, 0, "Instances", oPauseMenu);
	} else {
		//activate
		instance_activate_all();
		
		//pause menu
		instance_destroy(oPauseMenu);
	}
}

if(global.pause) exit;


//advance time
global.time += 0.01;
global.time = global.time mod 24;