//Q13. There are 2 signals x_sig and y_sig. On next clock of x_sig we should get y_sig. Write an assertion and also a cover property for the same. The assertion should be disabled when rst_n is high.
//(i.e., y_sig should match the value of x_sig after one clock cycle), and to disable this assertion when rst_n is high,
module test_x_to_y_sync;
  logic clk;          // Clock signal
  logic rst_n;        // Active-low reset signal
  logic x_sig;        // x signal to trigger y_sig
  logic y_sig;        // y signal to be checked

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
  end

  // Stimulus to test different cases
  initial begin
    // Reset the signals at the beginning
    rst_n = 0;
    x_sig = 0;
    y_sig = 0;
    #3 rst_n = 1;  // Release reset after 3ns
    
    // Case 1: x_sig changes, y_sig matches after one clock cycle
    #10 x_sig = 1;   // At time 13ns, x_sig changes
    #10 y_sig = 1;   // At time 23ns, y_sig should match x_sig after one cycle
    

    // Case 2: x_sig changes, but y_sig does not match (assertion fails)
    #10 x_sig = 0;   // At time 33ns, x_sig changes
    #10 y_sig = 1;   // At time 43ns, y_sig doesn't match x_sig (should fail assertion)
    

    // Case 3: During reset, assertion should be disabled
    #10 rst_n = 0;  // At time 53ns, assert reset
    #10 x_sig = 1;  // At time 63ns, x_sig changes (assertion disabled)
    #10 y_sig = 0;  // At time 73ns, y_sig changes (assertion is disabled)

    #20 $finish;  // End the simulation
  end

  // Assertion: When x_sig changes, y_sig should match it after one clock cycle
  property x_to_y_sync_assertion;
    @(posedge clk)
    disable iff (rst_n)  // Disable assertion when rst_n is high
    (x_sig == 1) |-> ##1 (y_sig == 1); // Ensure y_sig follows x_sig after one clock cycle
  endproperty

  // Assertion check
  assert_x_to_y_sync: assert property (x_to_y_sync_assertion)
    $display("PASSED: x_sig and y_sig matched at time %0t", $time);
  else
    $error("FAILED: x_sig and y_sig did not match at time %0t", $time);

  // Cover property: To track how often the assertion passes
  cover property (x_to_y_sync_assertion);
  
  // For waveform generation
  initial begin
    $dumpfile("x_to_y_sync.vcd");
    $dumpvars(0, test_x_to_y_sync);
  end
endmodule

//Logfile output
[2025-05-07 10:48:07 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May  7 06:48:08 2025

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
       test_x_to_y_sync
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module test_x_to_y_sync
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -lreader_common /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/libBA.a -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .256 seconds to compile + .219 seconds to elab + .200 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  7 06:48 2025
"testbench.sv", 54: test_x_to_y_sync.assert_x_to_y_sync: started at 65ns failed at 75ns
	Offending '(y_sig == 1)'
Error: "testbench.sv", 54: test_x_to_y_sync.assert_x_to_y_sync: at time 75 ns
FAILED: x_sig and y_sig did not match at time 75
"testbench.sv", 54: test_x_to_y_sync.assert_x_to_y_sync: started at 75ns failed at 85ns
	Offending '(y_sig == 1)'
Error: "testbench.sv", 54: test_x_to_y_sync.assert_x_to_y_sync: at time 85 ns
FAILED: x_sig and y_sig did not match at time 85
$finish called from file "testbench.sv", line 43.
$finish at simulation time                   93
"testbench.sv", 60: test_x_to_y_sync.unnamed$$_2, 9 attempts, 0 match
           V C S   S i m u l a t i o n   R e p o r t 
Time: 93 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Wed May  7 06:48:09 2025
Done
    
    
