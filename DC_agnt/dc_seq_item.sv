typedef enum{QQVGA,QCIF,QVGA,CIF,VGA,WVGA,XGA,QXGA,QSXGA,HD}resolutions;

class dc_seq_item extends uvm_sequence_item;
`uvm_object_utils(dc_seq_item)
  function new(string name="dc_seq_item");
    super.new(name);
endfunction
  
  rand bit[23:0] pixel_data[];
  bit data_valid;
  rand bit hsync;
  rand bit vsync;
  rand int height;
  rand int width;
  rand resolutions res;
  
  constraint c1{res==QQVGA -> {height==3 && width==4};
                res==QCIF -> {height==4 && width==4};
                res==QVGA -> {height==5 && width==4};
                res==CIF -> {height==5 && width==6};
                res==VGA -> {height==3 && width==5};
                 res==WVGA -> {height==5 && width==7};
                 res==XGA-> {height==6 && width==7};
                 res==QXGA -> {height==7 && width==8};
                 res==QSXGA -> {height==8 && width==7};
                 res==HD -> {height==8 && width==9};}
  
  constraint c2{pixel_data.size inside{width};}
endclass