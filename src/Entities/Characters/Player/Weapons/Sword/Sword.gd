extends Node2D

var center = Vector2.ZERO
var rotation_angle = 50
var angle_from = 75
var angle_to = 195
var color = Color(1.0, 0.0, 0.0)

export (float) var radius = 200
export (float) var attack_width_angle = 60

func attack(attack_angle):
	self.angle_from = attack_angle - attack_width_angle/2
	self.angle_to = attack_angle + attack_width_angle/2
	if angle_from > 360 and angle_to > 360:
		angle_from = wrapf(angle_from, 0, 360)
		angle_to = wrapf(angle_to, 0, 360)
	

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
	
func _draw():
	draw_circle_arc_poly(center, radius, angle_from, angle_to, color)
	
func _process(delta):
	update()

# https://docs.godotengine.org/en/stable/tutorials/2d/custom_drawing_in_2d.html#an-example-drawing-circular-arcs
# Was just looking for a way to visualize a *sweeping* attack
