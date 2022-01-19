//remove save state when game ends
if(file_exists("temp.ini")){
	file_delete("temp.ini");
}

audio_stop_all();