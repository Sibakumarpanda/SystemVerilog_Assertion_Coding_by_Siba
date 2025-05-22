//Q59. Is it possible to have concurrent assertions implemented inside a class?

/*Assertions themselves are typically used within modules or interfaces, but you can certainly encapsulate them within a class 
using object-oriented features in SystemVerilog. 
The class might include methods or properties that check for certain conditions, and you could implement concurrent checks in a testbench.
SystemVerilog assertions (property and assert) are typically used within modules, interfaces, or blocks, not directly inside classes in the way you have it. 
In SystemVerilog, assertions are generally evaluated in the context of a simulation environment (such as inside modules, interfaces, or initial/always blocks). 
They are not directly supported as class members in the way you might expect with other object-oriented constructs

*/
  
//Example   
class myassertions_class;

  logic clk;
  logic rst_n;
  logic [7:0] data;

  // Constructor
  function new(logic clk, logic rst_n, logic [7:0] data);
    this.clk = clk;
    this.rst_n = rst_n;
    this.data = data;
  endfunction


endclass : myassertions_class

module tb_top;

  logic clk;
  logic rst_n;
  logic [7:0] data;
  
  // Declare assertions class handle
  myassertions_class my_assertions_h;  
  
  always #2 clk = ~clk;  // Clock generation

  initial begin
    // Initialize signals
    clk = 0;
    rst_n = 1;
    data = 0;

    // Instantiate assertions class
    my_assertions_h = new(clk, rst_n, data);

    // Apply stimulus
    rst_n = 0;
    #5 rst_n = 1;
    #5 data = 200;
    #5 data = 300; // This will trigger data limit assertion failure
  end
  
   // Assertion 1: Check if reset is active low during the first clock cycle
  property reset_assertion;
    @(posedge clk) 
    disable iff (!rst_n) // Disable assertion when reset is active
    rst_n == 0;
  endproperty
  
  assert property (reset_assertion) 
    else $fatal("Reset assertion failed!");

  // Assertion 2: Data should not exceed 255 during operation
  property data_limit_assertion;
    @(posedge clk) 
    disable iff (rst_n) // Disable assertion during reset
    data <= 255;
  endproperty
    
  assert property (data_limit_assertion) 
    else $fatal("Data limit exceeded!");

  // Assertion 3: Data should remain stable when reset is active
  property stable_data_assertion;
    @(posedge clk) 
    disable iff (!rst_n) // Disable assertion when reset is not active
    data == $past(data);  // Data should remain stable on reset
  endproperty
    
  assert property (stable_data_assertion) 
    else $fatal("Data is unstable during reset!");  
endmodule :tb_top

//Logfile Output
[2025-05-22 09:27:14 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu May 22 05:27:15 2025

                    Copyright (c) 1991 - 2023 Synopsys, Inc.
   This software and the associated documentation are proprietary to Synopsys,
 Inc. This software may only be used in accordance with the terms and conditions
 of a written license agreement with Synopsys, Inc. All other use, reproduction,
   or distribution of this software is strictly prohibited.  Licensed Products
     communicate with Synopsys servers for the purpose of providing software
    updates, detecting software piracy and verifying that customers are using
    Licensed Products in conformity with the applicable License Key for such
  Licensed Products. Synopsys will use information gathered in connection with
    this process to deliver software updates and pursue software pirates and
                                   infringers.

 Inclusivity & Diversity - Visit SolvNetPlus to read the "Synopsys Statement on
            Inclusivity and Diversity" (Refer to article 000036315 at
                        https://solvnetplus.synopsys.com)

Parsing design file 'design.sv'
Parsing design file 'testbench.sv'
Top Level Modules:
       tb_top
TimeScale is 1 ns / 1 ns

Warning-[SVA-IAU] Invalid argument used
testbench.sv, 67
tb_top, "$fatal("Reset assertion failed!");"
  The first argument ""Reset assertion failed!"" used in '$fatal' is not 
  valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.


Warning-[SVA-IAU] Invalid argument used
testbench.sv, 77
tb_top, "$fatal("Data limit exceeded!");"
  The first argument ""Data limit exceeded!"" used in '$fatal' is not valid. 
  Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.


Warning-[SVA-IAU] Invalid argument used
testbench.sv, 87
tb_top, "$fatal("Data is unstable during reset!");"
  The first argument ""Data is unstable during reset!"" used in '$fatal' is 
  not valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.

Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module tb_top
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .250 seconds to compile + .224 seconds to elab + .200 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 22 05:27 2025
"testbench.sv", 66: tb_top.unnamed$$_1: started at 6ns failed at 6ns
	Offending '(rst_n == 0)'
Fatal: "testbench.sv", 66: tb_top.unnamed$$_1: at time 6 ns
Reset assertion failed!
$finish called from file "testbench.sv", line 66.
$finish at simulation time                    6
           V C S   S i m u l a t i o n   R e p o r t 
Time: 6 ns
Done    
  
