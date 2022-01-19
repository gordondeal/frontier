var type = async_load[? "event_type"];
var index = async_load[? "pad_index"];

//gamepad discovered
if(type == "gamepad discovered" and global.gp == -1){
	global.gp = index;
} else if (type == "gamepad lost" and global.gp == index){ //gamepad lost
	global.gp = -1;
}


