class my_subscriber extends uvm_subscriber#(dc_seq_item);
  `uvm_component_utils(my_subscriber)
  function new(string name="my_subscriber",uvm_component parent);
    super.new(name,parent);
    this.cg=new();
  endfunction
  
  virtual dc_interface dc_int;
  virtual ahb_interface ahb_int;
  virtual ppi_interface ppi_int;
  dc_seq_item dcs;
  uvm_analysis_imp#(dcs,my_subscriber) ais;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ais=new("ais",this);
    dcs=dc_seq_item::type_id::create("dcs",this);
    
    if(!(uvm_config_db#            (virtual   dc_interface)::get(this,"*","dc_int",dc_int)))
         
      `uvm_fatal(get_interface,"error")
      
    if(!(uvm_config_db#(virtual ahb_interface)::get(this,"*","ahb_int",ahb_int)))
      `uvm_fatal(get_interface,"error")
       
    if(!(uvm_config_db#(virtual ppi_interface)::get(this,"*","ahb_int",ahb_int)))
      `uvm_fatal(get_interface,"error");
    
  endfunction
  
  covergroup cg;
    option.per_instance=1;
    a:coverpoint dc_int.hsync;
    b:coverpoint dc_int.vsync;
    c:coverpoint dc_int.data_valid;
    d:coverpoint ahb_int.hwrite{bins b1={1};}
    e:coverpoint ahb_int.hready{bins b2={1};}
    f:coverpoint ppi_int.ppi_data_lane0{bins b3={[7:0]};}
    g:coverpoint ppi_int.ppi_lane0_en{bins b4={1};}
    h:coverpoint ppi_int.ppi_lane1_en{bins b5={1};}
  endgroup
  
  virtual function void write(dc_seq_item t);
    dcs=t;
  endfunction
  
  task run_phase(uvm_phase phase);
    forever
      begin
        @(posedge dc_int.dc_clk) cg.sample();
        if($get_coverage()==1000)
          break;
      end
  endtask
endclass
    
 
         
    