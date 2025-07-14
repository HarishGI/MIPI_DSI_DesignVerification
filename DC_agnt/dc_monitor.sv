class dc_monitor extends uvm_monitor;
`uvm_component_utils(dc_monitor)
 
  function new(string name="dc_monitor",uvm_component parent);
super.new(name,parent);
endfunction

int i;
dc_seq_item dcs;
 virtual dc_interface dc_int;
  uvm_analysis_port#(dc_seq_item)  madcs;

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db#(virtual dc_interface)::get(this,"*","dc_interface",dc_int)))
    `uvm_fatal(get_full_name(),"error");
  madcs = new ("madcs",this);                                                 
endfunction
                                                 
  task run_phase(uvm_phase phase);                             dcs=dc_seq_item::type_id::create("dcs",this); 
    
    @(posedge dc_int.dc_clk)
    dcs.pixel_data = new[9];
     forever
       begin
         dc_mon();
         if(i>=9)
           break;
       end
         madcs.write(dcs);
       
  endtask
    task dc_mon();
      @(posedge dc_int.dc_clk)
      if(dc_int.data_valid && (dc_int.pixel_data>0))
        begin
          dcs.pixel_data[i]=dc_int.pixel_data;
          $display("@time=%0t  dcs.pixel_data[%0d]=%0p",$time,i,dcs.pixel_data[i]);
          i++;
        end
    endtask
      endclass
        
        
    
                                                 