/*
 *  ==== DO NOT MODIFY THIS FILE - CHANGES WILL BE OVERWRITTEN ====
 *
 *  Generated from
 *      C:/ti/grace_1_10_00_17/packages/ti/mcu/msp430/csl/gpio/GPIO_init.xdt
 */

#include <msp430.h>

/*
 *  ======== GPIO_init ========
 *  Initialize MSP430 General Purpose Input Output Ports
 */
void GPIO_init(void)
{
    /* Port 1 Output Register */
    P1OUT = 0;

    /* Port 1 Port Select Register */
    P1SEL = BIT4 + BIT6;

    /* Port 1 Port Select 2 Register */
    P1SEL2 = BIT4;

    /* Port 1 Direction Register */
    P1DIR = BIT4 + BIT6;

    /* Port 1 Interrupt Edge Select Register */
    P1IES = 0;

    /* Port 1 Interrupt Flag Register */
    P1IFG = 0;

    /* Port 2 Port Select Register */
    P2SEL = BIT7;

    /* Port 2 Port Select Register */
    P2SEL &= ~(BIT6);

    /* Port 2 Interrupt Edge Select Register */
    P2IES = 0;

    /* Port 2 Interrupt Flag Register */
    P2IFG = 0;

}
