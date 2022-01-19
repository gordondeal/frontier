function item_pos(type){
	//returns position of item in inv (as collected)
	for(var i = 0; i < ds_list_size(global.inv); i++){
		var arr = global.inv[| i];
		
		if(arr[0] == type){
			return i;
		}
	}
	
	return -1;
}