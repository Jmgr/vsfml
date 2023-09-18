module graphics

import vsfml.system

#include <SFML/Graphics/Shader.h>

fn C.sfShader_createFromFile(&char, &char, &char) &C.sfShader
fn C.sfShader_createFromMemory(&char, &char, &char) &C.sfShader
fn C.sfShader_createFromStream(&C.sfInputStream, &C.sfInputStream, &C.sfInputStream) &C.sfShader
fn C.sfShader_destroy(&C.sfShader)
fn C.sfShader_setFloatUniform(&C.sfShader, &char, f32)
fn C.sfShader_setVec2Uniform(&C.sfShader, &char, C.sfGlslVec2)
fn C.sfShader_setVec3Uniform(&C.sfShader, &char, C.sfGlslVec3)
fn C.sfShader_setVec4Uniform(&C.sfShader, &char, C.sfGlslVec4)
fn C.sfShader_setColorUniform(&C.sfShader, &char, C.sfColor)
fn C.sfShader_setIntUniform(&C.sfShader, &char, int)
fn C.sfShader_setIvec2Uniform(&C.sfShader, &char, C.sfGlslIvec2)
fn C.sfShader_setIvec3Uniform(&C.sfShader, &char, C.sfGlslIvec3)
fn C.sfShader_setIvec4Uniform(&C.sfShader, &char, C.sfGlslIvec4)
fn C.sfShader_setIntColorUniform(&C.sfShader, &char, C.sfColor)
fn C.sfShader_setBoolUniform(&C.sfShader, &char, int)
fn C.sfShader_setBvec2Uniform(&C.sfShader, &char, C.sfGlslBvec2)
fn C.sfShader_setBvec3Uniform(&C.sfShader, &char, C.sfGlslBvec3)
fn C.sfShader_setBvec4Uniform(&C.sfShader, &char, C.sfGlslBvec4)
fn C.sfShader_setMat3Uniform(&C.sfShader, &char, &C.sfGlslMat3)
fn C.sfShader_setMat4Uniform(&C.sfShader, &char, &C.sfGlslMat4)
fn C.sfShader_setTextureUniform(&C.sfShader, &char, &C.sfTexture)
fn C.sfShader_setCurrentTextureUniform(&C.sfShader, &char)
fn C.sfShader_setFloatUniformArray(&C.sfShader, &char, &f32, usize)
fn C.sfShader_setVec2UniformArray(&C.sfShader, &char, &C.sfGlslVec2, usize)
fn C.sfShader_setVec3UniformArray(&C.sfShader, &char, &C.sfGlslVec3, usize)
fn C.sfShader_setVec4UniformArray(&C.sfShader, &char, &C.sfGlslVec4, usize)
fn C.sfShader_setMat3UniformArray(&C.sfShader, &char, &C.sfGlslMat3, usize)
fn C.sfShader_setMat4UniformArray(&C.sfShader, &char, &C.sfGlslMat4, usize)
fn C.sfShader_bind(&C.sfShader)
fn C.sfShader_isAvailable() int
fn C.sfShader_isGeometryAvailable() int

// new_shader_from_file: load the vertex, geometry and fragment shaders from files
// This function loads the vertex, geometry and fragment
// shaders. Pass NULL if you don't want to load
// a specific shader.
// The sources must be text files containing valid shaders
// in GLSL language. GLSL is a C-like language dedicated to
// OpenGL shaders; you'll probably need to read a good documentation
// for it before writing your own shaders.
pub fn new_shader_from_file(params ShaderNewShaderFromFileParams) !&Shader {
	unsafe {
		result := &Shader(C.sfShader_createFromFile(params.vertex_shader_filename.str,
			params.geometry_shader_filename.str, params.fragment_shader_filename.str))
		if voidptr(result) == C.NULL {
			return error('new_shader_from_file failed with vertex_shader_filename=${params.vertex_shader_filename} geometry_shader_filename=${params.geometry_shader_filename} fragment_shader_filename=${params.fragment_shader_filename}')
		}
		return result
	}
}

// ShaderNewShaderFromFileParams: parameters for new_shader_from_file
pub struct ShaderNewShaderFromFileParams {
pub:
	vertex_shader_filename   string // path of the vertex shader file to load, or NULL to skip this shader
	geometry_shader_filename string // path of the geometry shader file to load, or NULL to skip this shader
	fragment_shader_filename string // path of the fragment shader file to load, or NULL to skip this shader
}

