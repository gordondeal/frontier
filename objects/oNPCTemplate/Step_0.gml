switch(state){
	case st.idle: case st.move:

		//input for sword n board
		var inputX = 0, inputY = 0, run = 0, attack = 0;

		//calculate move
		var dir = point_direction(0, 0, inputX, inputY);
		moveX = lengthdir_x(moveSpeed, dir) * (1 + run);
		moveY = lengthdir_y(moveSpeed, dir) * (1 + run);
		
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
		
		//move player
		if(inputX != 0 or inputY != 0){
			x += moveX;
			y += moveY;
		}
		
		//state
		if(abs(inputX)+abs(inputY) == 0){
			state = st.idle;
		} else {
			state = st.move
			//speed up sprite when running
			image_speed = 1 + run/2;
		}
		
		//direction
		if(state == st.move) moveDir = dir div 90;
		
		//attack
		if(attack){
			state_set(st.attack);
		}
		
		//mask
		mask_index = sPlayer_Mask;
		
	break;
	
	case st.attack:
		mask_index = sprite_index;
		image_speed = 1.5;
	break;
		
}

sprite_index = sprites[state, moveDir];

//hit cooldown
if(hit_cooldown > 0){
	hit_cooldown--;
	
	image_alpha -= 0.1;
	if(image_alpha <= 0) image_alpha = 1;
} else {
	image_alpha = 1;
}