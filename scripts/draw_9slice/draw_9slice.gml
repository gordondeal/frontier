// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_9slice(_x, _y, _w, _h, _sprite, _subimg){
	
	//data
	var cellSize = sprite_get_width(_sprite)/3;
	var mainW = _w - cellSize*2;
	var mainH = _h - cellSize*2;
	var mainScaleW = mainW/cellSize;
	var mainScaleH = mainH/cellSize;
	
	//corners
	draw_sprite_part(_sprite, _subimg, 0, 0, cellSize, cellSize, _x, _y); //top left
	draw_sprite_part(_sprite, _subimg, cellSize*2, 0, cellSize, cellSize, (_x + _w) - cellSize, _y); //top right
    draw_sprite_part(_sprite, _subimg, 0, cellSize*2, cellSize, cellSize, _x, (_y + _h) - cellSize); //bottom left
	draw_sprite_part(_sprite, _subimg, cellSize*2, cellSize*2, cellSize, cellSize, (_x + _w) - cellSize, (_y + _h) - cellSize); //bottom right
 
	///Other
	draw_sprite_part_ext(_sprite, _subimg, cellSize, cellSize, cellSize, cellSize, _x + cellSize, _y + cellSize, mainScaleW, mainScaleH, -1, 1); //center
	draw_sprite_part_ext(_sprite, _subimg, cellSize, 0, cellSize, cellSize, _x + cellSize, _y, mainScaleW, 1, -1, 1); //top
	draw_sprite_part_ext(_sprite, _subimg, cellSize, cellSize*2, cellSize, cellSize, _x + cellSize, (_y + _h) - cellSize, mainScaleW, 1, -1, 1); //bottom
	draw_sprite_part_ext(_sprite, _subimg, 0, cellSize, cellSize, cellSize, _x, _y + cellSize, 1, mainScaleH, -1, 1); //left
	draw_sprite_part_ext(_sprite, _subimg, cellSize*2, cellSize, cellSize, cellSize, (_x + _w) - cellSize, _y + cellSize, 1, mainScaleH, -1, 1); //right

}