class stimulus;
	mailbox #(packet) s2d_mb;
	mailbox #(packet) s2s_mb;

	function new(mailbox #(packet) s2d_mb, mailbox #(packet) s2s_mb);
		this.s2d_mb = s2d_mb;
		this.s2s_mb = s2s_mb;
	endfunction

	packet pkt_q[$];

	function create_pkt(logic[7:0] data_in);
		packet pkt = new(data_in);
		pkt_q.push_back(pkt);
	endfunction	

	task run();
		packet pkt = new();

		while(1) begin
			wait(pkt_q.size()>0);
			pkt = pkt_q.pop_front();
			s2d_mb.put(pkt);
			$display("%0t: [stimulus] Send packet to driver", $time);
			s2s_mb.put(pkt);
			$display("%0t: [stimulus] Send packet to scoreboard", $time);
		end
	endtask

endclass
