/*
 * ======== Standard MSP430 includes ========
 */
#include <msp430.h>

/*
 * ======== Grace related includes ========
 */
#include <ti/mcu/msp430/csl/CSL.h>

unsigned int vgrid[4];

// v_a is connected to ADC channel A2 --> DTC stores in vgrid[1] (10 bit)
// v_b is connected to ADC channel A1 --> DTC stores in vgrid[2] (10 bit)
// v_c is connected to ADC channel A0 --> DTC stores in vgrid[3] (10 bit)

/*
 *  ======== main ========
 */
int main(int argc, char *argv[])
{
    CSL_init();                     // Activate Grace-generated configuration
    while(1){
    	// Configure DTC
        ADC10CTL0 &= ~ENC;
        while (ADC10CTL1 & BUSY);               // Wait till ADC10 core is active
        ADC10SA = (unsigned short) vgrid;		// Data transfer start at starting address of array vgrid

        // ADC Start Sampling and Conversion - Software trigger
    	ADC10CTL0 |= ENC + ADC10SC;

    	// Loop until ADC10IFG is set indicating ADC conversion sequence is complete
    	while ((ADC10CTL0 & ADC10IFG) == 0);

    	// Output the conversion result as a PWM
    	TACCR1 = vgrid[1];		// v_a phase
    	TACCR2 = vgrid[2];		// v_b phase
    	TBCCR1 = vgrid[3];		// v_c phase
    	__delay_cycles(5000);
    }
    
    return (0);
}
