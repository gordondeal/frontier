//menu
enum op{ resume, save, quit }

menuText[op.resume] = "Resume";
menuText[op.save] = "Save";
menuText[op.quit] = "Quit";

menuSelected = 0;
menuOptions = array_length(menuText);
menuSelectedPrev = 0;

reset = 1;
lyaxis = 0;
gamepad_set_axis_deadzone(0, 0.25);