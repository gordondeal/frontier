if(place_meeting(x, y, oPlayer)){
	room_goto(rmWorld);
	oPlayer.y += 20;
	
	//save doorID
	ini_open("temp.ini");
	ini_write_real("house", "doorID", doorID);
	ini_close();
}