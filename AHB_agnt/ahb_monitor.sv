 class ahb_monitor extends uvm_monitor;
  `uvm_component_utils(ahb_monitor)
  function new(string name="ahb_monitor",uvm_component parent);
super.new(name,parent);
endfunction
  

ahb_seq_item ahbs;
virtual ahb_interface ahb_int;


function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!(uvm_config_db#(virtual    ahb_interface)::get(this,"*","ahb_interface",ahb_int)))
       
    `uvm_fatal(get_full_name(),"error");
endfunction
         
   task run_phase(uvm_phase phase);
     ahbs=ahb_seq_item::type_id::create("ahbs");
         repeat(9)
          
           begin
         
         @(posedge ahb_int.ahb_clk)
             begin
         
         ahbs.hready=ahb_int.hready;
         ahbs.hresp=ahb_int.hresp;
             end
           end
           
       endtask
 endclass