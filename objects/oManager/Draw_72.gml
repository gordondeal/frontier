//lighting surface
if(!surface_exists(lightSurf)){
	lightSurf = surface_create(global.width, global.height);
}

//shadow surface
if(!surface_exists(shadowSurf)){
	shadowSurf = surface_create(global.width, global.height);
}
