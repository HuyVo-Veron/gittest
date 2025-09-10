module testbench;
  reg[2:0]  pid;
  reg       valid;
  wire[7:0] data;

  encoder u_dut(.*);

  // TODO User code
  import data_type_pkg::*;
  mailbox #(packet_st) exp_mb = new(); 
  mailbox #(packet_st) act_mb = new();

  initial begin
	  pid = 0;
	  valid = 0;
	  #100;

	  
	  fork
		  stimulus();
		  monitor();
		  compare();
	  join_any
	  disable fork;
    #1000ns;
    $display("End of simulation");
    $finish;
  end
  task stimulus();
	  packet_st packet;
	  repeat(5) begin
		  $display("[stimulus task] Random pid");
		  packet.pid = $random;
		  
		  $display("[stimulus task] Drive Pid=%h",packet.pid);
		  pid = packet.pid;
		  valid = 1;

		  $display("[stimulus task] Convert data from pid and send to mailbox");
		  convert(packet);
		  exp_mb.put(packet);
		  #10;
	  end
  endtask 

  function void convert(inout packet_st packet);
	  case(packet.pid)
		  0: packet.data = 8'hab;
		  1: packet.data = 8'h01;
		  2: packet.data = 8'h22;
		  3: packet.data = 8'h34;
		  4: packet.data = 8'h15;
		  5: packet.data = 8'hfc;
		  6: packet.data = 8'hdf;
		  7: packet.data = 8'h87;
	  endcase
  endfunction


  task monitor();
	  packet_st observed_pkt;
	  forever begin
		  wait(valid);
		  $display("[monitor task] Capture activity and send to mailbox");
		  #5;
		  observed_pkt.pid = pid;
		  observed_pkt.data = data;
		  act_mb.put(observed_pkt);
		  #5;
	  end
  endtask

  task compare();
	  packet_st act_pkt, exp_pkt;
	  forever begin
		  act_mb.get(act_pkt);
		  $display("[compare task] Get actual packet");
		  exp_mb.get(exp_pkt);
		  $display("[compare task] Get expected packet");
		  
		  if(act_pkt.data == exp_pkt.data) begin
			  $display("[compare task] Data endcode is matching %h",exp_pkt.data);
		  end else begin
			  $display("[compare task] Data endcode is not matching exp_pkt.data=%h, act_pkt.data=%h",exp_pkt.data, act_pkt.data);
		  end
	  end
  endtask


endmodule
