switch(state){
	case st.move:
		//audio_play_sound(choose(step_1, step_2, step_3, step_4), 1, false);
	break;
	
	case st.attack: case st.attack2: case st.roll:
		state_set(st.idle);
		
	break;
	
	case st.melee_to_bow_idle:
		state_set(st.bow_idle);
	break;
	
	case st.melee_to_bow_walk:
		state_set(st.bow_run);
	break;
	
	case st.bow_draw_idle: case st.bow_draw_forward: case st.bow_draw_backward: case st.bow_draw_right: case st.bow_draw_left:
		if(bowState == bowSt.draw and gamepad_button_check(global.gp, gp_shoulderlb)) state = st.bow_aim_idle;
		else {
			state = st.bow_shoot_idle;
			bowState = bowSt.shoot;
			var aimX = gamepad_axis_value(global.gp, gp_axisrh);
			var aimY = gamepad_axis_value(global.gp, gp_axisrv);
			aimDir = point_direction(0, 0, aimX, aimY);
			var arrow = instance_create_layer(x, y, "Instances", oPlayer_arrow);
			with(arrow) image_angle = other.aimDir;
			show_debug_message("arrow shot")
			audio_play_sound(bow_shoot, 1, false);
		}
	break;
	
	case st.bow_shoot_idle: case st.bow_shoot_forward: case st.bow_shoot_backward: case st.bow_shoot_left: case st.bow_shoot_right:
		bowState = -1;
		state_set(st.bow_idle);
	break;
	
	case st.bow_to_melee_idle: case st.bow_to_melee_walk:
		if(attack){
			attack = false;
			instance_create_layer(x,y,"Instances", oPlayer_melee_hit);
			audio_play_sound(sword_swoosh, 1, false);
			stamina -= meleeCost;
			state_set(st.attack);
		} else if(keyboard_check(vk_shift) and stamina > 0){
			state_set(st.block_idle);
			target = instance_nearest(x, y, oEnemies);
			audio_play_sound(sndBlock, 1, false);
		} else if(st.bow_to_melee_idle){
			state_set(st.idle);
		} else state_set(st.move);
		
	break;
	
	
	
	//case st.bow_to_melee_walk:
	//	if(attack){
	//		attack = false;
	//		instance_create_layer(x,y,"Instances", oPlayer_melee_hit);
	//		audio_play_sound(sword_swoosh, 1, false);
	//		stamina -= meleeCost;
	//		state_set(st.attack);
	//	} else if(keyboard_check(vk_shift) and stamina > 0){
	//		state_set(st.block_idle);
	//		target = instance_nearest(x, y, oEnemies);
	//		audio_play_sound(sndBlock, 1, false);
	//	} else state_set(st.move);
	//break;
	
	case st.dead:
		image_speed = 0;
		image_index = image_number - 1;
	
		alarm[0] = 60;
	break;
	
}