// new_shader_from_memory: load the vertex, geometry and fragment shaders from source code in memory
// This function loads the vertex, geometry and fragment
// shaders. Pass NULL if you don't want to load
// a specific shader.
// The sources must be valid shaders in GLSL language. GLSL is
// a C-like language dedicated to OpenGL shaders; you'll
// probably need to read a good documentation for it before
// writing your own shaders.
pub fn new_shader_from_memory(params ShaderNewShaderFromMemoryParams) !&Shader {
	unsafe {
		result := &Shader(C.sfShader_createFromMemory(params.vertex_shader.str, params.geometry_shader.str,
			params.fragment_shader.str))
		if voidptr(result) == C.NULL {
			return error('new_shader_from_memory failed with vertex_shader=${params.vertex_shader} geometry_shader=${params.geometry_shader} fragment_shader=${params.fragment_shader}')
		}
		return result
	}
}

// ShaderNewShaderFromMemoryParams: parameters for new_shader_from_memory
pub struct ShaderNewShaderFromMemoryParams {
pub:
	vertex_shader   string // string containing the source code of the vertex shader, or NULL to skip this shader
	geometry_shader string // string containing the source code of the geometry shader, or NULL to skip this shader
	fragment_shader string // string containing the source code of the fragment shader, or NULL to skip this shader
}

// new_shader_from_stream: load the vertex, geometry and fragment shaders from custom streams
// This function loads the vertex, geometry and fragment
// shaders. Pass NULL if you don't want to load
// a specific shader.
// The source codes must be valid shaders in GLSL language.
// GLSL is a C-like language dedicated to OpenGL shaders;
// you'll probably need to read a good documentation for
// it before writing your own shaders.
pub fn new_shader_from_stream(params ShaderNewShaderFromStreamParams) !&Shader {
	unsafe {
		result := &Shader(C.sfShader_createFromStream(&C.sfInputStream(params.vertex_shader_stream),
			&C.sfInputStream(params.geometry_shader_stream), &C.sfInputStream(params.fragment_shader_stream)))
		if voidptr(result) == C.NULL {
			return error('new_shader_from_stream failed')
		}
		return result
	}
}

// ShaderNewShaderFromStreamParams: parameters for new_shader_from_stream
pub struct ShaderNewShaderFromStreamParams {
pub:
	vertex_shader_stream   &system.InputStream = C.NULL // source stream to read the vertex shader from, or NULL to skip this shader
	geometry_shader_stream &system.InputStream = C.NULL // source stream to read the geometry shader from, or NULL to skip this shader
	fragment_shader_stream &system.InputStream = C.NULL // source stream to read the fragment shader from, or NULL to skip this shader
}

// free: destroy an existing shader
[unsafe]
pub fn (s &Shader) free() {
	unsafe {
		C.sfShader_destroy(&C.sfShader(s))
	}
}

// set_float_uniform: specify value for \p float uniform
pub fn (s &Shader) set_float_uniform(name string, x f32) {
	unsafe {
		C.sfShader_setFloatUniform(&C.sfShader(s), name.str, f32(x))
	}
}

// setvec2uniform: specify value for \p vec2 uniform
pub fn (s &Shader) setvec2uniform(name string, vector GlslVec2) {
	unsafe {
		C.sfShader_setVec2Uniform(&C.sfShader(s), name.str, *&C.sfGlslVec2(&vector))
	}
}

// setvec3uniform: specify value for \p vec3 uniform
pub fn (s &Shader) setvec3uniform(name string, vector GlslVec3) {
	unsafe {
		C.sfShader_setVec3Uniform(&C.sfShader(s), name.str, *&C.sfGlslVec3(&vector))
	}
}

// setvec4uniform: specify value for \p vec4 uniform
// Color objects can be passed to this function via
// the use of fromsfColor(sfColor);
pub fn (s &Shader) setvec4uniform(name string, vector GlslVec4) {
	unsafe {
		C.sfShader_setVec4Uniform(&C.sfShader(s), name.str, *&C.sfGlslVec4(&vector))
	}
}

// set_color_uniform: specify value for \p vec4 uniform
pub fn (s &Shader) set_color_uniform(name string, color Color) {
	unsafe {
		C.sfShader_setColorUniform(&C.sfShader(s), name.str, *&C.sfColor(&color))
	}
}

// set_int_uniform: specify value for \p int uniform
pub fn (s &Shader) set_int_uniform(name string, x int) {
	unsafe {
		C.sfShader_setIntUniform(&C.sfShader(s), name.str, int(x))
	}
}

