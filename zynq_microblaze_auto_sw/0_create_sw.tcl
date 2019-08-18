#assume top.hdf and top.bit in the current directory

setws .
exec rm -rf .metadata
exec rm -rf _hw
exec rm -rf _bsp
exec rm -rf _app
createhw -name _hw -hwspec top.hdf
createbsp -name _bsp -hwproject _hw -proc microblaze_0 -os standalone
projects -build
createapp -name _app -hwproject _hw -bsp _bsp -proc microblaze_0 -os standalone -lang C -app {Hello World}