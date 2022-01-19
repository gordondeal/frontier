//load
if(file_exists("temp.ini")){
	ini_open("temp.ini");
	
	hp = ini_read_real("player", "hp", 100);
	stamina = ini_read_real("player", "stamina", 100);
	var doorID = ini_read_real("house", "doorID", noone);
	
	//move to door
	if(instance_exists(doorID)){
		x = doorID.x;
		y = doorID.y + 20;
	}
	
	ini_close();
	file_delete("temp.ini");
	
	
}