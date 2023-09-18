module graphics

#include <SFML/Graphics/VertexBuffer.h>

// VertexBufferUsage: usage specifiers
// If data is going to be updated once or more every frame,
// set the usage to VertexBufferStream. If data is going
// to be set once and used for a long time without being
// modified, set the usage to VertexBufferUsageStatic.
// For everything else VertexBufferUsageDynamic should
// be a good compromise.
pub enum VertexBufferUsage {
	stream // Constantly changing data
	dynamic // Occasionally changing data
	@static // Rarely changing data
}

fn C.sfVertexBuffer_create(u32, C.sfPrimitiveType, C.sfVertexBufferUsage) &C.sfVertexBuffer
fn C.sfVertexBuffer_copy(&C.sfVertexBuffer) &C.sfVertexBuffer
fn C.sfVertexBuffer_destroy(&C.sfVertexBuffer)
fn C.sfVertexBuffer_update(&C.sfVertexBuffer, &C.sfVertex, u32, u32) int
fn C.sfVertexBuffer_updateFromVertexBuffer(&C.sfVertexBuffer, &C.sfVertexBuffer) int
fn C.sfVertexBuffer_swap(&C.sfVertexBuffer, &C.sfVertexBuffer)
fn C.sfVertexBuffer_setPrimitiveType(&C.sfVertexBuffer, C.sfPrimitiveType)
fn C.sfVertexBuffer_getPrimitiveType(&C.sfVertexBuffer) C.sfPrimitiveType
fn C.sfVertexBuffer_setUsage(&C.sfVertexBuffer, C.sfVertexBufferUsage)
fn C.sfVertexBuffer_getUsage(&C.sfVertexBuffer) C.sfVertexBufferUsage
fn C.sfVertexBuffer_bind(&C.sfVertexBuffer)
fn C.sfVertexBuffer_isAvailable() int

// new_vertex_buffer: create a new vertex buffer with a specific
// PrimitiveType and usage specifier.
// Creates the vertex buffer, allocating enough graphcis
// memory to hold \p vertexCount vertices, and sets its
// primitive type to \p type and usage to \p usage.
pub fn new_vertex_buffer(params VertexBufferNewVertexBufferParams) !&VertexBuffer {
	unsafe {
		result := &VertexBuffer(C.sfVertexBuffer_create(u32(params.vertex_count), *&C.sfPrimitiveType(&params.primitive_type),
			*&C.sfVertexBufferUsage(&params.usage)))
		if voidptr(result) == C.NULL {
			return error('new_vertex_buffer failed with vertex_count=${params.vertex_count} primitive_type=${params.primitive_type} usage=${params.usage}')
		}
		return result
	}
}

// VertexBufferNewVertexBufferParams: parameters for new_vertex_buffer
pub struct VertexBufferNewVertexBufferParams {
pub:
	vertex_count   u32               [required] // amount of vertices
	primitive_type PrimitiveType     [required]     // type of primitive
	usage          VertexBufferUsage [required] // usage specifier
}

// copy: copy an existing vertex buffer
pub fn (v &VertexBuffer) copy() !&VertexBuffer {
	unsafe {
		result := &VertexBuffer(C.sfVertexBuffer_copy(&C.sfVertexBuffer(v)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing vertex buffer
[unsafe]
pub fn (v &VertexBuffer) free() {
	unsafe {
		C.sfVertexBuffer_destroy(&C.sfVertexBuffer(v))
	}
}

// update: update a part of the buffer from an array of vertices
pub fn (v &VertexBuffer) update(params VertexBufferUpdateParams) bool {
	unsafe {
		return C.sfVertexBuffer_update(&C.sfVertexBuffer(v), &C.sfVertex(params.vertices),
			u32(params.vertex_count), u32(params.offset)) != 0
	}
}

// VertexBufferUpdateParams: parameters for update
pub struct VertexBufferUpdateParams {
pub:
	vertices     &Vertex [required] // number of vertices to copy
	vertex_count u32     [required]     // offset in the buffer to copy to
	offset       u32     [required]
}

// update_from_vertex_buffer: copy the contents of another buffer into this buffer
pub fn (v &VertexBuffer) update_from_vertex_buffer(other &VertexBuffer) bool {
	unsafe {
		return C.sfVertexBuffer_updateFromVertexBuffer(&C.sfVertexBuffer(v), &C.sfVertexBuffer(other)) != 0
	}
}

// swap: swap the contents of this vertex buffer with those of another
pub fn (v &VertexBuffer) swap(right &VertexBuffer) {
	unsafe {
		C.sfVertexBuffer_swap(&C.sfVertexBuffer(v), &C.sfVertexBuffer(right))
	}
}

// set_primitive_type: set the type of primitives to draw
// This function defines how the vertices must be interpreted
// when it's time to draw them.
// The default primitive type is sf::Points.
pub fn (v &VertexBuffer) set_primitive_type(primitiveType PrimitiveType) {
	unsafe {
		C.sfVertexBuffer_setPrimitiveType(&C.sfVertexBuffer(v), *&C.sfPrimitiveType(&primitiveType))
	}
}

// get_primitive_type: get the type of primitives drawn by the vertex buffer
pub fn (v &VertexBuffer) get_primitive_type() PrimitiveType {
	unsafe {
		return PrimitiveType(C.sfVertexBuffer_getPrimitiveType(&C.sfVertexBuffer(v)))
	}
}

// set_usage: set the usage specifier of this vertex buffer
// This function provides a hint about how this vertex buffer is
// going to be used in terms of data update frequency.
// After changing the usage specifier, the vertex buffer has
// to be updated with new data for the usage specifier to
// take effect.
// The default primitive type is VertexBufferStream.
pub fn (v &VertexBuffer) set_usage(usage VertexBufferUsage) {
	unsafe {
		C.sfVertexBuffer_setUsage(&C.sfVertexBuffer(v), *&C.sfVertexBufferUsage(&usage))
	}
}

// get_usage: get the usage specifier of this vertex buffer
pub fn (v &VertexBuffer) get_usage() VertexBufferUsage {
	unsafe {
		return VertexBufferUsage(C.sfVertexBuffer_getUsage(&C.sfVertexBuffer(v)))
	}
}

// bind: bind a vertex buffer for rendering
// This function is not part of the graphics API, it mustn't be
// used when drawing SFML entities. It must be used only if you
// mix VertexBuffer with OpenGL code.
pub fn (v &VertexBuffer) bind() {
	unsafe {
		C.sfVertexBuffer_bind(&C.sfVertexBuffer(v))
	}
}

// vertexbuffer_is_available: tell whether or not the system supports vertex buffers
// This function should always be called before using
// the vertex buffer features. If it returns false, then
// any attempt to use sf::VertexBuffer will fail.
pub fn vertexbuffer_is_available() bool {
	unsafe {
		return C.sfVertexBuffer_isAvailable() != 0
	}
}
