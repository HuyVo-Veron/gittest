class stimulus;
	mailbox #(packet) out_chan_to_driver;
	mailbox #(packet) out_chan_to_scoreboard;
	packet pkt;
	logic[7:0] data_in;

	function new(logic[7:0] data_in = 8'ha3);
		this.data_in = data_in;
	endfunction

	task run();
		for(int i=0; i<2; i++) begin
			pkt = new(data_in);
			out_chan_to_driver.put(pkt);
			$display("%0t [stimulus] Send packet to driver", $time);
			convert(pkt);
		
	endtask

	function void convert(inout packet pkt);
		logic[7:0] tmp;
		for(int i=0; i<8; i++) begin
			tmp[i] = pkt.data[7-i];
		end
		pkt.data[7:0] = tmp[7:0];
	endfunction

endclass
