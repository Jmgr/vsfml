module graphics

import vsfml.window
import vsfml.system

#include <SFML/Graphics/RenderTexture.h>

fn C.sfRenderTexture_create(u32, u32, int) &C.sfRenderTexture
fn C.sfRenderTexture_createWithSettings(u32, u32, &C.sfContextSettings) &C.sfRenderTexture
fn C.sfRenderTexture_destroy(&C.sfRenderTexture)
fn C.sfRenderTexture_getSize(&C.sfRenderTexture) C.sfVector2u
fn C.sfRenderTexture_setActive(&C.sfRenderTexture, int) int
fn C.sfRenderTexture_display(&C.sfRenderTexture)
fn C.sfRenderTexture_clear(&C.sfRenderTexture, C.sfColor)
fn C.sfRenderTexture_setView(&C.sfRenderTexture, &C.sfView)
fn C.sfRenderTexture_getView(&C.sfRenderTexture) &C.sfView
fn C.sfRenderTexture_getDefaultView(&C.sfRenderTexture) &C.sfView
fn C.sfRenderTexture_getViewport(&C.sfRenderTexture, &C.sfView) C.sfIntRect
fn C.sfRenderTexture_mapPixelToCoords(&C.sfRenderTexture, C.sfVector2i, &C.sfView) C.sfVector2f
fn C.sfRenderTexture_mapCoordsToPixel(&C.sfRenderTexture, C.sfVector2f, &C.sfView) C.sfVector2i
fn C.sfRenderTexture_drawSprite(&C.sfRenderTexture, &C.sfSprite, &C.sfRenderStates)
fn C.sfRenderTexture_drawText(&C.sfRenderTexture, &C.sfText, &C.sfRenderStates)
fn C.sfRenderTexture_drawShape(&C.sfRenderTexture, &C.sfShape, &C.sfRenderStates)
fn C.sfRenderTexture_drawCircleShape(&C.sfRenderTexture, &C.sfCircleShape, &C.sfRenderStates)
fn C.sfRenderTexture_drawConvexShape(&C.sfRenderTexture, &C.sfConvexShape, &C.sfRenderStates)
fn C.sfRenderTexture_drawRectangleShape(&C.sfRenderTexture, &C.sfRectangleShape, &C.sfRenderStates)
fn C.sfRenderTexture_drawVertexArray(&C.sfRenderTexture, &C.sfVertexArray, &C.sfRenderStates)
fn C.sfRenderTexture_drawVertexBuffer(&C.sfRenderTexture, &C.sfVertexBuffer, &C.sfRenderStates)
fn C.sfRenderTexture_drawPrimitives(&C.sfRenderTexture, &C.sfVertex, usize, C.sfPrimitiveType, &C.sfRenderStates)
fn C.sfRenderTexture_pushGLStates(&C.sfRenderTexture)
fn C.sfRenderTexture_popGLStates(&C.sfRenderTexture)
fn C.sfRenderTexture_resetGLStates(&C.sfRenderTexture)
fn C.sfRenderTexture_getTexture(&C.sfRenderTexture) &C.sfTexture
fn C.sfRenderTexture_setSmooth(&C.sfRenderTexture, int)
fn C.sfRenderTexture_isSmooth(&C.sfRenderTexture) int
fn C.sfRenderTexture_setRepeated(&C.sfRenderTexture, int)
fn C.sfRenderTexture_isRepeated(&C.sfRenderTexture) int
fn C.sfRenderTexture_generateMipmap(&C.sfRenderTexture) int

// new_render_texture: construct a new render texture
pub fn new_render_texture(params RenderTextureNewRenderTextureParams) !&RenderTexture {
	unsafe {
		result := &RenderTexture(C.sfRenderTexture_create(u32(params.width), u32(params.height),
			int(params.depth_buffer)))
		if voidptr(result) == C.NULL {
			return error('new_render_texture failed with width=${params.width} height=${params.height} depth_buffer=${params.depth_buffer}')
		}
		return result
	}
}

// RenderTextureNewRenderTextureParams: parameters for new_render_texture
pub struct RenderTextureNewRenderTextureParams {
pub:
	width        u32  [required]  // width of the render texture
	height       u32  [required]  // height of the render texture
	depth_buffer bool [required] // do you want a depth-buffer attached? (useful only if you're doing 3D OpenGL on the rendertexture)
}

