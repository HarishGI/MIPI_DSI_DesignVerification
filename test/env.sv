class env extends uvm_env;
  `uvm_component_utils(env)
  function new(string name="env",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  dc_agent dcag;
  ahb_agent ahbag;
  ppi_agent ppiag;
  scoreboard score;
 //my_subscriber sub;
 

  function void build_phase(uvm_phase phase);
   super.build_phase(phase);

    dcag = dc_agent::type_id::create("dcag",this);
    ahbag = ahb_agent::type_id::create("ahbag",this);
    ppiag = ppi_agent::type_id::create("ppiag",this);
    score = scoreboard::type_id::create("score",this);
  //  sub=my_subscriber::type_id::create("sub",this);
    
    
  endfunction
  
 function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   dcag.dcmon.madcs.connect(score.dcai);
   ppiag.ppi_mon.ppi_aport.connect(score.ppii);

  endfunction
endclass




 