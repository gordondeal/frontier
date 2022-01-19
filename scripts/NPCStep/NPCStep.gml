function NPCStep(){
	
	depth = -bbox_bottom;

	//calculate move
	if(irandom(40) == 0){
		dir = random(360);
		var spd = choose(moveSpeed, 0);
		moveX = lengthdir_x(spd, dir);
		moveY = lengthdir_y(spd, dir);
	}
			
	var dist = point_distance(xstart, ystart, x + moveX, y + moveY);
	if(place_meeting(x + moveX, y + moveY, oPlayer) or dist > maxDist or talking){
		moveX = 0;
		moveY = 0;
	}
		
	//collision
	if(collision(moveX, 0)){
		x = sign(moveX) > 0 ? floor(x) : ceil(x);
		while(!collision(sign(moveX), 0)){
			x += sign(moveX);
		}
		moveX = 0;
	}
		
	if(collision(0, moveY)){
		y = sign(moveY) > 0 ? floor(y) : ceil(y);
		while(!collision(0, sign(moveY))){
			y += sign(moveY);
		}
		moveY = 0;
	}
		
	//move npc
			
	x += moveX;
	y += moveY;
			
		
	//state
	if(abs(moveX)+abs(moveY) == 0){
		state = st.idle;
	} else {
		state = st.move;
	}
		
	//direction
	if(state == st.move) moveDir = dir div 45;
		
	//mask
	mask_index = sPlayer_Mask;
	
	//dialogue
	if(distance_to_object(oPlayer) < 30){
		talking = true;
		
		//face player
		moveDir = point_direction(x, y, oPlayer.x, oPlayer.y) div 45;
		
		//dialogue vars
		var strSize = string_length(message[line]);
		var totalMessages = array_length_1d(message);
		
		//increase char
		if(char < strSize){
			char++;
		} else if((keyboard_check_pressed(vk_enter) or gamepad_button_check_pressed(global.gp, gp_face4)) and line != totalMessages - 1){
			line++;
			char = 0;
		}
	} else {
		line = 0;
		char = 0;
		talking = false;
	}
		
		
	

	sprite_index = sprites[state, moveDir];
}