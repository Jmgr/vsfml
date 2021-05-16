module graphics

// transform_identity: identity transform (does nothing)
pub const transform_identity = Transform{
	matrix: [
		f32(1),
		f32(0),
		f32(0),
		f32(0),
		f32(1),
		f32(0),
		f32(0),
		f32(0),
		f32(1),
	]!
}
