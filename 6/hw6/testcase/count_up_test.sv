class count_up_test extends base_test;
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
		wait(dut_vif.presetn == 1'b1);
		write(8'h00, 8'h1);
	endtask
endclass



