class ahb_driver extends uvm_driver#(ahb_seq_item);
`uvm_component_utils(ahb_driver)
  function new(string name="ahb_driver",uvm_component parent);
super.new(name,parent);
endfunction
 
  virtual ahb_interface ahb_int;
  ahb_seq_item ahbs;
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ahbs=ahb_seq_item::type_id::create("ahbs");
   
    if(!(uvm_config_db#(virtual ahb_interface)::get(this,"*","ahb_interface",ahb_int)))
      `uvm_fatal(get_full_name(),"error");
  endfunction
  
  task run_phase(uvm_phase phase);
    forever
      begin
    seq_item_port.get_next_item(ahbs);
    
      begin
    
    @(posedge ahb_int.ahb_clk)
     ahb_int.haddr<=ahbs.haddr;
     ahb_int.hwrite<=ahbs.hwrite;
     ahb_int.hwdata<=ahbs.hwdata;
     ahb_int.hsize<=ahbs.hsize;
     ahb_int.hburst<=ahbs.hburst;
     ahb_int.hprot<=ahbs.hprot;
     
     
    
     seq_item_port.item_done();
      end
      end
  endtask
    
endclass