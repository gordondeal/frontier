function collision(xAdd, yAdd){
	var objCol = place_meeting(x + xAdd, y + yAdd, oCollision);
	
	var tileCol = tilemap_get_at_pixel(global.Tiles_Walls, x-4+xAdd, y+5+yAdd) or
				  tilemap_get_at_pixel(global.Tiles_Walls, x+3+xAdd, y+5+yAdd) or
				  tilemap_get_at_pixel(global.Tiles_Walls, x-4+xAdd, y+10+yAdd) or
				  tilemap_get_at_pixel(global.Tiles_Walls, x+3+xAdd, y+10+yAdd);
	//var tileCol = tilemap_get_at_pixel(global.Tiles_Walls, bbox_left+xAdd, bbox_top+yAdd) or
	//			  tilemap_get_at_pixel(global.Tiles_Walls, bbox_right+xAdd, bbox_top+yAdd) or
	//			  tilemap_get_at_pixel(global.Tiles_Walls, bbox_left+xAdd, bbox_bottom+yAdd) or
	//			  tilemap_get_at_pixel(global.Tiles_Walls, bbox_right+xAdd, bbox_bottom+yAdd);
	
	var outOfBounds = x + xAdd < 0 or x + xAdd > room_width or y + yAdd < 0 or y + yAdd > room_height;
	
	return objCol or tileCol or outOfBounds;
}
	