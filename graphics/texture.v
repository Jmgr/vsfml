module graphics

import vsfml.system
import vsfml.window

#include <SFML/Graphics/Texture.h>

fn C.sfTexture_create(u32, u32) &C.sfTexture
fn C.sfTexture_createFromFile(&char, &C.sfIntRect) &C.sfTexture
fn C.sfTexture_createFromMemory(voidptr, usize, &C.sfIntRect) &C.sfTexture
fn C.sfTexture_createFromStream(&C.sfInputStream, &C.sfIntRect) &C.sfTexture
fn C.sfTexture_createFromImage(&C.sfImage, &C.sfIntRect) &C.sfTexture
fn C.sfTexture_copy(&C.sfTexture) &C.sfTexture
fn C.sfTexture_destroy(&C.sfTexture)
fn C.sfTexture_getSize(&C.sfTexture) C.sfVector2u
fn C.sfTexture_copyToImage(&C.sfTexture) &C.sfImage
fn C.sfTexture_updateFromPixels(&C.sfTexture, &u8, u32, u32, u32, u32)
fn C.sfTexture_updateFromTexture(&C.sfTexture, &C.sfTexture, u32, u32)
fn C.sfTexture_updateFromImage(&C.sfTexture, &C.sfImage, u32, u32)
fn C.sfTexture_updateFromWindow(&C.sfTexture, &C.sfWindow, u32, u32)
fn C.sfTexture_updateFromRenderWindow(&C.sfTexture, &C.sfRenderWindow, u32, u32)
fn C.sfTexture_setSmooth(&C.sfTexture, int)
fn C.sfTexture_isSmooth(&C.sfTexture) int
fn C.sfTexture_setSrgb(&C.sfTexture, int)
fn C.sfTexture_isSrgb(&C.sfTexture) int
fn C.sfTexture_setRepeated(&C.sfTexture, int)
fn C.sfTexture_isRepeated(&C.sfTexture) int
fn C.sfTexture_generateMipmap(&C.sfTexture) int
fn C.sfTexture_swap(&C.sfTexture, &C.sfTexture)
fn C.sfTexture_bind(&C.sfTexture)

// new_texture: create a new texture
pub fn new_texture(params TextureNewTextureParams) !&Texture {
	unsafe {
		result := &Texture(C.sfTexture_create(u32(params.width), u32(params.height)))
		if voidptr(result) == C.NULL {
			return error('new_texture failed with width=${params.width} height=${params.height}')
		}
		return result
	}
}

// TextureNewTextureParams: parameters for new_texture
pub struct TextureNewTextureParams {
pub:
	width  u32 [required] // texture width
	height u32 [required] // texture height
}

// new_texture_from_file: create a new texture from a file
pub fn new_texture_from_file(params TextureNewTextureFromFileParams) !&Texture {
	unsafe {
		result := &Texture(C.sfTexture_createFromFile(params.filename.str, &C.sfIntRect(params.area)))
		if voidptr(result) == C.NULL {
			return error('new_texture_from_file failed with filename=${params.filename}')
		}
		return result
	}
}

// TextureNewTextureFromFileParams: parameters for new_texture_from_file
pub struct TextureNewTextureFromFileParams {
pub:
	filename string   [required] // path of the image file to load
	area     &IntRect = C.NULL // area of the source image to load (NULL to load the entire image)
}

// new_texture_from_memory: create a new texture from a file in memory
pub fn new_texture_from_memory(params TextureNewTextureFromMemoryParams) !&Texture {
	unsafe {
		result := &Texture(C.sfTexture_createFromMemory(voidptr(params.data), usize(params.size_in_bytes),
			&C.sfIntRect(params.area)))
		if voidptr(result) == C.NULL {
			return error('new_texture_from_memory failed with size_in_bytes=${params.size_in_bytes}')
		}
		return result
	}
}

// TextureNewTextureFromMemoryParams: parameters for new_texture_from_memory
pub struct TextureNewTextureFromMemoryParams {
pub:
	data          voidptr  [required] // pointer to the file data in memory
	size_in_bytes u64      [required]     // size of the data to load, in bytes
	area          &IntRect = C.NULL // area of the source image to load (NULL to load the entire image)
}

// new_texture_from_stream: create a new texture from a custom stream
pub fn new_texture_from_stream(params TextureNewTextureFromStreamParams) !&Texture {
	unsafe {
		result := &Texture(C.sfTexture_createFromStream(&C.sfInputStream(params.stream),
			&C.sfIntRect(params.area)))
		if voidptr(result) == C.NULL {
			return error('new_texture_from_stream failed')
		}
		return result
	}
}

