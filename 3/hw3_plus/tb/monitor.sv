class monitor;
	mailbox #(packet) out_chan;
	packet_pkt;
	virtual dut_if dut_vif;
	logic[7:0] TXD;

	function new(virtual dut_if dut_vif);
		this.dut_vif = dut_vif;
	endfunction

	task run();
		while(1) begin
			$display("%0t: [monitor] Start capture data in TXD", $time);
			pkt.data = dut_vif.TXD
			out_chan.put(pkt); 
			$display("%0t: [monitor] Data capture is %0x, sent to scoreboard", $time, pkt.data);
         	end

	endtask

endclass


