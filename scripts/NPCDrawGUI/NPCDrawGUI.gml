// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NPCDrawGUI(){
	//textbox
	if(talking){
		draw_set_font(ftDialogue);
		draw_textbox(message[line], char);
	}
}