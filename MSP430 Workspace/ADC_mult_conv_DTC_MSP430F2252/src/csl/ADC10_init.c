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
     * MSC -- Enable multiple sample and conversion
     * ~REFBURST -- Reference buffer on continuously
     * ~REFOUT -- Reference output off
     * ~ADC10SR -- Reference buffer supports up to ~200 ksps
     * ADC10SHT_0 -- 4 x ADC10CLKs
     * SREF_6 -- VR+ = VeREF+ and VR- = VREF-/ VeREF-
     * 
     * Note: ~<BIT> indicates that <BIT> has value zero
     */
    ADC10CTL0 = ADC10ON + MSC + ADC10SHT_0 + SREF_6;
    
    /* 
     * Control Register 1
     * 
     * ~ADC10BUSY -- No operation is active
     * CONSEQ_1 -- Sequence of channels
     * ADC10SSEL_0 -- ADC10OSC
     * ADC10DIV_0 -- Divide by 1
     * ~ISSH -- Input signal not inverted
     * ~ADC10DF -- ADC10 Data Format as binary
     * SHS_0 -- ADC10SC
     * INCH_2 -- ADC Channel 2
     * 
     * Note: ~<BIT> indicates that <BIT> has value zero
     */
    ADC10CTL1 = CONSEQ_1 + ADC10SSEL_0 + ADC10DIV_0 + SHS_0 + INCH_2;
    
    /* Analog (Input) Enable Control Register 0 */
    ADC10AE0 = 0x1F;
    
    /* Data Transfer Control Register 1 */
    ADC10DTC1 = 3;
    
    /* enable ADC10 */
    ADC10CTL0 |= ENC;
}
