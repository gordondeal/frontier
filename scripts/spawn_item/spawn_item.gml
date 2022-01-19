function spawn_item(_x, _y, item){
	//spawn
	var inst = instance_create_layer(_x, _y, "Instances", oItem);
	inst.itemType = item;
	
	//set sprite
	inst.sprite_index = oManager.itemSprite[item];
}