/// @description

event_inherited();

context_funcs = [];
var _f = 0;
repeat(array_length(global.context_funcs)){
	context_funcs[_f] = method(id, global.context_funcs[_f++]);
}

list_targets = ds_list_create();

contexts = [ // target				//range		//color
new Context(obj_target_player,		256,		3177241),
new Context(obj_target_fire,		192,		680611),
new Context(obj_target_enemy,		128,		986014),
new Context(obj_target_collision,	64,			5592405),
]

detect_range_max = 0;
context_targets_collection = [];
var _i = 0;
repeat(array_length(contexts)){
	var _context = contexts[_i++];
	array_push(context_targets_collection, _context.target);
	detect_range_max = max(detect_range_max, _context.detect_range);
}

array_unique_ext(context_targets_collection);

targets_considered = 0;
targets_num = 0