module main

import rand
import math
import vsfml.system
import vsfml.graphics
import vsfml.window
import vsfml.audio

// Define some constants
const (
	game_width   = 800
	game_height  = 600
	paddle_size  = system.Vector2f{25, 100}
	ball_radius  = 10.
	ai_time      = system.seconds(0.1)
	paddle_speed = 400.
	ball_speed   = 400.
)

struct Tennis {
	ball_sound    &audio.Sound
	sfml_logo     &graphics.Sprite
	left_paddle   &graphics.RectangleShape
	right_paddle  &graphics.RectangleShape
	ball          &graphics.CircleShape
	pause_message &graphics.Text
	win           &graphics.RenderWindow
mut:
	is_playing         bool
	clock              &system.Clock
	ball_angle         f32
	right_paddle_speed f32
	ai_timer           &system.Clock
}

fn new_tennis() ?Tennis {
	// Create the window of the application
	win := graphics.new_render_window(
		mode: window.VideoMode{game_width, game_height, 32}
		title: 'SFML Tennis'
		style: u32(window.WindowStyle.titlebar) | u32(window.WindowStyle.close)
	) ?
	win.set_vertical_sync_enabled(true)

	// Load the sounds used in the game
	mut ball_sound_file := $embed_file('resources/ball.wav')
	ball_sound_buffer := audio.new_sound_buffer_from_memory(
		data: ball_sound_file.data()
		size_in_bytes: u64(ball_sound_file.len)
	) ?
	// loading from a file: ball_sound_buffer := audio.new_sound_buffer_from_file(filename: 'ball.wav') ?
	ball_sound := audio.new_sound() ?
	ball_sound.set_buffer(ball_sound_buffer)

	// Create the SFML logo texture:
	mut sfml_logo_file := $embed_file('resources/sfml_logo.png')
	sfml_logo_texture := graphics.new_texture_from_memory(
		data: sfml_logo_file.data()
		size_in_bytes: u64(sfml_logo_file.len)
	) ?
	sfml_logo := graphics.new_sprite() ?
	sfml_logo.set_texture(sfml_logo_texture, true)
	sfml_logo.set_position(system.Vector2f{170, 50})

	// Create the left paddle
	left_paddle := graphics.new_rectangle_shape() ?
	left_paddle.set_size(paddle_size - system.Vector2f{3, 3})
	left_paddle.set_outline_thickness(3)
	left_paddle.set_outline_color(graphics.color_black)
	left_paddle.set_fill_color(graphics.color_from_rgb(100, 100, 200))
	left_paddle.set_origin(x: paddle_size.x / 2., y: paddle_size.y / 2.)

	// Create the right paddle
	right_paddle := graphics.new_rectangle_shape() ?
	right_paddle.set_size(paddle_size - system.Vector2f{3, 3})
	right_paddle.set_outline_thickness(3)
	right_paddle.set_outline_color(graphics.color_black)
	right_paddle.set_fill_color(graphics.color_from_rgb(200, 100, 100))
	right_paddle.set_origin(x: paddle_size.x / 2., y: paddle_size.y / 2.)

	// Create the ball
	ball := graphics.new_circle_shape() ?
	ball.set_radius(ball_radius - 3)
	ball.set_outline_thickness(2)
	ball.set_outline_color(graphics.color_black)
	ball.set_fill_color(graphics.color_white)
	ball.set_origin(x: ball_radius / 2., y: ball_radius / 2.)

	// Load the text font
	mut font_file := $embed_file('resources/tuffy.ttf')
	font := graphics.new_font_from_memory(data: font_file.data(), size_in_bytes: u64(font_file.len)) ?

	// Initialize the pause message
	pause_message := graphics.new_text() ?
	pause_message.set_font(font)
	pause_message.set_character_size(40)
	pause_message.set_position(x: 170., y: 200.)
	pause_message.set_fill_color(graphics.color_white)

	$if ios {
		pause_message.set_string('Welcome to SFML Tennis!\nTouch the screen to start the game.')
	} $else {
		pause_message.set_string('Welcome to SFML Tennis!\n\nPress space to start the game.')
	}

	return Tennis{
		ball_sound: ball_sound
		sfml_logo: sfml_logo
		left_paddle: left_paddle
		right_paddle: right_paddle
		ball: ball
		pause_message: pause_message
		win: win
		clock: system.new_clock() ?
		ai_timer: system.new_clock() ?
	}
}

