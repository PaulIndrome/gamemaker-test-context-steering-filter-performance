event_inherited();

if(global.filter_func < 0) exit;

context_funcs[global.filter_func]();