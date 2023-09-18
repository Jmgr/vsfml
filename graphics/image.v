module graphics

import vsfml.system

#include <SFML/Graphics/Image.h>

fn C.sfImage_create(u32, u32) &C.sfImage
fn C.sfImage_createFromColor(u32, u32, C.sfColor) &C.sfImage
fn C.sfImage_createFromPixels(u32, u32, &byte) &C.sfImage
fn C.sfImage_createFromFile(&char) &C.sfImage
fn C.sfImage_createFromMemory(voidptr, usize) &C.sfImage
fn C.sfImage_createFromStream(&C.sfInputStream) &C.sfImage
fn C.sfImage_copy(&C.sfImage) &C.sfImage
fn C.sfImage_destroy(&C.sfImage)
fn C.sfImage_saveToFile(&C.sfImage, &char) int
fn C.sfImage_getSize(&C.sfImage) C.sfVector2u
fn C.sfImage_createMaskFromColor(&C.sfImage, C.sfColor, byte)
fn C.sfImage_copyImage(&C.sfImage, &C.sfImage, u32, u32, C.sfIntRect, int)
fn C.sfImage_setPixel(&C.sfImage, u32, u32, C.sfColor)
fn C.sfImage_getPixel(&C.sfImage, u32, u32) C.sfColor
fn C.sfImage_getPixelsPtr(&C.sfImage) &byte
fn C.sfImage_flipHorizontally(&C.sfImage)
fn C.sfImage_flipVertically(&C.sfImage)

// new_image: create an image
// This image is filled with black pixels.
pub fn new_image(params ImageNewImageParams) !&Image {
	unsafe {
		result := &Image(C.sfImage_create(u32(params.width), u32(params.height)))
		if voidptr(result) == C.NULL {
			return error('new_image failed with width=${params.width} height=${params.height}')
		}
		return result
	}
}

// ImageNewImageParams: parameters for new_image
pub struct ImageNewImageParams {
pub:
	width  u32 [required] // width of the image
	height u32 [required] // height of the image
}

// new_image_from_color: create an image and fill it with a unique color
pub fn new_image_from_color(params ImageNewImageFromColorParams) !&Image {
	unsafe {
		result := &Image(C.sfImage_createFromColor(u32(params.width), u32(params.height),
			*&C.sfColor(&params.color)))
		if voidptr(result) == C.NULL {
			return error('new_image_from_color failed with width=${params.width} height=${params.height} color=${params.color}')
		}
		return result
	}
}

// ImageNewImageFromColorParams: parameters for new_image_from_color
pub struct ImageNewImageFromColorParams {
pub:
	width  u32   [required]   // width of the image
	height u32   [required]   // height of the image
	color  Color [required] // fill color
}

// new_image_from_pixels: create an image from an array of pixels
// The pixel array is assumed to contain 32-bits RGBA pixels,
// and have the given width and height. If not, this is
// an undefined behaviour.
// If pixels is null, an empty image is created.
pub fn new_image_from_pixels(params ImageNewImageFromPixelsParams) !&Image {
	unsafe {
		result := &Image(C.sfImage_createFromPixels(u32(params.width), u32(params.height),
			&byte(params.pixels)))
		if voidptr(result) == C.NULL {
			return error('new_image_from_pixels failed with width=${params.width} height=${params.height}')
		}
		return result
	}
}

// ImageNewImageFromPixelsParams: parameters for new_image_from_pixels
pub struct ImageNewImageFromPixelsParams {
pub:
	width  u32   [required]   // width of the image
	height u32   [required]   // height of the image
	pixels &byte [required] // array of pixels to copy to the image
}

// new_image_from_file: create an image from a file on disk
// The supported image formats are bmp, png, tga, jpg, gif,
// psd, hdr and pic. Some format options are not supported,
// like progressive jpeg.
// If this function fails, the image is left unchanged.
pub fn new_image_from_file(params ImageNewImageFromFileParams) !&Image {
	unsafe {
		result := &Image(C.sfImage_createFromFile(params.filename.str))
		if voidptr(result) == C.NULL {
			return error('new_image_from_file failed with filename=${params.filename}')
		}
		return result
	}
}

// ImageNewImageFromFileParams: parameters for new_image_from_file
pub struct ImageNewImageFromFileParams {
pub:
	filename string [required] // path of the image file to load
}

// new_image_from_memory: create an image from a file in memory
// The supported image formats are bmp, png, tga, jpg, gif,
// psd, hdr and pic. Some format options are not supported,
// like progressive jpeg.
// If this function fails, the image is left unchanged.
pub fn new_image_from_memory(params ImageNewImageFromMemoryParams) !&Image {
	unsafe {
		result := &Image(C.sfImage_createFromMemory(voidptr(params.data), usize(params.size)))
		if voidptr(result) == C.NULL {
			return error('new_image_from_memory failed with size=${params.size}')
		}
		return result
	}
}

// ImageNewImageFromMemoryParams: parameters for new_image_from_memory
pub struct ImageNewImageFromMemoryParams {
pub:
	data voidptr [required] // pointer to the file data in memory
	size u64     [required]     // size of the data to load, in bytes
}

