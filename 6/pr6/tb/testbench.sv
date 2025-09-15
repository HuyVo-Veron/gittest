module testbench; 

  apb_interface apb_if();

  register u_dut(
     .pclk(apb_if.pclk),    
     .presetn(apb_if.presetn), 
     .psel(apb_if.psel),    
     .penable(apb_if.penable), 
     .pwrite(apb_if.pwrite),  
     .paddr(apb_if.paddr),   
     .pwdata(apb_if.pwdata),  
     .pready(apb_if.pready));
  
  cpu_model u_model(
     .pclk(apb_if.pclk),    
     .presetn(apb_if.presetn), 
     .psel(apb_if.psel),    
     .penable(apb_if.penable), 
     .pwrite(apb_if.pwrite),  
     .paddr(apb_if.paddr),   
     .pwdata(apb_if.pwdata),  
     .pready(apb_if.pready));
  
  initial begin
    apb_if.presetn = 0;
    #100ns apb_if.presetn = 1;
  end

  initial begin
    apb_if.pclk = 0;
    forever begin 
      #10ns;
      apb_if.pclk = ~apb_if.pclk;
    end
  end

  // Stimulus: Control CPU model write transfer to DUT
  initial begin
    bit [7:0] addr;
    bit [7:0] data;

    wait(apb_if.presetn == 1);
    addr = $urandom;
    data = $urandom;
    u_model.apb_write(addr,data); 

    addr = $urandom;
    data = $urandom;
    u_model.apb_write(addr,data); 
    #100ns;
    $display("[testbench] End of simulation");
    $finish;
  end

  // TODO user code, write assertion
  sequence relation_sequence;
	  apb_if.penable ##1 !apb_if.pwrite && !apb_if.penable;
  endsequence

  property relation_check;
	  @(posedge apb_if.pclk) apb_if.psel && apb_if.pwrite && !apb_if.penable |=> relation_sequence;
  endproperty

  assert property (relation_check) else $error("Assertion Failed APB write transfer");


  property data_addr_stable;
	  @(posedge apb_if.pclk) apb_if.psel && apb_if.penable |-> $stable(apb_if.pwdata) && $stable(apb_if.paddr);
  endproperty

  assert property (data_addr_stable) else $error(" Failed Stable paddr && pwdata during transfer");

endmodule