// new_render_texture_with_settings: construct a new render texture
pub fn new_render_texture_with_settings(params RenderTextureNewRenderTextureWithSettingsParams) !&RenderTexture {
	unsafe {
		result := &RenderTexture(C.sfRenderTexture_createWithSettings(u32(params.width),
			u32(params.height), &C.sfContextSettings(params.settings)))
		if voidptr(result) == C.NULL {
			return error('new_render_texture_with_settings failed with width=${params.width} height=${params.height}')
		}
		return result
	}
}

// RenderTextureNewRenderTextureWithSettingsParams: parameters for new_render_texture_with_settings
pub struct RenderTextureNewRenderTextureWithSettingsParams {
pub:
	width    u32                     [required] // width of the render texture
	height   u32                     [required] // height of the render texture
	settings &window.ContextSettings = C.NULL // settings of the render texture
}

// free: destroy an existing render texture
[unsafe]
pub fn (r &RenderTexture) free() {
	unsafe {
		C.sfRenderTexture_destroy(&C.sfRenderTexture(r))
	}
}

// get_size: get the size of the rendering region of a render texture
pub fn (r &RenderTexture) get_size() system.Vector2u {
	unsafe {
		return system.Vector2u(C.sfRenderTexture_getSize(&C.sfRenderTexture(r)))
	}
}

// set_active: activate or deactivate a render texture as the current target for rendering
pub fn (r &RenderTexture) set_active(active bool) bool {
	unsafe {
		return C.sfRenderTexture_setActive(&C.sfRenderTexture(r), int(active)) != 0
	}
}

// display: update the contents of the target texture
pub fn (r &RenderTexture) display() {
	unsafe {
		C.sfRenderTexture_display(&C.sfRenderTexture(r))
	}
}

// clear: clear the rendertexture with the given color
pub fn (r &RenderTexture) clear(color Color) {
	unsafe {
		C.sfRenderTexture_clear(&C.sfRenderTexture(r), *&C.sfColor(&color))
	}
}

// set_view: change the current active view of a render texture
pub fn (r &RenderTexture) set_view(view &View) {
	unsafe {
		C.sfRenderTexture_setView(&C.sfRenderTexture(r), &C.sfView(view))
	}
}

// get_view: get the current active view of a render texture
pub fn (r &RenderTexture) get_view() !&View {
	unsafe {
		result := &View(C.sfRenderTexture_getView(&C.sfRenderTexture(r)))
		if voidptr(result) == C.NULL {
			return error('get_view failed')
		}
		return result
	}
}

// get_default_view: get the default view of a render texture
pub fn (r &RenderTexture) get_default_view() !&View {
	unsafe {
		result := &View(C.sfRenderTexture_getDefaultView(&C.sfRenderTexture(r)))
		if voidptr(result) == C.NULL {
			return error('get_default_view failed')
		}
		return result
	}
}

// get_viewport: get the viewport of a view applied to this target
pub fn (r &RenderTexture) get_viewport(view &View) IntRect {
	unsafe {
		return IntRect(C.sfRenderTexture_getViewport(&C.sfRenderTexture(r), &C.sfView(view)))
	}
}

// map_pixel_to_coords: convert a point from texture coordinates to world coordinates
// This function finds the 2D position that matches the
// given pixel of the render-texture. In other words, it does
// the inverse of what the graphics card does, to find the
// initial position of a rendered pixel.
// Initially, both coordinate systems (world units and target pixels)
// match perfectly. But if you define a custom view or resize your
// render-texture, this assertion is not true anymore, ie. a point
// located at (10, 50) in your render-texture may map to the point
// (150, 75) in your 2D world -- if the view is translated by (140, 25).
// This version uses a custom view for calculations, see the other
// overload of the function if you want to use the current view of the
// render-texture.
pub fn (r &RenderTexture) map_pixel_to_coords(point system.Vector2i, view &View) system.Vector2f {
	unsafe {
		return system.Vector2f(C.sfRenderTexture_mapPixelToCoords(&C.sfRenderTexture(r),
			*&C.sfVector2i(&point), &C.sfView(view)))
	}
}

