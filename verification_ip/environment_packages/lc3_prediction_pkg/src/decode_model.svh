   // The decode_model function models the behavior of the decode unit
   // The return value indicates model results status: 0 success, 1 failure
   function bit decode_model(input  bit           [15:0]  instr_dout, 
                             input  bit           [15:0]  npc_in    , 
                             output bit           [15:0]  ir        , 
                             output bit           [15:0]  npc_out   , 
                             output bit           [5:0]   e_control , 
                             output w_control_t           w_control , 
                             output mem_control_t         mem_control
                            );

         // Replace test code below with lc3 decode model
         ir = instr_dout;
         npc_out = npc_in;

	casex(instr_dout[15:12])
		ADD :
			begin
				w_control=ALUOUT;
				e_control=(instr_dout[5]==1) ? (6'b000000):(6'b000001);
				mem_control=MEM_CONTROL_DISABLED;
			end
		AND : 
			begin
				w_control=ALUOUT;
				e_control=(instr_dout[5]==1) ? (6'b010000):(6'b010001);
				mem_control=MEM_CONTROL_DISABLED;
			end
		NOT : 
			begin
				w_control=ALUOUT;
				e_control=6'b100000;
				mem_control=MEM_CONTROL_DISABLED;
			end
		BR  :
			begin
				w_control=ALUOUT;
				e_control=6'b000110;
				mem_control=MEM_CONTROL_DISABLED;
			end
		JMP :
			begin 
				w_control=ALUOUT;
				e_control=6'b001100;
				mem_control=MEM_CONTROL_DISABLED;
			end
		LD  : 
			begin
				w_control=MEMOUT;
				e_control=6'b000110;	
				mem_control=MEM_CONTROL_DISABLED;
			end
		LDR :
			begin
				w_control=MEMOUT;
				e_control=6'b001000;
				mem_control=MEM_CONTROL_DISABLED;
			end	
		LDI :
			begin
				w_control=MEMOUT;
				e_control=6'b000110;
				mem_control=MEM_CONTROL_ENABLED;
			end
		LEA :
			begin
				w_control=PCOUT;
				e_control=6'b000110;
				mem_control=MEM_CONTROL_DISABLED;
			end
		ST  : 
			begin
				w_control=ALUOUT;
			    	e_control=6'b000110;
				mem_control=MEM_CONTROL_DISABLED;
			end
		STR :
			begin
				w_control=ALUOUT;
				e_control=6'b001000;
				mem_control=MEM_CONTROL_DISABLED;
			end
		STI :
			begin
				w_control=ALUOUT;
				e_control=6'b000110;
				mem_control=MEM_CONTROL_ENABLED;
			end
		endcase

         return (0);
   endfunction

