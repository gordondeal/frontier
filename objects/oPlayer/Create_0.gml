//properties
walkSpeed = 0.75;
attack = false;
equipBow = false;
bowState = -1;
arrowSpeed = 5;

playerSurf = -1;

//variables
moveX = 0;
moveY = 0;
dir = 0;
moveDir = 0; //for sprites
aimDir = 0;
rollDir = 0;
boostX = 0;
boostY = 0;
moveSpeed = 0;
hit_cooldown = 0;
hitbox = instance_create_layer(x, y, "Instances", oPlayer_hitbox);
hitbox.owner = id;
target = -1;

//states
enum st{
	
	idle, 
	move,
	dead,
	
	//attack
	attack, 
	attack2, 
	
	//block
	block_idle,
	block_forward,
	block_backward,
	block_right,
	block_left,
	roll,
	
	//swap gear
	melee_to_bow_idle,
	melee_to_bow_walk,
	bow_to_melee_idle,
	bow_to_melee_walk,
	
	//bow
	bow_idle,
	bow_run,
	
	bow_draw_idle,
	bow_draw_forward,
	bow_draw_backward,
	bow_draw_left,
	bow_draw_right,
	
	bow_aim_idle,
	bow_aim_forward,
	bow_aim_backward,
	bow_aim_left,
	bow_aim_right,
	
	bow_shoot_idle,
	bow_shoot_forward,
	bow_shoot_backward,
	bow_shoot_left,
	bow_shoot_right
}

state = st.idle;

//stats
hp = 100;
stamina = 100;
meleeCost = 30;
staminaRefill = 0;
	
//sprites
sprites[st.idle, 0] = sPlayer_idle_right_strip13;
sprites[st.idle, 1] = sPlayer_idle_upright_strip13;
sprites[st.idle, 2] = sPlayer_idle_up_strip13;
sprites[st.idle, 3] = sPlayer_idle_upleft_strip13;
sprites[st.idle, 4] = sPlayer_idle_left_strip13;
sprites[st.idle, 5] = sPlayer_idle_downleft_strip13;
sprites[st.idle, 6] = sPlayer_idle_down_strip13;
sprites[st.idle, 7] = sPlayer_idle_downright_strip13;

sprites[st.move, 0] = sPlayer_run_right_strip11;
sprites[st.move, 1] = sPlayer_run_upright_strip11;
sprites[st.move, 2] = sPlayer_run_up_strip11;
sprites[st.move, 3] = sPlayer_run_upleft_strip11;
sprites[st.move, 4] = sPlayer_run_left_strip11;
sprites[st.move, 5] = sPlayer_run_downleft_strip11;
sprites[st.move, 6] = sPlayer_run_down_strip11;
sprites[st.move, 7] = sPlayer_run_downright_strip11;

sprites[st.attack, 0] = sPlayer_attack_right_strip11;
sprites[st.attack, 1] = sPlayer_attack_upright_strip11;
sprites[st.attack, 2] = sPlayer_attack_up_strip11;
sprites[st.attack, 3] = sPlayer_attack_upleft_strip11;
sprites[st.attack, 4] = sPlayer_attack_left_strip11;
sprites[st.attack, 5] = sPlayer_attack_downleft_strip11;
sprites[st.attack, 6] = sPlayer_attack_down_strip11;
sprites[st.attack, 7] = sPlayer_attack_downright_strip11;

sprites[st.attack2, 0] = sPlayer_Attack2_right_strip11;
sprites[st.attack2, 1] = sPlayer_Attack2_upright_strip11;
sprites[st.attack2, 2] = sPlayer_Attack2_up_strip11;
sprites[st.attack2, 3] = sPlayer_Attack2_upleft_strip11;
sprites[st.attack2, 4] = sPlayer_Attack2_left_strip11;
sprites[st.attack2, 5] = sPlayer_Attack2_downleft_strip11;
sprites[st.attack2, 6] = sPlayer_Attack2_down_strip11;
sprites[st.attack2, 7] = sPlayer_Attack2_downright_strip11;

