//properties
moveSpeed = 2;

//variables
moveX = 0;
moveY = 0;
moveDir = 0;
hit_cooldown = 0;


state = st.idle;
	
//sprites
sprites[st.idle, 0] = sPlayer_Idle_Right;
sprites[st.idle, 1] = sPlayer_Idle_Up;
sprites[st.idle, 2] = sPlayer_Idle_Left;
sprites[st.idle, 3] = sPlayer_Idle_Down;

sprites[st.move, 0] = sPlayer_Move_Right;
sprites[st.move, 1] = sPlayer_Move_Up;
sprites[st.move, 2] = sPlayer_Move_Left;
sprites[st.move, 3] = sPlayer_Move_Down;

sprites[st.attack, 0] = sPlayer_Attack_Right;
sprites[st.attack, 1] = sPlayer_Attack_Up;
sprites[st.attack, 2] = sPlayer_Attack_Left;
sprites[st.attack, 3] = sPlayer_Attack_Down;

mask = sPlayer_Mask;