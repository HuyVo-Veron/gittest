module testbench; 
  import converter_pkg::*;
  stimulus send_sti;
  driver   take_dri;
  monitor send_moni;
  scoreboard take_sb;

  mailbox #(packet) s2d_mb = new();
  mailbox #(packet) s2s_mb = new();
  mailbox #(packet) m2s_mb = new();

  dut_if d_if;
  
  parallel_to_serial u_dut(
	  .clk(d_if.clk), 
	  .rst_n(d_if.rst_n), 
	  .valid(d_if.valid), 
	  .data_in(d_if.data_in);
	  .TXD(d_if.TXD));

  	//this code line: receive d_if from driver;
	//send_moni = new(d_if);//this code line: send d_if to monitor

  
  initial begin
	  send_sti = new(8'ha3);
	  take_dri = new();
	  send_moni = new(d_if);
	  take_sb = new()

	  send_sti.out_chan_to_driver = s2d_mb;
	  take_dri.in_chan = s2d_mb;
	  send_moni.out_chan = m2s_mb;
	  take_sb.in_chan_from_monitor = m2s_mb;
	  send_sti.out_chan_to_scoreboard = s2s_mb;
	  take_sb.in_chan_from_stimulus = s2s_mb;

	  fork
		  sent_sti.run();
		  take_dri.run();
		  send_moni.run();
		  take_sb.run();
	  join

    #1us; $display("End simulation");
    $finish;
  end

endmodule