sprites[st.block_forward, 0] = sPlayer_block_forward_right_strip16;
sprites[st.block_forward, 1] = sPlayer_block_forward_upright_strip16;
sprites[st.block_forward, 2] = sPlayer_block_forward_up_strip16;
sprites[st.block_forward, 3] = sPlayer_block_forward_upleft_strip16;
sprites[st.block_forward, 4] = sPlayer_block_forward_left_strip16;
sprites[st.block_forward, 5] = sPlayer_block_forward_downleft_strip16;
sprites[st.block_forward, 6] = sPlayer_block_forward_down_strip16;
sprites[st.block_forward, 7] = sPlayer_block_forward_downright_strip16;

sprites[st.block_backward, 0] = sPlayer_block_backward_right_strip19;
sprites[st.block_backward, 1] = sPlayer_block_backward_upright_strip19;
sprites[st.block_backward, 2] = sPlayer_block_backward_up_strip19;
sprites[st.block_backward, 3] = sPlayer_block_backward_upleft_strip19;
sprites[st.block_backward, 4] = sPlayer_block_backward_left_strip19;
sprites[st.block_backward, 5] = sPlayer_block_backward_downleft_strip19;
sprites[st.block_backward, 6] = sPlayer_block_backward_down_strip19;
sprites[st.block_backward, 7] = sPlayer_block_backward_downright_strip19;

sprites[st.block_right, 0] = sPlayer_block_right_right_strip17;
sprites[st.block_right, 1] = sPlayer_block_right_upright_strip17;
sprites[st.block_right, 2] = sPlayer_block_right_up_strip17;
sprites[st.block_right, 3] = sPlayer_block_right_upleft_strip17;
sprites[st.block_right, 4] = sPlayer_block_right_left_strip17;
sprites[st.block_right, 5] = sPlayer_block_right_downleft_strip17;
sprites[st.block_right, 6] = sPlayer_block_right_down_strip17;
sprites[st.block_right, 7] = sPlayer_block_right_downright_strip17;

sprites[st.block_left, 0] = sPlayer_block_left_right_strip20;
sprites[st.block_left, 1] = sPlayer_block_left_upright_strip20;
sprites[st.block_left, 2] = sPlayer_block_left_up_strip20;
sprites[st.block_left, 3] = sPlayer_block_left_upleft_strip20;
sprites[st.block_left, 4] = sPlayer_block_left_left_strip20;
sprites[st.block_left, 5] = sPlayer_block_left_downleft_strip20;
sprites[st.block_left, 6] = sPlayer_block_left_down_strip20;
sprites[st.block_left, 7] = sPlayer_block_left_downright_strip20;

sprites[st.block_idle, 0] = sPlayer_block_idle_right_strip22;
sprites[st.block_idle, 1] = sPlayer_block_idle_upright_strip22;
sprites[st.block_idle, 2] = sPlayer_block_idle_up_strip22;
sprites[st.block_idle, 3] = sPlayer_block_idle_upleft_strip22;
sprites[st.block_idle, 4] = sPlayer_block_idle_left_strip22;
sprites[st.block_idle, 5] = sPlayer_block_idle_downleft_strip22;
sprites[st.block_idle, 6] = sPlayer_block_idle_down_strip22;
sprites[st.block_idle, 7] = sPlayer_block_idle_downright_strip22;

sprites[st.roll, 0] = sPlayer_roll_right_strip15;
sprites[st.roll, 1] = sPlayer_roll_upright_strip15;
sprites[st.roll, 2] = sPlayer_roll_up_strip15;
sprites[st.roll, 3] = sPlayer_roll_upleft_strip15;
sprites[st.roll, 4] = sPlayer_roll_left_strip15;
sprites[st.roll, 5] = sPlayer_roll_downleft_strip15;
sprites[st.roll, 6] = sPlayer_roll_down_strip15;
sprites[st.roll, 7] = sPlayer_roll_downright_strip15;