fn (mut t Tennis) game_loop() ? {
	for t.win.is_open() {
		// Handle events
		for {
			event := t.win.poll_event() or { break }
			match event {
				// Window closed or escape key pressed: exit
				window.CloseEvent {
					t.win.close()
					break
				}
				window.KeyPressedEvent {
					match event.code {
						.escape {
							t.win.close()
							break
						}
						.space {
							t.start_playing() ?
						}
						else {}
					}
				}
				window.TouchBeganEvent {
					t.start_playing() ?
				}
				window.SizeEvent {
					// Window size changed, adjust view appropriately
					view := graphics.new_view() ?
					view.set_size(x: game_width, y: game_height)
					view.set_center(x: game_width / 2, y: game_height / 2)
					t.win.set_view(view)
				}
				else {}
			}
		}

		t.play() ?

		// Clear the window
		t.win.clear(graphics.color_from_rgb(50, 50, 50))

		if t.is_playing {
			// Draw the paddles and the ball
			t.win.draw_rectangle_shape(object: t.left_paddle)
			t.win.draw_rectangle_shape(object: t.right_paddle)
			t.win.draw_circle_shape(object: t.ball)
		} else {
			// Draw the pause message
			t.win.draw_text(object: t.pause_message)
			t.win.draw_sprite(object: t.sfml_logo)
		}

		// Display things on screen
		t.win.display()
	}
}

fn (mut t Tennis) start_playing() ? {
	// Space key pressed: play
	if t.is_playing {
		return
	}

	// (re)start the game
	t.is_playing = true
	t.clock.restart()

	// Reset the position of the paddles and ball
	t.left_paddle.set_position(x: 10 + paddle_size.x / 2, y: game_height / 2)
	t.right_paddle.set_position(x: game_width - 10 - paddle_size.x / 2, y: game_height / 2)
	t.ball.set_position(x: game_width / 2, y: game_height / 2)

	// Reset the ball angle
	for {
		// Make sure the ball initial angle is not too much vertical
		t.ball_angle = f32(rand.int() % 360) * 2 * math.pi / 360

		if math.abs(math.cos(t.ball_angle)) >= 0.7 {
			break
		}
	}
}

