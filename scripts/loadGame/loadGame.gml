function loadGame(){
	var map = global.loadMap;
	
	//check room 
	if(room == map[? "room"]){
		//player
		oPlayer.x = map[? "x"];
		oPlayer.y = map[? "y"];
		oPlayer.hp = map[? "hp"];
		oPlayer.stamina = map[? "stamina"];
		
		//inventory
		ds_list_read(global.inv, map[? "inv"]);
		
		//world info
		global.time = map[? "time"];
		
		//delete map
		ds_map_destroy(map);
	}
}