sprites[st.melee_to_bow_idle, 0] = sPlayer_melee_to_bow_idle_right_strip15;
sprites[st.melee_to_bow_idle, 1] = sPlayer_melee_to_bow_idle_upright_strip15;
sprites[st.melee_to_bow_idle, 2] = sPlayer_melee_to_bow_idle_up_strip15;
sprites[st.melee_to_bow_idle, 3] = sPlayer_melee_to_bow_idle_upleft_strip15;
sprites[st.melee_to_bow_idle, 4] = sPlayer_melee_to_bow_idle_left_strip15;
sprites[st.melee_to_bow_idle, 5] = sPlayer_melee_to_bow_idle_downleft_strip15;
sprites[st.melee_to_bow_idle, 6] = sPlayer_melee_to_bow_idle_down_strip15;
sprites[st.melee_to_bow_idle, 7] = sPlayer_melee_to_bow_idle_downright_strip15;

sprites[st.melee_to_bow_walk, 0] = sPlayer_melee_to_bow_walk_right_strip15;
sprites[st.melee_to_bow_walk, 1] = sPlayer_melee_to_bow_walk_upright_strip15;
sprites[st.melee_to_bow_walk, 2] = sPlayer_melee_to_bow_walk_up_strip15;
sprites[st.melee_to_bow_walk, 3] = sPlayer_melee_to_bow_walk_upleft_strip15;
sprites[st.melee_to_bow_walk, 4] = sPlayer_melee_to_bow_walk_left_strip15;
sprites[st.melee_to_bow_walk, 5] = sPlayer_melee_to_bow_walk_downleft_strip15;
sprites[st.melee_to_bow_walk, 6] = sPlayer_melee_to_bow_walk_down_strip15;
sprites[st.melee_to_bow_walk, 7] = sPlayer_melee_to_bow_walk_downright_strip15;

sprites[st.bow_to_melee_idle, 0] = sPlayer_bow_to_melee_idle_right_strip15;
sprites[st.bow_to_melee_idle, 1] = sPlayer_bow_to_melee_idle_upright_strip15;
sprites[st.bow_to_melee_idle, 2] = sPlayer_bow_to_melee_idle_up_strip15;
sprites[st.bow_to_melee_idle, 3] = sPlayer_bow_to_melee_idle_upleft_strip15;
sprites[st.bow_to_melee_idle, 4] = sPlayer_bow_to_melee_idle_left_strip15;
sprites[st.bow_to_melee_idle, 5] = sPlayer_bow_to_melee_idle_downleft_strip15;
sprites[st.bow_to_melee_idle, 6] = sPlayer_bow_to_melee_idle_down_strip15;
sprites[st.bow_to_melee_idle, 7] = sPlayer_bow_to_melee_idle_downright_strip15;

sprites[st.bow_to_melee_walk, 0] = sPlayer_bow_to_melee_walk_right_strip15;
sprites[st.bow_to_melee_walk, 1] = sPlayer_bow_to_melee_walk_upright_strip15;
sprites[st.bow_to_melee_walk, 2] = sPlayer_bow_to_melee_walk_up_strip15;
sprites[st.bow_to_melee_walk, 3] = sPlayer_bow_to_melee_walk_upleft_strip15;
sprites[st.bow_to_melee_walk, 4] = sPlayer_bow_to_melee_walk_left_strip15;
sprites[st.bow_to_melee_walk, 5] = sPlayer_bow_to_melee_walk_downleft_strip15;
sprites[st.bow_to_melee_walk, 6] = sPlayer_bow_to_melee_walk_down_strip15;
sprites[st.bow_to_melee_walk, 7] = sPlayer_bow_to_melee_walk_downright_strip15;

