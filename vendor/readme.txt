INCS += -I/usr/include/lua
LIBS += -llua
->
INCS += -I/usr/include/lua5.1
LIBS += -llua5.1

---------------------------------------

DEFS += -DUSE_SIMD -DUSE_SIMD_X86_SSE2
->
#DEFS += -DUSE_SIMD -DUSE_SIMD_X86_SSE2

---------------------------------------

#TARGET = onscripter$(EXESUFFIX) \
#	sardec$(EXESUFFIX) \
#	nsadec$(EXESUFFIX) \
#	sarconv$(EXESUFFIX) \
#	nsaconv$(EXESUFFIX) 
TARGET = onscripter$(EXESUFFIX)

---------------------------------------

make -f Makefile.Linux

---------------------------------------

sudo apt-get install libsdl2-dev
sudo apt-get install liblua5.1-0-dev
sudo apt-get install libsdl2-image-dev 
sudo apt-get install libsdl2-ttf-dev 
sudo apt-get install libsdl2-mixer-dev 
sudo apt-get install libbz2-dev
sudo apt-get install libfontconfig1-dev
sudo apt-get install libogg-dev
sudo apt-get install libvorbis-dev

sudo apt-get install libjpeg62-dev

