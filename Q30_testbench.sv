//Q30. Write an assertion such that ,If signal_a is active, then signal_b was active 3 cycles ago.
module tb_top;
  logic clk;
  logic rst;
  logic signal_a;
  logic signal_b;

  // Clock generation
  always #5 clk = ~clk;

  // ASSERTION: If signal_a is active, then signal_b was active 3 cycles ago
  property p_signal_a_implies_signal_b_3_cycles_ago;
    @(posedge clk)
    disable iff (rst)
    signal_a |-> (signal_b == $past(signal_b, 3));
  endproperty
    
  P1:assert property (p_signal_a_implies_signal_b_3_cycles_ago)    
     $info ("PASSED: When signal_a is active, signal_b was active 3 cycles ago at time %0t ",$realtime);    
   else    
     $error("FAILED: When signal_a is active, signal_b was not active 3 cycles ago at time %0t ",$realtime);   

  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end  

  // STIMULUS
  initial begin
    // Initialize
    clk = 0; rst = 1; signal_a = 0; signal_b = 0;
    #12 rst = 0;
    // Stimulus patterns
    #10 signal_a = 1; signal_b = 1;   // signal_a active, signal_b was active 3 cycles ago
    #10 signal_a = 0; signal_b = 0;   // signal_a inactive, no check
    #10 signal_a = 1; signal_b = 1;   // signal_a active, signal_b was active 3 cycles ago
    #10 signal_a = 1; signal_b = 0;   // signal_a active, but signal_b was not active 3 cycles ago (should fail)
    #10 signal_a = 0; signal_b = 1;   // signal_a inactive, no check
    #10 signal_a = 1; signal_b = 1;   // signal_a active, signal_b was active 3 cycles ago
    #20 $finish;
  end
endmodule

//Logfile output    
[2025-05-14 03:22:42 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Tue May 13 23:22:43 2025

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
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module tb_top
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .421 seconds to compile + .363 seconds to elab + .452 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 13 23:22 2025
"testbench.sv", 21: tb_top.P1: started at 25ns failed at 25ns
	Offending '(signal_b == $past(signal_b, 3))'
Error: "testbench.sv", 21: tb_top.P1: at time 25 ns
FAILED: When signal_a is active, signal_b was not active 3 cycles ago at time 25 
"testbench.sv", 21: tb_top.P1: started at 45ns failed at 45ns
	Offending '(signal_b == $past(signal_b, 3))'
Error: "testbench.sv", 21: tb_top.P1: at time 45 ns
FAILED: When signal_a is active, signal_b was not active 3 cycles ago at time 45 
"testbench.sv", 21: tb_top.P1: started at 55ns failed at 55ns
	Offending '(signal_b == $past(signal_b, 3))'
Error: "testbench.sv", 21: tb_top.P1: at time 55 ns
FAILED: When signal_a is active, signal_b was not active 3 cycles ago at time 55 
Info: "testbench.sv", 21: tb_top.P1: at time 75 ns
PASSED: When signal_a is active, signal_b was active 3 cycles ago at time 75 
"testbench.sv", 21: tb_top.P1: started at 85ns failed at 85ns
	Offending '(signal_b == $past(signal_b, 3))'
Error: "testbench.sv", 21: tb_top.P1: at time 85 ns
FAILED: When signal_a is active, signal_b was not active 3 cycles ago at time 85 
$finish called from file "testbench.sv", line 45.
$finish at simulation time                   92
           V C S   S i m u l a t i o n   R e p o r t 
Time: 92 ns
CPU Time:      0.450 seconds;       Data structure size:   0.0Mb
Tue May 13 23:22:45 2025
Done    
