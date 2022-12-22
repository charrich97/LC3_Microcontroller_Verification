# instruction_memory interface packages source
# pragma uvmf custom additional begin
# pragma uvmf custom additional end

instruction_memory_PKG         = \
	+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/instruction_memory_pkg \
	-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/instruction_memory_pkg/instruction_memory_filelist_hvl.f 

instruction_memory_PKG_HDL         = \
	+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/instruction_memory_pkg \
	-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/instruction_memory_pkg/instruction_memory_filelist_hdl.f 

instruction_memory_PKG_XRTL         = \
	+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/instruction_memory_pkg \
	-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/instruction_memory_pkg/instruction_memory_filelist_xrtl.f 

COMP_instruction_memory_PKG_TGT_0 = q_comp_instruction_memory_pkg
COMP_instruction_memory_PKG_TGT_1 = v_comp_instruction_memory_pkg
COMP_instruction_memory_PKG_TGT = $(COMP_instruction_memory_PKG_TGT_$(USE_VELOCE))

comp_instruction_memory_pkg: $(COMP_instruction_memory_PKG_TGT) 

q_comp_instruction_memory_pkg:
	$(HDL_COMP_CMD) $(instruction_memory_PKG_HDL)
	$(HVL_COMP_CMD) $(instruction_memory_PKG)
	$(HDL_COMP_CMD) $(instruction_memory_PKG_XRTL) 

v_comp_instruction_memory_pkg:
	$(HVL_COMP_CMD) $(instruction_memory_PKG_HDL)
	$(HVL_COMP_CMD) $(instruction_memory_PKG)
	$(VELANALYZE_CMD) $(instruction_memory_PKG_HDL) 
	$(VELANALYZE_HVL_CMD) $(instruction_memory_PKG) 
	$(HDL_COMP_CMD) $(instruction_memory_PKG_XRTL)

ifeq ($(MTI_VCO_MODE),64)
  GCC_COMP_ARCH = -m64
else
  GCC_COMP_ARCH = -m32
endif

export instruction_memory_IF_DPI_SRC ?= $(UVMF_VIP_LIBRARY_HOME)/interface_packages/instruction_memory_pkg/dpi

C_FILE_COMPILE_LIST_instruction_memory_pkg	= \

O_FILE_COMPILE_LIST_instruction_memory_pkg = $(notdir $(C_FILE_COMPILE_LIST_instruction_memory_pkg:.c=.o))

GCC_COMP_ARGS_instruction_memory_pkg	+= -I$(instruction_memory_IF_DPI_SRC) \
	-fPIC 

GCC_COMP_ARGS_instruction_memory_pkg	+= $(instruction_memory_IF_GCC_COMP_ARGUMENTS)

GCC_LINK_ARGS_instruction_memory_pkg	+= \
	 \
 	-o .so

comp_instruction_memory_pkg_c_files:
	@echo "--------------------------------"
	@echo "Compiling Interface C source"
	@echo "--------------------------------"
	gcc $(GCC_COMP_ARCH) $(GCC_COMP_ARGS_instruction_memory_pkg) $(C_FILE_COMPILE_LIST_instruction_memory_pkg)
	@echo "--------------------------------"
	@echo "Linking Interface C objects into a shared object"
	@echo "--------------------------------"
	gcc $(GCC_COMP_ARCH) $(GCC_LINK_ARGS_instruction_memory_pkg) $(O_FILE_COMPILE_LIST_instruction_memory_pkg)
	@echo "--------------------------------"

