//music
//audio_play_sound(sndMusic, 1, true);
gamepad_set_axis_deadzone(0, 0);
//pause
global.pause = false;

//health
hpShow = 100;

//inventory
global.inv = ds_list_create();

//items
enum item{
	coin,
	apple,
	mushroom
}

itemSprite[item.coin] = sCoin;
itemSprite[item.apple] = sApple;
itemSprite[item.mushroom] = sMushroom;

//interface
instance_create_layer(0, 0, "Instances", oItemMenu);

//time
global.time = 9;

//lighting
lightSurf = -1;
eveningTime = 21;
nightTimeA = 0;
nightTimeB = 5;

eveningSpread = 3;
nightSpread = 3;

//shadows
shadowSurf = -1;

noShadow = ds_list_create();
ds_list_add(noShadow, oTree1, oTree2, oTree3, oGrass1, oGrass2, oGrass3, oGrass4, oGrass5, oGrass6, oManager, oWall, oHouseFront, oHouseSide, oDoor, oExit, oItemMenu, oSkeleton_corpse, oPauseMenu, oGamepadController);