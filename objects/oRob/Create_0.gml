//dialogue
message[0] = "Go fuck yourself, asshole.";
message[1] = "Go away.";
message[2] = "Fuck off and die.";
char = 0;
line = 0;
talking = false;


//properties
moveSpeed = 0.5;
maxDist = 64;

//variables
moveX = 0;
moveY = 0;
moveDir = 0;


state = st.idle;
	
//sprites
sprites[st.idle, 0] = sGoblin_idle_right_strip30;
sprites[st.idle, 1] = sGoblin_idle_upright_strip30;
sprites[st.idle, 2] = sGoblin_idle_up_strip30;
sprites[st.idle, 3] = sGoblin_idle_upleft_strip30;
sprites[st.idle, 4] = sGoblin_idle_left_strip30;
sprites[st.idle, 5] = sGoblin_idle_downleft_strip30;
sprites[st.idle, 6] = sGoblin_idle_down_strip30;
sprites[st.idle, 7] = sGoblin_idle_downright_strip30;

sprites[st.move, 0] = sGoblin_walk_right_strip17;
sprites[st.move, 1] = sGoblin_walk_upright_strip17;
sprites[st.move, 2] = sGoblin_walk_up_strip17;
sprites[st.move, 3] = sGoblin_walk_upleft_strip17;
sprites[st.move, 4] = sGoblin_walk_left_strip17;
sprites[st.move, 5] = sGoblin_walk_downleft_strip17;
sprites[st.move, 6] = sGoblin_walk_down_strip17;
sprites[st.move, 7] = sGoblin_walk_downright_strip17;

mask = sRob_Mask;