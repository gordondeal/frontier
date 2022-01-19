if(state == "closing"){
	mask_index = sPortcullis_mask;
	image_index = 0;
	image_speed = 0;
	state = "closed";
}
if(state == "opening"){
	mask_index = sPortcullis_open_mask;
	image_index = 16;
	image_speed = 0;
	state = "open";
}