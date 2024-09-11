class dram_cov extends uvm_subscriber#(dram_seq_item);

  `uvm_component_utils(dram_cov)

  dram_seq_item tr;

covergroup cg_in;
   option.per_instance= 1;
    option.name        = "functional_cov";
 
  DATA : coverpoint tr.data_in {
      bins din = {[0:255]};
    }
    ADDRESS:coverpoint tr.add{
      bins addr = {[0:64]};
    }
  enable: coverpoint tr.en{bins en={0,1};}
  write: coverpoint tr.wr{bins wr={0,1};}
  eXw:cross enable,write;

endgroup
  

 

function new(string name="dram_cov",uvm_component parent);

  super.new(name,parent);


  tr=dram_seq_item::type_id::create("tr");

  cg_in=new();
  endfunction

 

  function void write(dram_seq_item t);

   tr=t;

   cg_in.sample();

    $display("input coverage =%0d ",cg_in.get_coverage());
    

endfunction

endclass
