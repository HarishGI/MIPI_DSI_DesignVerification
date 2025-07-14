`include "uvm_macros.svh"
 import uvm_pkg::*;
   

`include "dc_interface.sv"
`include "dc_seq_item.sv"
`include "dc_seq.sv"
`include "dc_seqr.sv"
`include "dc_driver.sv"
`include "dc_monitor.sv"
`include "dc_agent.sv"


`include "ahb_interface.sv"
`include "ahb_seq_item.sv"
`include "ahb_seq.sv"
`include "ahb_seqr.sv"
`include "ahb_driver.sv"
`include "ahb_monitor.sv"
`include "ahb_agent.sv"


`include "ppi_interface.sv"
`include "ppi_seq_item.sv"
`include "ppi_monitor.sv"
`include "ppi_agent.sv"

`include "scoreboard.sv"
//`include "my_subscriber.sv"


`include "env.sv"
`include "test.sv"

module tb();
  bit dc_clk;
  bit dc_rst;
  bit dsi_clk;
  always #10 dc_clk=~ dc_clk;
  
  initial
    begin
      dc_rst=0;
      #30 dc_rst=1;
    end
 dc_interface dc_int(.dc_clk(dc_clk),
               .dc_rst(dc_rst));
  ahb_interface ahb_int(.ahb_clk(dc_clk),
                 .ahb_rst(dc_rst));

  ppi_interface ppi_int( .ppi_clk(dsi_clk));

  dsi#(8,9) dut(.pixel_data(dc_int.pixel_data),
                .data_valid(dc_int.data_valid),
                .hsync(dc_int.hsync),
                .vsync(dc_int.vsync),

                .haddr(ahb_int.haddr),
                .hwrite(ahb_int.hwrite),
                .hsize(ahb_int.hsize),
                .hburst(ahb_int.hburst),
                .htrans(ahb_int.htrans),
                .hwdata(ahb_int.hwdata),
                .hprot(ahb_int.hprot),
                .hresp(ahb_int.hresp),
                .hready(ahb_int.hready),

                .pclk(dc_clk),
                .dsi_clk(dsi_clk),
                .dsi_rst(dc_rst),
                .ppi_data_lane0(ppi_int.ppi_data_lane0),
                .ppi_data_lane1(ppi_int.ppi_data_lane1),
                .ppi_data_lane2(ppi_int.ppi_data_lane2),
                .ppi_data_lane3(ppi_int.ppi_data_lane3),
                .ppi_lane0_en(ppi_int.ppi_lane0_en),
                .ppi_lane1_en(ppi_int.ppi_lane1_en),
                .ppi_lane2_en(ppi_int.ppi_lane2_en),
                .ppi_lane3_en(ppi_int.ppi_lane3_en)
  );


  initial
    begin
      uvm_config_db#(virtual dc_interface)::set(null,"*","dc_interface",dc_int);
      uvm_config_db#(virtual ahb_interface)::set(null,"*","ahb_interface",ahb_int);
      uvm_config_db#(virtual ppi_interface)::set(null,"*","ppi_interface",ppi_int);
    end

  initial
    begin
      run_test("test");
      set_global_timeout(5100);
    end

  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
      #10000 $finish;
    end
endmodule