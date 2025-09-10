class monitor;
	mailbox #(packet) m2s_mb;
	virtual dut_if dut_vif;
	
	function new(mailbox #(packet) m2s_mb, virtual dut_if dut_vif);
		this.m2s_mb = m2s_mb;
		this.dut_vif = dut_vif;
	endfunction

	task run();
		packet pkt = new();
	
		while(1) begin
			@(negedge dut_vif.valid);
			$display("%0t, [monitor] Monitor start capture from dut",$time);
			for(int i=0; i<8; i++) begin
				#2;
				pkt.data[i] = dut_vif.TXD;
				@(posedge dut_vif.clk);
			end
			m2s_mb.put(pkt);
			$display("%0t, [monitor] Send packet to scoreboard, TXD=%0x",$time, pkt.data);
		end

	endtask


endclass