// TextureNewTextureFromStreamParams: parameters for new_texture_from_stream
pub struct TextureNewTextureFromStreamParams {
pub:
	stream &system.InputStream [required] // source stream to read from
	area   &IntRect = C.NULL // area of the source image to load (NULL to load the entire image)
}

// new_texture_from_image: create a new texture from an image
pub fn new_texture_from_image(params TextureNewTextureFromImageParams) !&Texture {
	unsafe {
		result := &Texture(C.sfTexture_createFromImage(&C.sfImage(params.image), &C.sfIntRect(params.area)))
		if voidptr(result) == C.NULL {
			return error('new_texture_from_image failed')
		}
		return result
	}
}

// TextureNewTextureFromImageParams: parameters for new_texture_from_image
pub struct TextureNewTextureFromImageParams {
pub:
	image &Image   [required] // image to upload to the texture
	area  &IntRect = C.NULL // area of the source image to load (NULL to load the entire image)
}

// copy: copy an existing texture
pub fn (t &Texture) copy() !&Texture {
	unsafe {
		result := &Texture(C.sfTexture_copy(&C.sfTexture(t)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing texture
[unsafe]
pub fn (t &Texture) free() {
	unsafe {
		C.sfTexture_destroy(&C.sfTexture(t))
	}
}

// get_size: return the size of the texture
pub fn (t &Texture) get_size() system.Vector2u {
	unsafe {
		return system.Vector2u(C.sfTexture_getSize(&C.sfTexture(t)))
	}
}

// copy_to_image: copy a texture's pixels to an image
pub fn (t &Texture) copy_to_image() !&Image {
	unsafe {
		result := &Image(C.sfTexture_copyToImage(&C.sfTexture(t)))
		if voidptr(result) == C.NULL {
			return error('copy_to_image failed')
		}
		return result
	}
}

// update_from_pixels: update a texture from an array of pixels
pub fn (t &Texture) update_from_pixels(params TextureUpdateFromPixelsParams) {
	unsafe {
		C.sfTexture_updateFromPixels(&C.sfTexture(t), &u8(params.pixels), u32(params.width),
			u32(params.height), u32(params.x), u32(params.y))
	}
}

// TextureUpdateFromPixelsParams: parameters for update_from_pixels
pub struct TextureUpdateFromPixelsParams {
pub:
	pixels &u8 [required] // array of pixels to copy to the texture
	width  u32 [required] // width of the pixel region contained in \a pixels
	height u32 [required] // height of the pixel region contained in \a pixels
	x      u32 [required] // x offset in the texture where to copy the source pixels
	y      u32 [required] // y offset in the texture where to copy the source pixels
}

// update_from_texture: update a part of this texture from another texture
// No additional check is performed on the size of the texture,
// passing an invalid combination of texture size and offset
// will lead to an undefined behavior.
// This function does nothing if either texture was not
// previously created.
pub fn (t &Texture) update_from_texture(params TextureUpdateFromTextureParams) {
	unsafe {
		C.sfTexture_updateFromTexture(&C.sfTexture(t), &C.sfTexture(params.source), u32(params.x),
			u32(params.y))
	}
}

// TextureUpdateFromTextureParams: parameters for update_from_texture
pub struct TextureUpdateFromTextureParams {
pub:
	source &Texture [required] // source texture to copy to destination texture
	x      u32      [required]      // x offset in this texture where to copy the source texture
	y      u32      [required]      // y offset in this texture where to copy the source texture
}

// update_from_image: update a texture from an image
pub fn (t &Texture) update_from_image(params TextureUpdateFromImageParams) {
	unsafe {
		C.sfTexture_updateFromImage(&C.sfTexture(t), &C.sfImage(params.image), u32(params.x),
			u32(params.y))
	}
}

// TextureUpdateFromImageParams: parameters for update_from_image
pub struct TextureUpdateFromImageParams {
pub:
	image &Image [required] // image to copy to the texture
	x     u32    [required]    // x offset in the texture where to copy the source pixels
	y     u32    [required]    // y offset in the texture where to copy the source pixels
}

// update_from_window: update a texture from the contents of a window
pub fn (t &Texture) update_from_window(params TextureUpdateFromWindowParams) {
	unsafe {
		C.sfTexture_updateFromWindow(&C.sfTexture(t), &C.sfWindow(params.window), u32(params.x),
			u32(params.y))
	}
}

// TextureUpdateFromWindowParams: parameters for update_from_window
pub struct TextureUpdateFromWindowParams {
pub:
	window &window.Window [required] // window to copy to the texture
	x      u32            [required] // x offset in the texture where to copy the source pixels
	y      u32            [required] // y offset in the texture where to copy the source pixels
}

// update_from_render_window: update a texture from the contents of a render-window
pub fn (t &Texture) update_from_render_window(params TextureUpdateFromRenderWindowParams) {
	unsafe {
		C.sfTexture_updateFromRenderWindow(&C.sfTexture(t), &C.sfRenderWindow(params.render_window),
			u32(params.x), u32(params.y))
	}
}

// TextureUpdateFromRenderWindowParams: parameters for update_from_render_window
pub struct TextureUpdateFromRenderWindowParams {
pub:
	render_window &RenderWindow [required] // render-window to copy to the texture
	x             u32           [required] // x offset in the texture where to copy the source pixels
	y             u32           [required] // y offset in the texture where to copy the source pixels
}

// set_smooth: enable or disable the smooth filter on a texture
pub fn (t &Texture) set_smooth(smooth bool) {
	unsafe {
		C.sfTexture_setSmooth(&C.sfTexture(t), int(smooth))
	}
}

// is_smooth: tell whether the smooth filter is enabled or not for a texture
pub fn (t &Texture) is_smooth() bool {
	unsafe {
		return C.sfTexture_isSmooth(&C.sfTexture(t)) != 0
	}
}

// set_srgb: enable or disable conversion from sRGB
// When providing texture data from an image file or memory, it can
// either be stored in a linear color space or an sRGB color space.
// Most digital images account for gamma correction already, so they
// would need to be "uncorrected" back to linear color space before
// being processed by the hardware. The hardware can automatically
// convert it from the sRGB color space to a linear color space when
// it gets sampled. When the rendered image gets output to the final
// framebuffer, it gets converted back to sRGB.
// After enabling or disabling sRGB conversion, make sure to reload
// the texture data in order for the setting to take effect.
// This option is only useful in conjunction with an sRGB capable
// framebuffer. This can be requested during window creation.
pub fn (t &Texture) set_srgb(sRgb bool) {
	unsafe {
		C.sfTexture_setSrgb(&C.sfTexture(t), int(sRgb))
	}
}

// is_srgb: tell whether the texture source is converted from sRGB or not
pub fn (t &Texture) is_srgb() bool {
	unsafe {
		return C.sfTexture_isSrgb(&C.sfTexture(t)) != 0
	}
}

// set_repeated: enable or disable repeating for a texture
// Repeating is involved when using texture coordinates
// outside the texture rectangle [0, 0, width, height].
// In this case, if repeat mode is enabled, the whole texture
// will be repeated as many times as needed to reach the
// coordinate (for example, if the X texture coordinate is
// 3 * width, the texture will be repeated 3 times).
// If repeat mode is disabled, the "extra space" will instead
// be filled with border pixels.
// Warning: on very old graphics cards, white pixels may appear
// when the texture is repeated. With such cards, repeat mode
// can be used reliably only if the texture has power-of-two
// dimensions (such as 256x128).
// Repeating is disabled by default.
pub fn (t &Texture) set_repeated(repeated bool) {
	unsafe {
		C.sfTexture_setRepeated(&C.sfTexture(t), int(repeated))
	}
}

// is_repeated: tell whether a texture is repeated or not
pub fn (t &Texture) is_repeated() bool {
	unsafe {
		return C.sfTexture_isRepeated(&C.sfTexture(t)) != 0
	}
}

// generate_mipmap: generate a mipmap using the current texture data
// Mipmaps are pre-computed chains of optimized textures. Each
// level of texture in a mipmap is generated by halving each of
// the previous level's dimensions. This is done until the final
// level has the size of 1x1. The textures generated in this process may
// make use of more advanced filters which might improve the visual quality
// of textures when they are applied to objects much smaller than they are.
// This is known as minification. Because fewer texels (texture elements)
// have to be sampled from when heavily minified, usage of mipmaps
// can also improve rendering performance in certain scenarios.
// Mipmap generation relies on the necessary OpenGL extension being
// available. If it is unavailable or generation fails due to another
// reason, this function will return false. Mipmap data is only valid from
// the time it is generated until the next time the base level image is
// modified, at which point this function will have to be called again to
// regenerate it.
pub fn (t &Texture) generate_mipmap() bool {
	unsafe {
		return C.sfTexture_generateMipmap(&C.sfTexture(t)) != 0
	}
}

// swap: swap the contents of a texture with those of another
pub fn (t &Texture) swap(right &Texture) {
	unsafe {
		C.sfTexture_swap(&C.sfTexture(t), &C.sfTexture(right))
	}
}

// bind: bind a texture for rendering
// This function is not part of the graphics API, it mustn't be
// used when drawing SFML entities. It must be used only if you
// mix Texture with OpenGL code.
pub fn (t &Texture) bind() {
	unsafe {
		C.sfTexture_bind(&C.sfTexture(t))
	}
}
