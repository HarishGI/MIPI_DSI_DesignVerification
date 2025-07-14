class ppi_agent extends uvm_agent;
  
  `uvm_component_utils(ppi_agent)
  
  function new(string name="ppi_agent",uvm_component parent);
  
    super.new(name,parent);
  endfunction
  
  ppi_monitor ppi_mon;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    ppi_mon = ppi_monitor::type_id::create("ppi_mon",this);
  endfunction
  
endclass
    