if(global.time > 20 and state == "open"){
	image_speed = -1;
	state = "closing";
} else if(global.time < 7 and global.time > 6 and state == "closed"){
	image_index = 0;
	image_speed = 1;
	state = "opening";
}
	
	
	
