class count_up_with_data_test extends base_test;
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
		wait(dut_vif.presetn == 1'b1);
		write(8'h00, 8'h0);
		write(8'h01, 8'd100);
		write(8'h00, 8'h1);
	endtask
endclass



