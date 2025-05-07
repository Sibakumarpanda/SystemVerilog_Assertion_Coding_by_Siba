//Q11. Write an assertion to make sure that a 5-bit grant signal only has one bit set at any time? (only one req granted at a time)
module test_grant_signal;
  logic clk;
  logic [4:0] grant; // 5-bit grant signal

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Stimulus to test different cases
  initial begin
    // Case 1: Valid cases (one bit set)
    #3  grant = 5'b00001;  // Only req0 granted
    #10 grant = 5'b00010;  // Only req1 granted
    #10 grant = 5'b00100;  // Only req2 granted
    #10 grant = 5'b01000;  // Only req3 granted
    #10 grant = 5'b10000;  // Only req4 granted

    // Case 2: Invalid case (more than one bit set)
    #10 grant = 5'b00111;  // Multiple bits set, invalid!
    #10 grant = 5'b01101;  // Multiple bits set, invalid!

    #10 $finish;
  end

  // Assertion: grant signal must have exactly one bit set at any time
  property one_hot_grant;
    @(posedge clk)
    (grant != 0) && (grant & (grant - 1)) == 0; // One-hot check
  endproperty

  // Assertion check
  P1: assert property (one_hot_grant)
    $display("PASSED: One-hot grant signal at time %0t with grant = %b", $time, grant);
  else
    $error("FAILED: grant signal is not one-hot at time %0t with grant = %b", $time, grant);

  // For waveform generation
  initial begin
    $dumpfile("grant_signal.vcd");
    $dumpvars(0, test_grant_signal);
  end
endmodule
    
//Log file output
[2025-05-07 10:43:31 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May  7 06:43:32 2025

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
       test_grant_signal
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module test_grant_signal
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .259 seconds to compile + .219 seconds to elab + .204 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  7 06:43 2025
PASSED: One-hot grant signal at time 5 with grant = 00001
PASSED: One-hot grant signal at time 15 with grant = 00010
PASSED: One-hot grant signal at time 25 with grant = 00100
PASSED: One-hot grant signal at time 35 with grant = 01000
PASSED: One-hot grant signal at time 45 with grant = 10000
"testbench.sv", 37: test_grant_signal.P1: started at 55ns failed at 55ns
	Offending '((grant != 0) && ((grant & (grant - 1)) == 0))'
Error: "testbench.sv", 37: test_grant_signal.P1: at time 55 ns
FAILED: grant signal is not one-hot at time 55 with grant = 00111
"testbench.sv", 37: test_grant_signal.P1: started at 65ns failed at 65ns
	Offending '((grant != 0) && ((grant & (grant - 1)) == 0))'
Error: "testbench.sv", 37: test_grant_signal.P1: at time 65 ns
FAILED: grant signal is not one-hot at time 65 with grant = 01101
$finish called from file "testbench.sv", line 27.
$finish at simulation time                   73
           V C S   S i m u l a t i o n   R e p o r t 
Time: 73 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Wed May  7 06:43:33 2025
Done
