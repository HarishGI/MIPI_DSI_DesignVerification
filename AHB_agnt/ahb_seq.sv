class ahb_seq extends uvm_sequence#(ahb_seq_item);
  `uvm_object_utils(ahb_seq)
  function new (string name="ahb_seq");
super.new (name);
endfunction
  ahb_seq_item ahbs;
  task body();
    ahbs=ahb_seq_item::type_id::create("ahbs");
    
    `uvm_rand_send_with(ahbs,{haddr=='h4000_0000;
                                 hwdata=='h0000_0000;
                                 hwrite==1;hburst==0;
                                 htrans==2;hsize==2;})
    
    `uvm_rand_send_with(ahbs,{haddr=='h4000_0020;
                                 hwdata=='h0000_003D;
                                 hwrite==1;hburst==0;
                                 htrans==2;hsize==2;})
    
    `uvm_rand_send_with(ahbs,{haddr=='h4000_0024;
                                 hwdata=='h0000_002E;
                                 hwrite==1;hburst==0;
                                 htrans==2;hsize==2;})
    
    `uvm_rand_send_with(ahbs,{haddr=='h4000_0028;
                                 hwdata=='h0021_0002;
                                 hwrite==1;hburst==0;
                              htrans==2;hsize==2;})
    
    `uvm_rand_send_with(ahbs,{haddr=='h4000_002C;
                                 hwdata=='h0000_1031;
                                 hwrite==1;hburst==0;
                                 htrans==2;hsize==2;})
    
    `uvm_rand_send_with(ahbs,{haddr=='h4000_0030;
                                 hwdata=='h0002_2011;
                                 hwrite==1;hburst==0;
                                 htrans==2;hsize==2;})
    
    `uvm_rand_send_with(ahbs,{haddr=='h4000_0034;
                                 hwdata=='h0000_0001;
                                 hwrite==1;hburst==0;
                                 htrans==2;hsize==2;})
    
    `uvm_rand_send_with(ahbs,{haddr=='h4000_0038;
                                 hwdata=='h0003_1021;
                                 hwrite==1;hburst==0;
                                 htrans==2;hsize==2;})
    
    `uvm_rand_send_with(ahbs,{haddr=='h4000_003C;
                                 hwdata=='h0001_5011;
                                 hwrite==1;hburst==0;
                                 htrans==2;hsize==2;})
    
                                
    
                                
  endtask  
    
endclass