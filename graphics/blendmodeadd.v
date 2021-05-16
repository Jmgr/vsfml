module graphics

// blend_alpha: blend source and dest according to dest alpha
pub const blend_alpha = BlendMode{
	colorSrcFactor: BlendFactor.src_alpha
	colorDstFactor: BlendFactor.one_minus_src_alpha
	colorEquation: BlendEquation.add
	alphaSrcFactor: BlendFactor.one
	alphaDstFactor: BlendFactor.one_minus_src_alpha
	alphaEquation: BlendEquation.add
}

// blend_add: add source to dest
pub const blend_add = BlendMode{
	colorSrcFactor: BlendFactor.src_alpha
	colorDstFactor: BlendFactor.one
	colorEquation: BlendEquation.add
	alphaSrcFactor: BlendFactor.one
	alphaDstFactor: BlendFactor.one
	alphaEquation: BlendEquation.add
}

// blend_multiply: multiply source and dest
pub const blend_multiply = BlendMode{
	colorSrcFactor: BlendFactor.dst_color
	colorDstFactor: BlendFactor.zero
	colorEquation: BlendEquation.add
	alphaSrcFactor: BlendFactor.dst_color
	alphaDstFactor: BlendFactor.zero
	alphaEquation: BlendEquation.add
}

// blend_none: overwrite dest with source
pub const blend_none = BlendMode{
	colorSrcFactor: BlendFactor.one
	colorDstFactor: BlendFactor.zero
	colorEquation: BlendEquation.add
	alphaSrcFactor: BlendFactor.one
	alphaDstFactor: BlendFactor.zero
	alphaEquation: BlendEquation.add
}
