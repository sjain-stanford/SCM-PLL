/*
 *  Do not modify this file; it is automatically 
 *  generated and any modifications will be overwritten.
 *
 * @(#) xdc-x20
 */

#define __nested__
#define __config__

#include <xdc/std.h>

/*
 * ======== GENERATED SECTIONS ========
 *     
 *     MODULE INCLUDES
 *     
 *     <module-name> INTERNALS
 *     <module-name> INHERITS
 *     <module-name> VTABLE
 *     <module-name> PATCH TABLE
 *     <module-name> DECLARATIONS
 *     <module-name> OBJECT OFFSETS
 *     <module-name> TEMPLATES
 *     <module-name> INITIALIZERS
 *     <module-name> FUNCTION STUBS
 *     <module-name> PROXY BODY
 *     <module-name> OBJECT DESCRIPTOR
 *     <module-name> SYSTEM FUNCTIONS
 *     <module-name> PRAGMAS
 *     
 *     INITIALIZATION ENTRY POINT
 *     PROGRAM GLOBALS
 *     CLINK DIRECTIVES
 */


/*
 * ======== MODULE INCLUDES ========
 */



/*
 * ======== xdc.cfg.Program TEMPLATE ========
 */

/*
 *  ======== __ASM__ ========
 *  Define absolute path prefix for this executable's
 *  configuration generated files.
 */
xdc__META(__ASM__, "@(#)__ASM__ = E:/proj/MSP430_workspace/Sine_externalDAC_MSP430F2252/Debug/configPkg/package/cfg/main_p430");

/*
 *  ======== __ISA__ ========
 *  Define the ISA of this executable.  This symbol is used by platform
 *  specific "exec" commands that support more than one ISA; e.g., gdb
 */
xdc__META(__ISA__, "@(#)__ISA__ = 430");

/*
 *  ======== __PLAT__ ========
 *  Define the name of the platform that can run this executable.  This
 *  symbol is used by platform independent "exec" commands
 */
xdc__META(__PLAT__, "@(#)__PLAT__ = ti.platforms.msp430");

/*
 *  ======== __TARG__ ========
 *  Define the name of the target used to build this executable.
 */
xdc__META(__TARG__, "@(#)__TARG__ = ti.targets.msp430.MSP430");

/*
 *  ======== __TRDR__ ========
 *  Define the name of the class that can read/parse this executable.
 */
xdc__META(__TRDR__, "@(#)__TRDR__ = ti.targets.omf.cof.Coff");


/*
 * ======== xdc.cfg.SourceDir TEMPLATE ========
 */



/*
 * ======== xdc.runtime.Reset TEMPLATE ========
 */

/* 
 * Startup_reset__I is an internal entry point called by target/platform
 * boot code. Boot code is not brought into a partial-link assembly. So,
 * without this pragma, whole program optimizers would otherwise optimize-out
 * this function.
 */
#ifdef __ti__
#pragma FUNC_EXT_CALLED(xdc_runtime_Startup_reset__I);
#endif

#ifdef __GNUC__
#if __GNUC__ >= 4
xdc_Void xdc_runtime_Startup_reset__I(void) __attribute__ ((externally_visible));
#endif
#endif

extern Void ti_catalog_msp430_init_Boot_init(void);  /* user defined reset function */

/*
 *  ======== xdc_runtime_Startup_reset__I ========
 *  This function is called by bootstrap initialization code as early as
 *  possible in the startup process.  This function calls all functions in
 *  the Reset.fxns array _as well as_ Startup.resetFxn (if it's non-NULL)
 */
xdc_Void xdc_runtime_Startup_reset__I(void)
{
    ti_catalog_msp430_init_Boot_init();
}

/*
 * ======== ti.catalog.msp430.init.Boot TEMPLATE ========
 */

    extern ti_catalog_msp430_init_Boot_disableWatchdog(UInt address);
    extern ti_catalog_msp430_init_Boot_configureDCO();

#if defined(__ti__)
#pragma CODE_SECTION(ti_catalog_msp430_init_Boot_init, ".text:.bootCodeSection")
#endif

/*
 *  ======== ti_catalog_msp430_init_Boot_init ========
 */
Void ti_catalog_msp430_init_Boot_init()
{
    ti_catalog_msp430_init_Boot_disableWatchdog(288);
}



/*
 * ======== ti.mcu.msp430.csl.CSL TEMPLATE ========
 */

/* CSL stuff */

/*
 * ======== ti.mcu.msp430.csl.watchdog.WDTplus TEMPLATE ========
 */

/* WDTplus stuff from C:/ti/grace_1_10_00_17/packages/ti/mcu/msp430/csl/watchdog/./WDTplus.xdt */

/*
 * ======== ti.mcu.msp430.csl.gpio.GPIO TEMPLATE ========
 */

/* GPIO stuff from C:/ti/grace_1_10_00_17/packages/ti/mcu/msp430/csl/gpio/./GPIO.xdt */

/*
 * ======== ti.mcu.msp430.csl.clock.BCSplus TEMPLATE ========
 */

/* 2xx Clock stuff from C:/ti/grace_1_10_00_17/packages/ti/mcu/msp430/csl/clock/./BCSplus.xdt */

/*
 * ======== ti.mcu.msp430.csl.system.System TEMPLATE ========
 */

/* System stuff from C:/ti/grace_1_10_00_17/packages/ti/mcu/msp430/csl/system/./System.xdt */

/*
 * ======== PROGRAM GLOBALS ========
 */


/*
 * ======== CONSTANTS ========
 */

