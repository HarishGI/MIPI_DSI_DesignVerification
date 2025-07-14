class ahb_seq_item extends uvm_sequence_item;
  `uvm_object_utils(ahb_seq_item)
function new(string name="ahb_seq_item");
super.new(name);
endfunction
  
  rand bit[31:0] haddr;
  rand bit[31:0] hwdata;
  rand bit hwrite;
  rand bit[2:0] hsize;
  rand bit[2:0] hburst;
  rand bit[1:0] htrans;
  bit[1:0] hresp;
  rand bit [3:0] hprot;
  bit  hready;
endclass