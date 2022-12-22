
   // The execute_model function models the behavior of the execute unit
   // The return value indicates model results status: 0 success, 1 failure
   function bit execute_model(

        input bit   [5:0] E_Control,
        input bit         bypass_alu_1,
        input bit         bypass_alu_2,
        input bit         bypass_mem_1,
        input bit         bypass_mem_2,
        input bit         enable_execute,
        input bit  [15:0] IR,
        input bit  [15:0] npc_in,
        input bit         Mem_Control_in,
        input bit  [1:0]  W_Control_in,
        input bit  [15:0] Mem_Bypass_Val,
        input bit  [15:0] VSR1,
        input bit  [15:0] VSR2,

        output bit [15:0] aluout,              
        output bit [1:0]  W_Control_out,       
        output bit        Mem_Control_out,     
        output bit [15:0] M_Data,              
        output bit [2:0]  dr,                  
        output bit [2:0]  sr1,                 
        output bit [2:0]  sr2,                 
        output bit [15:0] IR_Exec,             
        output bit [2:0]  NZP,                 
        output bit [15:0] pcout
        );

//local variables

	logic [15:0] alu1;
	logic [15:0] alu2;



               // source registers
                case (IR[15:12]) 
                    ADD, AND :
                        begin
                            sr1  = IR[8:6];
                            sr2  = IR[2:0];
                        end
                    NOT :
                        begin
                            sr1  = IR[8:6];
                            sr2  = IR[2:0];
                        end
                    LD, LDR, LDI, LEA :
                        begin
                            sr1  = IR[8:6];
                            sr2  = 0;
                        end
                    ST, STR, STI :
                        begin
                            sr1  = IR[8:6];
                            sr2  = IR[11:9];
                        end
                    BR, JMP:
                        begin
                            sr1  = IR[8:6];
                            sr2  = 0;
                        end
                    default :
                        begin
                            sr1  = 0;
                            sr2  = 0; 
                        end
                endcase

            if(enable_execute)
            begin
                Mem_Control_out  = Mem_Control_in;
                W_Control_out    = W_Control_in;
                IR_Exec          = IR;
                
                // destination registers
                case (IR[15:12]) 
                    ADD, AND :
                        begin
                            dr   = IR[11:9];
                        end
                    NOT :
                        begin
                            dr   = IR[11:9];
                        end
                    LD, LDR, LDI, LEA :
                        begin
                            dr   = IR[11:9];
                        end
                    ST, STR, STI :
                        begin
                            dr   = 0;
                        end
                    BR, JMP:
                        begin
                            dr   = 0;
                        end
                    default :
                        begin
                            dr   = 0;
                        end
                endcase
                
                // NZP values
                if(IR[15:12] == BR)
                begin
                    NZP = IR[11:9];
                end
                else if(IR[15:12] == JMP)
                begin
                    NZP = 7;
                end
                else 
                begin
                    NZP = 0;
                end
              
                // assertion to check both bypass values not 1
                assert (! (bypass_mem_1 && bypass_alu_1)) ;
                assert (! (bypass_mem_2 && bypass_alu_2)) ;

               // get alu values 
                case({bypass_mem_1,bypass_alu_1})
                    2'b00: alu1 = VSR1;
                    2'b01: alu1 = aluout;
                    2'b10: alu1 = Mem_Bypass_Val;
                    default: alu1 = 0; // error
                endcase
               
                case({bypass_mem_2,bypass_alu_2})
                    2'b00: alu2 = (E_Control[0]) ? VSR2: {{11{IR[4]}},IR[4:0]} ;
                    2'b01: alu2 = aluout;
                    2'b10: alu2 = Mem_Bypass_Val;
                    default: alu2 = 0; //error
                endcase

                // M_Data
                M_Data = (bypass_alu_2) ? alu2 : VSR2;

                // source & destination registers
                if ((IR[15:12] == ADD) || (IR[15:12] == AND) || (IR[15:12] == NOT))  
                begin // for arithmetic operations
                    case (E_Control[5:4]) // can use EX_IR too 
                      2'b00:
                          begin
                              aluout = alu1 + alu2;
                          end
                      2'b01:
                          begin 
                              aluout = alu1 & alu2;
                          end
                      2'b10:
                          begin 
                              aluout = ~alu1;
                          end
                      default:
                          begin 
                              aluout = 0;
                          end
                  endcase
                  //pcout = 0;
                  pcout = aluout;
                end
                else
                begin // branch and loads
                    case (E_Control[3:1]) // can use EX_IR too 
                      3'b000:
                          begin
                              pcout = alu1 + {{6{IR[10]}},IR[9:0]};
                          end
                      3'b001:
                          begin
                              pcout = npc_in - 16'b1 + {{6{IR[10]}},IR[9:0]};
                          end
                      3'b010:
                          begin
                              pcout = alu1 + {{8{IR[8]}},IR[7:0]};
                          end
                      3'b011:
                          begin
                              pcout = npc_in - 16'b1 + {{8{IR[8]}},IR[7:0]};
                          end
                      3'b100:
                          begin
                              pcout = alu1 + {{11{IR[5]}},IR[4:0]};
                          end
                      3'b101:
                          begin
                              pcout = npc_in - 16'b1 + {{11{IR[5]}},IR[4:0]};
                          end
                      3'b110:
                          begin
                              pcout = alu1 ;
                          end
                      3'b111:
                          begin
                              pcout = npc_in - 16'b1 ;
                          end
                      default:
                          begin
                              pcout = 0 ;
                          end
                    endcase
                  aluout = pcout;
                end
            end
            else // Enable execute is 0
            begin
                NZP = 0;
            end
         
        return (0);
   endfunction
