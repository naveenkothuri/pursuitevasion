###########################################################################
## Makefile generated for Simulink model 'lego_move_optitrack2'. 
## 
## Makefile     : lego_move_optitrack2.mk
## Generated on : Tue Aug 08 11:51:00 2017
## MATLAB Coder version: 3.3 (R2017a)
## 
## Build Info:
## 
## Final product: $(RELATIVE_PATH_TO_ANCHOR)/lego_move_optitrack2
## Product type : executable
## Build type   : Top-Level Standalone Executable
## 
###########################################################################

###########################################################################
## MACROS
###########################################################################

# Macro Descriptions:
# PRODUCT_NAME            Name of the system to build
# MAKEFILE                Name of this makefile
# COMPUTER                Computer type. See the MATLAB "computer" command.

PRODUCT_NAME              = lego_move_optitrack2
MAKEFILE                  = lego_move_optitrack2.mk
COMPUTER                  = PCWIN64
MATLAB_ROOT               = F:/MATLAB/R2017a
MATLAB_BIN                = F:/MATLAB/R2017a/bin
MATLAB_ARCH_BIN           = F:/MATLAB/R2017a/bin/win64
MASTER_ANCHOR_DIR         = 
START_DIR                 = E:/academics/thesis/NatNetSDK
ARCH                      = win64
SOLVER                    = 
SOLVER_OBJ                = 
CLASSIC_INTERFACE         = 0
TGT_FCN_LIB               = None
MODEL_HAS_DYNAMICALLY_LOADED_SFCNS = 0
MODELREF_LINK_RSPFILE_NAME = lego_move_optitrack2_ref.rsp
RELATIVE_PATH_TO_ANCHOR   = ..
C_STANDARD_OPTS           = 
CPP_STANDARD_OPTS         = 

###########################################################################
## TOOLCHAIN SPECIFICATIONS
###########################################################################

# Toolchain Name:          Sourcery G++ Lite v2009q3 v4.7 | gmake (64-bit Windows)
# Supported Version(s):    
# ToolchainInfo Version:   R2017a
# Specification Revision:  1.0
# 
#-------------------------------------------
# Macros assumed to be defined elsewhere
#-------------------------------------------

# EV3_LMS2012_DIR
# EV3_LMSTYPES_DIR
# EV3_BYTECODES_DIR
# EV3_COMPILER_DIR
# EV3_COMPILER_BIN_DIR
# EV3_COMPILER_LIB_DIR
# EV3_COMPILER_HEADER_DIR
# EV3_COMPILER_HEADER_DIR2
# EV3_COMPILER_HEADER_DIR3
# EV3_SourceryLite

#-----------
# MACROS
#-----------

SHELL                    = %SystemRoot%/system32/cmd.exe

TOOLCHAIN_SRCS = 
TOOLCHAIN_INCS = 
TOOLCHAIN_LIBS = -lm -lm

#------------------------
# BUILD TOOL COMMANDS
#------------------------

# C Compiler: Sourcery G++ Lite v2009q3 C Compiler
CC_PATH = $(EV3_SourceryLite)
CC = $(CC_PATH)/arm-none-linux-gnueabi-gcc

# Linker: Sourcery G++ Lite v2009q3 Linker
LD_PATH = $(EV3_SourceryLite)
LD = $(LD_PATH)/arm-none-linux-gnueabi-gcc

# C++ Compiler: Sourcery G++ Lite v2009q3 C Compiler
CPP_PATH = $(EV3_SourceryLite)
CPP = $(CPP_PATH)/arm-none-linux-gnueabi-g++

# C++ Linker: Sourcery G++ Lite v2009q3 C++ Linker
CPP_LD_PATH = $(EV3_SourceryLite)
CPP_LD = $(CPP_LD_PATH)/arm-none-linux-gnueabi-gcc

# Archiver: Sourcery G++ Lite v2009q3 Archiver
AR_PATH = $(EV3_SourceryLite)
AR = $(AR_PATH)/arm-none-linux-gnueabi-ar

# MEX Tool: MEX Tool
MEX_PATH = $(MATLAB_BIN)
MEX = $(MEX_PATH)/mex

# Download: Download
DOWNLOAD =

# Execute: Execute
EXECUTE = $(PRODUCT)

# Builder: GMAKE Utility
MAKE_PATH = %MATLAB%\bin\win64
MAKE = $(MAKE_PATH)/gmake


#-------------------------
# Directives/Utilities
#-------------------------

CDEBUG              = -g
C_OUTPUT_FLAG       = -o
LDDEBUG             = -g
OUTPUT_FLAG         = -o
CPPDEBUG            = -g
CPP_OUTPUT_FLAG     = -o
CPPLDDEBUG          = -g
OUTPUT_FLAG         = -o
ARDEBUG             =
STATICLIB_OUTPUT_FLAG =
MEX_DEBUG           = -g
RM                  = @del /F
ECHO                = @echo
MV                  = @move
RUN                 =

