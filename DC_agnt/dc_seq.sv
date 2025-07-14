class dc_seq extends uvm_sequence#(dc_seq_item);
  `uvm_object_utils(dc_seq)

  function new(string name="seq");
    super.new(name);
  endfunction
  
  dc_seq_item dcs;
 
   task body();
    
   dcs=dc_seq_item::type_id::create("dcs");
     begin
       wait_for_grant();
       dcs.randomize() with {res == HD;};
       send_request(dcs);
       wait_for_item_done();
     end
   endtask
  
endclass