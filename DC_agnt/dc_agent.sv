class dc_agent extends uvm_agent;
  `uvm_component_utils (dc_agent)
  function new(string name="dc_agent",uvm_component parent);
    super.new(name,parent);
endfunction



  dc_seqr dcseqr;
  dc_driver dcdri;
  dc_monitor dcmon;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    dcseqr = dc_seqr::type_id::create("dcseqr",this);
    dcdri = dc_driver::type_id::create("dcdri",this);
    dcmon = dc_monitor::type_id::create("dcmon",this);
  endfunction


function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  dcdri.seq_item_port.connect(dcseqr.seq_item_export);
endfunction
endclass

  
  