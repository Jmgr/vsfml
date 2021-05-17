module system

fn (a Vector3f) + (b Vector3f) Vector3f {
	return Vector3f{a.x + b.x, a.y + b.y, a.z + b.z}
}

fn (a Vector3f) - (b Vector3f) Vector3f {
	return Vector3f{a.x - b.x, a.y - b.y, a.z - b.z}
}

fn (a Vector3f) * (b Vector3f) Vector3f {
	return Vector3f{a.x * b.x, a.y * b.y, a.z * b.z}
}

fn (a Vector3f) / (b Vector3f) Vector3f {
	return Vector3f{a.x / b.x, a.y / b.y, a.z / b.z}
}
