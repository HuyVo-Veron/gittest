class apb_base_test extends uvm_test;
	`uvm_component_utils(apb_base_test)

	apb_environment apb_env;

	function new (string name="apb_base_test", uvm_component parent); // tham so kieu component, chi ra thanh phan cha trong té
		super.new(name, parent);
	endfunction: new

	virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("build_phase", "Entered...", UVM_HIGH)
	
	apb_env = apb_environment::type_id::create("apb_env",this);

	`uvm_info("build_phase", "Exiting...", UVM_HIGH)
	endfunction: build_phase

	virtual function void end_of_elaboration_phase(uvm_phase phase);
//	function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	`uvm_info("end_of_elaboration_phase", "Entered...", UVM_HIGH)
	
	uvm_top.print_topology();
	`uvm_info("end_of_elaboration_phase", "Exiting...", UVM_HIGH)
	endfunction: end_of_elaboration_phase
endclass
