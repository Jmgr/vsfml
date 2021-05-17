module system

fn (a Vector2u) + (b Vector2u) Vector2u {
	return Vector2u{a.x + b.x, a.y + b.y}
}

fn (a Vector2u) - (b Vector2u) Vector2u {
	return Vector2u{a.x - b.x, a.y - b.y}
}

fn (a Vector2u) * (b Vector2u) Vector2u {
	return Vector2u{a.x * b.x, a.y * b.y}
}

fn (a Vector2u) / (b Vector2u) Vector2u {
	return Vector2u{a.x / b.x, a.y / b.y}
}

fn (a Vector2f) + (b Vector2f) Vector2f {
	return Vector2f{a.x + b.x, a.y + b.y}
}

fn (a Vector2f) - (b Vector2f) Vector2f {
	return Vector2f{a.x - b.x, a.y - b.y}
}

fn (a Vector2f) * (b Vector2f) Vector2f {
	return Vector2f{a.x * b.x, a.y * b.y}
}

fn (a Vector2f) / (b Vector2f) Vector2f {
	return Vector2f{a.x / b.x, a.y / b.y}
}
