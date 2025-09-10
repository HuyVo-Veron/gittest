class apb_environment extends uvm_env;
	`uvm_component_utils(apb_environment)

	apb_scoreboard apb_sb;
	apb_agent      apb_agt;


	function new (string name="apb_environment", uvm_component parent);
		super.new(name, parent);
	endfunction: new

	virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("build_phase", "Entered...", UVM_HIGH)
	
	apb_sb = apb_scoreboard::type_id::create("apb_sb",this);
	apb_agt = apb_agent::type_id::create("apb_agt",this);

	`uvm_info("build_phase", "Exiting...", UVM_HIGH)
	endfunction: build_phase

endclass: apb_environment
