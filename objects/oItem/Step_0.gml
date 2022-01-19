//collect
if(place_meeting(x, y, oPlayer) and !collected){
	collected = true;
	
	//increase count
	var itemPos = item_pos(itemType);
	if(itemPos == -1){
		ds_list_add(global.inv, [itemType, 1]);
	} else {
		var arr = global.inv[| itemPos];
		arr[@1]++;
	}
}

//scale
//image_xscale = lerp(image_xscale, 1, 0.2);
//image_yscale = image_xscale;

if(collected){
	image_alpha -= 0.1;
	y -= 1;
	
	if(image_alpha <= 0) instance_destroy();
}