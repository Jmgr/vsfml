# vSFML

V binding for the [Simple and Fast Multimedia Library](https://www.sfml-dev.org/) (SFML). Based on the SFML C binding.

All SFML features are available with the exception of the thread and mutex functions (use the ones from the vlib).

Only tested on Ubuntu 18.04, but should work on other operating systems.

# API

 * [system](https://jmgr.github.io/vsfml/system.html)
 * [window](https://jmgr.github.io/vsfml/window.html)
 * [graphics](https://jmgr.github.io/vsfml/graphics.html)
 * [network](https://jmgr.github.io/vsfml/network.html)
 * [audio](https://jmgr.github.io/vsfml/audio.html)

## Examples

```v
module main

import vsfml.graphics
import vsfml.window
import vsfml.system

fn main() {
	win := graphics.new_render_window(
		mode: window.VideoMode{800, 600, 32}
		title: 'Basic example'
	) ?
	win.set_vertical_sync_enabled(true)

	sfml_logo_texture := graphics.new_texture_from_file(filename: 'resources/sfml_logo.png') ?
	sfml_logo := graphics.new_sprite() ?
	sfml_logo.set_texture(sfml_logo_texture, true)
	sfml_logo.set_position(system.Vector2f{170, 50})

	for win.is_open() {
		// Process all events
		for {
			event := win.poll_event() or { break }
			match event {
				// Window closed or escape key pressed: exit
				window.CloseEvent {
					win.close()
					break
				}
				window.KeyPressedEvent {
					match event.code {
						.escape {
							win.close()
							break
						}
						else {}
					}
				}
				else {}
			}
		}

		// Display
		win.clear(graphics.color_from_rgb(50, 50, 50))

		win.draw_sprite(object: sfml_logo)

		win.display()
	}
}
```

The [examples](https://github.com/Jmgr/vsfml/tree/master/examples) directory contains a port of the SFML [Tennis](https://github.com/SFML/SFML/tree/master/examples/tennis) example.

## Dependencies

### Linux

#### Ubuntu

`$ sudo apt install libcsfml-dev`
