class driver;
	mailbox #(packet) s2d_mb;
	virtual dut_if dut_vif;
	
	function new(mailbox #(packet) s2d_mb, virtual dut_if dut_vif);
		this.s2d_mb = s2d_mb;
		this.dut_vif = dut_vif;
	endfunction

	task run();
		packet pkt = new();
		while(1) begin
			s2d_mb.get(pkt);
			$display("%0t, [driver] Get packet from stimulus",$time);
			@(posedge dut_vif.clk);
			$display("%0t, [driver] Drive dut with data in %0x",$time, pkt.data);
			dut_vif.valid = 1;
			dut_vif.data_in = pkt.data;
			@(posedge dut_vif.clk);
			dut_vif.valid = 0;
			repeat(7) @(posedge dut_vif.clk);
		end

	endtask


endclass


