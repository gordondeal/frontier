 if(global.pause) exit;
 


//get target view position and size. size is halved so the view will focus around its center
var cW = camera_get_view_width(view_camera[0]);
var cH = camera_get_view_height(view_camera[0]);
var cX = camera_get_view_x(view_camera[0]);
var cY = camera_get_view_y(view_camera[0]);



//the interpolation rate
var rate = 0.05;

//interpolate the view position to the new, relative position.
var new_x = lerp(cX, oPlayer.x - cW/2, rate);
var new_y = lerp(cY, oPlayer.y - cH/2, rate);

//room camera collision
//if(new_x < 0){ new_x = 0; }
//if(new_x > room_width - width){ new_x = room_width - width; }
//if(new_y < 0){ new_y = 0; }
//if(new_y > room_height - height){ new_y = room_height - height; }
//clamp
new_x = clamp(new_x, 0, room_width - cW);
new_y = clamp(new_y, 0, room_height - cH);


//for small rooms
if(room_width < cW or room_height < cH){
	new_x = room_width/2 - cW/2;
	new_y = room_height/2 - cH/2;
}

//update the view position
camera_set_view_pos(view_camera[0], new_x, new_y);