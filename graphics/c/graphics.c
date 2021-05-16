#include "graphics.h"

int pollEventRenderWindow(sfRenderWindow *window, int *eventType,
                          void **event) {
  sfEvent sfEvent;
  if (!sfRenderWindow_pollEvent(window, &sfEvent)) {
    return 0;
  }
  *eventType = sfEvent.type;
  *event = &sfEvent;
  return 1;
}