// setivec2uniform: specify value for \p ivec2 uniform
pub fn (s &Shader) setivec2uniform(name string, vector GlslIvec2) {
	unsafe {
		C.sfShader_setIvec2Uniform(&C.sfShader(s), name.str, *&C.sfGlslIvec2(&vector))
	}
}

// setivec3uniform: specify value for \p ivec3 uniform
pub fn (s &Shader) setivec3uniform(name string, vector GlslIvec3) {
	unsafe {
		C.sfShader_setIvec3Uniform(&C.sfShader(s), name.str, *&C.sfGlslIvec3(&vector))
	}
}

// setivec4uniform: specify value for \p ivec4 uniform
// Color objects can be passed to this function via
// the use of fromsfColor(sfColor);
pub fn (s &Shader) setivec4uniform(name string, vector GlslIvec4) {
	unsafe {
		C.sfShader_setIvec4Uniform(&C.sfShader(s), name.str, *&C.sfGlslIvec4(&vector))
	}
}

// set_int_color_uniform: specify value for \p ivec4 uniform
pub fn (s &Shader) set_int_color_uniform(name string, color Color) {
	unsafe {
		C.sfShader_setIntColorUniform(&C.sfShader(s), name.str, *&C.sfColor(&color))
	}
}

// set_bool_uniform: specify value for \p bool uniform
pub fn (s &Shader) set_bool_uniform(name string, x bool) {
	unsafe {
		C.sfShader_setBoolUniform(&C.sfShader(s), name.str, int(x))
	}
}

// setbvec2uniform: specify value for \p bvec2 uniform
pub fn (s &Shader) setbvec2uniform(name string, vector GlslBvec2) {
	unsafe {
		C.sfShader_setBvec2Uniform(&C.sfShader(s), name.str, *&C.sfGlslBvec2(&vector))
	}
}

// setbvec3uniform: specify value for \p Bvec3 uniform
pub fn (s &Shader) setbvec3uniform(name string, vector GlslBvec3) {
	unsafe {
		C.sfShader_setBvec3Uniform(&C.sfShader(s), name.str, *&C.sfGlslBvec3(&vector))
	}
}

// setbvec4uniform: specify value for \p bvec4 uniform
// Color objects can be passed to this function via
// the use of fromsfColor(sfColor);
pub fn (s &Shader) setbvec4uniform(name string, vector GlslBvec4) {
	unsafe {
		C.sfShader_setBvec4Uniform(&C.sfShader(s), name.str, *&C.sfGlslBvec4(&vector))
	}
}

// setmat3uniform: specify value for \p mat3 matrix
pub fn (s &Shader) setmat3uniform(name string, matrix &GlslMat3) {
	unsafe {
		C.sfShader_setMat3Uniform(&C.sfShader(s), name.str, &C.sfGlslMat3(matrix))
	}
}

// setmat4uniform: specify value for \p mat4 matrix
pub fn (s &Shader) setmat4uniform(name string, matrix &GlslMat4) {
	unsafe {
		C.sfShader_setMat4Uniform(&C.sfShader(s), name.str, &C.sfGlslMat4(matrix))
	}
}

// set_texture_uniform: specify a texture as \p sampler2D uniform
pub fn (s &Shader) set_texture_uniform(name string, texture &Texture) {
	unsafe {
		C.sfShader_setTextureUniform(&C.sfShader(s), name.str, &C.sfTexture(texture))
	}
}

// set_current_texture_uniform: specify current texture as \p sampler2D uniform
// This overload maps a shader texture variable to the
// texture of the object being drawn, which cannot be
// known in advance.
// The corresponding parameter in the shader must be a 2D texture
// (\p sampler2D GLSL type).
pub fn (s &Shader) set_current_texture_uniform(name string) {
	unsafe {
		C.sfShader_setCurrentTextureUniform(&C.sfShader(s), name.str)
	}
}

// set_float_uniform_array: specify values for \p float[] array uniform
pub fn (s &Shader) set_float_uniform_array(params ShaderSetFloatUniformArrayParams) {
	unsafe {
		C.sfShader_setFloatUniformArray(&C.sfShader(s), params.name.str, &f32(params.scalar_array),
			usize(params.length))
	}
}

// ShaderSetFloatUniformArrayParams: parameters for set_float_uniform_array
pub struct ShaderSetFloatUniformArrayParams {
pub:
	name         string [required] // name of the uniform variable in GLSL
	scalar_array &f32   [required]   // pointer to array of \p float values
	length       u64    [required]    // number of elements in the array
}

