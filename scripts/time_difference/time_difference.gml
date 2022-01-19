
function time_difference(a, b, limit){
	//difference 1
	var diff1 = abs(a - b);
	
	//difference 2
	if(a > b) a -= limit;
	else if(a < b) a += limit;
	var diff2 = abs(a - b);
	
	return min(diff1, diff2);
}