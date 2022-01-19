if(touched){
	room_goto(targetRoom);
	oPlayer.y = playerY + 20;
	
	//reset
	touched = false;
	image_speed = 0;
	image_index = 0;
}