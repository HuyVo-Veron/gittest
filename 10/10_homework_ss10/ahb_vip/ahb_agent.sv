class ahb_agent extends uvm_agent;
  `uvm_component_utils(ahb_agent)

  ahb_monitor   monitor;
  ahb_driver    driver;
  ahb_sequencer sequencer;



  function new(string name="ahb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase","Entered...",UVM_HIGH)
	monitor = ahb_monitor::type_id::create("monitor",this);
	driver = ahb_driver::type_id::create("driver",this);
	sequencer = ahb_sequencer::type_id::create("sequencer",this);



    `uvm_info("build_phase","Exiting...",UVM_HIGH)

  endfunction: build_phase

endclass: ahb_agent
