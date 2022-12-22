
// UVM
+incdir+${UVM_HOME}/src
${UVM_HOME}/src/uvm_pkg.sv

// Common UVMF files
-f ${UVMF_HOME}/common/common_sve.f

// Sub-Environments
-F ${UVMF_VIP_LIBRARY_HOME}/environment_packages/writeback_env_pkg/writeback_env_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/environment_packages/execute_env_pkg/execute_env_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/environment_packages/controller_env_pkg/controller_env_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/environment_packages/decode_env_pkg/decode_env_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/environment_packages/fetch_env_pkg/fetch_env_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/environment_packages/memaccess_env_pkg/memaccess_env_pkg_sve.F

+incdir+.
./LC3_env_pkg.sv
