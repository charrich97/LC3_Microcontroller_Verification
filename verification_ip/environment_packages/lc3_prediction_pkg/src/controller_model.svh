
   // The controller_model function models the behavior of the controller unit
   // The return value indicates model results status: 0 success, 1 failure
   function bit controller_model(input bit complete_data,
                             input bit complete_instr, 
                             input bit [15:0] IR, 
                             input bit [2:0] psr, 
                             input bit [15:0] IR_Exec, 
                             input bit [15:0] IMem_dout, 
                             input bit [2:0] NZP, 
                             output bit      enable_updatePC, 
                             output bit      enable_fetch, 
                             output bit      enable_decode, 
                             output bit      enable_execute, 
                             output bit      enable_writeback, 
                             output bit      bypass_alu_1, 
                             output bit      bypass_alu_2, 
                             output bit      bypass_mem_1, 
                             output bit      bypass_mem_2, 
                             output bit [2:0]   mem_state, 
                             output bit br_taken
                         );


static bit memstateLDI = 1'b0;
static bit memstateSTI = 1'b0;
static bit enable_flag = 1'b0;
static bit br_enable_flag = 1'b0;
static bit branch_mode = 1'b0;

//default values
		   bypass_alu_1=0;
		   bypass_alu_2=0;
		   bypass_mem_1=0;
		   bypass_mem_2=0;

