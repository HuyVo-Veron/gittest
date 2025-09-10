class scoreboard;
	mailbox #(packet) in_chan_from_monitor;
	mailbox #(packet) in_chan_from_stimulus;
	packet pkt_moni;
	packet pkt_sti;

	function new();
	endfunction

	task run();
		while(1) begin
			in_chan_from_monitor.get(pkt_moni);
			in_chan_from_stimulus.get(pkt_sti);
			if(pkt_moni.data == pkt_sti.data) begin
				$display("%0t: [scoreboard] Data comparision is matching %0x",$time, pkt_moni.data);
			end else begin
				$display("%0t: [scoreboard] Data comparision is not matching exp=%0x, act=%0x",$time, plt_sti.data, pkt_moni.data);
			end

	endtask
endclass