#----------------------------------------
# "Faster Builds" Build Configuration
#----------------------------------------

ARFLAGS              = -r
CFLAGS               = -c \
                       -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -O0
CPPFLAGS             =
CPP_LDFLAGS          =
CPP_SHAREDLIB_LDFLAGS  =
DOWNLOAD_FLAGS       =
EXECUTE_FLAGS        =
LDFLAGS              = -lrt \
                       -lpthread
MEX_CPPFLAGS         =
MEX_CPPLDFLAGS       =
MEX_CFLAGS           =
MEX_LDFLAGS          =
MAKE_FLAGS           = -f $(MAKEFILE)
SHAREDLIB_LDFLAGS    =

#--------------------
# File extensions
#--------------------

C_DEP               = .dep
H_EXT               = .h
OBJ_EXT             = .o
C_EXT               = .c
EXE_EXT             =
SHAREDLIB_EXT       = .a
CXX_DEP             = .dep
HPP_EXT             = .hpp
OBJ_EXT             = .o
CPP_EXT             = .cpp
EXE_EXT             =
SHAREDLIB_EXT       = .a
STATICLIB_EXT       = .a
MEX_EXT             = .mexw64
MAKE_EXT            = .mk


###########################################################################
## OUTPUT INFO
###########################################################################

PRODUCT = $(RELATIVE_PATH_TO_ANCHOR)/lego_move_optitrack2
PRODUCT_TYPE = "executable"
BUILD_TYPE = "Top-Level Standalone Executable"

###########################################################################
## INCLUDE PATHS
###########################################################################

