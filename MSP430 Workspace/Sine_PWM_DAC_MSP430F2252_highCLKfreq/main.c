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
    
    // >>>>> Fill-in user code here <<<<<
    
//    //------------------------------------------------------------------------------
//    // Flash - 8-bit Sine Lookup table with 32 points
//    //------------------------------------------------------------------------------
//    const char sin_tab[32] = { 128, 152, 176, 198, 218, 234, 245, 253, 255, 253,
//    245, 234, 218, 198, 176, 152, 128, 103, 79, 57, 37, 21, 10, 2, 0, 2, 10, 21,
//    37, 57, 79, 103 };

//    //------------------------------------------------------------------------------
//    // Flash - 16-bit Sine Lookup table with 32 points
//    //------------------------------------------------------------------------------
//    const unsigned char sin_tab[32] = {
//    		0x8000, 0x99C4, 0xB27A, 0xC91F, 0xDCC5, 0xECA0, 0xF807, 0xFE85, 0xFFD5, 0xFBE9, 0xF2EA, 0xE537,
//			0xD360, 0xBE1E, 0xA651, 0x8CF3, 0x7308, 0x59AF, 0x41E2, 0x2CA0, 0x1AC9, 0x0D16, 0x0417, 0x002B,
//			0x017B, 0x07F9, 0x1360, 0x233B, 0x36E1, 0x4D86, 0x663C, 0x8000
//    };

    //------------------------------------------------------------------------------
    // Flash - 8-bit Sine Lookup table with 64 points
    //------------------------------------------------------------------------------
    const char sin_tab[64] = { 128, 140, 153, 165, 177, 188, 198, 209, 218, 226,
    		234, 240, 245, 250, 253, 254, 255, 254, 253, 250, 245, 240, 234, 226,
    		218, 209, 199, 188, 177, 165, 153, 140, 128, 116, 103, 91, 79, 68, 57,
    		47, 38, 30, 22, 16, 11, 6, 3, 2, 1, 2, 3, 6, 11, 16 ,22, 30, 38, 47, 57,
    		68, 79, 91, 103, 116 };

    //------------------------------------------------------------------------------
    // Flash - 8-bit Cosine Lookup table with 64 points
    //------------------------------------------------------------------------------
    const char cos_tab[64] = { 255, 254, 253, 250, 245, 240, 234, 226,
    		218, 209, 199, 188, 177, 165, 153, 140, 128, 116, 103, 91, 79, 68, 57,
    		47, 38, 30, 22, 16, 11, 6, 3, 2, 1, 2, 3, 6, 11, 16 ,22, 30, 38, 47, 57,
    		68, 79, 91, 103, 116, 128, 140, 153, 165, 177, 188, 198, 209, 218, 226,
    		234, 240, 245, 250, 253, 254 };

    int i;

////  Toggle LED
//    while(1){
//    P1OUT ^= BIT0;
//    __delay_cycles(100000);
//    }

//  Generate a sine wave at the Pin 1.2, cosine wave at Pin 1.3
//	PWM Clock frequency = 16MHz; hence 1 Clock Period = (10^-6)/16 s
//	One sine wave period of 20 ms has 64 points
//	Each Point has a time duration of 20/64 = 0.3125 ms
//	The PWM period must me much smaller than 0.3125 ms to create an accurate sine output after LPF stage
//	Lets choose the no. of clock ticks in 1 PWM period as 260 (i.e. PWM period = 260/(16*10^6) = 16.25 us)
//	Thus max. output of saw-tooth wave = 260 (dec) or 104 (hex)

    while(1){

    	for( i=0 ; i<=63 ; i++ ){
    	TACCR1 = sin_tab[i];
    	TACCR2 = cos_tab[i];
    	// for a sinusoidal wave of 50Hz, the 64 points should take displayed by (20/64) ms which is 5000 CLK cycles
    	__delay_cycles(5000);
    	}

    }

    return (0);
}
