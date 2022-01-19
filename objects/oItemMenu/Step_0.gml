var itemKey = -1;
if(keyboard_check_pressed(ord("1"))){
	itemKey = 0;
} else if(keyboard_check_pressed(ord("2"))){
	itemKey = 1;
} else if(keyboard_check_pressed(ord("3"))){
	itemKey = 2;
} else if(keyboard_check_pressed(ord("4"))){
	itemKey = 3;
}


if(itemKey > -1 and !is_undefined(global.inv[| itemKey])){
	var arr = global.inv[| itemKey];
	var item = arr[0];
	
	switch(item){
		case item.apple:
			oPlayer.hp += 50;
		break;
		case item.mushroom:
			oPlayer.stamina += 50;
		break;
	}
	
	arr[@1]--;
	
	if(arr[1] <= 0){
		ds_list_delete(global.inv, itemKey);
	}
}