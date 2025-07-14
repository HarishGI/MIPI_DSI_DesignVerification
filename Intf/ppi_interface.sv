interface ppi_interface(input bit ppi_clk);
  logic [7:0] ppi_data_lane0;
  logic [7:0] ppi_data_lane1;
  logic [7:0] ppi_data_lane2;
  logic [7:0] ppi_data_lane3;
  logic ppi_lane0_en;
  logic ppi_lane1_en;
  logic ppi_lane2_en;
  logic ppi_lane3_en;
  
  sequence s1;
    $rose (ppi_lane0_en);
  endsequence
  sequence s2;
    $rose (ppi_lane1_en);
  endsequence
  property p1;
    @(posedge ppi_clk)
    s1 |=> s2;
  endproperty
  assert property(p1)
    $info("assertion pass");
    else
      $warning("assertion failed");
    
endinterface
  