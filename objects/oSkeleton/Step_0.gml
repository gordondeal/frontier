switch(state){
	case st.idle: case st.move:

		//input for sword n board
		//var inputX = 0, inputY = 0, run = 0, attack = 0;

		//calculate move
		//var dir = point_direction(0, 0, inputX, inputY);
		//moveX = lengthdir_x(moveSpeed, dir) * (1 + run);
		//moveY = lengthdir_y(moveSpeed, dir) * (1 + run);
		//var dir;
		
		
		
		//follow player
		if(instance_exists(oPlayer) and distance_to_object(oPlayer) < range){
			dir = point_direction(x, y, oPlayer.x, oPlayer.y);
			//moveDir = dir div 45;
			
			moveSpeed = walkSpeed;
			
			//moveX = lengthdir_x(walkSpeed, dir);
			//moveY = lengthdir_y(walkSpeed, dir);
			
			
			
		} else if (irandom(60) == 0){ 	//move randomly
			dir = irandom(359);
			moveSpeed = choose(walkSpeed, 0);
			//dir = irandom(4) * 90; //square movement
			//moveX = lengthdir_x(choose(walkSpeed, 0), dir);
			//moveY = lengthdir_y(choose(walkSpeed, 0), dir);
			//moveDir = dir div 45;
		}
		
		moveX = lengthdir_x(moveSpeed, dir);
		moveY = lengthdir_y(moveSpeed, dir);
		moveDir = dir div 45;
		
		//boost
		moveX += round(boostX);
		moveY += round(boostY);
		
		//enemy collision
		if(place_meeting(x+moveX, y+moveY, oEnemies)){
			moveX = 0;
			moveY = 0;
			//show_debug_message("enemy collision");
		}
		
		
		
		//collision
		if(collision(moveX, 0)){
			//x = sign(moveX) > 0 ? floor(x) : ceil(x);
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			//y = sign(moveY) > 0 ? floor(y) : ceil(y);
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		//move player
		//if(inputX != 0 or inputY != 0){
		
			x += moveX;
			y += moveY;
		//}
		
		//state
		if(moveX != 0 or moveY != 0){
			state = st.move
			//speed up sprite when running
			image_speed = 1;
			
		} else {
			state = st.idle;
		}
		
		//direction
		//if(state == st.move) 
		
		//attack
		//&& oPlayer.state != st.attack
		if(distance_to_object(oPlayer) < 20){
			state_set(st.attack);
			audio_play_sound(skeleton_attack, 1, false);
		}
		
		//knockback
		with(hitbox){
			if((place_meeting(x, y, oPlayer_arrow) or place_meeting(x, y, oPlayer_melee_hit) or place_meeting(x, y, oPlayer_melee_hit2)) and other.hit_cooldown == 0){
				dir = point_direction(oPlayer.x, oPlayer.y, other.x, other.y);
				other.boostX = lengthdir_x(3, dir);
				other.boostY = lengthdir_y(3, dir);
				other.hp--;
				other.hit_cooldown = 30;
				audio_play_sound(sword_hit, 1, false);
				if(other.hp > 0)audio_play_sound(skeleton_yell, 1, false);
				
				show_debug_message("boost: " + string(other.boostX) + ", " + string(other.boostY));
				
				if(place_meeting(x, y, oPlayer_arrow)){
					var arrow = instance_nearest(x, y, oPlayer_arrow);
					instance_destroy(arrow);
				}
				
				
			}
		}
		
		//mask
		mask_index = sPlayer_Mask;
		
	break;
	
	case st.attack:
		//mask_index = sprite_index;
		image_speed = 1.5;
		
		if(round(image_index) == 9 and !hit){
			hit = instance_create_layer(x, y, "Instances", oSkeleton_melee_hit);
			hit.owner = id;
			hit.image_index = moveDir mod 45;
			audio_play_sound(skeleton_swoosh, 1, false);
		} else {
			hit = -1;
		}
		
		//show_debug_message(image_index);
		
		//knockback
		with(hitbox){
			if((place_meeting(x, y, oPlayer_arrow) or place_meeting(x, y, oPlayer_melee_hit) or place_meeting(x, y, oPlayer_melee_hit2)) and other.hit_cooldown == 0){
				dir = point_direction(oPlayer.x, oPlayer.y, other.x, other.y);
				other.boostX = lengthdir_x(3, dir);
				other.boostY = lengthdir_y(3, dir);
				other.hp--;
				other.hit_cooldown = 30;
				other.hit.attacking = false;
				other.state = st.idle;
				other.image_index = 0;
				audio_play_sound(sword_hit, 1, false);
				
				if(place_meeting(x, y, oPlayer_arrow)){
					var arrow = instance_nearest(x, y, oPlayer_arrow);
					instance_destroy(arrow);
				}
				     
				   
				   
			}
		}
		
		//enemy collision
		if(place_meeting(x+moveX, y+moveY, oEnemies)){
			moveX = 0;
			moveY = 0;
			//show_debug_message("enemy collision");
		}
		
		//collision
		if(collision(moveX, 0)){
			//x = sign(moveX) > 0 ? floor(x) : ceil(x);
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			moveX = 0;
		}
		
		if(collision(0, moveY)){
			//y = sign(moveY) > 0 ? floor(y) : ceil(y);
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			moveY = 0;
		}
		
		moveX *= 0.9;
		moveY *= 0.9;
		
		x += moveX;
		y += moveY;
	break;
		
}

sprite_index = sprites[state, moveDir];

//boost
boostX = lerp(boostX, 0, 0.1);
boostY = lerp(boostY, 0, 0.1);

//die
if(hp <= 0 and state != st.dead){
	instance_destroy(hit);
	audio_play_sound(skeleton_death, 1, false);
	var corpse = instance_create_layer(x, y, "Corpses", oSkeleton_corpse);
	corpse.moveDir = moveDir;
	
	instance_destroy(hitbox);
	instance_destroy();
	oPlayer.target = -1;
}

//hit cooldown
if(hit_cooldown > 0){
	hit_cooldown--;
	
	image_alpha -= 0.1;
	if(image_alpha <= 0) image_alpha = 1;
} else {
	image_alpha = 1;
}

