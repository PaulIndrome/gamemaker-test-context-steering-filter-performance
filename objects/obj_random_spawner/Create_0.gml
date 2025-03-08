/// @description 

dbg_view("cs filter", true, 0, 512, 256, 100);
dbg_slider_int(ref_create(global, "filter_func"), 0, array_length(global.context_funcs) - 1);

repeat(num_players){
    test_create(obj_target_player);
}

repeat(num_enemies){
    test_create(obj_target_enemy);
}

repeat(num_fires){
    test_create(obj_target_fire);
}

repeat(num_collisions){
    test_create(obj_target_collision);
}

repeat(num_context_steerers){
    test_create(obj_context_steering_base);
}


function test_create(_obj){
	var _x = 16 + irandom(room_width) - 32;
	var _y = 16 + irandom(room_height) - 32;
    instance_create_layer(_x, _y, "Instances", _obj);
}