interface dc_interface(input dc_clk,input dc_rst);
  logic [23:0]pixel_data;
  logic data_valid;
  logic hsync;
  logic vsync;
  
  sequence s1;
    $rose (vsync);
  endsequence
  sequence s2;
    $rose (hsync);
  endsequence
  sequence s3;
    $fell (hsync) ##4 data_valid;
  endsequence
  property p1;
    @(posedge dc_clk)
       s1 |-> s2 ##5 s3;
  endproperty
  
  assert property(p1)
    $info("assertion pass");
       else
    $fatal("fail",$time);
  
endinterface