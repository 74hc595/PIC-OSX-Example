/**
 * Configuration bits
 */

#ifndef _CONFIG_H_
#define _CONFIG_H_

#include <pic14regs.h>
#include <stdint.h>

// pic14 doesn't support #pragma config, so we do it this way
__code uint16_t __at (_CONFIG1) __config1 =
  _FCMEN_OFF      & // Fail-Safe Clock Monitor disabled
  _IESO_OFF       & // Internal/External Switchover disabled
  _BOREN_OFF      & // Brown-Out Reset disabled
  _WDTE_OFF       & // Watchdog Timer disabled
  _FOSC_INTOSC;     // Internal oscillator

__code uint16_t __at (_CONFIG2) __config2 =
  _PLLEN_ENABLED  & // PLL enabled
  _PLLMULT_3x     & // 3x PLL
  _USBLSCLK_48MHz & // 48MHz USB clock
  _CPUDIV_NOCLKDIV; // No clock divider

#endif
