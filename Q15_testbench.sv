//Q15. Write an assertion or property to check if signal y is reflected upon signal x immediately.
//This is equivalent to saying that y immediately follows x in terms of value, i.e., both signals should have the same value at the same time.
module test_x_reflects_y_immediately;
  logic clk;      // Clock signal
  logic rst_n;    // Reset signal (active-low)
  logic x;        // Signal x
  logic y;        // Signal y
 
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
  end

  // Stimulus to test different cases
  initial begin
    // Reset the signals
    rst_n = 0;
    x = 0;
    y = 0;
    #3 rst_n = 1;  // Release reset after 3ns
    
    // Case 1: x and y change together
    #10 x = 1;   // At time 13ns, x is 1
    #10 y = 1;   // At time 23ns, y is also 1 (immediate reflection)
    
    // Case 2: x and y are different (assertion fails)
    #10 x = 0;   // At time 33ns, x becomes 0
    #10 y = 1;   // At time 43ns, y remains 1 (assertion fails)
    
    // Case 3: x and y change together again
    #10 x = 1;   // At time 53ns, x is 1
    #10 y = 1;   // At time 63ns, y is also 1 (immediate reflection)
    
    // Case 4: Reset, assertion is disabled during reset
    #10 rst_n = 0;  // At time 73ns, reset is asserted (deassert x, y)
    #10 x = 0;  // At time 83ns, x is 0 but assertion is disabled
    #10 y = 0;  // At time 93ns, y is also 0 (assertion disabled)
    
    #20 $finish;  // End the simulation
  end

  // Property: y must reflect x immediately
  property y_reflects_immediately_on_x;
    @(posedge clk)
    disable iff (rst_n)    // Disable assertion when reset is active
    x == y;                // Assert that x == y at each positive edge of the clock
  endproperty

  // Assertion check
  assert_x_reflects_y: assert property (y_reflects_immediately_on_x)
    begin      
      $display("PASSED: y reflects x immediately at time %0t", $time);
    end
  else
    begin      
      $error("FAILED: y did not reflect x immediately at time %0t", $time);
    end
  
  initial begin
    $dumpfile("x_reflects_y.vcd");
    $dumpvars();
  end
endmodule

//Log file output
[2025-05-07 10:52:15 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May  7 06:52:16 2025

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
       test_x_reflects_y_immediately
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module test_x_reflects_y_immediately
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _332_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .258 seconds to compile + .231 seconds to elab + .237 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  7 06:52 2025
PASSED: y reflects x immediately at time 75
"testbench.sv", 54: test_x_reflects_y_immediately.assert_x_reflects_y: started at 85ns failed at 85ns
	Offending '(x == y)'
Error: "testbench.sv", 54: test_x_reflects_y_immediately.assert_x_reflects_y: at time 85 ns
FAILED: y did not reflect x immediately at time 85
PASSED: y reflects x immediately at time 95
PASSED: y reflects x immediately at time 105
$finish called from file "testbench.sv", line 43.
$finish at simulation time                  113
           V C S   S i m u l a t i o n   R e p o r t 
Time: 113 ns
CPU Time:      0.240 seconds;       Data structure size:   0.0Mb
Wed May  7 06:52:17 2025
Done
    
    
