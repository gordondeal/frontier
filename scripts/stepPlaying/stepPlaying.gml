// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function stepPlaying(){
	return audio_is_playing(step_1) or audio_is_playing(step_2) or audio_is_playing(step_3) or audio_is_playing(step_4);
}