// map_coords_to_pixel: convert a point from world coordinates to texture coordinates
// This function finds the pixel of the render-texture that matches
// the given 2D point. In other words, it goes through the same process
// as the graphics card, to compute the final position of a rendered point.
// Initially, both coordinate systems (world units and target pixels)
// match perfectly. But if you define a custom view or resize your
// render-texture, this assertion is not true anymore, ie. a point
// located at (150, 75) in your 2D world may map to the pixel
// (10, 50) of your render-texture -- if the view is translated by (140, 25).
// This version uses a custom view for calculations, see the other
// overload of the function if you want to use the current view of the
// render-texture.
pub fn (r &RenderTexture) map_coords_to_pixel(point system.Vector2f, view &View) system.Vector2i {
	unsafe {
		return system.Vector2i(C.sfRenderTexture_mapCoordsToPixel(&C.sfRenderTexture(r),
			*&C.sfVector2f(&point), &C.sfView(view)))
	}
}

// draw_sprite: draw a drawable object to the render-target
pub fn (r &RenderTexture) draw_sprite(params RenderTextureDrawSpriteParams) {
	unsafe {
		C.sfRenderTexture_drawSprite(&C.sfRenderTexture(r), &C.sfSprite(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderTextureDrawSpriteParams: parameters for draw_sprite
pub struct RenderTextureDrawSpriteParams {
pub:
	object &Sprite       [required] // object to draw
	states &RenderStates = C.NULL // render states to use for drawing (NULL to use the default states)
}

// draw_text
pub fn (r &RenderTexture) draw_text(params RenderTextureDrawTextParams) {
	unsafe {
		C.sfRenderTexture_drawText(&C.sfRenderTexture(r), &C.sfText(params.object), &C.sfRenderStates(params.states))
	}
}

// RenderTextureDrawTextParams: parameters for draw_text
pub struct RenderTextureDrawTextParams {
pub:
	object &Text         [required]
	states &RenderStates = C.NULL
}

// draw_shape
pub fn (r &RenderTexture) draw_shape(params RenderTextureDrawShapeParams) {
	unsafe {
		C.sfRenderTexture_drawShape(&C.sfRenderTexture(r), &C.sfShape(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderTextureDrawShapeParams: parameters for draw_shape
pub struct RenderTextureDrawShapeParams {
pub:
	object &Shape        [required]
	states &RenderStates = C.NULL
}

// draw_circle_shape
pub fn (r &RenderTexture) draw_circle_shape(params RenderTextureDrawCircleShapeParams) {
	unsafe {
		C.sfRenderTexture_drawCircleShape(&C.sfRenderTexture(r), &C.sfCircleShape(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderTextureDrawCircleShapeParams: parameters for draw_circle_shape
pub struct RenderTextureDrawCircleShapeParams {
pub:
	object &CircleShape  [required]
	states &RenderStates = C.NULL
}

// draw_convex_shape
pub fn (r &RenderTexture) draw_convex_shape(params RenderTextureDrawConvexShapeParams) {
	unsafe {
		C.sfRenderTexture_drawConvexShape(&C.sfRenderTexture(r), &C.sfConvexShape(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderTextureDrawConvexShapeParams: parameters for draw_convex_shape
pub struct RenderTextureDrawConvexShapeParams {
pub:
	object &ConvexShape  [required]
	states &RenderStates = C.NULL
}

// draw_rectangle_shape
pub fn (r &RenderTexture) draw_rectangle_shape(params RenderTextureDrawRectangleShapeParams) {
	unsafe {
		C.sfRenderTexture_drawRectangleShape(&C.sfRenderTexture(r), &C.sfRectangleShape(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderTextureDrawRectangleShapeParams: parameters for draw_rectangle_shape
pub struct RenderTextureDrawRectangleShapeParams {
pub:
	object &RectangleShape [required]
	states &RenderStates = C.NULL
}

// draw_vertex_array
pub fn (r &RenderTexture) draw_vertex_array(params RenderTextureDrawVertexArrayParams) {
	unsafe {
		C.sfRenderTexture_drawVertexArray(&C.sfRenderTexture(r), &C.sfVertexArray(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderTextureDrawVertexArrayParams: parameters for draw_vertex_array
pub struct RenderTextureDrawVertexArrayParams {
pub:
	object &VertexArray  [required]
	states &RenderStates = C.NULL
}

// draw_vertex_buffer
pub fn (r &RenderTexture) draw_vertex_buffer(params RenderTextureDrawVertexBufferParams) {
	unsafe {
		C.sfRenderTexture_drawVertexBuffer(&C.sfRenderTexture(r), &C.sfVertexBuffer(params.object),
			&C.sfRenderStates(params.states))
	}
}

// RenderTextureDrawVertexBufferParams: parameters for draw_vertex_buffer
pub struct RenderTextureDrawVertexBufferParams {
pub:
	object &VertexBuffer [required]
	states &RenderStates = C.NULL
}

// draw_primitives: draw primitives defined by an array of vertices to a render texture
pub fn (r &RenderTexture) draw_primitives(params RenderTextureDrawPrimitivesParams) {
	unsafe {
		C.sfRenderTexture_drawPrimitives(&C.sfRenderTexture(r), &C.sfVertex(params.vertices),
			usize(params.vertex_count), *&C.sfPrimitiveType(&params.primitive_type), &C.sfRenderStates(params.states))
	}
}

// RenderTextureDrawPrimitivesParams: parameters for draw_primitives
pub struct RenderTextureDrawPrimitivesParams {
pub:
	vertices       &Vertex       [required]       // pointer to the vertices
	vertex_count   u64           [required]           // number of vertices in the array
	primitive_type PrimitiveType [required] // type of primitives to draw
	states         &RenderStates = C.NULL // render states to use for drawing (NULL to use the default states)
}

// push_gl_states: save the current OpenGL render states and matrices
// This function can be used when you mix SFML drawing
// and direct OpenGL rendering. Combined with popGLStates,
// it ensures that:
pub fn (r &RenderTexture) push_gl_states() {
	unsafe {
		C.sfRenderTexture_pushGLStates(&C.sfRenderTexture(r))
	}
}

// pop_gl_states: restore the previously saved OpenGL render states and matrices
// See the description of pushGLStates to get a detailed
// description of these functions.
pub fn (r &RenderTexture) pop_gl_states() {
	unsafe {
		C.sfRenderTexture_popGLStates(&C.sfRenderTexture(r))
	}
}

// reset_gl_states: reset the internal OpenGL states so that the target is ready for drawing
// This function can be used when you mix SFML drawing
// and direct OpenGL rendering, if you choose not to use
// pushGLStates/popGLStates. It makes sure that all OpenGL
// states needed by SFML are set, so that subsequent draw*()
// calls will work as expected.
pub fn (r &RenderTexture) reset_gl_states() {
	unsafe {
		C.sfRenderTexture_resetGLStates(&C.sfRenderTexture(r))
	}
}

// get_texture: get the target texture of a render texture
pub fn (r &RenderTexture) get_texture() !&Texture {
	unsafe {
		result := &Texture(C.sfRenderTexture_getTexture(&C.sfRenderTexture(r)))
		if voidptr(result) == C.NULL {
			return error('get_texture failed')
		}
		return result
	}
}

// set_smooth: enable or disable the smooth filter on a render texture
pub fn (r &RenderTexture) set_smooth(smooth bool) {
	unsafe {
		C.sfRenderTexture_setSmooth(&C.sfRenderTexture(r), int(smooth))
	}
}

// is_smooth: tell whether the smooth filter is enabled or not for a render texture
pub fn (r &RenderTexture) is_smooth() bool {
	unsafe {
		return C.sfRenderTexture_isSmooth(&C.sfRenderTexture(r)) != 0
	}
}

// set_repeated: enable or disable texture repeating
pub fn (r &RenderTexture) set_repeated(repeated bool) {
	unsafe {
		C.sfRenderTexture_setRepeated(&C.sfRenderTexture(r), int(repeated))
	}
}

// is_repeated: tell whether the texture is repeated or not
pub fn (r &RenderTexture) is_repeated() bool {
	unsafe {
		return C.sfRenderTexture_isRepeated(&C.sfRenderTexture(r)) != 0
	}
}

// generate_mipmap: generate a mipmap using the current texture data
// This function is similar to generateMipmap and operates
// on the texture used as the target for drawing.
// Be aware that any draw operation may modify the base level image data.
// For this reason, calling this function only makes sense after all
// drawing is completed and display has been called. Not calling display
// after subsequent drawing will lead to undefined behavior if a mipmap
// had been previously generated.
pub fn (r &RenderTexture) generate_mipmap() bool {
	unsafe {
		return C.sfRenderTexture_generateMipmap(&C.sfRenderTexture(r)) != 0
	}
}
