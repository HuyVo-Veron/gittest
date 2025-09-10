module testbench; 

  mailbox #(bit[7:0]) mb = new();
  semaphore key = new(1);

  task stimulus();
    bit[7:0] pid;
    for(bit[7:0] i=0; i<10; i++) begin
      pid = $random;
      mb.put(pid);
      $display("%0t: Put to mailbox, pid is %0d ",$time,pid);
    end
  endtask
 
  task write();
	  bit[7:0] value;
	  
	  while(1) begin
		  key.get(1);
		  mb.get(value);
		  $display("%0t: [Task Write] Get pid %d from mailbox",$time, value);
		  #50;
	 	  $display("%0t: [Task Write] Process write is done", $time);
		  key.put(1);
	  end
 endtask


  task read();
	  bit[7:0] value;
	  
	  while(1) begin
		  key.get(1);
		  mb.get(value);
		  $display("%0t: [Task Read] Get pid %d from mailbox", $time, value);
		  #20;
	  	  $display("%0t: [Task Read] Process read is done", $time);
		  key.put(1);
	  end
 endtask

  // TODO User code

  initial begin
    fork
	    stimulus();
	    read();
	    write();
    join
    #1000;
    $display("End of simulation");
    $finish;
  end

endmodule
