class scoreboard;
	mailbox #(packet) s2s_mb;
	mailbox #(packet) m2s_mb;

	function new(mailbox #(packet) m2s_mb, mailbox #(packet) s2s_mb);
		this.m2s_mb = m2s_mb;
		this.s2s_mb = s2s_mb;
	endfunction

	task run();
		packet exp_pkt = new();
		packet act_pkt = new();

		while(1) begin
			m2s_mb.get(act_pkt);
			$display("%0t, [scoreboard]: Get actual packet", $time);
			s2s_mb.get(exp_pkt);
			$display("%0t, [scoreboard]: Get expect packet", $time);
			
			if(act_pkt.data == exp_pkt.data) begin
				$display("%0t, [scoreboard]: Data is matching %0x", $time, exp_pkt.data);
			end else begin
				$display("%0t, [scoreboard]: Data is not matching exp=%0x, act=%0x",$time, exp_pkt.data, act_pkt.data);
			end
		end

	endtask


endclass
