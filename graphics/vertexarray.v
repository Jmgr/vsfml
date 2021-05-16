module graphics

#include <SFML/Graphics/VertexArray.h>

fn C.sfVertexArray_create() &C.sfVertexArray
fn C.sfVertexArray_copy(&C.sfVertexArray) &C.sfVertexArray
fn C.sfVertexArray_destroy(&C.sfVertexArray)
fn C.sfVertexArray_getVertexCount(&C.sfVertexArray) size_t
fn C.sfVertexArray_getVertex(&C.sfVertexArray, size_t) &C.sfVertex
fn C.sfVertexArray_clear(&C.sfVertexArray)
fn C.sfVertexArray_resize(&C.sfVertexArray, size_t)
fn C.sfVertexArray_append(&C.sfVertexArray, C.sfVertex)
fn C.sfVertexArray_setPrimitiveType(&C.sfVertexArray, C.sfPrimitiveType)
fn C.sfVertexArray_getPrimitiveType(&C.sfVertexArray) C.sfPrimitiveType
fn C.sfVertexArray_getBounds(&C.sfVertexArray) C.sfFloatRect

// new_vertex_array: create a new vertex array
pub fn new_vertex_array() ?&VertexArray {
	unsafe {
		result := &VertexArray(C.sfVertexArray_create())
		if voidptr(result) == C.NULL {
			return error('new_vertex_array failed')
		}
		return result
	}
}

// copy: copy an existing vertex array
pub fn (v &VertexArray) copy() ?&VertexArray {
	unsafe {
		result := &VertexArray(C.sfVertexArray_copy(&C.sfVertexArray(v)))
		if voidptr(result) == C.NULL {
			return error('copy failed')
		}
		return result
	}
}

// free: destroy an existing vertex array
[unsafe]
pub fn (v &VertexArray) free() {
	unsafe {
		C.sfVertexArray_destroy(&C.sfVertexArray(v))
	}
}

// get_vertex_count: return the vertex count of a vertex array
pub fn (v &VertexArray) get_vertex_count() u64 {
	unsafe {
		return u64(C.sfVertexArray_getVertexCount(&C.sfVertexArray(v)))
	}
}

// get_vertex: get access to a vertex by its index
// This function doesn't check index, it must be in range
// [0, vertex count - 1]. The behaviour is undefined
// otherwise.
pub fn (v &VertexArray) get_vertex(index u64) ?&Vertex {
	unsafe {
		result := &Vertex(C.sfVertexArray_getVertex(&C.sfVertexArray(v), size_t(index)))
		if voidptr(result) == C.NULL {
			return error('get_vertex failed with index=$index')
		}
		return result
	}
}

// clear: clear a vertex array
// This function removes all the vertices from the array.
// It doesn't deallocate the corresponding memory, so that
// adding new vertices after clearing doesn't involve
// reallocating all the memory.
pub fn (v &VertexArray) clear() {
	unsafe {
		C.sfVertexArray_clear(&C.sfVertexArray(v))
	}
}

// resize: resize the vertex array
// If vertexCount is greater than the current size, the previous
// vertices are kept and new (default-constructed) vertices are
// added.
// If vertexCount is less than the current size, existing vertices
// are removed from the array.
pub fn (v &VertexArray) resize(vertexCount u64) {
	unsafe {
		C.sfVertexArray_resize(&C.sfVertexArray(v), size_t(vertexCount))
	}
}

// append: add a vertex to a vertex array array
pub fn (v &VertexArray) append(vertex Vertex) {
	unsafe {
		C.sfVertexArray_append(&C.sfVertexArray(v), C.sfVertex(vertex))
	}
}

// set_primitive_type: set the type of primitives of a vertex array
// This function defines how the vertices must be interpreted
// when it's time to draw them:
pub fn (v &VertexArray) set_primitive_type(primitiveType PrimitiveType) {
	unsafe {
		C.sfVertexArray_setPrimitiveType(&C.sfVertexArray(v), C.sfPrimitiveType(primitiveType))
	}
}

// get_primitive_type: get the type of primitives drawn by a vertex array
pub fn (v &VertexArray) get_primitive_type() PrimitiveType {
	unsafe {
		return PrimitiveType(C.sfVertexArray_getPrimitiveType(&C.sfVertexArray(v)))
	}
}

// get_bounds: compute the bounding rectangle of a vertex array
// This function returns the axis-aligned rectangle that
// contains all the vertices of the array.
pub fn (v &VertexArray) get_bounds() FloatRect {
	unsafe {
		return FloatRect(C.sfVertexArray_getBounds(&C.sfVertexArray(v)))
	}
}
