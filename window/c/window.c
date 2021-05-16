#include "window.h"

int pollEventWindow(sfWindow *window, int *eventType, void **event) {
  sfEvent sfEvent;
  if (!sfWindow_pollEvent(window, &sfEvent)) {
    return 0;
  }
  *eventType = sfEvent.type;
  *event = &sfEvent;
  return 1;
}
