## THIS IS A GENERATED FILE -- DO NOT EDIT
.configuro: .libraries,430 linker.cmd \
  package/cfg/main_p430.o430 \

linker.cmd: package/cfg/main_p430.xdl
	$(SED) 's"^\"\(package/cfg/main_p430cfg.cmd\)\"$""\"E:/proj/MSP430_workspace/Sine_PWM_DAC_MSP430F2252_highCLKfreq/Debug/configPkg/\1\""' package/cfg/main_p430.xdl > $@
