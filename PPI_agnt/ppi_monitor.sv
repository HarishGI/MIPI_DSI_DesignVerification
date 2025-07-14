class ppi_monitor extends uvm_monitor;
`uvm_component_utils(ppi_monitor)
  function new(string name="ppi_monitor",uvm_component parent);
super.new(name,parent);
endfunction
 
  dc_seq_item dcs;
  ppi_seq_item ppis;
 virtual  ppi_interface ppi_int;
  uvm_analysis_port#(ppi_seq_item) ppi_aport;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ppis=ppi_seq_item::type_id::create("ppis");
   
    if(!(uvm_config_db#(virtual ppi_interface)::get(this,"*","ppi_interface",ppi_int)))
      `uvm_fatal (get_full_name(),"error");
           ppi_aport=new("ppi_aport",this);
   endfunction
           
           task run_phase(uvm_phase phase);
             dcs=dc_seq_item::type_id::create("dcs");
             ppis.pixel_data=new[100];
            
             forever
               begin
                 ppi_moni();
                 
               end
           endtask
           
           task ppi_moni();
             bit [7:0] data[200];
             bit [23:0] mem[9];
             bit [7:0]k;
             
             @(posedge ppi_int.ppi_clk)
            @(ppi_int.ppi_lane0_en && ppi_int.ppi_lane1_en)
             
             for(int i=0;i<59;i=i+2)
               begin
                  @(posedge ppi_int.ppi_clk)
                 data[i]=ppi_int.ppi_data_lane0;
                
                 data[i+1]=ppi_int.ppi_data_lane1;
               end
             
             for(int i=30;i<57;i=i+3)
               begin
                 mem[k]={data[i+2],data[i+1],data[i]};
                 k++;
               end
             ppis.pixel_data=mem;
             ppi_aport.write(ppis);
           endtask
                 
                 
              
           
endclass