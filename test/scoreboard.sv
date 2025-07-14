class scoreboard extends uvm_scoreboard;
  `uvm_component_utils (scoreboard)
  
  `uvm_analysis_imp_decl(_dcai)
  `uvm_analysis_imp_decl(_ppii)
  function new (string name="scoreboard",uvm_component parent);
    super.new (name,parent);
  endfunction
  
  dc_seq_item dcs,dcs1;
  ppi_seq_item ppis,ppis1;
  dc_seq_item dcq[$];
  ppi_seq_item ppiq[$];
  
  uvm_analysis_imp_dcai#(dc_seq_item,scoreboard) dcai;
  uvm_analysis_imp_ppii#(ppi_seq_item,scoreboard) ppii;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    dcai=new("dcai",this);
    ppii=new("ppii",this);
  endfunction
  
  
  function void write_dcai(dc_seq_item dcs);
    if(dcs.pixel_data.size>0)
      
      begin
        dcq.push_back(dcs);
      end
  endfunction
  
  function void write_ppii(ppi_seq_item ppis);
    if(ppis.pixel_data.size>0)
      begin
        ppiq.push_back(ppis);
      end
    $display("ppiq=%0p",ppiq);
  endfunction
  
  task run_phase(uvm_phase phase);
    forever
      begin
        wait((dcq.size>0) && (ppiq.size>0))
        compare();
      end
  endtask
  
  function void compare();
    dc_seq_item vara;
    ppi_seq_item varb;
    
    vara=dcq.pop_front();
    $display("hh",vara);
    
    varb=ppiq.pop_front();
    for(int i=0;i<8;i++)
     begin
      if(vara.pixel_data[i] == varb.pixel_data[i])
        begin
       $display("scoreboard matched..................vara.pixel_data[%0d]=%0p varb.pixel_data[%0d]=%0p",i,vara.pixel_data[i],i,varb.pixel_data[i]);
          end
        else
          begin
            $display("scoreboard  not matched..................vara.pixel_data[%0d]=%0p varb.pixel_data[%0d]=%0p",i,vara.pixel_data[i],i,varb.pixel_data[i]);
          end
     end
        
        endfunction
        
  endclass
  