fn (mut t Tennis) play() ? {
	if !t.is_playing {
		return
	}

	delta_time := t.clock.restart().as_seconds()

	// Move the player's paddle
	if window.keyboard_is_key_pressed(window.KeyCode.up)
		&& t.left_paddle.get_position().y - paddle_size.y / 2 > 5 {
		t.left_paddle.move(x: 0, y: -paddle_speed * delta_time)
	}
	if window.keyboard_is_key_pressed(window.KeyCode.down)
		&& t.left_paddle.get_position().y + paddle_size.y / 2 < game_height - 5 {
		t.left_paddle.move(x: 0, y: paddle_speed * delta_time)
	}

	if window.touch_is_down(0) {
		pos := graphics.touch_get_position_render_window(0, t.win)
		mapped_pos := t.win.map_pixel_to_coords(pos, t.win.get_view() ?)
		t.left_paddle.set_position(x: t.left_paddle.get_position().x, y: mapped_pos.y)
	}

	// Move the computer's paddle
	if (t.right_paddle_speed < 0 && t.right_paddle.get_position().y - paddle_size.y / 2 > 5)
		|| (t.right_paddle_speed > 0
		&& t.right_paddle.get_position().y + paddle_size.y / 2 < game_height - 5) {
		t.right_paddle.move(x: 0, y: t.right_paddle_speed * delta_time)
	}

	// Update the computer's paddle direction according to the ball position
	if t.ai_timer.get_elapsed_time() > ai_time {
		t.ai_timer.restart()
		if t.ball.get_position().y + ball_radius > t.right_paddle.get_position().y +
			paddle_size.y / 2 {
			t.right_paddle_speed = paddle_speed
		} else if t.ball.get_position().y - ball_radius < t.right_paddle.get_position().y - paddle_size.y / 2 {
			t.right_paddle_speed = -paddle_speed
		} else {
			t.right_paddle_speed = 0
		}
	}

	// Move the ball
	factor := ball_speed * delta_time
	t.ball.move(x: f32(math.cos(t.ball_angle) * factor), y: f32(math.sin(t.ball_angle) * factor))

	mut input_string := ''
	$if ios {
		input_string = 'Touch the screen to restart.'
	} $else {
		input_string = 'Press space to restart or\nescape to exit.'
	}

	// Check collisions between the ball and the screen
	if t.ball.get_position().x - ball_radius < 0 {
		t.is_playing = false
		t.pause_message.set_string('You Lost!\n\n' + input_string)
	}
	if t.ball.get_position().x + ball_radius > game_width {
		t.is_playing = false
		t.pause_message.set_string('You Won!\n\n' + input_string)
	}
	if t.ball.get_position().y - ball_radius < 0 {
		t.ball_sound.play()
		t.ball_angle = -t.ball_angle
		t.ball.set_position(x: t.ball.get_position().x, y: ball_radius + 0.1)
	}
	if t.ball.get_position().y + ball_radius > game_height {
		t.ball_sound.play()
		t.ball_angle = -t.ball_angle
		t.ball.set_position(x: t.ball.get_position().x, y: game_height - ball_radius - 0.1)
	}

	// Check the collisions between the ball and the paddles
	// Left Paddle
	if t.ball.get_position().x - ball_radius < t.left_paddle.get_position().x + paddle_size.x / 2
		&& t.ball.get_position().x - ball_radius > t.left_paddle.get_position().x
		&& t.ball.get_position().y + ball_radius >= t.left_paddle.get_position().y - paddle_size.y / 2
		&& t.ball.get_position().y - ball_radius <= t.left_paddle.get_position().y + paddle_size.y / 2 {
		if t.ball.get_position().y > t.left_paddle.get_position().y {
			t.ball_angle = math.pi - t.ball_angle + f32(rand.int() % 20) * math.pi / 180
		} else {
			t.ball_angle = math.pi - t.ball_angle - f32(rand.int() % 20) * math.pi / 180
		}

		t.ball_sound.play()
		t.ball.set_position(
			x: t.left_paddle.get_position().x + ball_radius + paddle_size.x / 2 + 0.1
			y: t.ball.get_position().y
		)
	}

	// Right Paddle
	if t.ball.get_position().x + ball_radius > t.right_paddle.get_position().x - paddle_size.x / 2
		&& t.ball.get_position().x + ball_radius < t.right_paddle.get_position().x
		&& t.ball.get_position().y + ball_radius >= t.right_paddle.get_position().y - paddle_size.y / 2
		&& t.ball.get_position().y - ball_radius <= t.right_paddle.get_position().y + paddle_size.y / 2 {
		if t.ball.get_position().y > t.right_paddle.get_position().y {
			t.ball_angle = math.pi - t.ball_angle + f32(rand.int() % 20) * math.pi / 180
		} else {
			t.ball_angle = math.pi - t.ball_angle - f32(rand.int() % 20) * math.pi / 180
		}

		t.ball_sound.play()
		t.ball.set_position(
			x: t.right_paddle.get_position().x - ball_radius - paddle_size.x / 2 - 0.1
			y: t.ball.get_position().y
		)
	}
}

fn main() {
	mut tennis := new_tennis() ?
	tennis.game_loop() ?
}