sprites[st.bow_idle, 0] = sPlayer_bow_idle_right_strip15;
sprites[st.bow_idle, 1] = sPlayer_bow_idle_upright_strip15;
sprites[st.bow_idle, 2] = sPlayer_bow_idle_up_strip15;
sprites[st.bow_idle, 3] = sPlayer_bow_idle_upleft_strip15;
sprites[st.bow_idle, 4] = sPlayer_bow_idle_left_strip15;
sprites[st.bow_idle, 5] = sPlayer_bow_idle_downleft_strip15;
sprites[st.bow_idle, 6] = sPlayer_bow_idle_down_strip15;
sprites[st.bow_idle, 7] = sPlayer_bow_idle_downright_strip15;

sprites[st.bow_run, 0] = sPlayer_bow_run_right_strip13;
sprites[st.bow_run, 1] = sPlayer_bow_run_upright_strip13;
sprites[st.bow_run, 2] = sPlayer_bow_run_up_strip13;
sprites[st.bow_run, 3] = sPlayer_bow_run_upleft_strip13;
sprites[st.bow_run, 4] = sPlayer_bow_run_left_strip13;
sprites[st.bow_run, 5] = sPlayer_bow_run_downleft_strip13;
sprites[st.bow_run, 6] = sPlayer_bow_run_down_strip13;
sprites[st.bow_run, 7] = sPlayer_bow_run_downright_strip13;

sprites[st.bow_draw_idle, 0] = sPlayer_bow_draw_idle_right_strip15;
sprites[st.bow_draw_idle, 1] = sPlayer_bow_draw_idle_upright_strip15;
sprites[st.bow_draw_idle, 2] = sPlayer_bow_draw_idle_up_strip15;
sprites[st.bow_draw_idle, 3] = sPlayer_bow_draw_idle_upleft_strip15;
sprites[st.bow_draw_idle, 4] = sPlayer_bow_draw_idle_left_strip15;
sprites[st.bow_draw_idle, 5] = sPlayer_bow_draw_idle_downleft_strip15;
sprites[st.bow_draw_idle, 6] = sPlayer_bow_draw_idle_down_strip15;
sprites[st.bow_draw_idle, 7] = sPlayer_bow_draw_idle_downright_strip15;

sprites[st.bow_draw_forward, 0] = sPlayer_bow_draw_forward_right_strip15;
sprites[st.bow_draw_forward, 1] = sPlayer_bow_draw_forward_upright_strip15;
sprites[st.bow_draw_forward, 2] = sPlayer_bow_draw_forward_up_strip15;
sprites[st.bow_draw_forward, 3] = sPlayer_bow_draw_forward_upleft_strip15;
sprites[st.bow_draw_forward, 4] = sPlayer_bow_draw_forward_left_strip15;
sprites[st.bow_draw_forward, 5] = sPlayer_bow_draw_forward_downleft_strip15;
sprites[st.bow_draw_forward, 6] = sPlayer_bow_draw_forward_down_strip15;
sprites[st.bow_draw_forward, 7] = sPlayer_bow_draw_forward_downright_strip15;

sprites[st.bow_draw_backward, 0] = sPlayer_bow_draw_backward_right_strip15;
sprites[st.bow_draw_backward, 1] = sPlayer_bow_draw_backward_upright_strip15;
sprites[st.bow_draw_backward, 2] = sPlayer_bow_draw_backward_up_strip15;
sprites[st.bow_draw_backward, 3] = sPlayer_bow_draw_backward_upleft_strip15;
sprites[st.bow_draw_backward, 4] = sPlayer_bow_draw_backward_left_strip15;
sprites[st.bow_draw_backward, 5] = sPlayer_bow_draw_backward_downleft_strip15;
sprites[st.bow_draw_backward, 6] = sPlayer_bow_draw_backward_down_strip15;
sprites[st.bow_draw_backward, 7] = sPlayer_bow_draw_backward_downright_strip15;

