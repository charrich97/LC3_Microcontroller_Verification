# LC3 environment packages source and make target

# pragma uvmf custom additional begin
# pragma uvmf custom additional end

# Include all requisite sub-environment package targets for this bench
include $(UVMF_VIP_LIBRARY_HOME)/environment_packages/writeback_env_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/environment_packages/execute_env_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/environment_packages/controller_env_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/environment_packages/decode_env_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/environment_packages/fetch_env_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/environment_packages/memaccess_env_pkg/Makefile

LC3_ENV_PKG =\
		 $(UVMF_VIP_LIBRARY_HOME)/environment_packages/LC3_env_pkg/LC3_env_pkg.sv

COMP_LC3_PKG_TGT_0 = q_comp_LC3_env_pkg
COMP_LC3_PKG_TGT_1 = v_comp_LC3_env_pkg
COMP_LC3_PKG_TGT = $(COMP_LC3_PKG_TGT_$(USE_VELOCE))

comp_LC3_env_pkg: $(COMP_LC3_PKG_TGT) 

q_comp_LC3_env_pkg:    comp_writeback_env_pkg  comp_execute_env_pkg  comp_controller_env_pkg  comp_decode_env_pkg  comp_fetch_env_pkg  comp_memaccess_env_pkg 
		$(HVL_COMP_CMD) +incdir+$(UVMF_VIP_LIBRARY_HOME)/environment_packages/LC3_env_pkg $(LC3_ENV_PKG)

v_comp_LC3_env_pkg: q_comp_LC3_env_pkg
	$(VELANALYZE_HVL_CMD) +incdir+$(UVMF_VIP_LIBRARY_HOME)/environment_packages/LC3_env_pkg $(LC3_ENV_PKG)



ifeq ($(MTI_VCO_MODE),64)
  GCC_COMP_ARCH = -m64
else
  GCC_COMP_ARCH = -m32
endif

export LC3_ENV_DPI_SRC ?= $(UVMF_VIP_LIBRARY_HOME)/environment_packages/LC3_env_pkg/dpi

C_FILE_COMPILE_LIST_LC3_env_pkg	= \

O_FILE_COMPILE_LIST_LC3_env_pkg = $(notdir $(C_FILE_COMPILE_LIST_LC3_env_pkg:.c=.o))

GCC_COMP_ARGS_LC3_env_pkg	+= -I$(LC3_ENV_DPI_SRC) \
	-fPIC 

GCC_COMP_ARGS_LC3_env_pkg	+= $(LC3_ENV_GCC_COMP_ARGUMENTS)

GCC_LINK_ARGS_LC3_env_pkg	+= \
	 \
 	-o .so

comp_LC3_env_pkg_c_files:
	@echo "--------------------------------"
	@echo "Compiling Environment C source"
	@echo "--------------------------------"
	gcc $(GCC_COMP_ARCH) $(GCC_COMP_ARGS_LC3_env_pkg) $(C_FILE_COMPILE_LIST_LC3_env_pkg)
	@echo "--------------------------------"
	@echo "Linking Environment C objects into a shared object"
	@echo "--------------------------------"
	gcc $(GCC_COMP_ARCH) $(GCC_LINK_ARGS_LC3_env_pkg) $(O_FILE_COMPILE_LIST_LC3_env_pkg)
	@echo "--------------------------------"

