extends Control


class_name RadialMenu

export (Color) var outerColor : Color
export (Color) var innerColor : Color
export (int) var sections : int
export (int) var detailLevel : int

onready var hitBox = $HitBox

var outerCircle : int
var innerCircle : int
var centerPoint : Vector2
var lineAngles : float
var sectionPoints : Array
var collidersAdded : bool = false


func _ready():
	outerCircle = rect_size.x/2
	innerCircle = rect_size.x/5
	centerPoint = Vector2(rect_size.x/2,rect_size.y/2)
	lineAngles = 360 / sections
	print(lineAngles)
	
func _process(delta):
	lineAngles = 360 / sections
	update()
	if sectionPoints.size() * detailLevel == sections * detailLevel and collidersAdded == false:
		_addSegmentColliders()

func _draw():
	draw_circle(centerPoint,outerCircle,outerColor)
	_drawLines()
	draw_circle(centerPoint,innerCircle,innerColor)
	
func _drawLines():
	var instance : CollisionPolygon2D = CollisionPolygon2D.new()
	for i in sections:
		draw_line(centerPoint,Vector2(-outerCircle,0).rotated(deg2rad(lineAngles *i))+centerPoint,innerColor,2.0,false)
		if sectionPoints.size() < (sections * detailLevel) and collidersAdded == false:
			sectionPoints.push_back(Vector2(-outerCircle,0).rotated(deg2rad((lineAngles *i)))+centerPoint)
	print(sectionPoints.size())
	
func _addSegmentColliders():
	
	for c in sections:
		var instance : CollisionPolygon2D = CollisionPolygon2D.new()
		var points : PoolVector2Array
		points.push_back(centerPoint)
		for p in detailLevel-1:
			points.push_back(sectionPoints[p * c])
		instance.polygon = points
		hitBox.add_child(instance)
	collidersAdded = true
	
	
func _updateSections():
	sectionPoints.clear()
	if sectionPoints.size() < sections: #0 3
		for j in detailLevel:
			sectionPoints.push_back(Vector2(-outerCircle,0).rotated(deg2rad(lineAngles *j))+centerPoint)
	print("HitboxChildren: ",hitBox.get_children())
	for k in hitBox.get_children():
		hitBox.remove_child(k)
	print("HitboxChildren: ",hitBox.get_children())
	collidersAdded = false
	print("HitboxChildren: ",hitBox.get_children())
	update()
	
	
	
	
	
	
	
	


func _on_SectionsEdit_text_entered(new_text):
	sections = int(new_text)
	_updateSections()
	print("SectionPoints: ",sectionPoints)
	pass # Replace with function body.
