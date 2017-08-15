/*
 * ======== Standard MSP430 includes ========
 */
#include <msp430.h>

/*
 * ======== Grace related includes ========
 */
#include <ti/mcu/msp430/csl/CSL.h>

/*
 *  ======== main ========
 */
int main(int argc, char *argv[])
{
    CSL_init();                     // Activate Grace-generated configuration

    while (1){
    // ADC Start Conversion - Software trigger
    ADC10CTL0 |= ADC10SC;

    // Loop until ADC10IFG is set indicating ADC conversion complete
    while ((ADC10CTL0 & ADC10IFG) == 0);

    // Read ADC conversion result from ADC10MEM and convert the 10 bit result to a 8 bit value, to send to PORT1
    P1OUT = ADC10MEM/4;
    }

    return (0);
}
