draw_self();

if(global.filter_func < 0) exit;

switch(global.filter_func){
	case 0:
	case 1:
	case 4:
		draw_text(x, y, $"1:{targets_considered}");
		break;
	case 2:
	case 3:
		draw_text(x, y, $"2:{targets_considered} / {targets_num} ({targets_num - targets_considered})")
		break;
	default:
		break;
}

var _c = 0;
repeat(array_length(contexts)){
	var _context = contexts[_c++];
	var _col = _context.color;
    draw_circle_color(x, y, _context.detect_range, _col, _col, true);
}