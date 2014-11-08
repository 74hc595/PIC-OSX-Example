#include <stdint.h>

void delay(uint16_t d)
{
  uint16_t i;
  for (i = 0; i < d; i++) {
    __asm nop __endasm;
  }
}

