setws .
#exec rm -rf _app
#createapp -name _app -hwproject _hw -bsp _bsp -proc microblaze_0 -os standalone -lang C -app {Hello World}
#projects -build -type app -name _app
set src_files [list helloworld platform]
set obj_files ""
exec mkdir -p "_app/obj"
foreach file $src_files {
    set cmd "exec mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT\"_app/obj/$file.o\" -I_bsp/microblaze_0/include -mlittle-endian -mcpu=v11.0 -mxl-soft-mul -Wl,--no-relax -ffunction-sections -fdata-sections -MMD -MP -MT\"_app/obj/$file.o\" -o _app/obj/$file.o _app/src/$file.c"
    puts $cmd
    eval $cmd
    append obj_files " _app/obj/$file.o"
}
#set obj_files_flatten [join $obj_files]
#exec mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"_app/src/helloworld.o" -I_bsp/microblaze_0/include -mlittle-endian -mcpu=v11.0 -mxl-soft-mul -Wl,--no-relax -ffunction-sections -fdata-sections -MMD -MP -MT"_app/src/helloworld.o" -o "_app/src/helloworld.o" "_app/src/helloworld.c"
#exec mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"_app/src/platform.o" -I_bsp/microblaze_0/include -mlittle-endian -mcpu=v11.0 -mxl-soft-mul -Wl,--no-relax -ffunction-sections -fdata-sections -MMD -MP -MT"_app/src/platform.o" -o "_app/src/platform.o" "_app/src/platform.c"
set cmd "exec mb-gcc -Wl,-T -Wl,_app/src/lscript.ld -L_bsp/microblaze_0/lib -mlittle-endian -mcpu=v11.0 -mxl-soft-mul -Wl,--no-relax -Wl,--gc-sections $obj_files -o _app.elf -Wl,--start-group,-lxil,-lgcc,-lc,--end-group"
puts $cmd
eval $cmd
exec mb-size _app.elf