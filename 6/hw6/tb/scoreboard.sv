class scoreboard;
  `include "coverage.sv"

  mailbox #(packet) m2s_mb;

  function new(mailbox #(packet) m2s_mb);
    this.m2s_mb = m2s_mb;
    APB_GROUP = new();
    apb_trans = new();
  endfunction

  task run();
    packet pkt = new;

    while(1) begin
      m2s_mb.get(pkt);
      $display("%0t: [scoreboard] Get packet from monitor: %s: addr = %b, data = %h",
                                                          $time,pkt.transfer.name(),pkt.addr,pkt.data);
      sample_fc(pkt);

    end
  endtask

  function void sample_fc(packet pkt);
	  $cast(apb_trans, pkt);
	  APB_GROUP.sample();
  endfunction

endclass
