#
_XDCBUILDCOUNT = 0
ifneq (,$(findstring path,$(_USEXDCENV_)))
override XDCPATH = C:/ti/grace_1_10_00_17/packages;E:/proj/MSP430_workspace/Sine_PWM_DAC_MSP430F2252/.config
override XDCROOT = C:/ti/xdctools_3_22_04_46
override XDCBUILDCFG = ./config.bld
endif
ifneq (,$(findstring args,$(_USEXDCENV_)))
override XDCARGS = 
override XDCTARGETS = 
endif
#
ifeq (0,1)
PKGPATH = C:/ti/grace_1_10_00_17/packages;E:/proj/MSP430_workspace/Sine_PWM_DAC_MSP430F2252/.config;C:/ti/xdctools_3_22_04_46/packages;..
HOSTOS = Windows
endif
