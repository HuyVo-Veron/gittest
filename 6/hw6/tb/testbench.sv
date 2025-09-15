module testbench; 
  import counter_pkg::*;
  import test_pkg::*;
 
  dut_if d_if();

  basic_counter u_dut(
    .pclk(d_if.pclk),       
    .presetn(d_if.presetn),    
    .psel(d_if.psel),       
    .penable(d_if.penable),    
    .pwrite(d_if.pwrite),     
    .paddr(d_if.paddr),      
    .pwdata(d_if.pwdata),     
    .prdata(d_if.prdata),     
    .pready(d_if.pready),     
    .intr(d_if.intr));

  bit[7:0] internal_count;
  assign internal_count = u_dut.u_counter.count;

  initial begin
    d_if.presetn = 0;
    #100ns d_if.presetn = 1;
  end

  initial begin
    d_if.pclk = 0;
    forever begin 
      #10ns;
      d_if.pclk = ~d_if.pclk;
    end
  end

  initial begin
    #1ms;
    $display("[testbench] Time out....Seems your tb is hang!");
    $finish;
  end

  base_test               base = new();
  count_up_test 	  count_up = new();
  count_down_test	  count_down = new();
  count_up_with_data_test count_up_with_data = new();
  count_down_with_data_test count_down_with_data = new();

  initial begin
	  if($test$plusargs("count_up_test")) begin
		  $display("run count_up_test");
		  base = count_up;
	  end
	  if($test$plusargs("count_down_test")) begin
		  $display("run count_up_test");
		  base = count_down;
	  end
	  if($test$plusargs("count_up_with_data_test")) begin
		  $display("run count_up_with_data_test");
		  base = count_up_with_data;
	  end
	  if($test$plusargs("count_down_with_data_test")) begin
		  $display("run count_down_with_data_test");
		  base = count_down_with_data;
	  end
    base.dut_vif = d_if;
    base.run_test();
  end
    
endmodule
