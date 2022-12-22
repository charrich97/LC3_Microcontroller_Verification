 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { writeback_writeback_in_agent_h }
wave add uvm_test_top.environment.writeback.writeback_in_agent_h.writeback_in_agent_h_monitor.txn_stream -radix string -tag F0
wave group writeback_writeback_in_agent_h_bus
wave add -group writeback_writeback_in_agent_h_bus hdl_top.writeback_writeback_in_agent_h_bus.* -radix hexadecimal -tag F0
wave group writeback_writeback_in_agent_h_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_writeback_out_agent_h }
wave add uvm_test_top.environment.writeback.writeback_out_agent_h.writeback_out_agent_h_monitor.txn_stream -radix string -tag F0
wave group writeback_writeback_out_agent_h_bus
wave add -group writeback_writeback_out_agent_h_bus hdl_top.writeback_writeback_out_agent_h_bus.* -radix hexadecimal -tag F0
wave group writeback_writeback_out_agent_h_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_agent_in }
wave add uvm_test_top.environment.execute.agent_in.agent_in_monitor.txn_stream -radix string -tag F0
wave group execute_agent_in_bus
wave add -group execute_agent_in_bus hdl_top.execute_agent_in_bus.* -radix hexadecimal -tag F0
wave group execute_agent_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_agent_out }
wave add uvm_test_top.environment.execute.agent_out.agent_out_monitor.txn_stream -radix string -tag F0
wave group execute_agent_out_bus
wave add -group execute_agent_out_bus hdl_top.execute_agent_out_bus.* -radix hexadecimal -tag F0
wave group execute_agent_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { controller_controller_in_agent_inst }
wave add uvm_test_top.environment.controller.controller_in_agent_inst.controller_in_agent_inst_monitor.txn_stream -radix string -tag F0
wave group controller_controller_in_agent_inst_bus
wave add -group controller_controller_in_agent_inst_bus hdl_top.controller_controller_in_agent_inst_bus.* -radix hexadecimal -tag F0
wave group controller_controller_in_agent_inst_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { controller_controller_out_agent_inst }
wave add uvm_test_top.environment.controller.controller_out_agent_inst.controller_out_agent_inst_monitor.txn_stream -radix string -tag F0
wave group controller_controller_out_agent_inst_bus
wave add -group controller_controller_out_agent_inst_bus hdl_top.controller_controller_out_agent_inst_bus.* -radix hexadecimal -tag F0
wave group controller_controller_out_agent_inst_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_decode_in_agent_inst }
wave add uvm_test_top.environment.decode.decode_in_agent_inst.decode_in_agent_inst_monitor.txn_stream -radix string -tag F0
wave group decode_decode_in_agent_inst_bus
wave add -group decode_decode_in_agent_inst_bus hdl_top.decode_decode_in_agent_inst_bus.* -radix hexadecimal -tag F0
wave group decode_decode_in_agent_inst_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_decode_out_agent_inst }
wave add uvm_test_top.environment.decode.decode_out_agent_inst.decode_out_agent_inst_monitor.txn_stream -radix string -tag F0
wave group decode_decode_out_agent_inst_bus
wave add -group decode_decode_out_agent_inst_bus hdl_top.decode_decode_out_agent_inst_bus.* -radix hexadecimal -tag F0
wave group decode_decode_out_agent_inst_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { fetch_fetch_in_agent_h }
wave add uvm_test_top.environment.fetch.fetch_in_agent_h.fetch_in_agent_h_monitor.txn_stream -radix string -tag F0
wave group fetch_fetch_in_agent_h_bus
wave add -group fetch_fetch_in_agent_h_bus hdl_top.fetch_fetch_in_agent_h_bus.* -radix hexadecimal -tag F0
wave group fetch_fetch_in_agent_h_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { fetch_fetch_out_agent_h }
wave add uvm_test_top.environment.fetch.fetch_out_agent_h.fetch_out_agent_h_monitor.txn_stream -radix string -tag F0
wave group fetch_fetch_out_agent_h_bus
wave add -group fetch_fetch_out_agent_h_bus hdl_top.fetch_fetch_out_agent_h_bus.* -radix hexadecimal -tag F0
wave group fetch_fetch_out_agent_h_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_memaccess_in_agent_h }
wave add uvm_test_top.environment.memaccess.memaccess_in_agent_h.memaccess_in_agent_h_monitor.txn_stream -radix string -tag F0
wave group memaccess_memaccess_in_agent_h_bus
wave add -group memaccess_memaccess_in_agent_h_bus hdl_top.memaccess_memaccess_in_agent_h_bus.* -radix hexadecimal -tag F0
wave group memaccess_memaccess_in_agent_h_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_memaccess_out_agent_h }
wave add uvm_test_top.environment.memaccess.memaccess_out_agent_h.memaccess_out_agent_h_monitor.txn_stream -radix string -tag F0
wave group memaccess_memaccess_out_agent_h_bus
wave add -group memaccess_memaccess_out_agent_h_bus hdl_top.memaccess_memaccess_out_agent_h_bus.* -radix hexadecimal -tag F0
wave group memaccess_memaccess_out_agent_h_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { data_memory_agent }
wave add uvm_test_top.environment.data_memory_agent.data_memory_agent_monitor.txn_stream -radix string -tag F0
wave group data_memory_agent_bus
wave add -group data_memory_agent_bus hdl_top.data_memory_agent_bus.* -radix hexadecimal -tag F0
wave group data_memory_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { instruction_memory_agent }
wave add uvm_test_top.environment.instruction_memory_agent.instruction_memory_agent_monitor.txn_stream -radix string -tag F0
wave group instruction_memory_agent_bus
wave add -group instruction_memory_agent_bus hdl_top.instruction_memory_agent_bus.* -radix hexadecimal -tag F0
wave group instruction_memory_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]

wave update on
WaveSetStreamView

