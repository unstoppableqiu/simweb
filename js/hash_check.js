function check(pa){
//format check

	if(pa.length==0) return false;

	var in_braket = false;
	var has_a = false;
	var has_A = false;
	var has_s = false;
	var has_d = false;
	for(var idx=0; idx<pa.length; idx++){
		if(in_braket){
			if(pa[idx]==']'){
				in_braket=false;
			}
			else{
				switch (pa[idx]){
					case 'a':
						if(has_a) return false;
						has_a = true;
						break;
					case 'A':
						if(has_A) return false;
						has_A = true;
						break;
					case 'd':
						if(has_d) return false;
						has_d = true;
						break;
					case 's':
						if(has_s) return false;
						has_s = true;
						break;
					default:
						return false;
				}
			}
		}
		else
		{
			if(pa[idx]==']') return false; //unpairred braket
			if(pa[idx]=='['){					
				if(idx==pa.length-1) return false;
				if(pa[idx+1]==']') return false;
				has_a = false;
				has_A = false;
				has_s = false;
				has_d = false;
				in_braket=true;
			} 
			else{
				continue;
			}
		}
	}

	if(in_braket) return false;

	return true;
}

function calc(pa){
//assume format check pass

	var num_total_hash = 1;

	var in_braket = false;
	for(var idx=0; idx<pa.length; idx++){
		if(in_braket){
			if(pa[idx]==']')
				in_braket=false;
			else{
				switch(pa[idx]){
					case 'a':
						num_total_hash = num_total_hash * 26;
						break;
					case 'A':
						num_total_hash = num_total_hash * 26;
						break;
					case 's':
						num_total_hash = num_total_hash * 32;
						break;
					case 'd':
						num_total_hash = num_total_hash * 10;
						break;
					default:
						return 0;
				}					
			}
		}
		else{
			if(pa[idx]=='[') in_braket=true;
		}
	}

	return num_total_hash;
}

function getpa(){
	var pa = document.getElementById("inputbox").value;
	console.log("getpa");
	console.log("input string: "+pa)
	console.log("format check pass: "+check(pa))
	if(check(pa)){
		console.log("num_total_hash: " + calc(pa))
	}
}