// setvec2uniformarray: specify values for \p vec2[] array uniform
pub fn (s &Shader) setvec2uniformarray(params ShaderSetvec2uniformarrayParams) {
	unsafe {
		C.sfShader_setVec2UniformArray(&C.sfShader(s), params.name.str, &C.sfGlslVec2(params.vector_array),
			usize(params.length))
	}
}

// ShaderSetvec2uniformarrayParams: parameters for setvec2uniformarray
pub struct ShaderSetvec2uniformarrayParams {
pub:
	name         string    [required]    // name of the uniform variable in GLSL
	vector_array &GlslVec2 [required] // pointer to array of \p vec2 values
	length       u64       [required]       // number of elements in the array
}

// setvec3uniformarray: specify values for \p vec3[] array uniform
pub fn (s &Shader) setvec3uniformarray(params ShaderSetvec3uniformarrayParams) {
	unsafe {
		C.sfShader_setVec3UniformArray(&C.sfShader(s), params.name.str, &C.sfGlslVec3(params.vector_array),
			usize(params.length))
	}
}

// ShaderSetvec3uniformarrayParams: parameters for setvec3uniformarray
pub struct ShaderSetvec3uniformarrayParams {
pub:
	name         string    [required]    // name of the uniform variable in GLSL
	vector_array &GlslVec3 [required] // pointer to array of \p vec3 values
	length       u64       [required]       // number of elements in the array
}

// setvec4uniformarray: specify values for \p vec4[] array uniform
pub fn (s &Shader) setvec4uniformarray(params ShaderSetvec4uniformarrayParams) {
	unsafe {
		C.sfShader_setVec4UniformArray(&C.sfShader(s), params.name.str, &C.sfGlslVec4(params.vector_array),
			usize(params.length))
	}
}

// ShaderSetvec4uniformarrayParams: parameters for setvec4uniformarray
pub struct ShaderSetvec4uniformarrayParams {
pub:
	name         string    [required]    // name of the uniform variable in GLSL
	vector_array &GlslVec4 [required] // pointer to array of \p vec4 values
	length       u64       [required]       // number of elements in the array
}

// setmat3uniformarray: specify values for \p mat3[] array uniform
pub fn (s &Shader) setmat3uniformarray(params ShaderSetmat3uniformarrayParams) {
	unsafe {
		C.sfShader_setMat3UniformArray(&C.sfShader(s), params.name.str, &C.sfGlslMat3(params.matrix_array),
			usize(params.length))
	}
}

// ShaderSetmat3uniformarrayParams: parameters for setmat3uniformarray
pub struct ShaderSetmat3uniformarrayParams {
pub:
	name         string    [required]    // name of the uniform variable in GLSL
	matrix_array &GlslMat3 [required] // pointer to array of \p mat3 values
	length       u64       [required]       // number of elements in the array
}

// setmat4uniformarray: specify values for \p mat4[] array uniform
pub fn (s &Shader) setmat4uniformarray(params ShaderSetmat4uniformarrayParams) {
	unsafe {
		C.sfShader_setMat4UniformArray(&C.sfShader(s), params.name.str, &C.sfGlslMat4(params.matrix_array),
			usize(params.length))
	}
}

// ShaderSetmat4uniformarrayParams: parameters for setmat4uniformarray
pub struct ShaderSetmat4uniformarrayParams {
pub:
	name         string    [required]    // name of the uniform variable in GLSL
	matrix_array &GlslMat4 [required] // pointer to array of \p mat4 values
	length       u64       [required]       // number of elements in the array
}

// bind: bind a shader for rendering (activate it)
// This function is not part of the graphics API, it mustn't be
// used when drawing SFML entities. It must be used only if you
// mix Shader with OpenGL code.
pub fn (s &Shader) bind() {
	unsafe {
		C.sfShader_bind(&C.sfShader(s))
	}
}

// shader_is_available: tell whether or not the system supports shaders
// This function should always be called before using
// the shader features. If it returns false, then
// any attempt to use Shader will fail.
pub fn shader_is_available() bool {
	unsafe {
		return C.sfShader_isAvailable() != 0
	}
}

// shader_is_geometry_available: tell whether or not the system supports geometry shaders
// This function should always be called before using
// the geometry shader features. If it returns false, then
// any attempt to use Shader geometry shader features will fail.
// This function can only return true if isAvailable() would also
// return true, since shaders in general have to be supported in
// order for geometry shaders to be supported as well.
// Note: The first call to this function, whether by your
// code or SFML will result in a context switch.
pub fn shader_is_geometry_available() bool {
	unsafe {
		return C.sfShader_isGeometryAvailable() != 0
	}
}
