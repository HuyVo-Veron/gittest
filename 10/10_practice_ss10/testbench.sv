import uvm_pkg::*;
class apb_transaction extends uvm_sequence_item;

  typedef enum bit {
       WRITE = 1
      ,READ  = 0
  } xact_type_enum;

  rand xact_type_enum xact_type;
  rand bit[31:0]      address;
  rand bit[31:0]      data;

  `uvm_object_utils_begin (apb_transaction)
    `uvm_field_enum       (xact_type_enum ,xact_type ,UVM_ALL_ON |UVM_HEX ) //enable chức năng: copy, compare, print, pack, unpack, record.
    `uvm_field_int        (address                   ,UVM_ALL_ON |UVM_HEX ) //dạng hexadecimal.
    `uvm_field_int        (data                      ,UVM_ALL_ON |UVM_HEX )
  `uvm_object_utils_end

  function new(string name="apb_transaction");
    super.new(name);
  endfunction: new

endclass: apb_transaction


class apb_sequencer extends uvm_sequencer #(apb_transaction);
  `uvm_component_utils(apb_sequencer)

  function new(string name="apb_sequencer", uvm_component parent);
    super.new(name,parent);
  endfunction: new

endclass: apb_sequencer


class apb_driver extends uvm_driver #(apb_transaction);
  `uvm_component_utils(apb_driver)

  function new(string name="apb_driver", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction: build_phase

endclass: apb_driver


class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)

  function new(string name="apb_monitor", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
  endtask: run_phase

endclass: apb_monitor


class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)

  apb_monitor   monitor;
  apb_driver    driver;
  apb_sequencer sequencer;

  function new(string name="apb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction: build_phase

endclass: apb_agent


class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)

  function new(string name="apb_scoreboard", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase","Entered...",UVM_HIGH)
    `uvm_info("build_phase","Exited...",UVM_HIGH)
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
  endtask: run_phase

endclass: apb_scoreboard


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






module testbench;

  initial begin
    /** Start the UVM test */
    run_test();
  end

endmodule

