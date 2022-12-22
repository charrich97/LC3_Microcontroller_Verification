onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hdl_top/decode_decode_in_agent_inst_bus/clock
add wave -noupdate /hdl_top/decode_decode_in_agent_inst_bus/reset
add wave -noupdate /hdl_top/decode_decode_in_agent_inst_bus/enable_decode
add wave -noupdate /hdl_top/decode_decode_in_agent_inst_bus/Instr_dout
add wave -noupdate /hdl_top/decode_decode_in_agent_inst_bus/npc_in
add wave -noupdate /hdl_top/decode_decode_in_agent_inst_bus/psr
add wave -noupdate /hdl_top/decode_decode_out_agent_inst_bus/clock
add wave -noupdate /hdl_top/decode_decode_out_agent_inst_bus/reset
add wave -noupdate /hdl_top/decode_decode_out_agent_inst_bus/IR
add wave -noupdate /hdl_top/decode_decode_out_agent_inst_bus/npc_out
add wave -noupdate /hdl_top/decode_decode_out_agent_inst_bus/E_control
add wave -noupdate /hdl_top/decode_decode_out_agent_inst_bus/W_control
add wave -noupdate /hdl_top/decode_decode_out_agent_inst_bus/Mem_control
add wave -noupdate /hdl_top/decode_decode_out_agent_inst_bus/enable_decode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2581000 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 214
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {8506050 ns}
