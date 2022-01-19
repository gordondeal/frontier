//player collision
var xDist = abs(x - oPlayer.x);

if(!locked and !touched and place_meeting(x, y, oPlayer) and xDist < 3){
	touched = true;
	playerY = oPlayer.y;
	image_speed = 1;
	
	//sound
	audio_play_sound(sndMenu, 1, false);
}