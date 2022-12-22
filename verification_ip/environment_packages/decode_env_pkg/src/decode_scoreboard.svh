class decode_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(decode_scoreboard)

  `uvm_analysis_imp_decl(_actual   );
  `uvm_analysis_imp_decl(_expected );

  uvm_analysis_imp_actual     #(decode_out_transaction  , decode_scoreboard ) actual      ;
  uvm_analysis_imp_expected   #(decode_out_transaction  , decode_scoreboard ) expected    ;
  
  decode_out_transaction        expected_hash[$]                                            ;

  typedef enum int  {   DECODE_PREDICTED_TRANSACTIONS   = 0 , 
                        DECODE_ACTUAL_TRANSACTIONS      = 1 , 
                        DECODE_TRANSACTION_MATCHES      = 2 , 
                        DECODE_TRANSACTION_MISMATCHES   = 3 ,
                        DECODE_TRANSACTION_NOT_RECEIVED = 4
                    }   report_variables_index_t          ;
  int     report_variables[report_variables_index_t];                                                                                                             ;
  string  report_header                       = "DECODE SCOREBOARD RESULTS"                                                                                       ;
  int     unsigned nothing_to_compare_against_count                                                                                                               ;
  int     unsigned match_count                                                                                                                                    ;
  int     unsigned expected_transaction_count                                                                                                                     ;
  int     unsigned actual_transaction_count                                                                                                                       ;
  int     unsigned mismatch_count                                                                                                                                 ;
  bit     end_of_activity_check                                                                                                                                   ;
  bit     end_of_test_empty_check                                                                                                                                 ;
  bit     wait_for_scoreboard_empty                                                                                                                               ;
  event   entry_received_event                                                                                                                                    ;
  event   scoreboard_has_drained                                                                                                                                  ;

  extern         function         new                         (string                   name  ="decode_scoreboard" , uvm_component parent  = null             )   ;
  extern virtual function void    build_phase                 (uvm_phase                phase                                                                 )   ;
  extern virtual function void    check_phase                 (uvm_phase                phase                                                                 )   ;
  extern virtual function void    report_phase                (uvm_phase                phase                                                                 )   ;
  extern virtual function void    phase_ready_to_end          (uvm_phase                phase                                                                 )   ;
  extern virtual function void    write_expected              (decode_out_transaction   t                                                                     )   ;
  extern virtual function void    write_actual                (decode_out_transaction   t                                                                     )   ; 
  extern virtual task             wait_for_scoreboard_drain   (                                                                                               )   ;
  extern virtual function string  report_message              (string                   header                      , int variables [report_variables_index_t])   ; 
endclass : decode_scoreboard

function decode_scoreboard::new(string name = "decode_scoreboard", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void decode_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  actual                    = new ("obsvr_ae"                   , this        ) ;
  expected                  = new ("predict_ae"                 , this        ) ;
  wait_for_scoreboard_empty = 1                                                 ;
endfunction

function void decode_scoreboard::phase_ready_to_end(uvm_phase phase);
  if (phase.get_name() == "run")
    begin : if_run_phase
      if (wait_for_scoreboard_empty) begin : if_wait_for_scoreboard_empty
        phase.raise_objection(this);
        fork begin : wait_for_scoreboard_to_drain
          wait_for_scoreboard_drain();
          phase.drop_objection(this);
        end : wait_for_scoreboard_to_drain
        join_none
      end : if_wait_for_scoreboard_empty
    end : if_run_phase
  end_of_test_empty_check = 1;
  end_of_activity_check   = 1;
endfunction : phase_ready_to_end

function void decode_scoreboard::write_expected(decode_out_transaction t);
  expected_hash.push_back(t)    ;
  -> entry_received_event       ;
  expected_transaction_count ++ ;
endfunction : write_expected

function void decode_scoreboard::write_actual(decode_out_transaction t);
  decode_out_transaction        decode_out_predict_trans;
  -> entry_received_event       ;
  actual_transaction_count ++   ;

  if (expected_hash.size() != 0) begin : item_exists_in_array
    decode_out_predict_trans = expected_hash.pop_front();
    if (t.compare(decode_out_predict_trans)) begin : compare_pass
      match_count ++;
      `uvm_info (get_full_name(), $sformatf("CORRECT SCOREBOARD TRANSACTION   %s" , t.convert2string()), UVM_LOW  );
    end : compare_pass
    else begin : compare_fail
      mismatch_count ++;
      `uvm_error(get_name(), $sformatf("INCORRECT SCOREBOARD TRANSACTION %s" , t.convert2string()));
    end : compare_fail
  end : item_exists_in_array
  else begin : no_item_exists_in_array
    nothing_to_compare_against_count ++;
    `uvm_error(get_full_name(), $sformatf("NO PREDICTED ENTRY RECEIVED"));
  end : no_item_exists_in_array
endfunction : write_actual


function void decode_scoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase); 
  if (end_of_activity_check  && (actual_transaction_count == 0)) begin: actual_transactions_not_received
    `uvm_error(get_full_name(), $sformatf("ACTUAL SCOOREBOARD ENTRIES HAVE NOT BEEN RECEIVED"));
  end : actual_transactions_not_received
  if (end_of_activity_check  && (expected_transaction_count == 0)) begin: expected_transactions_not_received
    `uvm_error(get_full_name(), $sformatf("EXPECTED SCOOREBOARD ENTRIES HAVE NOT BEEN RECEIVED"));
  end : expected_transactions_not_received
  if (end_of_test_empty_check && (expected_hash.size() != 0)) begin : entries_remain
    `uvm_error(get_full_name(), $sformatf("SCOREBOARD NOT EMPTY"));
  end : entries_remain 
  
endfunction : check_phase

task decode_scoreboard::wait_for_scoreboard_drain();
  while(expected_hash.size() != 0) begin: while_transaction_entries_remain
    @(entry_received_event);
  end : while_transaction_entries_remain
  -> scoreboard_has_drained;
endtask : wait_for_scoreboard_drain

function void decode_scoreboard::report_phase(uvm_phase phase);
  super.report_phase(phase);
  report_variables[0] = expected_transaction_count        ;
  report_variables[1] = actual_transaction_count          ;
  report_variables[2] = match_count                       ;
  report_variables[3] = mismatch_count                    ;
  report_variables[4] = nothing_to_compare_against_count  ;
  `uvm_info(get_full_name(), report_message(report_header, report_variables), UVM_LOW ) 
endfunction

function string decode_scoreboard::report_message(string header, int variables [report_variables_index_t]);
  string s = " ";
  s = {s, $sformatf("\n********%s*********\n", header                                                 )};
  s = {s, $sformatf("NUM PREDICTED  TRANSACTIONS: %d\n", variables[DECODE_PREDICTED_TRANSACTIONS    ] )};
  s = {s, $sformatf("NUM ACTUAL     TRANSACTIONS: %d\n", variables[DECODE_ACTUAL_TRANSACTIONS       ] )};
  s = {s, $sformatf("NUM CORRECT    TRANSACTIONS: %d\n", variables[DECODE_TRANSACTION_MATCHES       ] )};
  s = {s, $sformatf("NUM INCORRECT  TRANSACTIONS: %d\n", variables[DECODE_TRANSACTION_MISMATCHES    ] )};
  s = {s, $sformatf("NUM ENTRIES NOT RECEIVED   : %d\n", variables[DECODE_TRANSACTION_NOT_RECEIVED  ] )};
  s = {s, $sformatf("******************************************\n"                                    )};
  return s; 
endfunction
