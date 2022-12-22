
   // The writeback_model function models the behavior of the writeback unit
   // The return value indicates model results status: 0 success, 1 failure
   function bit writeback_model(input bit [15:0] aluout, 
                             input bit [1:0] W_Control, 
                             input bit [15:0] npc, 
                             input bit [15:0] pcout, 
                             input bit [15:0] memout, 
                             input bit        enable_writeback, 
                             input bit [2:0]  sr1, 
                             input bit [2:0]  sr2, 
                             input bit [2:0]  dr, 
                             output bit [15:0] vsr1, 
                             output bit [15:0] vsr2, 
                             output bit [2:0] psr
                         ); 

logic [15:0] Dr_in;
static logic [15:0] regfile[0:7];

		    if(W_Control==0)
		    begin
		    	Dr_in=aluout;
		    end

		    if(W_Control==1)
		    begin
		    	Dr_in=memout;
		    end

		    if(W_Control==2)
		    begin
		    	Dr_in=pcout;
		    end

	//Write into dr must be after sr registers
		    vsr1=regfile[sr1];
		    vsr2=regfile[sr2];

		    if(enable_writeback==1)  
		    begin
		    	if(Dr_in==0)
		    		psr=3'b010;
		    	else if(Dr_in[15]==1)
		    		psr=3'b100;
		    	else if((Dr_in[15]==0)&&(Dr_in!=0))
		    		psr=3'b001;

		    	regfile[dr]=Dr_in;
		    end

         return (0);
   endfunction