sprites[st.bow_draw_left, 0] = sPlayer_bow_draw_left_right_strip15;
sprites[st.bow_draw_left, 1] = sPlayer_bow_draw_left_upright_strip15;
sprites[st.bow_draw_left, 2] = sPlayer_bow_draw_left_up_strip15;
sprites[st.bow_draw_left, 3] = sPlayer_bow_draw_left_upleft_strip15;
sprites[st.bow_draw_left, 4] = sPlayer_bow_draw_left_left_strip15;
sprites[st.bow_draw_left, 5] = sPlayer_bow_draw_left_downleft_strip15;
sprites[st.bow_draw_left, 6] = sPlayer_bow_draw_left_down_strip15;
sprites[st.bow_draw_left, 7] = sPlayer_bow_draw_left_downright_strip15;

sprites[st.bow_draw_right, 0] = sPlayer_bow_draw_right_right_strip15;
sprites[st.bow_draw_right, 1] = sPlayer_bow_draw_right_upright_strip15;
sprites[st.bow_draw_right, 2] = sPlayer_bow_draw_right_up_strip15;
sprites[st.bow_draw_right, 3] = sPlayer_bow_draw_right_upleft_strip15;
sprites[st.bow_draw_right, 4] = sPlayer_bow_draw_right_left_strip15;
sprites[st.bow_draw_right, 5] = sPlayer_bow_draw_right_downleft_strip15;
sprites[st.bow_draw_right, 6] = sPlayer_bow_draw_right_down_strip15;
sprites[st.bow_draw_right, 7] = sPlayer_bow_draw_right_downright_strip15;

sprites[st.bow_aim_idle, 0] = sPlayer_bow_aim_idle_right_strip15;
sprites[st.bow_aim_idle, 1] = sPlayer_bow_aim_idle_upright_strip15;
sprites[st.bow_aim_idle, 2] = sPlayer_bow_aim_idle_up_strip15;
sprites[st.bow_aim_idle, 3] = sPlayer_bow_aim_idle_upleft_strip15;
sprites[st.bow_aim_idle, 4] = sPlayer_bow_aim_idle_left_strip15;
sprites[st.bow_aim_idle, 5] = sPlayer_bow_aim_idle_downleft_strip15;
sprites[st.bow_aim_idle, 6] = sPlayer_bow_aim_idle_down_strip15;
sprites[st.bow_aim_idle, 7] = sPlayer_bow_aim_idle_downright_strip15;

sprites[st.bow_aim_forward, 0] = sPlayer_bow_aim_forward_right_strip15;
sprites[st.bow_aim_forward, 1] = sPlayer_bow_aim_forward_upright_strip15;
sprites[st.bow_aim_forward, 2] = sPlayer_bow_aim_forward_up_strip15;
sprites[st.bow_aim_forward, 3] = sPlayer_bow_aim_forward_upleft_strip15;
sprites[st.bow_aim_forward, 4] = sPlayer_bow_aim_forward_left_strip15;
sprites[st.bow_aim_forward, 5] = sPlayer_bow_aim_forward_downleft_strip15;
sprites[st.bow_aim_forward, 6] = sPlayer_bow_aim_forward_down_strip15;
sprites[st.bow_aim_forward, 7] = sPlayer_bow_aim_forward_downright_strip15;

sprites[st.bow_aim_backward, 0] = sPlayer_bow_aim_backward_right_strip15;
sprites[st.bow_aim_backward, 1] = sPlayer_bow_aim_backward_upright_strip15;
sprites[st.bow_aim_backward, 2] = sPlayer_bow_aim_backward_up_strip15;
sprites[st.bow_aim_backward, 3] = sPlayer_bow_aim_backward_upleft_strip15;
sprites[st.bow_aim_backward, 4] = sPlayer_bow_aim_backward_left_strip15;
sprites[st.bow_aim_backward, 5] = sPlayer_bow_aim_backward_downleft_strip15;
sprites[st.bow_aim_backward, 6] = sPlayer_bow_aim_backward_down_strip15;
sprites[st.bow_aim_backward, 7] = sPlayer_bow_aim_backward_downright_strip15;