INCLUDES_BUILDINFO = -I$(START_DIR) -IC:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/ev3/include -I$(START_DIR)/lego_move_optitrack2_ert_rtw -I$(MATLAB_ROOT)/extern/include -I$(MATLAB_ROOT)/simulink/include -I$(MATLAB_ROOT)/rtw/c/src -I$(MATLAB_ROOT)/rtw/c/src/ext_mode/common -I$(MATLAB_ROOT)/rtw/c/ert -I$(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils -I$(EV3_LMSTYPES_DIR)/.. -I$(EV3_LMS2012_DIR)/.. -I$(EV3_BYTECODES_DIR)/.. -I$(MATLAB_ROOT)/toolbox/target/codertarget/rtos/inc -IC:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/ev3/src

INCLUDES = $(INCLUDES_BUILDINFO)

###########################################################################
## DEFINES
###########################################################################

DEFINES_ = -DMODEL=lego_move_optitrack2 -DNUMST=1 -DNCSTATES=0 -DHAVESTDIO -DON_TARGET_WAIT_FOR_START=1 -DTERMFCN=1 -DONESTEPFCN=1 -DMAT_FILE=0 -DMULTI_INSTANCE_CODE=0 -DEXT_MODE=1 -DINTEGER_CODE=0 -DMT=0 -DCLASSIC_INTERFACE=0 -DALLOCATIONFCN=0 -DTID01EQ=0 -DEXIT_FAILURE=1 -DEXTMODE_DISABLEPRINTF -DEXTMODE_DISABLETESTING -DEXTMODE_DISABLE_ARGS_PROCESSING=1 -DSTACK_SIZE=64 -D__MW_TARGET_USE_HARDWARE_RESOURCES_H__ -DRT
DEFINES_BUILD_ARGS = -DTERMFCN=1 -DONESTEPFCN=1 -DMAT_FILE=0 -DMULTI_INSTANCE_CODE=0 -DEXT_MODE=1 -DINTEGER_CODE=0 -DMT=0 -DCLASSIC_INTERFACE=0 -DALLOCATIONFCN=0
DEFINES_IMPLIED = -DTID01EQ=0
DEFINES_OPTS = -DON_TARGET_WAIT_FOR_START=1
DEFINES_SKIPFORSIL = -DEXIT_FAILURE=1 -DEXTMODE_DISABLEPRINTF -DEXTMODE_DISABLETESTING -DEXTMODE_DISABLE_ARGS_PROCESSING=1 -DSTACK_SIZE=64 -DRT
DEFINES_STANDARD = -DMODEL=lego_move_optitrack2 -DNUMST=1 -DNCSTATES=0 -DHAVESTDIO

DEFINES = $(DEFINES_) $(DEFINES_BUILD_ARGS) $(DEFINES_IMPLIED) $(DEFINES_OPTS) $(DEFINES_SKIPFORSIL) $(DEFINES_STANDARD)

###########################################################################
## SOURCE FILES
###########################################################################

SRCS = $(START_DIR)/lego_move_optitrack2_ert_rtw/lego_move_optitrack2.c $(MATLAB_ROOT)/rtw/c/src/ext_mode/common/ext_svr.c $(MATLAB_ROOT)/rtw/c/src/ext_mode/common/updown.c $(MATLAB_ROOT)/rtw/c/src/ext_mode/common/ext_work.c $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/rtiostream_utils.c $(MATLAB_ROOT)/toolbox/target/codertarget/rtos/src/linuxinitialize.c $(MATLAB_ROOT)/rtw/c/src/ext_mode/common/rtiostream_interface.c $(MATLAB_ROOT)/rtw/c/src/rtiostream/rtiostreamtcpip/rtiostream_tcpip.c C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/ev3/src/driver_ev3_button.c C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/ev3/src/driver_ev3_lcd.c C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/ev3/src/MW_legoev3init.c C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/ev3/src/driver_ev3_ultrasonic_sensor.c

MAIN_SRC = $(START_DIR)/lego_move_optitrack2_ert_rtw/ert_main.c

ALL_SRCS = $(SRCS) $(MAIN_SRC)

###########################################################################
## OBJECTS
###########################################################################

OBJS = lego_move_optitrack2.o ext_svr.o updown.o ext_work.o rtiostream_utils.o linuxinitialize.o rtiostream_interface.o rtiostream_tcpip.o driver_ev3_button.o driver_ev3_lcd.o MW_legoev3init.o driver_ev3_ultrasonic_sensor.o

MAIN_OBJ = ert_main.o

ALL_OBJS = $(OBJS) $(MAIN_OBJ)

###########################################################################
## PREBUILT OBJECT FILES
###########################################################################

PREBUILT_OBJS = 

###########################################################################
## LIBRARIES
###########################################################################

LIBS = 

###########################################################################
## SYSTEM LIBRARIES
###########################################################################

SYSTEM_LIBS = 

###########################################################################
## ADDITIONAL TOOLCHAIN FLAGS
###########################################################################

#---------------
# C Compiler
#---------------

CFLAGS_SKIPFORSIL = -I$(EV3_COMPILER_HEADER_DIR) -I$(EV3_COMPILER_HEADER_DIR2) -I$(EV3_COMPILER_HEADER_DIR3) -I$(EV3_LMS2012_DIR) -I$(EV3_LMSTYPES_DIR) -I$(EV3_BYTECODES_DIR) -c -nostdinc
CFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CFLAGS += $(CFLAGS_SKIPFORSIL) $(CFLAGS_BASIC)

#-----------------
# C++ Compiler
#-----------------

CPPFLAGS_SKIPFORSIL = -I$(EV3_COMPILER_HEADER_DIR) -I$(EV3_COMPILER_HEADER_DIR2) -I$(EV3_COMPILER_HEADER_DIR3) -I$(EV3_LMS2012_DIR) -I$(EV3_LMSTYPES_DIR) -I$(EV3_BYTECODES_DIR) -c -nostdinc
CPPFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CPPFLAGS += $(CPPFLAGS_SKIPFORSIL) $(CPPFLAGS_BASIC)

#---------------
# C++ Linker
#---------------

CPP_LDFLAGS_SKIPFORSIL = -L$(EV3_COMPILER_LIB_DIR)

CPP_LDFLAGS += $(CPP_LDFLAGS_SKIPFORSIL)

#------------------------------
# C++ Shared Library Linker
#------------------------------

CPP_SHAREDLIB_LDFLAGS_SKIPFORSIL = -L$(EV3_COMPILER_LIB_DIR)

CPP_SHAREDLIB_LDFLAGS += $(CPP_SHAREDLIB_LDFLAGS_SKIPFORSIL)

#-----------
# Linker
#-----------

LDFLAGS_SKIPFORSIL = -L$(EV3_COMPILER_LIB_DIR)

LDFLAGS += $(LDFLAGS_SKIPFORSIL)

#--------------------------
# Shared Library Linker
#--------------------------

SHAREDLIB_LDFLAGS_SKIPFORSIL = -L$(EV3_COMPILER_LIB_DIR)

SHAREDLIB_LDFLAGS += $(SHAREDLIB_LDFLAGS_SKIPFORSIL)

###########################################################################
## INLINED COMMANDS
###########################################################################


DERIVED_SRCS = $(subst .o,.dep,$(OBJS))

build:

%.dep:



-include codertarget_assembly_flags.mk
-include ../codertarget_assembly_flags.mk
-include *.dep


###########################################################################
## PHONY TARGETS
###########################################################################

.PHONY : all build buildobj clean info prebuild download execute


all : build
	@echo "### Successfully generated all binary outputs."


build : prebuild $(PRODUCT)


buildobj : prebuild $(OBJS) $(PREBUILT_OBJS)
	@echo "### Successfully generated all binary outputs."


prebuild : 


download : build


execute : download
	@echo "### Invoking postbuild tool "Execute" ..."
	$(EXECUTE) $(EXECUTE_FLAGS)
	@echo "### Done invoking postbuild tool."


###########################################################################
## FINAL TARGET
###########################################################################

#-------------------------------------------
# Create a standalone executable            
#-------------------------------------------

$(PRODUCT) : $(OBJS) $(PREBUILT_OBJS) $(MAIN_OBJ)
	@echo "### Creating standalone executable "$(PRODUCT)" ..."
	$(LD) $(LDFLAGS) -o $(PRODUCT) $(OBJS) $(MAIN_OBJ) $(SYSTEM_LIBS) $(TOOLCHAIN_LIBS)
	@echo "### Created: $(PRODUCT)"


###########################################################################
## INTERMEDIATE TARGETS
###########################################################################

#---------------------
# SOURCE-TO-OBJECT
#---------------------

%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : %.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(START_DIR)/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(START_DIR)/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(START_DIR)/lego_move_optitrack2_ert_rtw/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(START_DIR)/lego_move_optitrack2_ert_rtw/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/simulink/src/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/simulink/src/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/ext_mode/common/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/ext_mode/common/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


linuxinitialize.o : $(MATLAB_ROOT)/toolbox/target/codertarget/rtos/src/linuxinitialize.c
	$(CC) $(CFLAGS) -o $@ $<


rtiostream_tcpip.o : $(MATLAB_ROOT)/rtw/c/src/rtiostream/rtiostreamtcpip/rtiostream_tcpip.c
	$(CC) $(CFLAGS) -o $@ $<


driver_ev3_button.o : C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/ev3/src/driver_ev3_button.c
	$(CC) $(CFLAGS) -o $@ $<


driver_ev3_lcd.o : C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/ev3/src/driver_ev3_lcd.c
	$(CC) $(CFLAGS) -o $@ $<


MW_legoev3init.o : C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/ev3/src/MW_legoev3init.c
	$(CC) $(CFLAGS) -o $@ $<


driver_ev3_ultrasonic_sensor.o : C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/ev3/src/driver_ev3_ultrasonic_sensor.c
	$(CC) $(CFLAGS) -o $@ $<


###########################################################################
## DEPENDENCIES
###########################################################################

$(ALL_OBJS) : $(MAKEFILE) rtw_proj.tmw


###########################################################################
## MISCELLANEOUS TARGETS
###########################################################################

info : 
	@echo "### PRODUCT = $(PRODUCT)"
	@echo "### PRODUCT_TYPE = $(PRODUCT_TYPE)"
	@echo "### BUILD_TYPE = $(BUILD_TYPE)"
	@echo "### INCLUDES = $(INCLUDES)"
	@echo "### DEFINES = $(DEFINES)"
	@echo "### ALL_SRCS = $(ALL_SRCS)"
	@echo "### ALL_OBJS = $(ALL_OBJS)"
	@echo "### LIBS = $(LIBS)"
	@echo "### MODELREF_LIBS = $(MODELREF_LIBS)"
	@echo "### SYSTEM_LIBS = $(SYSTEM_LIBS)"
	@echo "### TOOLCHAIN_LIBS = $(TOOLCHAIN_LIBS)"
	@echo "### CFLAGS = $(CFLAGS)"
	@echo "### LDFLAGS = $(LDFLAGS)"
	@echo "### SHAREDLIB_LDFLAGS = $(SHAREDLIB_LDFLAGS)"
	@echo "### CPPFLAGS = $(CPPFLAGS)"
	@echo "### CPP_LDFLAGS = $(CPP_LDFLAGS)"
	@echo "### CPP_SHAREDLIB_LDFLAGS = $(CPP_SHAREDLIB_LDFLAGS)"
	@echo "### ARFLAGS = $(ARFLAGS)"
	@echo "### MEX_CFLAGS = $(MEX_CFLAGS)"
	@echo "### MEX_CPPFLAGS = $(MEX_CPPFLAGS)"
	@echo "### MEX_LDFLAGS = $(MEX_LDFLAGS)"
	@echo "### MEX_CPPLDFLAGS = $(MEX_CPPLDFLAGS)"
	@echo "### DOWNLOAD_FLAGS = $(DOWNLOAD_FLAGS)"
	@echo "### EXECUTE_FLAGS = $(EXECUTE_FLAGS)"
	@echo "### MAKE_FLAGS = $(MAKE_FLAGS)"


clean : 
	$(ECHO) "### Deleting all derived files..."
	$(RM) $(subst /,\,$(PRODUCT))
	$(RM) $(subst /,\,$(ALL_OBJS))
	$(RM) *.dep
	$(ECHO) "### Deleted all derived files."


