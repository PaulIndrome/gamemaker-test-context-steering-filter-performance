global.filter_func = 0;

///@param {Asset.GMObject} _target
///@param {real} _detect_range
///@param {Constant.Color} _color
function Context(_target, _detect_range, _color) constructor {
	target = _target;
	detect_range = _detect_range;
	color = _color;
}

global.context_funcs = [];
global.context_func_desc = [];

global.context_func_desc[0] = "per context 1 cclist";
global.context_funcs[0] = function(){
	ds_list_clear(list_targets);
	targets_considered = 0;
	
	var _c = 0;
	repeat(array_length(contexts)){
		ds_list_clear(list_targets);
		
		var _context = contexts[_c++];
		var _num_targets = collision_circle_list(x, y, _context.detect_range, _context.target, false, true, list_targets, false);
		
		targets_considered += _num_targets;
	}
}

global.context_func_desc[1] = "per context 1 cclist, dist query";
global.context_funcs[1] = function(){
	ds_list_clear(list_targets);
	targets_considered = 0;
	
	var _dist = 0, _target = noone;
	
	var _c = 0;
	repeat(array_length(contexts)){
		ds_list_clear(list_targets);
		
		var _context = contexts[_c++];
		var _num_targets = collision_circle_list(x, y, _context.detect_range, _context.target, false, true, list_targets, false);
		
		var _t = 0;
		repeat(_num_targets){
			_target = list_targets[| _t++];
		    _dist = point_distance(x, y, _target.x, _target.y);
		}
		
		targets_considered += _num_targets;
	}
}

global.context_func_desc[2] = "1 cclist max range, all targets, filter obj & dist";
global.context_funcs[2] = function(){
	ds_list_clear(list_targets);
	targets_considered = 0;
	
	targets_num = collision_circle_list(x, y, detect_range_max, context_targets_collection, false, true, list_targets, false);
	
	var _c = 0;
	repeat(array_length(contexts)){
		var _context = contexts[_c++];
		var _t = 0;
		repeat(targets_num){ // this repeated ds_list traversal could be shortened by converting it to an array and using array_filter?
			var _target = list_targets[| _t++];
			
			if(_target.object_index != _context.target) continue;
			if(point_distance(x, y, _target.x, _target.y) > _context.detect_range) continue;
			
			targets_considered++;
		}
	}
}

global.context_func_desc[3] = "1 cclist max range, all targets, convert to array, array_filter & dist";
global.context_funcs[3] = function(){
	ds_list_clear(list_targets);
	targets_considered = 0;
	
	targets_num = collision_circle_list(x, y, detect_range_max, context_targets_collection, false, true, list_targets, false);
	
	var _arr_targets = array_create_ext(ds_list_size(list_targets), function (_i) { return list_targets[| _i]; });
	
	var _c = 0;
	repeat(array_length(contexts)){
		var _context = contexts[_c++];
		var _filtered_arr = array_filter(_arr_targets, method({ _context }, function(_e) { return _e.object_index == _context.target; }));
		var _t = 0;
		repeat(array_length(_filtered_arr)){
			var _target = _filtered_arr[_t++];
			
			if(point_distance(x, y, _target.x, _target.y) > _context.detect_range) continue;
			
			targets_considered++;
		}
	}
}

global.context_func_desc[4] = "per context with(target), filter dist";
global.context_funcs[4] = function(){
	ds_list_clear(list_targets);
	targets_considered = 0;
	
	var _x = x;
	var _y = y;
	
    var _c = 0;
	repeat(array_length(contexts)){
	    var _context = contexts[_c++];
		with(_context.target){
		    if(point_distance(_x, _y, x, y) > _context.detect_range) continue;
			
			other.targets_considered++;
		}
	}
}