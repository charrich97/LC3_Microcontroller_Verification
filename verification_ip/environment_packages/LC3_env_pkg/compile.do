# Tcl do file for compile of LC3 interface

# pragma uvmf custom additional begin
# pragma uvmf custom additional end


# Include build for sub-environment writeback_env_pkg
quietly set cmd [format "source %s/environment_packages/writeback_env_pkg/compile.do" $env(UVMF_VIP_LIBRARY_HOME)]
eval $cmd
# Include build for sub-environment execute_env_pkg
quietly set cmd [format "source %s/environment_packages/execute_env_pkg/compile.do" $env(UVMF_VIP_LIBRARY_HOME)]
eval $cmd
# Include build for sub-environment controller_env_pkg
quietly set cmd [format "source %s/environment_packages/controller_env_pkg/compile.do" $env(UVMF_VIP_LIBRARY_HOME)]
eval $cmd
# Include build for sub-environment decode_env_pkg
quietly set cmd [format "source %s/environment_packages/decode_env_pkg/compile.do" $env(UVMF_VIP_LIBRARY_HOME)]
eval $cmd
# Include build for sub-environment fetch_env_pkg
quietly set cmd [format "source %s/environment_packages/fetch_env_pkg/compile.do" $env(UVMF_VIP_LIBRARY_HOME)]
eval $cmd
# Include build for sub-environment memaccess_env_pkg
quietly set cmd [format "source %s/environment_packages/memaccess_env_pkg/compile.do" $env(UVMF_VIP_LIBRARY_HOME)]
eval $cmd

quietly set cmd [format "vlog -timescale 1ps/1ps +incdir+%s/environment_packages/LC3_env_pkg" $env(UVMF_VIP_LIBRARY_HOME)]
quietly set cmd [format "%s %s/environment_packages/LC3_env_pkg/LC3_env_pkg.sv" $cmd $env(UVMF_VIP_LIBRARY_HOME)]
eval $cmd


