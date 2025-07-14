class ahb_agent extends uvm_agent;
    `uvm_component_utils(ahb_agent)
         
  function new (string name="ahb_agent",uvm_component parent);
          super.new(name,parent);
  endfunction
  
  ahb_seqr ahbseqr;
  ahb_driver  ahbdri;
  ahb_monitor   ahbmon;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ahbseqr = ahb_seqr::type_id::create("ahbseqr",this);
    ahbdri = ahb_driver::type_id::create("ahbdri",this);
    ahbmon = ahb_monitor::type_id::create("ahbmon",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    
    ahbdri.seq_item_port.connect(ahbseqr.seq_item_export);
  endfunction
endclass
  
  