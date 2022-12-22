//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------                     
//               
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.  
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//

module hdl_top();

  import LC3_parameters_pkg::*;
  import uvmf_base_pkg_hdl::*;

  // pragma attribute hdl_top partition_module_xrtl                                            
  // pragma uvmf custom clock_generator begin
  bit clk;
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    #1ns;
    clk = 0;
    forever begin
      clk = ~clk;
      #10ns;
    end
  end
  // pragma uvmf custom clock_generator end

  // pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 1;
    #100ns;
    rst = 0;
  end
  // pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
  writeback_in_if writeback_writeback_in_agent_h_bus (
      // pragma uvmf custom writeback_writeback_in_agent_h_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom writeback_writeback_in_agent_h_bus_connections end
  );
  writeback_out_if writeback_writeback_out_agent_h_bus (
      // pragma uvmf custom writeback_writeback_out_agent_h_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom writeback_writeback_out_agent_h_bus_connections end
  );
  execute_in_if execute_agent_in_bus (
      // pragma uvmf custom execute_agent_in_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom execute_agent_in_bus_connections end
  );
  execute_out_if execute_agent_out_bus (
      // pragma uvmf custom execute_agent_out_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom execute_agent_out_bus_connections end
  );
  controller_in_if controller_controller_in_agent_inst_bus (
      // pragma uvmf custom controller_controller_in_agent_inst_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom controller_controller_in_agent_inst_bus_connections end
  );
  controller_out_if controller_controller_out_agent_inst_bus (
      // pragma uvmf custom controller_controller_out_agent_inst_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom controller_controller_out_agent_inst_bus_connections end
  );
  decode_in_if decode_decode_in_agent_inst_bus (
      // pragma uvmf custom decode_decode_in_agent_inst_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom decode_decode_in_agent_inst_bus_connections end
  );
  decode_out_if decode_decode_out_agent_inst_bus (
      // pragma uvmf custom decode_decode_out_agent_inst_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom decode_decode_out_agent_inst_bus_connections end
  );
  fetch_in_if fetch_fetch_in_agent_h_bus (
      // pragma uvmf custom fetch_fetch_in_agent_h_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom fetch_fetch_in_agent_h_bus_connections end
  );
  fetch_out_if fetch_fetch_out_agent_h_bus (
      // pragma uvmf custom fetch_fetch_out_agent_h_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom fetch_fetch_out_agent_h_bus_connections end
  );
  memaccess_in_if memaccess_memaccess_in_agent_h_bus (
      // pragma uvmf custom memaccess_memaccess_in_agent_h_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom memaccess_memaccess_in_agent_h_bus_connections end
  );
  memaccess_out_if memaccess_memaccess_out_agent_h_bus (
      // pragma uvmf custom memaccess_memaccess_out_agent_h_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom memaccess_memaccess_out_agent_h_bus_connections end
  );
  data_memory_if data_memory_agent_bus (
      // pragma uvmf custom data_memory_agent_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom data_memory_agent_bus_connections end
  );
  instruction_memory_if instruction_memory_agent_bus (
      // pragma uvmf custom instruction_memory_agent_bus_connections begin
      .clock(clk),
      .reset(rst)
      // pragma uvmf custom instruction_memory_agent_bus_connections end
  );
  writeback_in_monitor_bfm writeback_writeback_in_agent_h_mon_bfm (
      writeback_writeback_in_agent_h_bus.monitor_port
  );
  writeback_out_monitor_bfm writeback_writeback_out_agent_h_mon_bfm (
      writeback_writeback_out_agent_h_bus.monitor_port
  );
  execute_in_monitor_bfm execute_agent_in_mon_bfm (execute_agent_in_bus.monitor_port);
  execute_out_monitor_bfm execute_agent_out_mon_bfm (execute_agent_out_bus.monitor_port);
  controller_in_monitor_bfm controller_controller_in_agent_inst_mon_bfm (
      controller_controller_in_agent_inst_bus.monitor_port
  );
  controller_out_monitor_bfm controller_controller_out_agent_inst_mon_bfm (
      controller_controller_out_agent_inst_bus.monitor_port
  );
  decode_in_monitor_bfm decode_decode_in_agent_inst_mon_bfm (
      decode_decode_in_agent_inst_bus.monitor_port
  );
  decode_out_monitor_bfm decode_decode_out_agent_inst_mon_bfm (
      decode_decode_out_agent_inst_bus.monitor_port
  );
  fetch_in_monitor_bfm fetch_fetch_in_agent_h_mon_bfm (fetch_fetch_in_agent_h_bus.monitor_port);
  fetch_out_monitor_bfm fetch_fetch_out_agent_h_mon_bfm (fetch_fetch_out_agent_h_bus.monitor_port);
  memaccess_in_monitor_bfm memaccess_memaccess_in_agent_h_mon_bfm (
      memaccess_memaccess_in_agent_h_bus.monitor_port
  );
  memaccess_out_monitor_bfm memaccess_memaccess_out_agent_h_mon_bfm (
      memaccess_memaccess_out_agent_h_bus.monitor_port
  );
  data_memory_monitor_bfm data_memory_agent_mon_bfm (data_memory_agent_bus.monitor_port);
  instruction_memory_monitor_bfm instruction_memory_agent_mon_bfm (
      instruction_memory_agent_bus.monitor_port
  );
  data_memory_driver_bfm data_memory_agent_drv_bfm (data_memory_agent_bus.responder_port);
  instruction_memory_driver_bfm instruction_memory_agent_drv_bfm (
      instruction_memory_agent_bus.responder_port
  );

  // pragma uvmf custom dut_instantiation begin
  // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
  // Instantiate your DUT here
  // These DUT's instantiated to show verilog and vhdl instantiation
  //   verilog_dut         dut_verilog(   .clk(clk), .rst(rst), .in_signal(vhdl_to_verilog_signal), .out_signal(verilog_to_vhdl_signal));
  //   vhdl_dut            dut_vhdl   (   .clk(clk), .rst(rst), .in_signal(verilog_to_vhdl_signal), .out_signal(vhdl_to_verilog_signal));

  //***************************************************************************
  // LC3 Top Module
  //***************************************************************************
  LC3 DUT (
      .clock         (clk),
      .reset         (rst),
      .pc            (instruction_memory_agent_bus.PC),
      .instrmem_rd   (instruction_memory_agent_bus.instrmem_rd),
      .Instr_dout    (instruction_memory_agent_bus.Instr_dout),
      .complete_instr(instruction_memory_agent_bus.complete_instr),
      .complete_data (data_memory_agent_bus.complete_data),
      .Data_dout     (data_memory_agent_bus.Data_dout),
      .Data_din      (data_memory_agent_bus.Data_din),
      .Data_rd       (data_memory_agent_bus.Data_rd),
      .Data_addr     (data_memory_agent_bus.Data_addr)
  );

  //***************************************************************************
  // Controller Module Input Signals
  //***************************************************************************

  assign controller_controller_in_agent_inst_bus.complete_data     = DUT.Ctrl.complete_data;
  assign controller_controller_in_agent_inst_bus.complete_instr    = DUT.Ctrl.complete_instr;
  assign controller_controller_in_agent_inst_bus.IR                = DUT.Ctrl.IR;
  assign controller_controller_in_agent_inst_bus.IR_Exec           = DUT.Ctrl.IR_Exec;
  assign controller_controller_in_agent_inst_bus.psr               = DUT.Ctrl.psr;
  assign controller_controller_in_agent_inst_bus.NZP               = DUT.Ctrl.NZP;
  assign controller_controller_in_agent_inst_bus.IMem_dout         = DUT.Ctrl.Instr_dout;


  //***************************************************************************
  // Controller Module Output Signals
  //***************************************************************************
  assign controller_controller_out_agent_inst_bus.bypass_alu_1     = DUT.Ctrl.bypass_alu_1;
  assign controller_controller_out_agent_inst_bus.bypass_alu_2     = DUT.Ctrl.bypass_alu_2;
  assign controller_controller_out_agent_inst_bus.bypass_mem_1     = DUT.Ctrl.bypass_mem_1;
  assign controller_controller_out_agent_inst_bus.bypass_mem_2     = DUT.Ctrl.bypass_mem_2;
  assign controller_controller_out_agent_inst_bus.enable_fetch     = DUT.Ctrl.enable_fetch;
  assign controller_controller_out_agent_inst_bus.enable_decode    = DUT.Ctrl.enable_decode;
  assign controller_controller_out_agent_inst_bus.enable_execute   = DUT.Ctrl.enable_execute;
  assign controller_controller_out_agent_inst_bus.enable_writeback = DUT.Ctrl.enable_writeback;
  assign controller_controller_out_agent_inst_bus.enable_updatePC  = DUT.Ctrl.enable_updatePC;
  assign controller_controller_out_agent_inst_bus.mem_state        = DUT.Ctrl.mem_state;
  assign controller_controller_out_agent_inst_bus.br_taken         = DUT.Ctrl.br_taken;

  //***************************************************************************
  // Fetch Module Signals Input Signals
  //***************************************************************************
  assign fetch_fetch_in_agent_h_bus.enable_updatePC                = DUT.Fetch.enable_updatePC;
  assign fetch_fetch_in_agent_h_bus.enable_fetch                   = DUT.Fetch.enable_fetch;
  assign fetch_fetch_in_agent_h_bus.taddr                          = DUT.Fetch.taddr;
  assign fetch_fetch_in_agent_h_bus.brtaken                       = DUT.Fetch.br_taken;

  //***************************************************************************
  // Fetch Module Signals Output Signals
  //***************************************************************************
  assign fetch_fetch_out_agent_h_bus.enable_fetch                  = DUT.Fetch.enable_fetch;
  assign fetch_fetch_out_agent_h_bus.pc                            = DUT.Fetch.pc;
  assign fetch_fetch_out_agent_h_bus.npc                           = DUT.Fetch.npc_out;
  assign fetch_fetch_out_agent_h_bus.imem_rd                       = DUT.Fetch.instrmem_rd;

  //***************************************************************************
  // Decode Module Input Signals
  //***************************************************************************
  assign decode_decode_in_agent_inst_bus.enable_decode             = DUT.Dec.enable_decode;
  assign decode_decode_in_agent_inst_bus.Instr_dout                = DUT.Dec.dout;
  assign decode_decode_in_agent_inst_bus.npc_in                    = DUT.Dec.npc_in;

  //***************************************************************************
  // Decode Module Output Signals
  //***************************************************************************
  assign decode_decode_out_agent_inst_bus.enable_decode            = DUT.Dec.enable_decode;
  assign decode_decode_out_agent_inst_bus.IR                       = DUT.Dec.IR;
  assign decode_decode_out_agent_inst_bus.E_control                = DUT.Dec.E_Control;
  assign decode_decode_out_agent_inst_bus.npc_out                  = DUT.Dec.npc_out;
  assign decode_decode_out_agent_inst_bus.Mem_control              = DUT.Dec.Mem_Control;
  assign decode_decode_out_agent_inst_bus.W_control                = DUT.Dec.W_Control;

  //***************************************************************************
  // Execute Module Input Signals
  //***************************************************************************
  assign execute_agent_in_bus.W_Control_in                         = DUT.Ex.W_Control_in;
  assign execute_agent_in_bus.Mem_Control_in                       = DUT.Ex.Mem_Control_in;
  assign execute_agent_in_bus.E_control                            = DUT.Ex.E_Control;
  assign execute_agent_in_bus.IR                                   = DUT.Ex.IR;
  assign execute_agent_in_bus.npc_in                               = DUT.Ex.npc;
  assign execute_agent_in_bus.VSR1                                 = DUT.Ex.VSR1;
  assign execute_agent_in_bus.VSR2                                 = DUT.Ex.VSR2;
  assign execute_agent_in_bus.Mem_Bypass_Val                       = DUT.Ex.Mem_Bypass_Val;
  assign execute_agent_in_bus.bypass_alu_1                         = DUT.Ex.bypass_alu_1;
  assign execute_agent_in_bus.bypass_alu_2                         = DUT.Ex.bypass_alu_2;
  assign execute_agent_in_bus.bypass_mem_1                         = DUT.Ex.bypass_mem_1;
  assign execute_agent_in_bus.bypass_mem_2                         = DUT.Ex.bypass_mem_2;
  assign execute_agent_in_bus.enable_execute                       = DUT.Ex.enable_execute;

  //***************************************************************************
  // Execute Module Output Signals
  //***************************************************************************
  assign execute_agent_out_bus.W_Control_out                       = DUT.Ex.W_Control_out;
  assign execute_agent_out_bus.Mem_Control_out                     = DUT.Ex.Mem_Control_out;
  assign execute_agent_out_bus.aluout                              = DUT.Ex.aluout;
  assign execute_agent_out_bus.pcout                               = DUT.Ex.pcout;
  assign execute_agent_out_bus.sr1                                 = DUT.Ex.sr1;
  assign execute_agent_out_bus.sr2                                 = DUT.Ex.sr2;
  assign execute_agent_out_bus.dr                                  = DUT.Ex.dr;
  assign execute_agent_out_bus.M_Data                              = DUT.Ex.M_Data;
  assign execute_agent_out_bus.NZP                                 = DUT.Ex.NZP;
  assign execute_agent_out_bus.IR_Exec                             = DUT.Ex.IR_Exec;
  assign execute_agent_out_bus.enable_execute_status               = DUT.Ex.enable_execute;

  //***************************************************************************
  // MemAccess Module Input Signals
  //***************************************************************************
  assign memaccess_memaccess_in_agent_h_bus.mem_state              = DUT.MemAccess.mem_state;
  assign memaccess_memaccess_in_agent_h_bus.M_control              = DUT.MemAccess.M_Control;
  assign memaccess_memaccess_in_agent_h_bus.M_Data                 = DUT.MemAccess.M_Data;
  assign memaccess_memaccess_in_agent_h_bus.M_addr                 = DUT.MemAccess.M_Addr;
  assign memaccess_memaccess_in_agent_h_bus.DMem_dout              = DUT.MemAccess.Data_dout;

  //***************************************************************************
  // MemAccess Module Output Signals
  //***************************************************************************
  assign memaccess_memaccess_out_agent_h_bus.DMem_addr             = DUT.MemAccess.Data_addr;
  assign memaccess_memaccess_out_agent_h_bus.DMem_rd               = DUT.MemAccess.Data_rd;
  assign memaccess_memaccess_out_agent_h_bus.DMem_din              = DUT.MemAccess.Data_din;
  assign memaccess_memaccess_out_agent_h_bus.memout                = DUT.MemAccess.memout;

  //***************************************************************************
  // Writeback Module Input Signals
  //***************************************************************************
  assign writeback_writeback_in_agent_h_bus.enable_writeback       = DUT.WB.enable_writeback;
  assign writeback_writeback_in_agent_h_bus.aluout                 = DUT.WB.aluout;
  assign writeback_writeback_in_agent_h_bus.memout                 = DUT.WB.memout;
  assign writeback_writeback_in_agent_h_bus.sr1                    = DUT.WB.sr1;
  assign writeback_writeback_in_agent_h_bus.sr2                    = DUT.WB.sr2;
  assign writeback_writeback_in_agent_h_bus.dr                     = DUT.WB.dr;
  assign writeback_writeback_in_agent_h_bus.npc                    = DUT.WB.npc;
  assign writeback_writeback_in_agent_h_bus.pcout                  = DUT.WB.pcout;
  assign writeback_writeback_in_agent_h_bus.W_control              = DUT.WB.W_Control;

  //***************************************************************************
  // Writeback Module Output Signals
  //***************************************************************************
  assign writeback_writeback_out_agent_h_bus.enable_writeback      = DUT.WB.enable_writeback;
  assign writeback_writeback_out_agent_h_bus.VSR1                  = DUT.WB.d1;
  assign writeback_writeback_out_agent_h_bus.VSR2                  = DUT.WB.d2;
  assign writeback_writeback_out_agent_h_bus.psr                   = DUT.WB.psr;

  // pragma uvmf custom dut_instantiation end

  initial begin  // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db#(virtual writeback_in_monitor_bfm)::set(null, UVMF_VIRTUAL_INTERFACES,
                                                          writeback_writeback_in_agent_h_BFM,
                                                          writeback_writeback_in_agent_h_mon_bfm);
    uvm_config_db#(virtual writeback_out_monitor_bfm)::set(null, UVMF_VIRTUAL_INTERFACES,
                                                           writeback_writeback_out_agent_h_BFM,
                                                           writeback_writeback_out_agent_h_mon_bfm);
    uvm_config_db#(virtual execute_in_monitor_bfm)::set(
        null, UVMF_VIRTUAL_INTERFACES, execute_agent_in_BFM, execute_agent_in_mon_bfm);
    uvm_config_db#(virtual execute_out_monitor_bfm)::set(
        null, UVMF_VIRTUAL_INTERFACES, execute_agent_out_BFM, execute_agent_out_mon_bfm);
    uvm_config_db#(virtual controller_in_monitor_bfm)::set(
        null, UVMF_VIRTUAL_INTERFACES, controller_controller_in_agent_inst_BFM,
        controller_controller_in_agent_inst_mon_bfm);
    uvm_config_db#(virtual controller_out_monitor_bfm)::set(
        null, UVMF_VIRTUAL_INTERFACES, controller_controller_out_agent_inst_BFM,
        controller_controller_out_agent_inst_mon_bfm);
    uvm_config_db#(virtual decode_in_monitor_bfm)::set(null, UVMF_VIRTUAL_INTERFACES,
                                                       decode_decode_in_agent_inst_BFM,
                                                       decode_decode_in_agent_inst_mon_bfm);
    uvm_config_db#(virtual decode_out_monitor_bfm)::set(null, UVMF_VIRTUAL_INTERFACES,
                                                        decode_decode_out_agent_inst_BFM,
                                                        decode_decode_out_agent_inst_mon_bfm);
    uvm_config_db#(virtual fetch_in_monitor_bfm)::set(
        null, UVMF_VIRTUAL_INTERFACES, fetch_fetch_in_agent_h_BFM, fetch_fetch_in_agent_h_mon_bfm);
    uvm_config_db#(virtual fetch_out_monitor_bfm)::set(null, UVMF_VIRTUAL_INTERFACES,
                                                       fetch_fetch_out_agent_h_BFM,
                                                       fetch_fetch_out_agent_h_mon_bfm);
    uvm_config_db#(virtual memaccess_in_monitor_bfm)::set(null, UVMF_VIRTUAL_INTERFACES,
                                                          memaccess_memaccess_in_agent_h_BFM,
                                                          memaccess_memaccess_in_agent_h_mon_bfm);
    uvm_config_db#(virtual memaccess_out_monitor_bfm)::set(null, UVMF_VIRTUAL_INTERFACES,
                                                           memaccess_memaccess_out_agent_h_BFM,
                                                           memaccess_memaccess_out_agent_h_mon_bfm);
    uvm_config_db#(virtual data_memory_monitor_bfm)::set(
        null, UVMF_VIRTUAL_INTERFACES, data_memory_agent_BFM, data_memory_agent_mon_bfm);
    uvm_config_db#(virtual instruction_memory_monitor_bfm)::set(null, UVMF_VIRTUAL_INTERFACES,
                                                                instruction_memory_agent_BFM,
                                                                instruction_memory_agent_mon_bfm);
    uvm_config_db#(virtual data_memory_driver_bfm)::set(
        null, UVMF_VIRTUAL_INTERFACES, data_memory_agent_BFM, data_memory_agent_drv_bfm);
    uvm_config_db#(virtual instruction_memory_driver_bfm)::set(null, UVMF_VIRTUAL_INTERFACES,
                                                               instruction_memory_agent_BFM,
                                                               instruction_memory_agent_drv_bfm);
  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end

