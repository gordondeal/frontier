var surf = surface_create(rectWidth, rectHeight);

surface_set_target(surf);

//background
draw_clear(backColor);

//items
var border = 2;

for(var i = 0; i < ds_list_size(global.inv); i++){
	var arr = global.inv[| i];
	
	var item = arr[0];
	var count = arr[1];
	
	//cell position
	var xx = i * cellSize;
	
	//rectangle
	draw_set_alpha(0.2);
	draw_rectangle(xx + border, border, xx+ cellSize - border*2, cellSize - border*2, false);
	draw_set_alpha(1);
	
	//item
	draw_sprite(oManager.itemSprite[item], 0, xx + cellSize/2, cellSize/2);
	
	//count
	draw_text(xx, 0, count);
}

//draw surface
surface_reset_target();

draw_surface(surf, x, y);

surface_free(surf);