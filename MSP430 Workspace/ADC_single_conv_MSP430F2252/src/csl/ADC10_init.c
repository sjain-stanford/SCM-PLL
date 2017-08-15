/*
 *  ==== DO NOT MODIFY THIS FILE - CHANGES WILL BE OVERWRITTEN ====
 *
 *  Generated from
 *      C:/ti/grace_1_10_00_17/packages/ti/mcu/msp430/csl/adc/ADC10_init.xdt
 */

#include <msp430.h>

/*
 *  ======== ADC10_init ========
 *  Initialize MSP430 10-bit Analog to Digital Converter
 */
void ADC10_init(void)
{
    /* disable ADC10 during initialization */
    ADC10CTL0 &= ~ENC;

    /* 
     * Control Register 0
     * 
     * ~ADC10SC -- No conversion
     * ~ENC -- Disable ADC
     * ~ADC10IFG -- Clear ADC interrupt flag
     * ~ADC10IE -- Disable ADC interrupt
     * ADC10ON -- Switch On ADC10
     * ~REFON -- Disable ADC reference generator
     * ~REF2_5V -- Set reference voltage generator = 1.5V
     * ~MSC -- Disable multiple sample and conversion
     * ~REFBURST -- Reference buffer on continuously
     * ~REFOUT -- Reference output off
     * ~ADC10SR -- Reference buffer supports up to ~200 ksps
     * ADC10SHT_0 -- 4 x ADC10CLKs
     * SREF_6 -- VR+ = VeREF+ and VR- = VREF-/ VeREF-
     * 
     * Note: ~<BIT> indicates that <BIT> has value zero
     */
    ADC10CTL0 = ADC10ON + ADC10SHT_0 + SREF_6;
    
    /* Analog (Input) Enable Control Register 0 */
    ADC10AE0 = 0x19;
    
    /* enable ADC10 */
    ADC10CTL0 |= ENC;
}
