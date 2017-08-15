## THIS IS A GENERATED FILE -- DO NOT EDIT
.configuro: .libraries,430 linker.cmd \
  package/cfg/main_p430.o430 \

linker.cmd: package/cfg/main_p430.xdl
	$(SED) 's"^\"\(package/cfg/main_p430cfg.cmd\)\"$""\"E:/proj/MSP430_workspace/SRF_simulate_MSP430F2252/.config/xconfig_main/\1\""' package/cfg/main_p430.xdl > $@
