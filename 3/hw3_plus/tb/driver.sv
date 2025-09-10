class driver;
	mailbox #(packet) in_chan;
	packet pkt;
	virtual dut_if dut_vif;

	function new();
	endfunction

	task run();
		while(1) begin
			in_chan.get(pkt);
			dut_vif.data_in = pkt.data;
			dut_vif.valid = 1;
			#1;
		end
	endtask

endclass


