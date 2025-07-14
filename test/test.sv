class test extends uvm_test;
  `uvm_component_utils(test)
  
  function new(string name="test",uvm_component parent);
    super.new(name,parent);
  endfunction
    env henv;
  dc_seq dcseq;
  ahb_seq ahbseq;
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    henv = env::type_id::create("henv",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    dcseq=dc_seq::type_id::create("dcseq",this);
    ahbseq=ahb_seq::type_id::create("ahbseq",this);
    phase.raise_objection(this);
    fork
      dcseq.start(henv.dcag.dcseqr);
      ahbseq.start(henv.ahbag.ahbseqr);
    join
    #15;
    phase.drop_objection(this);
  endtask
  
  function void start_of_simulation_phase(uvm_phase phase);
    uvm_top.print_topology;
     
  endfunction
  
endclass
  
  
  
  
  