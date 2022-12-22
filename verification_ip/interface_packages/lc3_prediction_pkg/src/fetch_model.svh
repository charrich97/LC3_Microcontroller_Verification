
   // The fetch_model function models the behavior of the fetch unit
   // The return value indicates model results status: 0 success, 1 failure
   function bit fetch_model(input bit           enable_updatePC, 
                             input bit          enable_fetch, 
                             input bit          br_taken, 
                             input bit [15:0]   taddr, 
                             output bit [15:0]  npc, 
                             output bit [15:0]  pc, 
                             output bit         instrmem_rd
                         ); 

logic [1:0] Input_cntl;
static logic [15:0] gold_pc = 16'h3000;

    Input_cntl = {enable_updatePC, enable_fetch};
	casex(Input_cntl)
				2'b00:
					begin
						gold_pc=gold_pc;
						instrmem_rd=1'b0;	
					end
				2'b01:
					begin
						gold_pc=gold_pc;
						instrmem_rd=1'b1;
					end
				2'b10:
					begin
						gold_pc=(br_taken)? taddr: gold_pc+1'b1;
						instrmem_rd=1'b0;
					end
				2'b11:
					begin
						gold_pc=(br_taken)? taddr: gold_pc+1'b1;
						instrmem_rd=1'b1;
					end
				default: gold_pc=16'hx;
			endcase
	 pc = gold_pc;
         npc = pc + 1'b1;

         return (0);
   endfunction
