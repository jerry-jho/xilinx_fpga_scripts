setws .
connect -url tcp:127.0.0.1:3121
source _hw/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*"} -index 0
rst -system
after 3000
targets -set -filter {level==0} -index 1
fpga -file top.bit
targets -set -nocase -filter {name =~"APU*"} -index 0
loadhw -hw top.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"} -index 0
ps7_init
ps7_post_config