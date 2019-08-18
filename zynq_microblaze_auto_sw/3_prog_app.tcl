connect
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"} -index 1
dow _app.elf
configparams force-mem-access 0
con