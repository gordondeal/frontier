//properties
walkSpeed = 0.5;
range = 150;
attack = 20;
hitbox = instance_create_layer(x, y, "Instances", oSkeleton_hitbox);
hitbox.owner = id;
hit = -1;
dir = 0;


//variables
moveX = 0;
moveY = 0;
moveDir = 0;
boostX = 0;
boostY = 0;
moveSpeed = 1;
hp = 3;
hit_cooldown = 0;


state = st.idle;
	
//sprites
sprites[st.idle, 0] = sSkeleton_idle_right_strip28;
sprites[st.idle, 1] = sSkeleton_idle_upright_strip28;
sprites[st.idle, 2] = sSkeleton_idle_up_strip28;
sprites[st.idle, 3] = sSkeleton_idle_upleft_strip28;
sprites[st.idle, 4] = sSkeleton_idle_left_strip28;
sprites[st.idle, 5] = sSkeleton_idle_downleft_strip28;
sprites[st.idle, 6] = sSkeleton_idle_down_strip28;
sprites[st.idle, 7] = sSkeleton_idle_downright_strip28;

sprites[st.move, 0] = sSkeleton_walk_right_strip20;
sprites[st.move, 1] = sSkeleton_walk_upright_strip20;
sprites[st.move, 2] = sSkeleton_walk_up_strip20;
sprites[st.move, 3] = sSkeleton_walk_upleft_strip20;
sprites[st.move, 4] = sSkeleton_walk_left_strip20;
sprites[st.move, 5] = sSkeleton_walk_downleft_strip20;
sprites[st.move, 6] = sSkeleton_walk_down_strip20;
sprites[st.move, 7] = sSkeleton_walk_downright_strip20;

sprites[st.attack, 0] = sSkeleton_attack_right_strip39;
sprites[st.attack, 1] = sSkeleton_attack_upright_strip39;
sprites[st.attack, 2] = sSkeleton_attack_up_strip39;
sprites[st.attack, 3] = sSkeleton_attack_upleft_strip39;
sprites[st.attack, 4] = sSkeleton_attack_left_strip39;
sprites[st.attack, 5] = sSkeleton_attack_downleft_strip39;
sprites[st.attack, 6] = sSkeleton_attack_down_strip39;
sprites[st.attack, 7] = sSkeleton_attack_downright_strip39;

sprites[st.dead, 0] = sSkeleton_death_right_strip19;
sprites[st.dead, 1] = sSkeleton_death_upright_strip19;
sprites[st.dead, 2] = sSkeleton_death_up_strip19;
sprites[st.dead, 3] = sSkeleton_death_upleft_strip19;
sprites[st.dead, 4] = sSkeleton_death_left_strip19;
sprites[st.dead, 5] = sSkeleton_death_downleft_strip19;
sprites[st.dead, 6] = sSkeleton_death_down_strip19;
sprites[st.dead, 7] = sSkeleton_death_downright_strip19;

mask = sPlayer_Mask;