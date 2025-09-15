interface apb_interface;

  logic        pclk;       
  logic        presetn;    
  logic        psel;       
  logic        penable;    
  logic        pwrite;     
  logic [7:0]  paddr;      
  logic [7:0]  pwdata;     
  logic        pready; 

endinterface
