interface ahb_interface (input ahb_clk,input ahb_rst);
  logic [31:0] haddr;
  logic hwrite;
  logic [31:0] hwdata;
  logic [2:0] hburst;
  logic [2:0] hsize;
  logic [1:0] htrans;
  logic [1:0] hresp;
  logic [3:0] hprot;
  logic hready;
endinterface