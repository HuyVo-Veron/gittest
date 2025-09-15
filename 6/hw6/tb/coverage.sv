packet apb_trans;

covergroup APB_GROUP;
	 apb_transfer: coverpoint apb_trans.transfer
	 {
		 bins apb_read = {packet::READ};
		 bins apb_write = {packet::WRITE};
	 }


	 apb_address: coverpoint apb_trans.addr
	 {
		 bins CCR_addr = {2'b00};
		 bins CDR_addr = {2'b01};
	 }

	 apb_data: coverpoint apb_trans.data
	 {
		 bins count_up = {8'h01};
		 bins count_down = {8'h03};
		 bins data_value = {8'd100};
	 }



	 apb_transaction: cross apb_transfer, apb_address;
	 
	 counter_up_feature: cross apb_data, apb_address, apb_transfer
	 {
		 ignore_bins counter_up = !binsof(apb_transfer) intersect{packet::WRITE} ||
	      	 !binsof(apb_address) intersect{2'b00} ||  
		 !binsof(apb_data) intersect{8'h01};
	 }

	counter_down_feature: cross apb_data, apb_address, apb_transfer
	 {
		 ignore_bins counter_down = !binsof(apb_transfer) intersect{packet::WRITE} || 
		 !binsof(apb_address) intersect{2'b00} ||  
		 !binsof(apb_data) intersect{8'h11};
	 }

	counter_with_data_feature: cross apb_data, apb_address, apb_transfer
	 {
		 ignore_bins counter_with_data = !binsof(apb_transfer) intersect{packet::WRITE} || 
		 !binsof(apb_address) intersect{2'b01} ||  
		 !binsof(apb_data) intersect{8'd100};
	 }
endgroup