// Logic for mem state

	 if(memstateLDI==1)
	   begin
	      mem_state=2'b00;
	      memstateLDI=0;
	   end
	 else if(memstateSTI==1)
	   begin
	      mem_state=2'b10;
	      memstateSTI=0;
	   end
	 else if((IR[15:12]== STR)||(IR[15:12]== ST))
	   begin
	      mem_state=2'b10;
	   end
	 else if((IR[15:12]==LDR)||(IR[15:12]==LD))
	   begin
	      mem_state=2'b00;
	   end
	 else if(IR[15:12]==LDI)
	   begin
	      mem_state=2'b01;
	      memstateLDI=1;
	   end
	 else if(IR[15:12]==STI)
	   begin
	      mem_state=2'b01;
	      memstateSTI=1;
	   end
    else 
    begin
	    mem_state=2'b11;
    end

	 //MOST IMPORTANT STAGE : Handle with care.......
	 //3 copies of the same instruction at different times is available to use...IMEM out, IR out from decode and IR out from execute stage.....
	 // Use this to determine the dependencies and hence generate the bypass alu1 and bypass alu2 instructions from it............

	 // IR, IR_EXec and 
	 //******************************************CODE fragment for bypasses******************************************//
    if((IR[15:12]==ADD)||(IR[15:12]==AND)||(IR[15:12]==NOT))
    begin
        if((IR_Exec[15:12]==ADD)||(IR_Exec[15:12]==AND)||(IR_Exec[15:12]==NOT)||(IR_Exec[15:12]==LEA))
        begin
		   if(IR_Exec[11:9]==IR[8:6])
		     bypass_alu_1=1;
		   if(IR_Exec[11:9]==IR[2:0])
		     bypass_alu_2=1;
		   if(IR[5]==1)
		     bypass_alu_2=0;
		end
	      
        if((IR_Exec[15:12]==LD)||(IR_Exec[15:12]==LDR)||(IR_Exec[15:12]==LDI))
		begin
		   if(IR_Exec[11:9]==IR[8:6])
		     bypass_mem_1=1;
		   if(IR_Exec[11:9]==IR[2:0])
		     bypass_mem_2=1;
		   if(IR[5]==1)
		     bypass_mem_2=0;
		end
	end

	if(IR[15:12]==LDR)
	   begin
	      if((IR_Exec[15:12]==ADD)||(IR_Exec[15:12]==AND)||(IR_Exec[15:12]==NOT)||(IR_Exec[15:12]==LEA))
		    begin
		        if(IR_Exec[11:9]==IR[8:6])
		         bypass_alu_1=1;
		    end		
	   end

	 if(IR[15:12]==STR)
	   begin
	      if((IR_Exec[15:12]==ADD)||(IR_Exec[15:12]==AND)||(IR_Exec[15:12]==NOT)||(IR_Exec[15:12]==LEA))
		begin
		   
		   if(IR_Exec[11:9]==IR[11:9])
		     bypass_alu_2=1;
		   if(IR_Exec[11:9]==IR[8:6])
		     bypass_alu_1=1;
		end		
	  end
	 
      if((IR[15:12]==ST) || (IR[15:12]==STI))
	   begin
	      if((IR_Exec[15:12]==ADD)||(IR_Exec[15:12]==AND)||(IR_Exec[15:12]==NOT)||(IR_Exec[15:12]==LEA))
		begin
		   if(IR_Exec[11:9]==IR[11:9])
		     bypass_alu_2=1;
		end		
	  end

      if(IR[15:12]==JMP)
	   begin
	      if((IR_Exec[15:12]==ADD)||(IR_Exec[15:12]==AND)||(IR_Exec[15:12]==NOT)||(IR_Exec[15:12]==LEA))
		begin
		   if(IR_Exec[11:9]==IR[8:6])
		     bypass_alu_1=1;
		end		
	  end

	 //+++++++++++++++++++++++++  Enable signals +++++++++++++++++++++++++++++++++


    case (enable_flag)
        0 : 
        begin
            enable_flag = 0;
	        if((IR_Exec[15:12]==LD) || (IR_Exec[15:12]==LDR) || (IR_Exec[15:12]==ST) || (IR_Exec[15:12]==STR))
            begin
                enable_flag = 2;
	            if((IR_Exec[15:12]==ST) || (IR_Exec[15:12]==STR))
                begin
                    enable_flag = 3;
                end
            end
            else if ((IR_Exec[15:12]==LDI) || (IR_Exec[15:12]==STI))
            begin
                enable_flag = 4;
	            if(IR_Exec[15:12]==STI)
                begin
                    enable_flag = 5;
                end
            end
        end
        1 : 
        begin
            enable_flag = 0;
        end
        2 : 
        begin
            enable_flag = 0;
        end
        3 : 
        begin
            enable_flag = 1;
        end
        4 : 
        begin
            enable_flag = 2;
        end
        5 : 
        begin
            enable_flag = 3;
        end
        default : 
        begin
            enable_flag = 0;
        end
    endcase
    
    case (enable_flag)
        0 : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=1;
        end
        1 : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=0;
		       enable_updatePC=1;
        end
        2,3,4,5 :
        begin
		       enable_fetch=0;
		       enable_decode=0;
		       enable_execute=0;
		       enable_writeback=0;
		       enable_updatePC=0;
        end
        default : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=1;
        end
    endcase


    case (br_enable_flag)
        0 : 
        begin
            if ((IMem_dout[15:12]==BR) || (IMem_dout[15:12]==JMP))
            br_enable_flag = 1;
        end
        1 : 
        begin
            br_enable_flag = 2;
        end
        2 : 
        begin
            br_enable_flag = 3;
        end
        3 : 
        begin
            br_enable_flag = 4;
        end
        4 : 
        begin
            if ((IMem_dout[15:12]==BR) || (IMem_dout[15:12]==JMP))
            br_enable_flag = 5;
        end
        5 : 
        begin
            br_enable_flag = 6;
        end
        6 : 
        begin
            br_enable_flag = 0;
        end
        default : 
        begin
            br_enable_flag = 0;
        end
    endcase

    case (br_enable_flag)
        0 : 
        begin
           if (branch_mode == 1)
            begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=1;
               br_taken = 0;
               branch_mode = 0;
            end
        end
        1 : 
        begin
		       enable_fetch=0;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=0;
               br_taken = 0;
               branch_mode = 1;
        end
        2 : 
        begin
		       enable_fetch=0;
		       enable_decode=0;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=0;
               br_taken = 0;
        end
        3 : 
        begin
		       enable_fetch=0;
		       enable_decode=0;
		       enable_execute=0;
		       enable_writeback=0;
		       enable_updatePC=0;
            if (IR[15:12]==JMP)
            begin
               br_taken = 1'b1;
	       enable_updatePC= 1'b1;
            end
            else
            begin
               br_taken = (psr & NZP) ? 1'b1 : 1'b0;
               enable_updatePC = (psr & NZP) ? 1'b1 : 1'b0;
           end
        end
        4 : 
        begin
		       enable_fetch=1;
		       enable_decode=0;
		       enable_execute=0;
		       enable_writeback=0;
		       enable_updatePC=1;
               br_taken = 0;
        end
        5 : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=0;
		       enable_writeback=0;
		       enable_updatePC=1;
               br_taken = 0;
        end
        6 : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=0;
		       enable_updatePC=1;
               br_taken = 0;
        end
        default : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=1;
               br_taken = 0;
        end
    endcase


         return (0);
   endfunction
