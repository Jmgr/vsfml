module graphics

#include <SFML/Graphics/BlendMode.h>

[typedef]
struct C.sfBlendMode {
pub:
	colorSrcFactor BlendFactor
	colorDstFactor BlendFactor
	colorEquation  BlendEquation
	alphaSrcFactor BlendFactor
	alphaDstFactor BlendFactor
	alphaEquation  BlendEquation
}

// BlendMode: blending mode for drawing
pub type BlendMode = C.sfBlendMode

// BlendFactor: enumeration of the blending factors
pub enum BlendFactor {
	zero // (0, 0, 0, 0)
	one // (1, 1, 1, 1)
	src_color // (src.r, src.g, src.b, src.a)
	one_minus_src_color // (1, 1, 1, 1) - (src.r, src.g, src.b, src.a)
	dst_color // (dst.r, dst.g, dst.b, dst.a)
	one_minus_dst_color // (1, 1, 1, 1) - (dst.r, dst.g, dst.b, dst.a)
	src_alpha // (src.a, src.a, src.a, src.a)
	one_minus_src_alpha // (1, 1, 1, 1) - (src.a, src.a, src.a, src.a)
	dst_alpha // (dst.a, dst.a, dst.a, dst.a)
	one_minus_dst_alpha // (1, 1, 1, 1) - (dst.a, dst.a, dst.a, dst.a)
}

// BlendEquation: enumeration of the blending equations
pub enum BlendEquation {
	add // Pixel = Src * SrcFactor + Dst * DstFactor
	subtract // Pixel = Src * SrcFactor - Dst * DstFactor
	reverse_subtract // Pixel = Dst * DstFactor - Src * SrcFactor
}
