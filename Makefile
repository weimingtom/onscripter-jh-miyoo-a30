# -*- Makefile -*-
#
# Makefile.Linux - Makefile rules for linux
#

#copy this file from Makefile.Linux
#
#sudo apt-get install libsdl2-dev
#(x)sudo apt-get install liblua5.1-0-dev
#sudo apt-get install libsdl2-image-dev 
#sudo apt-get install libsdl2-ttf-dev 
#sudo apt-get install libsdl2-mixer-dev 
#sudo apt-get install libbz2-dev
#(x)sudo apt-get install libfontconfig1-dev
#(x)sudo apt-get install libogg-dev
#(x)sudo apt-get install libvorbis-dev
#
MIYOO:=0
#now only for MIYOO A30, not MIYOO MINI
#if MIYOO==0, built for PC, xubuntu20 or rpd:
#make clean && make MIYOO=0

EXESUFFIX =
OBJSUFFIX = .o

.SUFFIXES:
.SUFFIXES: $(OBJSUFFIX) .cpp .h

#TARGET = onscripter$(EXESUFFIX) \
#	sardec$(EXESUFFIX) \
#	nsadec$(EXESUFFIX) \
#	sarconv$(EXESUFFIX) \
#	nsaconv$(EXESUFFIX) 
TARGET = onscripter$(EXESUFFIX)
EXT_OBJS = 

# mandatory: SDL, SDL_ttf, SDL_image, SDL_mixer, bzip2
ifeq ($(MIYOO),1)
SYSROOT?=/home/wmt/work_a30/staging_dir/target
ARCH=-marm -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard 
#-march=armv7ve+simd
DEFS = -DLINUX -DUSE_SDL_RENDERER -DNDEBUG -DMIYOO
#-DMIYOO, search SDL_RenderPresent in ONScripter.cpp, there is a display flush bug for SDL2
INCS = -Os $(ARCH) -I${SYSROOT}/usr/include -I${SYSROOT}/usr/include/SDL2 -ffunction-sections -fdata-sections -Wall
LIBS = -L${SYSROOT}/usr/lib $(ARCH) -lSDL2_ttf  -lSDL2_mixer -lSDL2 -lmad -lfreetype -lbz2 -ljpeg -lpng -lz -lpthread -lm
#removed -lSDL2_image
EXT_FLAGS =
else
DEFS = -DLINUX -DUSE_SDL_RENDERER -DNDEBUG -DMIYOO
INCS = `sdl2-config --cflags`
LIBS = `sdl2-config --libs` -lSDL2_ttf -lSDL2_mixer -ljpeg -lpng -lz -lbz2 -lm
EXT_FLAGS = 
 endif

# recommended: smpeg
#DEFS += -DUSE_SMPEG
#INCS += `smpeg-config --cflags`
#LIBS += `smpeg-config --libs`

# recommended: fontconfig (to get default font)
#DEFS += -DUSE_FONTCONFIG
#LIBS += -lfontconfig

# recommended: OggVorbis 
#DEFS += -DUSE_OGG_VORBIS
#LIBS += -logg -lvorbis -lvorbisfile

# optional: Integer OggVorbis
#DEFS += -DUSE_OGG_VORBIS -DINTEGER_OGG_VORBIS
#LIBS += -lvorbisidec

# optional: support CD audio
#DEFS += -DUSE_CDROM

# optional: avifile
#DEFS += -DUSE_AVIFILE
#INCS += `avifile-config --cflags`
#LIBS += `avifile-config --libs`
#TARGET += simple_aviplay$(EXESUFFIX)
#EXT_OBJS += AVIWrapper$(OBJSUFFIX)

# optional: lua
#DEFS += -DUSE_LUA
#INCS += -I/usr/include/lua5.1
#LIBS += -llua5.1
#EXT_OBJS += LUAHandler$(OBJSUFFIX)

# optional: SIMD optimizing
#DEFS += -DUSE_SIMD -DUSE_SIMD_X86_SSE2

# optional: multicore rendering
#DEFS += -DUSE_OMP_PARALLEL
#EXT_FLAGS += -fopenmp

# optional: enable builtin effects
DEFS += -DUSE_BUILTIN_EFFECTS -DUSE_BUILTIN_LAYER_EFFECTS


# optional: enable English mode
#DEFS += -DENABLE_1BYTE_CHAR -DFORCE_1BYTE_CHAR


# for GNU g++
ifeq ($(MIYOO),1)
CC = /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ 
LD = /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ -o
else
CC = g++ 
LD = g++ -o
endif

#CFLAGS = -g -Wall -pipe -c $(INCS) $(DEFS)
CFLAGS = -std=c++11 -O3 -Wall -fomit-frame-pointer -pipe -c $(INCS) $(DEFS) $(EXT_FLAGS)

# for GCC on PowerPC specfied
#CC = powerpc-unknown-linux-gnu-g++
#LD = powerpc-unknown-linux-gnu-g++ -o

#CFLAGS = -O3 -mtune=G4 -maltivec -mabi=altivec -mpowerpc-gfxopt -mmultiple -mstring -Wall -fomit-frame-pointer -pipe -c $(INCS) $(DEFS)

# for Intel compiler
#CC = icc
#LD = icc -o

#CFLAGS = -O3 -tpp6 -xK -c $(INCS) $(DEFS)

RM = rm -f

include Makefile.onscripter
