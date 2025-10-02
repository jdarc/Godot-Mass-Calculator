@tool
class_name MassCalculator

const MATERIAL_DENSITY_TABLE := {
	&"Air": 1.0,
	&"Acrylic": 1400.0,
	&"Asphalt (Crushed)": 721.0,
	&"Bark": 240.0,
	&"Beans (Cocoa)": 593.0,
	&"Beans (Soy)": 721.0,
	&"Brick (Pressed)": 2400.0,
	&"Brick (Common)": 2000.0,
	&"Brick (Soft)": 1600.0,
	&"Brass": 8216.0,
	&"Bronze": 8860.0,
	&"Carbon (Solid)": 2146.0,
	&"Cardboard": 689.0,
	&"Cast Iron": 7150.0,
	&"Chalk (Solid)": 2499.0,
	&"Concrete": 2320.0,
	&"Charcoal": 208.0,
	&"Cork": 240.0,
	&"Copper": 8933.0,
	&"Garbage": 481.0,
	&"Glass (Broken)": 1940.0,
	&"Glass (Solid)": 2190.0,
	&"Gold": 19282.0,
	&"Granite (Broken)": 1650.0,
	&"Granite (Solid)": 2691.0,
	&"Gravel": 2780.0,
	&"Ice (Crushed)": 593.0,
	&"Ice (Solid)": 919.0,
	&"Iron": 7874.0,
	&"Lead": 11342.0,
	&"Limestone (Broken)": 1554.0,
	&"Limestone (Solid)": 2611.0,
	&"Marble (Broken)": 1570.0,
	&"Marble (Solid)": 2563.0,
	&"Paper": 1201.0,
	&"Peanuts (Shelled)": 641.0,
	&"Peanuts (Not Shelled)": 272.0,
	&"Plaster": 849.0,
	&"Plastic": 1200.0,
	&"Polystyrene": 1050.0,
	&"Rubber": 1522.0,
	&"Silver": 10501.0,
	&"Steel": 7860.0,
	&"Stone": 2515.0,
	&"Stone (Crushed)": 1602.0,
	&"Timber": 610.0
}


static func calculate_mass(body: RigidBody3D, material_key: String) -> float:
	var volume := 0.0
	var density := 0.0
	if MATERIAL_DENSITY_TABLE.has(material_key):
		density = MATERIAL_DENSITY_TABLE[material_key]
	for it: CollisionShape3D in body.find_children(&"*", &"CollisionShape3D"):
		volume += _calculate_shape_volume(it.shape)
	return maxf(0.001, volume * density)


static func _calculate_shape_volume(shape: Shape3D) -> float:
	if shape is BoxShape3D:
		return shape.size.x * shape.size.y * shape.size.z
	elif shape is SphereShape3D:
		return 4.0 / 3.0 * PI * shape.radius * shape.radius * shape.radius
	elif shape is CapsuleShape3D or shape is CylinderShape3D:
		return PI * shape.radius * shape.radius * shape.height
	elif shape is ConvexPolygonShape3D:
		return _calculate_delaunay_volume(shape.points)
	else:
		return 0.0


static func _calculate_delaunay_volume(points: PackedVector3Array) -> float:
	if points.size() < 4:
		push_error(&"At least 4 non-coplanar points are required for tetrahedralization.")
		return 0.0

	var tetra_indices := Geometry3D.tetrahedralize_delaunay(points)
	if tetra_indices.size() < 4:
		push_error(&"Invalid tetrahedralization: insufficient tetrahedra.")
		return 0.0

	# Sum volumes of all tetrahedra...
	var volume: float = 0.0
	for i: int in range(0, tetra_indices.size(), 4):
		var v1 := points[tetra_indices[i + 0]]
		var v2 := points[tetra_indices[i + 1]]
		var v3 := points[tetra_indices[i + 2]]
		var v4 := points[tetra_indices[i + 3]]
		volume += _calculate_tetrahedron_volume(v1, v2, v3, v4)

	return volume


# Tetrahedron volume using scalar triple product
static func _calculate_tetrahedron_volume(v1: Vector3, v2: Vector3, v3: Vector3, v4: Vector3) -> float:
	return absf((v2 - v1).dot((v3 - v1).cross((v4 - v1)))) / 6.0
