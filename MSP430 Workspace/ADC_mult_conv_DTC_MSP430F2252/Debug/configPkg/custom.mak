## THIS IS A GENERATED FILE -- DO NOT EDIT
.configuro: .libraries,430 linker.cmd \
  package/cfg/main_p430.o430 \

linker.cmd: package/cfg/main_p430.xdl
	$(SED) 's"^\"\(package/cfg/main_p430cfg.cmd\)\"$""\"E:/proj/MSP430_workspace/ADC_mult_conv_DTC_MSP430F2252/Debug/configPkg/\1\""' package/cfg/main_p430.xdl > $@
