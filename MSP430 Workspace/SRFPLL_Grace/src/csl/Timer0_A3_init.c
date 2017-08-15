/*
 *  ==== DO NOT MODIFY THIS FILE - CHANGES WILL BE OVERWRITTEN ====
 *
 *  Generated from
 *      C:/ti/grace_1_10_00_17/packages/ti/mcu/msp430/csl/timer/ITimerx_A_init.xdt
 */

#include <msp430.h>

/*
 *  ======== Timer0_A3_init ========
 *  Initialize MSP430 Timer0_A3 timer
 */
void Timer0_A3_init(void)
{
    /* 
     * TA0CCTL1, Capture/Compare Control Register 1
     * 
     * CM_0 -- No Capture
     * CCIS_0 -- CCIxA
     * ~SCS -- Asynchronous Capture
     * ~SCCI -- Latched capture signal (read)
     * ~CAP -- Compare mode
     * OUTMOD_7 -- PWM output mode: 7 - PWM reset/set
     * 
     * Note: ~<BIT> indicates that <BIT> has value zero
     */
    TA0CCTL1 = CM_0 + CCIS_0 + OUTMOD_7;

    /* TA0CCR0, Timer_A Capture/Compare Register 0 */
    TA0CCR0 = 1023;

    /* 
     * TA0CTL, Timer_A3 Control Register
     * 
     * TASSEL_2 -- SMCLK
     * ID_0 -- Divider - /1
     * MC_1 -- Up Mode
     */
    TA0CTL = TASSEL_2 + ID_0 + MC_1;
}