sprites[st.bow_aim_left, 0] = sPlayer_bow_aim_left_right_strip15;
sprites[st.bow_aim_left, 1] = sPlayer_bow_aim_left_upright_strip15;
sprites[st.bow_aim_left, 2] = sPlayer_bow_aim_left_up_strip15;
sprites[st.bow_aim_left, 3] = sPlayer_bow_aim_left_upleft_strip15;
sprites[st.bow_aim_left, 4] = sPlayer_bow_aim_left_left_strip15;
sprites[st.bow_aim_left, 5] = sPlayer_bow_aim_left_downleft_strip15;
sprites[st.bow_aim_left, 6] = sPlayer_bow_aim_left_down_strip15;
sprites[st.bow_aim_left, 7] = sPlayer_bow_aim_left_downright_strip15;

sprites[st.bow_aim_right, 0] = sPlayer_bow_aim_right_right_strip15;
sprites[st.bow_aim_right, 1] = sPlayer_bow_aim_right_upright_strip15;
sprites[st.bow_aim_right, 2] = sPlayer_bow_aim_right_up_strip15;
sprites[st.bow_aim_right, 3] = sPlayer_bow_aim_right_upleft_strip15;
sprites[st.bow_aim_right, 4] = sPlayer_bow_aim_right_left_strip15;
sprites[st.bow_aim_right, 5] = sPlayer_bow_aim_right_downleft_strip15;
sprites[st.bow_aim_right, 6] = sPlayer_bow_aim_right_down_strip15;
sprites[st.bow_aim_right, 7] = sPlayer_bow_aim_right_downright_strip15;

sprites[st.bow_shoot_idle, 0] = sPlayer_bow_shoot_idle_right_strip15;
sprites[st.bow_shoot_idle, 1] = sPlayer_bow_shoot_idle_upright_strip15;
sprites[st.bow_shoot_idle, 2] = sPlayer_bow_shoot_idle_up_strip15;
sprites[st.bow_shoot_idle, 3] = sPlayer_bow_shoot_idle_upleft_strip15;
sprites[st.bow_shoot_idle, 4] = sPlayer_bow_shoot_idle_left_strip15;
sprites[st.bow_shoot_idle, 5] = sPlayer_bow_shoot_idle_downleft_strip15;
sprites[st.bow_shoot_idle, 6] = sPlayer_bow_shoot_idle_down_strip15;
sprites[st.bow_shoot_idle, 7] = sPlayer_bow_shoot_idle_downright_strip15;

sprites[st.bow_shoot_forward, 0] = sPlayer_bow_shoot_forward_right_strip15;
sprites[st.bow_shoot_forward, 1] = sPlayer_bow_shoot_forward_upright_strip15;
sprites[st.bow_shoot_forward, 2] = sPlayer_bow_shoot_forward_up_strip15;
sprites[st.bow_shoot_forward, 3] = sPlayer_bow_shoot_forward_upleft_strip15;
sprites[st.bow_shoot_forward, 4] = sPlayer_bow_shoot_forward_left_strip15;
sprites[st.bow_shoot_forward, 5] = sPlayer_bow_shoot_forward_downleft_strip15;
sprites[st.bow_shoot_forward, 6] = sPlayer_bow_shoot_forward_down_strip15;
sprites[st.bow_shoot_forward, 7] = sPlayer_bow_shoot_forward_downright_strip15;

sprites[st.bow_shoot_backward, 0] = sPlayer_bow_shoot_backward_right_strip15;
sprites[st.bow_shoot_backward, 1] = sPlayer_bow_shoot_backward_upright_strip15;
sprites[st.bow_shoot_backward, 2] = sPlayer_bow_shoot_backward_up_strip15;
sprites[st.bow_shoot_backward, 3] = sPlayer_bow_shoot_backward_upleft_strip15;
sprites[st.bow_shoot_backward, 4] = sPlayer_bow_shoot_backward_left_strip15;
sprites[st.bow_shoot_backward, 5] = sPlayer_bow_shoot_backward_downleft_strip15;
sprites[st.bow_shoot_backward, 6] = sPlayer_bow_shoot_backward_down_strip15;
sprites[st.bow_shoot_backward, 7] = sPlayer_bow_shoot_backward_downright_strip15;

