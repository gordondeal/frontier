switch(state){
	case st.idle: case st.move:
		
		//input for sword n board
		var inputX, inputY, run;
		inputX = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		inputY = keyboard_check(ord("S")) - keyboard_check(ord("W")); 
		//run = keyboard_check(vk_shift) and stamina > 0;
		run = false;
		var block = keyboard_check(vk_shift) and stamina > 0;
		attack = keyboard_check_pressed(vk_space) and stamina >= meleeCost;
		
		
		dir = point_direction(0, 0, inputX, inputY);
		moveX = lengthdir_x(moveSpeed, dir) * (1 + run) + round(boostX);
		moveY = lengthdir_y(moveSpeed, dir) * (1 + run) + round(boostY);
		
		//gamepad input
		if(gamepad_is_connected(global.gp)){
			inputX = gamepad_axis_value(global.gp, gp_axislh);
			if(abs(inputX) < 0.2) inputX = 0;
			
			inputY = gamepad_axis_value(global.gp, gp_axislv);
			if(abs(inputY) < 0.2) inputY = 0;
			
			attack = gamepad_button_check_pressed(global.gp, gp_face1) and stamina >= meleeCost;
			//run = gamepad_button_check(global.gp, gp_shoulderr) and stamina > 0;
			var block = gamepad_button_check(global.gp, gp_shoulderr) and stamina > 0;
			
			dir = point_direction(0, 0, inputX, inputY);
			moveX = inputX * moveSpeed * (1 + run) + round(boostX);
			moveY = inputY * moveSpeed * (1 + run) + round(boostY);
			equipBow = gamepad_button_check(global.gp, gp_shoulderlb);
		}
		
		//state
		if(abs(inputX)+abs(inputY) == 0){
			state = st.idle;
			moveSpeed = 0;
		} else {
			state = st.move
			moveSpeed = walkSpeed;
			//speed up sprite when running
			image_speed = moveSpeed*1.5;
		}

		//calculate move
		
		
		//collision
		if(collision(moveX, 0)){
			
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		//move player
		x += moveX;
		y += moveY;
		
		if((moveX != 0 or moveY != 0) and (round(image_index) == 1 or round(image_index) == 7) and !stepPlaying()){
			audio_play_sound(choose(step_1, step_2, step_3, step_4), 1, false);
		}
		
		//direction
		if(state == st.move){
			moveDir = (dir+22.5) div 45 < 8 ? (dir+22.5) div 45 : 0;
		}
		
		//attack
		if(attack){
			attack = false;
			state_set(st.attack);
			instance_create_layer(x,y,"Instances", oPlayer_melee_hit);
			audio_play_sound(sword_swoosh, 1, false);
			stamina -= meleeCost;
		}
		
		//equip bow
		if(equipBow){
			equipBow = false;
			if(state == st.move) state_set(st.melee_to_bow_walk);
			else state_set(st.melee_to_bow_idle);
		}
		
		//block
		if(block){
			state_set(st.block_idle);
			target = instance_nearest(x, y, oEnemies);
			audio_play_sound(sndBlock, 1, false);
		} 
		
		//enemy collision
		with(hitbox){
			var enemyHit = instance_place(x, y, oSkeleton_melee_hit);
		
			if(enemyHit and other.hit_cooldown == 0){
				var enemy = enemyHit.owner;
				
				var dir = point_direction(enemy.x, enemy.y, other.x, other.y);
				other.boostX = lengthdir_x(8, dir);
				other.boostY = lengthdir_y(8, dir);
			
				other.hp -= enemy.attack;
				audio_play_sound(skeleton_hit, 1, false);
			
				other.hit_cooldown = 30;
			} 
		}
		
		//stamina
		if(run){
			stamina--;
			staminaRefill = 60;
		} else if(stamina < 100 and staminaRefill <= 0) {
			stamina++;
		}
		
		if(staminaRefill > 0) staminaRefill--;
		
		//mask
		mask_index = sPlayer_Mask;
		
	break;
	
	case st.attack: case st.attack2:
		if((keyboard_check_pressed(vk_space) or gamepad_button_check_pressed(global.gp, gp_face1)) and stamina >= meleeCost) attack = true;
	
		var block = (keyboard_check(vk_shift) or gamepad_button_check(global.gp, gp_shoulderr)) and stamina > 0;
		if(!block) target = -1;
		
		if(attack and image_index > 6){
			attack = false;
			
			stamina -= meleeCost;
			var inputX, inputY, dir;
			inputX = keyboard_check(ord("D")) - keyboard_check(ord("A"));
			inputY = keyboard_check(ord("S")) - keyboard_check(ord("W")); 
			 dir = point_direction(0, 0, inputX, inputY);
			if(target > -1) dir = point_direction(x, y, target.x, target.y);
		
			moveX = lengthdir_x(moveSpeed, dir);
			moveY = lengthdir_y(moveSpeed, dir);
		
			//gamepad input
			if(gamepad_is_connected(global.gp)){
				inputX = gamepad_axis_value(global.gp, gp_axislh);
				if(abs(inputX) < 0.2) inputX = 0;
			
				inputY = gamepad_axis_value(global.gp, gp_axislv);
				if(abs(inputY) < 0.2) inputY = 0;
			
				//attack = gamepad_button_check_pressed(global.gp, gp_face1);
			
				dir = point_direction(0, 0, inputX, inputY);
				if(target > -1) dir = point_direction(x, y, target.x, target.y);
				moveX = inputX * moveSpeed;
				moveY = inputY * moveSpeed;
			}
			
			var moving = inputX != 0 or inputY != 0;
			
			if(moving and target == -1) moveDir = (dir+22.5) div 45 < 8 ? (dir+22.5) div 45 : 0;
			
			audio_play_sound(sword_swoosh, 1, false);
			
			if(state == st.attack){
				state_set(st.attack2); 
				instance_create_layer(x,y,"Instances", oPlayer_melee_hit2);
			}else if(state == st.attack2){
				state_set(st.attack);
				instance_create_layer(x,y,"Instances", oPlayer_melee_hit);
			}
		}
		
		//mask_index = sPlayer_Mask;
		image_speed = 1.5;
		
		//collision
		if(collision(moveX, 0)){
			
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		//enemy collision
		with(hitbox){
			var enemyHit = instance_place(x, y, oSkeleton_melee_hit);
			
		
			if(enemyHit and other.hit_cooldown == 0){
				var enemy = enemyHit.owner;
				
				var dir = point_direction(enemy.x, enemy.y, other.x, other.y);
				other.boostX = lengthdir_x(8, dir);
				other.boostY = lengthdir_y(8, dir);
			
				other.hp -= enemy.attack;
				audio_play_sound(skeleton_hit, 1, false);
			
				other.hit_cooldown = 30;
			} 
		}
			
		
		moveX *= 0.9;
		moveY *= 0.9;
		
		//move player
		x += moveX;
		y += moveY;
	break;
	
	case st.block_idle: case st.block_forward: case st.block_backward: case st.block_right: case st.block_left:
		if(target == -1){
			target = instance_nearest(x, y, oEnemies);
		}
		var target_dir = point_direction(x, y, target.x, target.y);
		var inputX = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		var inputY = keyboard_check(ord("S")) - keyboard_check(ord("W")); 
		var dir = point_direction(0, 0, inputX, inputY);
		var roll = gamepad_button_check_pressed(global.gp, gp_face2) or keyboard_check_pressed(ord("Q"));
		
		moveX = lengthdir_x(moveSpeed/2, dir) + round(boostX);
		moveY = lengthdir_y(moveSpeed/2, dir) + round(boostY);
		
		//gamepad input
		if(gamepad_is_connected(global.gp)){
			inputX = gamepad_axis_value(global.gp, gp_axislh);
			if(abs(inputX) < 0.2) inputX = 0;
			
			inputY = gamepad_axis_value(global.gp, gp_axislv);
			if(abs(inputY) < 0.2) inputY = 0;
			
			
			dir = point_direction(0, 0, inputX, inputY);
			moveX = inputX * moveSpeed/2 + round(boostX);;
			moveY = inputY * moveSpeed/2 + round(boostY);;
		}
		
		if(abs(inputX)+abs(inputY) == 0){
			moveSpeed = 0;
			state = st.block_idle;
		} else {
			moveSpeed = walkSpeed;
			//speed up sprite when running
			image_speed = moveSpeed*1.5;
			
			var dir_dif = target_dir - dir >= 0 ? target_dir - dir : target_dir - dir + 360;
			var block_dir = (dir_dif+45) div 90 < 4 ? (dir_dif+45) div 90 : 0;
			if(block_dir == 0) state = st.block_forward;
			else if(block_dir == 1) state = st.block_right;
			else if(block_dir == 2) state = st.block_backward;
			else if(block_dir == 3) state = st.block_left;
		}
		
		if(keyboard_check_released(vk_shift) or gamepad_button_check_released(global.gp, gp_shoulderr) or stamina <= 0){
			state_set(st.idle);
			target = -1;
			audio_play_sound(sndBlock, 1, false);
		}
		
		
		attack = (keyboard_check_pressed(vk_space) or gamepad_button_check_pressed(global.gp, gp_face1)) and stamina >= meleeCost;
		moveDir = (target_dir+22.5) div 45 < 8 ? (target_dir+22.5) div 45 : 0;
		
		//attack
		if(attack){
			attack = false;
			state_set(st.attack);
			instance_create_layer(x,y,"Instances", oPlayer_melee_hit);
			audio_play_sound(sword_swoosh, 1, false);
			stamina -= meleeCost;
		}
		
		if(roll){
			moveDir = (dir+22.5) div 45 < 8 ? (dir+22.5) div 45 : 0;
			rollDir = dir;
			state_set(st.roll);
		}
		
		//collision
		if(collision(moveX, 0)){
			
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		//enemy collision
		with(hitbox){
			var enemyHit = instance_place(x, y, oSkeleton_melee_hit);
		
			if(enemyHit and other.hit_cooldown == 0){
				var enemy = enemyHit.owner;
				
				var dir = point_direction(enemy.x, enemy.y, other.x, other.y);
				other.boostX = lengthdir_x(2, dir);
				other.boostY = lengthdir_y(2, dir);
			
				audio_play_sound(choose(shield_hit, shield_hit2), 1, false);
			
				other.hit_cooldown = 30;
			} 
		}
		
		
		moveX *= 0.9;
		moveY *= 0.9;
		
		if((moveX != 0 or moveY != 0) and (round(image_index) == 1 or round(image_index) == 9) and !stepPlaying()){
			audio_play_sound(choose(step_1, step_2, step_3, step_4), 1, false);
		}
		
		x += moveX;
		y += moveY;
		
	break;
	case st.roll:
		//collision
		if(collision(moveX, 0)){
			
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		if(keyboard_check_released(vk_shift) or gamepad_button_check_released(global.gp, gp_shoulderr) or stamina <= 0){
			target = -1;
		}
		
		image_speed = 1.5;
		
		//moveX += round(boostX);
		moveX = lengthdir_x(moveSpeed, rollDir) + round(boostX);
		moveY = lengthdir_y(moveSpeed, rollDir) + round(boostY);
		
		x += moveX;
		y += moveY;
	break;
	case st.melee_to_bow_idle: case st.melee_to_bow_walk:
		//input for sword n board
		var inputX, inputY, run;
		inputX = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		inputY = keyboard_check(ord("S")) - keyboard_check(ord("W")); 
		
		dir = point_direction(0, 0, inputX, inputY);
		moveX = lengthdir_x(moveSpeed, dir) + round(boostX);
		moveY = lengthdir_y(moveSpeed, dir) + round(boostY);
		
		//gamepad input
		if(gamepad_is_connected(global.gp)){
			inputX = gamepad_axis_value(global.gp, gp_axislh);
			if(abs(inputX) < 0.2) inputX = 0;
			
			inputY = gamepad_axis_value(global.gp, gp_axislv);
			if(abs(inputY) < 0.2) inputY = 0;
			
			dir = point_direction(0, 0, inputX, inputY);
			moveX = inputX * moveSpeed + round(boostX);
			moveY = inputY * moveSpeed + round(boostY);
		}
		
		image_speed = 2;
		
		//state
		if(abs(inputX)+abs(inputY) == 0){
			state = st.melee_to_bow_idle;
			moveSpeed = 0;
		} else {
			state = st.melee_to_bow_walk;
			moveSpeed = walkSpeed/2;
			//speed up sprite when running
			//image_speed = moveSpeed*1.5;
		}

		//calculate move
		
		
		//collision
		if(collision(moveX, 0)){
			
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		//move player
		x += moveX;
		y += moveY;
		
		if((moveX != 0 or moveY != 0) and (round(image_index) == 4 or round(image_index) == 11) and !stepPlaying()){
			audio_play_sound(choose(step_1, step_2, step_3, step_4), 1, false);
		}
		
		if(round(image_index) == 2 and !audio_is_playing(sheath_sword)) audio_play_sound(sheath_sword, 1, false);
		if(round(image_index) == 14 and !audio_is_playing(equip_bow)) audio_play_sound(equip_bow, 1, false);
		
		//direction
		if(state == st.melee_to_bow_walk){
			moveDir = (dir+22.5) div 45 < 8 ? (dir+22.5) div 45 : 0;
		}
		
		//enemy collision
		with(hitbox){
			var enemyHit = instance_place(x, y, oSkeleton_melee_hit);
		
			if(enemyHit and other.hit_cooldown == 0){
				var enemy = enemyHit.owner;
				
				var dir = point_direction(enemy.x, enemy.y, other.x, other.y);
				other.boostX = lengthdir_x(4, dir);
				other.boostY = lengthdir_y(4, dir);
			
				other.hp -= enemy.attack;
				audio_play_sound(skeleton_hit, 1, false);
			
				other.hit_cooldown = 30;
			} 
		}
		
		if(stamina < 100 and staminaRefill <= 0) {
			stamina++;
		}
		
		if(staminaRefill > 0) staminaRefill--;
		
		//mask
		mask_index = sPlayer_Mask;
	break;
	
	case st.bow_idle: case st.bow_run:
		
		//input for sword n board
		var inputX, inputY, run;
		inputX = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		inputY = keyboard_check(ord("S")) - keyboard_check(ord("W")); 
		//run = keyboard_check(vk_shift) and stamina > 0;
		run = false;
		var block = keyboard_check(vk_shift) and stamina > 0;
		attack = keyboard_check_pressed(vk_space) and stamina >= meleeCost;
		bowState = keyboard_check_pressed(ord("E")) ? bowSt.draw : -1;
		
		
		dir = point_direction(0, 0, inputX, inputY);
		moveX = lengthdir_x(moveSpeed, dir) * (1 + run) + round(boostX);
		moveY = lengthdir_y(moveSpeed, dir) * (1 + run) + round(boostY);
		
		//gamepad input
		if(gamepad_is_connected(global.gp)){
			inputX = gamepad_axis_value(global.gp, gp_axislh);
			if(abs(inputX) < 0.2) inputX = 0;
			
			inputY = gamepad_axis_value(global.gp, gp_axislv);
			if(abs(inputY) < 0.2) inputY = 0;
			
			attack = gamepad_button_check_pressed(global.gp, gp_face1) and stamina >= meleeCost;
			//run = gamepad_button_check(global.gp, gp_shoulderr) and stamina > 0;
			var block = gamepad_button_check(global.gp, gp_shoulderr) and stamina > 0;
			
			dir = point_direction(0, 0, inputX, inputY);
			moveX = inputX * moveSpeed * (1 + run) + round(boostX);
			moveY = inputY * moveSpeed * (1 + run) + round(boostY);
			//equipBow = gamepad_button_check(global.gp, gp_shoulderlb);
			bowState = gamepad_button_check(global.gp, gp_shoulderlb) ? bowSt.draw : -1;
		}
		
		//state
		if(abs(inputX)+abs(inputY) == 0){
			state = st.bow_idle;
			moveSpeed = 0;
		} else {
			state = st.bow_run;
			moveSpeed = walkSpeed;
			//speed up sprite when running
			image_speed = moveSpeed*1.5;
		}

		//calculate move
		
		
		//collision
		if(collision(moveX, 0)){
			
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		//move player
		x += moveX;
		y += moveY;
		
		//footstep sounds
		if((moveX != 0 or moveY != 0) and (round(image_index) == 1 or round(image_index) == 7) and !stepPlaying()){
			audio_play_sound(choose(step_1, step_2, step_3, step_4), 1, false);
		}
		
		//direction
		if(state == st.bow_run){
			moveDir = (dir+22.5) div 45 < 8 ? (dir+22.5) div 45 : 0;
		}
		
		//attack
		if(attack){
			//attack = false;
			if(state == st.bow_run) state_set(st.bow_to_melee_walk);
			if(state == st.bow_idle) state_set(st.bow_to_melee_walk);
			//instance_create_layer(x,y,"Instances", oPlayer_melee_hit);
			//audio_play_sound(sword_swoosh, 1, false);
			//stamina -= meleeCost;
		}
		
		//block
		if(block){
			if(state == st.bow_run) state_set(st.bow_to_melee_walk);
			if(state == st.bow_idle) state_set(st.bow_to_melee_walk);
		}
		
		if(bowState == bowSt.draw){
			state_set(st.bow_draw_idle);
			audio_play_sound(bow_draw, 1, false);
		}
		
		//enemy collision
		with(hitbox){
			var enemyHit = instance_place(x, y, oSkeleton_melee_hit);
		
			if(enemyHit and other.hit_cooldown == 0){
				var enemy = enemyHit.owner;
				
				var dir = point_direction(enemy.x, enemy.y, other.x, other.y);
				other.boostX = lengthdir_x(8, dir);
				other.boostY = lengthdir_y(8, dir);
			
				other.hp -= enemy.attack;
				audio_play_sound(skeleton_hit, 1, false);
			
				other.hit_cooldown = 30;
			} 
		}
		
		if(stamina < 100 and staminaRefill <= 0) {
			stamina++;
		}
		
		if(staminaRefill > 0) staminaRefill--;
		
		//mask
		mask_index = sPlayer_Mask;
	break;
	
	case st.bow_draw_idle: case st.bow_draw_forward: case st.bow_draw_backward: case st.bow_draw_left: case st.bow_draw_right:
		image_speed = 2;
		//input for sword n board
		var target_dir, inputX, inputY, aimX, aimY;
		//var inputX = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		//var inputY = keyboard_check(ord("S")) - keyboard_check(ord("W")); 
		//var dir = point_direction(0, 0, inputX, inputY);
		//var roll = gamepad_button_check_pressed(global.gp, gp_face2) or keyboard_check_pressed(ord("Q"));
		
		//moveX = lengthdir_x(moveSpeed/2, dir) + round(boostX);
		//moveY = lengthdir_y(moveSpeed/2, dir) + round(boostY);
		
		//gamepad input
		if(gamepad_is_connected(global.gp)){
			inputX = gamepad_axis_value(global.gp, gp_axislh);
			aimX = gamepad_axis_value(global.gp, gp_axisrh);
			if(abs(inputX) < 0.2) inputX = 0;
			
			inputY = gamepad_axis_value(global.gp, gp_axislv);
			aimY = gamepad_axis_value(global.gp, gp_axisrv);
			if(abs(inputY) < 0.2) inputY = 0;
			aimDir = point_direction(0, 0, aimX, aimY);
			
			dir = point_direction(0, 0, inputX, inputY);
			target_dir = point_direction(0, 0, aimX, aimY);
			moveX = inputX * moveSpeed/2 + round(boostX);;
			moveY = inputY * moveSpeed/2 + round(boostY);;
		}
		
		if(abs(inputX)+abs(inputY) == 0){
			moveSpeed = 0;
			state = st.bow_draw_idle;
		} else {
			moveSpeed = walkSpeed;
			//speed up sprite when running
			image_speed = moveSpeed*1.5;
			
			var dir_dif = target_dir - dir >= 0 ? target_dir - dir : target_dir - dir + 360;
			var block_dir = (dir_dif+45) div 90 < 4 ? (dir_dif+45) div 90 : 0;
			if(block_dir == 0) state = st.bow_draw_forward;
			else if(block_dir == 1) state = st.bow_draw_right;
			else if(block_dir == 2) state = st.bow_draw_backward;
			else if(block_dir == 3) state = st.bow_draw_left;
			//show_debug_message("move: " + block_dir);
		}
		
		//if(keyboard_check_released(vk_shift) or gamepad_button_check_released(global.gp, gp_shoulderr) or stamina <= 0){
			//state_set(st.idle);
			//target = -1;
			//audio_play_sound(sndBlock, 1, false);
		//}
		
		
		//attack = (keyboard_check_pressed(vk_space) or gamepad_button_check_pressed(global.gp, gp_face1)) and stamina >= meleeCost;
		moveDir = (target_dir+22.5) div 45 < 8 ? (target_dir+22.5) div 45 : 0;
		//show_debug_message("aim: " + moveDir);
		
		
		//collision
		if(collision(moveX, 0)){
			
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		//enemy collision
		with(hitbox){
			var enemyHit = instance_place(x, y, oSkeleton_melee_hit);
		
			if(enemyHit and other.hit_cooldown == 0){
				var enemy = enemyHit.owner;
				
				var dir = point_direction(enemy.x, enemy.y, other.x, other.y);
				other.boostX = lengthdir_x(2, dir);
				other.boostY = lengthdir_y(2, dir);
			
				audio_play_sound(choose(shield_hit, shield_hit2), 1, false);
			
				other.hit_cooldown = 30;
			} 
		}
		
		
		moveX *= 0.9;
		moveY *= 0.9;
		
		if((moveX != 0 or moveY != 0) and (round(image_index) == 1 or round(image_index) == 9) and !stepPlaying()){
			audio_play_sound(choose(step_1, step_2, step_3, step_4), 1, false);
		}
		
		x += moveX;
		y += moveY;
		
		
	break;
	
	case st.bow_aim_idle: case st.bow_aim_forward: case st.bow_aim_backward: case st.bow_aim_left: case st.bow_aim_right:
		image_speed = 2;
		//input for sword n board
		var target_dir, inputX, inputY, aimX, aimY;
		//var inputX = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		//var inputY = keyboard_check(ord("S")) - keyboard_check(ord("W")); 
		//var dir = point_direction(0, 0, inputX, inputY);
		//var roll = gamepad_button_check_pressed(global.gp, gp_face2) or keyboard_check_pressed(ord("Q"));
		
		//moveX = lengthdir_x(moveSpeed/2, dir) + round(boostX);
		//moveY = lengthdir_y(moveSpeed/2, dir) + round(boostY);
		
		//gamepad input
		if(gamepad_is_connected(global.gp)){
			inputX = gamepad_axis_value(global.gp, gp_axislh);
			aimX = gamepad_axis_value(global.gp, gp_axisrh);
			if(abs(inputX) < 0.2) inputX = 0;
			
			inputY = gamepad_axis_value(global.gp, gp_axislv);
			aimY = gamepad_axis_value(global.gp, gp_axisrv);
			if(abs(inputY) < 0.2) inputY = 0;
			
			
			dir = point_direction(0, 0, inputX, inputY);
			aimDir = point_direction(0, 0, aimX, aimY);
			moveX = inputX * moveSpeed/2 + round(boostX);;
			moveY = inputY * moveSpeed/2 + round(boostY);;

			bowState = gamepad_button_check_released(global.gp, gp_shoulderlb) ? bowSt.shoot : bowSt.aim;
		}
		
		if(abs(inputX)+abs(inputY) == 0){
			moveSpeed = 0;
			state = st.bow_aim_idle;
		} else {
			moveSpeed = walkSpeed;
			//speed up sprite when running
			image_speed = moveSpeed*1.5;
			
			var dir_dif = aimDir - dir >= 0 ? aimDir - dir : aimDir - dir + 360;
			var block_dir = (dir_dif+45) div 90 < 4 ? (dir_dif+45) div 90 : 0;
			if(block_dir == 0) state = st.bow_aim_forward;
			else if(block_dir == 1) state = st.bow_aim_right;
			else if(block_dir == 2) state = st.bow_aim_backward;
			else if(block_dir == 3) state = st.bow_aim_left;
			//show_debug_message("move: " + block_dir);
		}
		
		//if(keyboard_check_released(vk_shift) or gamepad_button_check_released(global.gp, gp_shoulderr) or stamina <= 0){
			//state_set(st.idle);
			//target = -1;
			//audio_play_sound(sndBlock, 1, false);
		//}
		
		
		//attack = (keyboard_check_pressed(vk_space) or gamepad_button_check_pressed(global.gp, gp_face1)) and stamina >= meleeCost;
		moveDir = (aimDir+22.5) div 45 < 8 ? (aimDir+22.5) div 45 : 0;
		//show_debug_message("aim: " + moveDir);
		
		
		//collision
		if(collision(moveX, 0)){
			
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		//enemy collision
		with(hitbox){
			var enemyHit = instance_place(x, y, oSkeleton_melee_hit);
		
			if(enemyHit and other.hit_cooldown == 0){
				var enemy = enemyHit.owner;
				
				var dir = point_direction(enemy.x, enemy.y, other.x, other.y);
				other.boostX = lengthdir_x(2, dir);
				other.boostY = lengthdir_y(2, dir);
			
				audio_play_sound(choose(shield_hit, shield_hit2), 1, false);
			
				other.hit_cooldown = 30;
			} 
		}
		
		
		moveX *= 0.9;
		moveY *= 0.9;
		
		if((moveX != 0 or moveY != 0) and (round(image_index) == 1 or round(image_index) == 9) and !stepPlaying()){
			audio_play_sound(choose(step_1, step_2, step_3, step_4), 1, false);
		}
		
		x += moveX;
		y += moveY;
		
		
		if(bowState == bowSt.shoot){
			
			audio_play_sound(bow_shoot, 1, false);
			var arrow = instance_create_layer(x, y, "Instances", oPlayer_arrow);
			with(arrow) image_angle = other.aimDir;
			show_debug_message("arrow shot")
			state_set(st.bow_shoot_idle);
		}
	break;
	
	case st.bow_shoot_idle: case st.bow_shoot_forward: case st.bow_shoot_backward: case st.bow_shoot_left: case st.bow_shoot_right:
		image_speed = 2;
		//input for sword n board
		var target_dir, inputX, inputY, aimX, aimY;
		//var inputX = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		//var inputY = keyboard_check(ord("S")) - keyboard_check(ord("W")); 
		//var dir = point_direction(0, 0, inputX, inputY);
		//var roll = gamepad_button_check_pressed(global.gp, gp_face2) or keyboard_check_pressed(ord("Q"));
		
		//moveX = lengthdir_x(moveSpeed/2, dir) + round(boostX);
		//moveY = lengthdir_y(moveSpeed/2, dir) + round(boostY);
		
		//gamepad input
		if(gamepad_is_connected(global.gp)){
			inputX = gamepad_axis_value(global.gp, gp_axislh);
			//aimX = gamepad_axis_value(global.gp, gp_axisrh);
			if(abs(inputX) < 0.2) inputX = 0;
			
			inputY = gamepad_axis_value(global.gp, gp_axislv);
			//aimY = gamepad_axis_value(global.gp, gp_axisrv);
			if(abs(inputY) < 0.2) inputY = 0;
			//aimDir = point_direction(0, 0, aimX, aimY);
			
			dir = point_direction(0, 0, inputX, inputY);
			//target_dir = point_direction(0, 0, aimX, aimY);
			moveX = inputX * moveSpeed/2 + round(boostX);;
			moveY = inputY * moveSpeed/2 + round(boostY);;

			//bowState = gamepad_button_check_released(global.gp, gp_shoulderlb) ? "shoot" : "aim";
		}
		
		if(abs(inputX)+abs(inputY) == 0){
			moveSpeed = 0;
			state = st.bow_shoot_idle;
		} else {
			moveSpeed = walkSpeed;
			//speed up sprite when running
			image_speed = moveSpeed*1.5;
			
			var dir_dif = aimDir - dir >= 0 ? aimDir - dir : aimDir - dir + 360;
			var block_dir = (dir_dif+45) div 90 < 4 ? (dir_dif+45) div 90 : 0;
			if(block_dir == 0) state = st.bow_shoot_forward;
			else if(block_dir == 1) state = st.bow_shoot_right;
			else if(block_dir == 2) state = st.bow_shoot_backward;
			else if(block_dir == 3) state = st.bow_shoot_left;
			//show_debug_message("move: " + block_dir);
		}
		
		//if(keyboard_check_released(vk_shift) or gamepad_button_check_released(global.gp, gp_shoulderr) or stamina <= 0){
			//state_set(st.idle);
			//target = -1;
			//audio_play_sound(sndBlock, 1, false);
		//}
		
		
		//attack = (keyboard_check_pressed(vk_space) or gamepad_button_check_pressed(global.gp, gp_face1)) and stamina >= meleeCost;
		moveDir = (aimDir+22.5) div 45 < 8 ? (aimDir+22.5) div 45 : 0;
		//show_debug_message("aim: " + moveDir);
		
		
		//collision
		if(collision(moveX, 0)){
			
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		//enemy collision
		with(hitbox){
			var enemyHit = instance_place(x, y, oSkeleton_melee_hit);
		
			if(enemyHit and other.hit_cooldown == 0){
				var enemy = enemyHit.owner;
				
				var dir = point_direction(enemy.x, enemy.y, other.x, other.y);
				other.boostX = lengthdir_x(2, dir);
				other.boostY = lengthdir_y(2, dir);
			
				//audio_play_sound(choose(shield_hit, shield_hit2), 1, false);
			
				other.hit_cooldown = 30;
			} 
		}
		
		
		moveX *= 0.9;
		moveY *= 0.9;
		
		if((moveX != 0 or moveY != 0) and (round(image_index) == 1 or round(image_index) == 9) and !stepPlaying()){
			audio_play_sound(choose(step_1, step_2, step_3, step_4), 1, false);
		}
		
		x += moveX;
		y += moveY;
		
		
		
		
	break;
	
	case st.bow_to_melee_idle: case st.bow_to_melee_walk:
		//input for sword n board
		var inputX, inputY, run;
		inputX = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		inputY = keyboard_check(ord("S")) - keyboard_check(ord("W")); 
		
		dir = point_direction(0, 0, inputX, inputY);
		moveX = lengthdir_x(moveSpeed, dir) + round(boostX);
		moveY = lengthdir_y(moveSpeed, dir) + round(boostY);
		
		//gamepad input
		if(gamepad_is_connected(global.gp)){
			inputX = gamepad_axis_value(global.gp, gp_axislh);
			if(abs(inputX) < 0.2) inputX = 0;
			
			inputY = gamepad_axis_value(global.gp, gp_axislv);
			if(abs(inputY) < 0.2) inputY = 0;
			
			dir = point_direction(0, 0, inputX, inputY);
			moveX = inputX * moveSpeed + round(boostX);
			moveY = inputY * moveSpeed + round(boostY);
		}
		
		image_speed = 2;
		
		//state
		if(abs(inputX)+abs(inputY) == 0){
			state = st.bow_to_melee_idle;
			moveSpeed = 0;
		} else {
			state = st.bow_to_melee_walk;
			moveSpeed = walkSpeed/2;
			//speed up sprite when running
			//image_speed = moveSpeed*1.5;
		}

		//calculate move
		
		
		//collision
		if(collision(moveX, 0)){
			
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		//move player
		x += moveX;
		y += moveY;
		
		if((moveX != 0 or moveY != 0) and (round(image_index) == 4 or round(image_index) == 11) and !stepPlaying()){
			audio_play_sound(choose(step_1, step_2, step_3, step_4), 1, false);
		}
		
		if(round(image_index) == 2 and !audio_is_playing(equip_bow)) audio_play_sound(equip_bow, 1, false);
		if(round(image_index) == 5 and !audio_is_playing(equip_sword)) audio_play_sound(equip_sword, 1, false);
		
		//direction
		if(state == st.bow_to_melee_walk){
			moveDir = (dir+22.5) div 45 < 8 ? (dir+22.5) div 45 : 0;
		}
		
		//enemy collision
		with(hitbox){
			var enemyHit = instance_place(x, y, oSkeleton_melee_hit);
		
			if(enemyHit and other.hit_cooldown == 0){
				var enemy = enemyHit.owner;
				
				var dir = point_direction(enemy.x, enemy.y, other.x, other.y);
				other.boostX = lengthdir_x(4, dir);
				other.boostY = lengthdir_y(4, dir);
			
				other.hp -= enemy.attack;
				audio_play_sound(skeleton_hit, 1, false);
			
				other.hit_cooldown = 30;
			} 
		}
		
		if(stamina < 100 and staminaRefill <= 0) {
			stamina++;
		}
		
		if(staminaRefill > 0) staminaRefill--;
		
		//mask
		mask_index = sPlayer_Mask;
	break;
		
}

var door = instance_place(x, y, oDoor);
if(door and door.touched){
	y--;
	state = st.move;
	moveDir = 1;
}

sprite_index = sprites[state, moveDir];

//boost
boostX = lerp(boostX, 0, 0.1);
boostY = lerp(boostY, 0, 0.1);

//death
if(hp <= 0 and state != st.dead){
	state_set(st.dead);
}

//hit cooldown
if(hit_cooldown > 0){
	hit_cooldown--;
	
	image_alpha -= 0.1;
	if(image_alpha <= 0) image_alpha = 1;
} else {
	image_alpha = 1;
}
