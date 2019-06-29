extends Panel
onready var itemName = $Name
onready var itemImage = $Item/IImage

var textCenter : Vector2
var elipseArray :PoolVector2Array
var triangleArray : PoolVector2Array
var namePos : Vector2
var nameDim : Vector2
var nameColor : Color = Color( 0.40, 0.22, 0.12, 1 )
var triangleLen : int = 15
func _ready():
	namePos = Vector2(itemName.rect_position.x,itemName.rect_position.y + 2)
	nameDim = itemName.rect_size
	_setElipse()
	_setTriangle()
	
func _draw():
	draw_colored_polygon(elipseArray,nameColor)
	draw_circle(Vector2(namePos.x,namePos.y +nameDim.y / 2),nameDim.y / 2,nameColor)
	draw_circle(Vector2(namePos.x + nameDim.x,namePos.y +nameDim.y / 2),nameDim.y /2, nameColor)
	draw_colored_polygon(triangleArray,nameColor)

func _setElipse():
	elipseArray.push_back(namePos)
	elipseArray.push_back(Vector2(namePos.x + nameDim.x,namePos.y))
	elipseArray.push_back(Vector2(namePos.x + nameDim.x,namePos.y +nameDim.y))
	elipseArray.push_back(Vector2(namePos.x,namePos.y +nameDim.y))

func _setTriangle():
	triangleArray.push_back(Vector2(namePos.x + nameDim.x /2 -triangleLen /1.7, namePos.y + nameDim.y))
	triangleArray.push_back(Vector2(namePos.x + nameDim.x /2 +triangleLen /1.7, namePos.y + nameDim.y))
	triangleArray.push_back(Vector2(namePos.x + nameDim.x /2, namePos.y + nameDim.y + triangleLen))
	

func _updateName():
	elipseArray.resize(0)
	triangleArray.resize(0)
	_setElipse()
	_setTriangle()
	update()

func _on_NameEdit_text_entered(new_name):
	if new_name == "Goomba":
		itemImage.texture = load("res://Sprites/goomba.png")
	if new_name == "Mario":
		itemImage.texture = load("res://Sprites/mario.png")
	if new_name == "Question Mark Block":
		itemImage.texture = load("res://Sprites/QuestionMarkBlock.png")
	
	itemName.text = str(new_name)
	var timer = get_tree().create_timer(0.01)
	yield(timer,"timeout")
	namePos = Vector2(itemName.rect_position.x,itemName.rect_position.y + 2)
	nameDim = itemName.rect_size
	var timer2 = get_tree().create_timer(0.01)
	yield(timer2,"timeout")
	_updateName()

