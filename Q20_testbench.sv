/* NOTE:
Test Stimulus: Various combinations of inputs to test different cases:
When x remains the same (x == $past(x)), y should be 0.
If x changes, y remains 0, which is valid.
while x remains the same and y becomes non-zero , the assertion will fail, showing that y must remain 0 when x does not change.
    
Possible Test Input Combinations:
Case 1: x = 0, y = 0 → x doesn't change, y is 0.
Case 2: x = 1, y = 0 → x doesn't change, y remains 0.
Case 3: x changes (from 0 to 1, or 1 to 0), y remains 0.
Case 4: x stays the same, but y changes to a non-zero value (Assertion should fail).
  
Expected Results:
If the assertion passes, everything works as expected.
If the assertion fails, it will show that the value of y was non-zero when x stayed the same, which violates the property.
This should work as expected for verifying that y is 0 whenever x does not change.
*/
//Q20. Write an property to check if signal "x" is equal to previous "x", signal y would be 0 

// Meaning  if signal x is equal to the previous value of x then signal y should be 0 in that case
module tb_top;
  reg clk;
  reg x;
  reg y;  
  
  always begin
    #5 clk = ~clk;  // Clock with a period of 10 time units
  end
   
  initial begin    
    clk = 0;
    x = 0;
    y = 1;  // Start with y = 1

    // Stimulus: Test case 1: x does not change, y should be 0
    #10 x = 0; y = 0;  // x remains 0, y should be 0
    #10 x = 1; y = 0;  // x changes to 1, y should be 0
    
    // Stimulus: Test case 2: x changes, but y should still be 0
    #10 x = 1; y = 0;  // x remains 1, y should be 0
    #10 x = 0; y = 0;  // x changes back to 0, y should be 0
    
    // Stimulus: Test case 3: Checking y non-zero when x changes
    #10 x = 1; y = 0;  // x remains 1, y should still be 0
    #10 x = 1; y = 1;  // Now y is non-zero; assertion will fail if x = 1
    // Test ends after some time
    #10 $stop;    
  end
  
   property check_x_equals_past_x;
    @(posedge clk) 
     (x == $past(x)) |-> (y == 0);
   endproperty
  
   P1:assert property (check_x_equals_past_x)    
     $info ("PASSED: Assertion Passsed while checking x equals to past x at TIME=%0d ",$realtime);    
   else    
     $error("FAILED: Assertion Failed  while checking x equals to past x at TIME=%0d ",$realtime);
    
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
endmodule
     
//Log file output     
[2025-05-09 09:23:46 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Fri May  9 05:23:47 2025

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
CPU time: .422 seconds to compile + .377 seconds to elab + .357 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  9 05:23 2025
Info: "testbench.sv", 47: tb_top.P1: at time 15 ns
PASSED: Assertion Passsed while checking x equals to past x at TIME=15 
Info: "testbench.sv", 47: tb_top.P1: at time 35 ns
PASSED: Assertion Passsed while checking x equals to past x at TIME=35 
"testbench.sv", 47: tb_top.P1: started at 65ns failed at 65ns
	Offending '(y == 0)'
Error: "testbench.sv", 47: tb_top.P1: at time 65 ns
FAILED: Assertion Failed  while checking x equals to past x at TIME=65 
$stop at time 70 Scope: tb_top File: testbench.sv Line: 38