// new_image_from_stream: create an image from a custom stream
// The supported image formats are bmp, png, tga, jpg, gif,
// psd, hdr and pic. Some format options are not supported,
// like progressive jpeg.
// If this function fails, the image is left unchanged.
pub fn new_image_from_stream(params ImageNewImageFromStreamParams) !&Image {
	unsafe {
		result := &Image(C.sfImage_createFromStream(&C.sfInputStream(params.stream)))
		if voidptr(result) == C.NULL {
			return error('new_image_from_stream failed')
		}
		return result
	}
}

// ImageNewImageFromStreamParams: parameters for new_image_from_stream
pub struct ImageNewImageFromStreamParams {
pub:
	stream &system.InputStream [required] // source stream to read from
}

// copy: copy an existing image
pub fn (i &Image) copy() !&Image {
	unsafe {
		result := &Image(C.sfImage_copy(&C.sfImage(i)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing image
[unsafe]
pub fn (i &Image) free() {
	unsafe {
		C.sfImage_destroy(&C.sfImage(i))
	}
}

// save_to_file: save an image to a file on disk
// The format of the image is automatically deduced from
// the extension. The supported image formats are bmp, png,
// tga and jpg. The destination file is overwritten
// if it already exists. This function fails if the image is empty.
pub fn (i &Image) save_to_file(filename string) bool {
	unsafe {
		return C.sfImage_saveToFile(&C.sfImage(i), filename.str) != 0
	}
}

// get_size: return the size of an image
pub fn (i &Image) get_size() system.Vector2u {
	unsafe {
		return system.Vector2u(C.sfImage_getSize(&C.sfImage(i)))
	}
}

// new_void_mask_from_color: create a transparency mask from a specified color-key
// This function sets the alpha value of every pixel matching
// the given color to alpha (0 by default), so that they
// become transparent.
pub fn new_void_mask_from_color(params ImageNewVoidMaskFromColorParams) {
	unsafe {
		C.sfImage_createMaskFromColor(&C.sfImage(params.image), *&C.sfColor(&params.color),
			byte(params.alpha))
	}
}

// ImageNewVoidMaskFromColorParams: parameters for new_void_mask_from_color
pub struct ImageNewVoidMaskFromColorParams {
pub:
	image &Image [required] // image object
	color Color  [required]  // color to make transparent
	alpha byte   [required]   // alpha value to assign to transparent pixels
}

// copy_image: copy pixels from an image onto another
// This function does a slow pixel copy and should not be
// used intensively. It can be used to prepare a complex
// static image from several others, but if you need this
// kind of feature in real-time you'd better use RenderTexture.
// If sourceRect is empty, the whole image is copied.
// If applyAlpha is set to true, the transparency of
// source pixels is applied. If it is false, the pixels are
// copied unchanged with their alpha value.
pub fn (i &Image) copy_image(params ImageCopyImageParams) {
	unsafe {
		C.sfImage_copyImage(&C.sfImage(i), &C.sfImage(params.source), u32(params.dest_x),
			u32(params.dest_y), *&C.sfIntRect(&params.source_rect), int(params.apply_alpha))
	}
}

// ImageCopyImageParams: parameters for copy_image
pub struct ImageCopyImageParams {
pub:
	source      &Image  [required]  // source image to copy
	dest_x      u32     [required]     // x coordinate of the destination position
	dest_y      u32     [required]     // y coordinate of the destination position
	source_rect IntRect [required] // sub-rectangle of the source image to copy
	apply_alpha bool    [required]    // should the copy take in account the source transparency?
}

// set_pixel: change the color of a pixel in an image
// This function doesn't check the validity of the pixel
// coordinates, using out-of-range values will result in
// an undefined behaviour.
pub fn (i &Image) set_pixel(params ImageSetPixelParams) {
	unsafe {
		C.sfImage_setPixel(&C.sfImage(i), u32(params.x), u32(params.y), *&C.sfColor(&params.color))
	}
}

// ImageSetPixelParams: parameters for set_pixel
pub struct ImageSetPixelParams {
pub:
	x     u32   [required]   // x coordinate of pixel to change
	y     u32   [required]   // y coordinate of pixel to change
	color Color [required] // new color of the pixel
}

// get_pixel: get the color of a pixel in an image
// This function doesn't check the validity of the pixel
// coordinates, using out-of-range values will result in
// an undefined behaviour.
pub fn (i &Image) get_pixel(x u32, y u32) Color {
	unsafe {
		return Color(C.sfImage_getPixel(&C.sfImage(i), u32(x), u32(y)))
	}
}

// get_pixels_ptr: get a read-only pointer to the array of pixels of an image
// The returned value points to an array of RGBA pixels made of
// 8 bits integers components. The size of the array is
// getWidth() * getHeight() * 4.
// Warning: the returned pointer may become invalid if you
// modify the image, so you should never store it for too long.
// If the image is empty, a null pointer is returned.
pub fn (i &Image) get_pixels_ptr() !&u8 {
	unsafe {
		result := &u8(C.sfImage_getPixelsPtr(&C.sfImage(i)))
		if voidptr(result) == C.NULL {
			return error('get_pixels_ptr failed')
		}
		return result
	}
}

// flip_horizontally: flip an image horizontally (left <-> right)
pub fn (i &Image) flip_horizontally() {
	unsafe {
		C.sfImage_flipHorizontally(&C.sfImage(i))
	}
}

// flip_vertically: flip an image vertically (top <-> bottom)
pub fn (i &Image) flip_vertically() {
	unsafe {
		C.sfImage_flipVertically(&C.sfImage(i))
	}
}