sprites[st.bow_shoot_left, 0] = sPlayer_bow_shoot_left_right_strip15;
sprites[st.bow_shoot_left, 1] = sPlayer_bow_shoot_left_upright_strip15;
sprites[st.bow_shoot_left, 2] = sPlayer_bow_shoot_left_up_strip15;
sprites[st.bow_shoot_left, 3] = sPlayer_bow_shoot_left_upleft_strip15;
sprites[st.bow_shoot_left, 4] = sPlayer_bow_shoot_left_left_strip15;
sprites[st.bow_shoot_left, 5] = sPlayer_bow_shoot_left_downleft_strip15;
sprites[st.bow_shoot_left, 6] = sPlayer_bow_shoot_left_down_strip15;
sprites[st.bow_shoot_left, 7] = sPlayer_bow_shoot_left_downright_strip15;

sprites[st.bow_shoot_right, 0] = sPlayer_bow_shoot_right_right_strip15;
sprites[st.bow_shoot_right, 1] = sPlayer_bow_shoot_right_upright_strip15;
sprites[st.bow_shoot_right, 2] = sPlayer_bow_shoot_right_up_strip15;
sprites[st.bow_shoot_right, 3] = sPlayer_bow_shoot_right_upleft_strip15;
sprites[st.bow_shoot_right, 4] = sPlayer_bow_shoot_right_left_strip15;
sprites[st.bow_shoot_right, 5] = sPlayer_bow_shoot_right_downleft_strip15;
sprites[st.bow_shoot_right, 6] = sPlayer_bow_shoot_right_down_strip15;
sprites[st.bow_shoot_right, 7] = sPlayer_bow_shoot_right_downright_strip15;

sprites[st.dead, 0] = sPlayer_Dead;
sprites[st.dead, 1] = sPlayer_Dead;
sprites[st.dead, 2] = sPlayer_Dead;
sprites[st.dead, 3] = sPlayer_Dead;
sprites[st.dead, 4] = sPlayer_Dead;
sprites[st.dead, 5] = sPlayer_Dead;
sprites[st.dead, 6] = sPlayer_Dead;
sprites[st.dead, 7] = sPlayer_Dead;

enum bowSt{
	draw,
	aim,
	shoot
}

nearArm[bowSt.draw, 0] = sPlayer_bow_draw_near_arm_right_strip15;
nearArm[bowSt.draw, 1] = sPlayer_bow_draw_near_arm_upright_strip15;
nearArm[bowSt.draw, 2] = sPlayer_bow_draw_near_arm_up_strip15;
nearArm[bowSt.draw, 3] = sPlayer_bow_draw_near_arm_upleft_strip15;
nearArm[bowSt.draw, 4] = sPlayer_bow_draw_near_arm_left_strip15;
nearArm[bowSt.draw, 5] = sPlayer_bow_draw_near_arm_downleft_strip15;
nearArm[bowSt.draw, 6] = sPlayer_bow_draw_near_arm_down_strip15;
nearArm[bowSt.draw, 7] = sPlayer_bow_draw_near_arm_downright_strip15;

farArm[bowSt.draw, 0] = sPlayer_bow_draw_far_arm_right_strip15;
farArm[bowSt.draw, 1] = sPlayer_bow_draw_far_arm_upright_strip15;
farArm[bowSt.draw, 2] = sPlayer_bow_draw_far_arm_up_strip15;
farArm[bowSt.draw, 3] = sPlayer_bow_draw_far_arm_upleft_strip15;
farArm[bowSt.draw, 4] = sPlayer_bow_draw_far_arm_left_strip15;
farArm[bowSt.draw, 5] = sPlayer_bow_draw_far_arm_downleft_strip15;
farArm[bowSt.draw, 6] = sPlayer_bow_draw_far_arm_down_strip15;
farArm[bowSt.draw, 7] = sPlayer_bow_draw_far_arm_downright_strip15;

