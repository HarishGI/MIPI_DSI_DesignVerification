class dc_seqr extends uvm_sequencer#(dc_seq_item);
`uvm_component_utils(dc_seqr)
  function new(string name="dc_seqr",uvm_component parent);
    super.new(name,parent);
endfunction
endclass
