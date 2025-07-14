class dc_driver extends uvm_driver#(dc_seq_item);
 `uvm_component_utils(dc_driver)
  function new(string name="dc_driver",uvm_component parent);
   super.new(name,parent);
endfunction
  
dc_seq_item dcs;
 virtual dc_interface dc_int;
  int i,j;
  
function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    dcs=dc_seq_item::type_id::create("dcs");
  if(!(uvm_config_db#(virtual      dc_interface)::get(this,"*","dc_interface",dc_int)))
    `uvm_fatal(get_full_name(),"error");
endfunction
           
           virtual task run_phase(uvm_phase phase);
            
             forever
               begin
                 seq_item_port.get_next_item(dcs);
                 main_dcs();
                 $display("hhhh");
                 
                 seq_item_port.item_done();
                 dcs.print();
               end
           endtask
           
           task main_dcs();
             vsync();
             vbp();
             for(int i=0;i<dcs.height;i++)
             begin
               for(j=0;j<dcs.width;j++)
                 begin
                   @(posedge dc_int.dc_clk)
                   dc_int.pixel_data<= dcs.pixel_data[j];
                     dc_int.data_valid<=1;
                   
                 end
               vbp();
               hsync();
               vbp();
             end
             vsync();
           endtask
           
           task vsync();
             repeat(5)
             begin
               @(posedge dc_int.dc_clk)
                dc_int.pixel_data<=0;
                dc_int.data_valid<=0;
                dc_int.hsync<=1;
                dc_int.vsync<=1;
             end
           endtask
             
             task hsync();
               repeat(5)
                 begin
                   @(posedge dc_int.dc_clk)
                    dc_int.pixel_data<=0;
                    dc_int.data_valid<=0;
                    dc_int.hsync<=1;
                    dc_int.vsync<=0;
                 end
             endtask
           
           task vbp();
             repeat(3)
               begin
                 @(posedge dc_int.dc_clk)
                 dc_int.pixel_data<=0;
                 dc_int.data_valid<=0;
                 dc_int.hsync<=0;
                 dc_int.vsync<=0;
               end
           endtask
               
             
           endclass
           
                
           
           
           
           
