module testbench; 
  import converter_pkg::*;
  
  stimulus stim;
  driver dri;
  monitor moni;
  scoreboard sb;

  mailbox #(packet) s2s_mb; 
  mailbox #(packet) s2d_mb; 
  mailbox #(packet) m2s_mb; 

  dut_if d_if();

  parallel_to_serial u_dut(
	  .clk(d_if.clk),
	  .rst_n(d_if.rst_n),
	  .valid(d_if.valid),
	  .data_in(d_if.data_in),
	  .TXD(d_if.TXD));

  initial begin
    d_if.rst_n = 0;
    #100;
    d_if.rst_n = 1;
 end

  initial begin
	  d_if.clk = 0;
	  forever begin
		  #10 d_if.clk = ~d_if.clk;
	  end
  end

  initial begin
	  s2s_mb = new();
	  m2s_mb = new();
	  s2d_mb = new();

	  stim = new(s2d_mb, s2s_mb);
	  dri = new(s2d_mb, d_if);
	  moni = new(m2s_mb, d_if);
	  sb = new(m2s_mb, s2s_mb);

	  fork
		  stim.run();
		  dri.run();
		  moni.run();
		  sb.run();
	  join


  end

  initial begin
	  wait(d_if.rst_n);
	  stim.create_pkt(8'ha3);
	  stim.create_pkt(8'h8a);

    #1us; $display("End simulation");
    $finish;
 
  end

endmodule
