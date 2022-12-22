
   // The mem_access_model function models the behavior of the mem_access unit
   // The return value indicates model results status: 0 success, 1 failure
   function bit mem_access_model(input bit  [15:0]  M_Data,
                             input bit      [15:0]  M_Addr,
                             input bit              M_Control, 
                             input bit      [1:0]   mem_state, 
                             input bit      [15:0]  DMem_dout, 
                             output bit     [15:0]  DMem_addr, 
                             output bit     [15:0]  DMem_din, 
                             output bit     [15:0]  memout, 
                             output bit             DMem_rd
                         );

		memout=DMem_dout;
		DMem_addr=16'hxxxx;
		DMem_rd=1'bx;
		DMem_din=16'hxxxx;

		if(mem_state===0)
		begin
			DMem_rd=1;
			DMem_din=0;
			if(M_Control===0)	//For LDR
			begin
				DMem_addr=M_Addr;
			end
			if(M_Control==1) //For LDI
			begin
				DMem_addr=DMem_dout;
			end
		end

		else if(mem_state===2)
		begin
			DMem_rd=0;
			DMem_din=M_Data;
	 
			if(M_Control==0)	//For STR
			begin
				DMem_addr=M_Addr;
			end
			if(M_Control==1) //For STI
			begin
				DMem_addr=DMem_dout;
			end
		end


		else if(mem_state===1)
		begin
			DMem_rd=1;
			DMem_din=0;
			DMem_addr=M_Addr; 
		end


		else if(mem_state===3)
		begin
			DMem_addr=16'hzzzz;
			DMem_rd=1'bz;
			DMem_din=16'hzzzz;
		end

        return (0);
   endfunction