nearArm[bowSt.aim, 0] = sPlayer_bow_aim_idle_near_arm_right_strip15;
nearArm[bowSt.aim, 1] = sPlayer_bow_aim_idle_near_arm_upright_strip15;
nearArm[bowSt.aim, 2] = sPlayer_bow_aim_idle_near_arm_up_strip15;
nearArm[bowSt.aim, 3] = sPlayer_bow_aim_idle_near_arm_upleft_strip15;
nearArm[bowSt.aim, 4] = sPlayer_bow_aim_idle_near_arm_left_strip15;
nearArm[bowSt.aim, 5] = sPlayer_bow_aim_idle_near_arm_downleft_strip15;
nearArm[bowSt.aim, 6] = sPlayer_bow_aim_idle_near_arm_down_strip15;
nearArm[bowSt.aim, 7] = sPlayer_bow_aim_idle_near_arm_downright_strip15;

farArm[bowSt.aim, 0] = sPlayer_bow_aim_idle_far_arm_right_strip15;
farArm[bowSt.aim, 1] = sPlayer_bow_aim_idle_far_arm_upright_strip15;
farArm[bowSt.aim, 2] = sPlayer_bow_aim_idle_far_arm_up_strip15;
farArm[bowSt.aim, 3] = sPlayer_bow_aim_idle_far_arm_upleft_strip15;
farArm[bowSt.aim, 4] = sPlayer_bow_aim_idle_far_arm_left_strip15;
farArm[bowSt.aim, 5] = sPlayer_bow_aim_idle_far_arm_downleft_strip15;
farArm[bowSt.aim, 6] = sPlayer_bow_aim_idle_far_arm_down_strip15;
farArm[bowSt.aim, 7] = sPlayer_bow_aim_idle_far_arm_downright_strip15;

nearArm[bowSt.shoot, 0] = sPlayer_bow_shoot_near_arm_right_strip15;
nearArm[bowSt.shoot, 1] = sPlayer_bow_shoot_near_arm_upright_strip15;
nearArm[bowSt.shoot, 2] = sPlayer_bow_shoot_near_arm_up_strip15;
nearArm[bowSt.shoot, 3] = sPlayer_bow_shoot_near_arm_upleft_strip15;
nearArm[bowSt.shoot, 4] = sPlayer_bow_shoot_near_arm_left_strip15;
nearArm[bowSt.shoot, 5] = sPlayer_bow_shoot_near_arm_downleft_strip15;
nearArm[bowSt.shoot, 6] = sPlayer_bow_shoot_near_arm_down_strip15;
nearArm[bowSt.shoot, 7] = sPlayer_bow_shoot_near_arm_downright_strip15;

farArm[bowSt.shoot, 0] = sPlayer_bow_shoot_far_arm_right_strip15;
farArm[bowSt.shoot, 1] = sPlayer_bow_shoot_far_arm_upright_strip15;
farArm[bowSt.shoot, 2] = sPlayer_bow_shoot_far_arm_up_strip15;
farArm[bowSt.shoot, 3] = sPlayer_bow_shoot_far_arm_upleft_strip15;
farArm[bowSt.shoot, 4] = sPlayer_bow_shoot_far_arm_left_strip15;
farArm[bowSt.shoot, 5] = sPlayer_bow_shoot_far_arm_downleft_strip15;
farArm[bowSt.shoot, 6] = sPlayer_bow_shoot_far_arm_down_strip15;
farArm[bowSt.shoot, 7] = sPlayer_bow_shoot_far_arm_downright_strip15;