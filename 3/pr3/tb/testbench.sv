module testbench; 
  // TODO User code
  import src_snk_pkg::*;
  mailbox #(packet) mb;

  source send;
  sink take;


  initial begin
	  //inilize signal
	  send = new(5);
	  take = new();
	  mb = new(1);
	  
	  send.out_chan = mb;
	  take.in_chan = mb;

	  fork
		  send.run();
		  take.run();
	  join_any


        #100; $display("End of simulation");

	$finish;
  end

endmodule
