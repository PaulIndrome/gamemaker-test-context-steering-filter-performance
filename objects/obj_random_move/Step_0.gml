x = ( sin((current_time + instance_time_offset) * 0.0001 * instance_speed) + 1 ) * 0.5 * room_width;
y = lerp(y, random_y_target, delta_time * 0.0000001 * move_speed_y);