/*
 *  ==== DO NOT MODIFY THIS FILE - CHANGES WILL BE OVERWRITTEN ====
 *
 *  Generated from
 *      C:/ti/grace_1_10_00_17/packages/ti/mcu/msp430/csl/timer/ITimerx_A_init.xdt
 */

#include <msp430.h>

/*
 *  ======== Timer1_A3_init ========
 *  Initialize MSP430 Timer1_A3 timer
 */
void Timer1_A3_init(void)
{
    /* 
     * TA1CCTL1, Capture/Compare Control Register 1
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
    TA1CCTL1 = CM_0 + CCIS_0 + OUTMOD_7;

    /* 
     * TA1CCTL2, Capture/Compare Control Register 2
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
    TA1CCTL2 = CM_0 + CCIS_0 + OUTMOD_7;

    /* TA1CCR0, Timer_A Capture/Compare Register 0 */
    TA1CCR0 = 1025;

    /* 
     * TA1CTL, Timer_A3 Control Register
     * 
     * TASSEL_2 -- SMCLK
     * ID_0 -- Divider - /1
     * MC_1 -- Up Mode
     */
    TA1CTL = TASSEL_2 + ID_0 + MC_1;
}
