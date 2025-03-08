event_inherited();

if(global.filter_func < 0) exit;

instance_funcs[global.filter_func]();