//***************************************************************************************
//  MSP430G2553 SRFPLL Design and Optimization
//
//  Sambhav R Jain
//  Pradhyumna Ravikirthi
//  NIT Trichy
//  2012
//  Built with Code Composer Studio v5
//***************************************************************************************

#include <msp430g2553.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;						// Stop WDT (Watch-dog Timer)
  ADC10CTL0 = ADC10SHT_2 + ADC10ON + ADC10IE; 	// ADC10ON, Interrupt Enabled
  ADC10CTL1 = INCH1;                       	// Input A1
  ADC10AE0 |= 0x02;                         	// PA.1 ADC enable
  P1DIR &= 0xFFF8;								// Set P1.0, P1.1, P1.2 as input pins

  // v_a --> P1.0
  // v_b --> P1.1
  // v_c --> P1.2

  float kp = -2.159641;
  float ki = -487.250012;

  for (;;)
  {
	volatile unsigned int i;            // volatile to prevent optimization

	P1OUT ^= 0x01;                      // Toggle P1.0 using exclusive-OR

	i = 10000;                          // SW Delay
	do i--;
	while (i != 0);
  }
}
