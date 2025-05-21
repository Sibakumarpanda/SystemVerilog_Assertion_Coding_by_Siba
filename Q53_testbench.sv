//Q53. Write an assertion such that On rose of a, wait for rose of b or c. If b comes first, then d should be 1. If c comes first d should be zero.

/*On the rising edge of a, we wait for the rising edge of either b or c.
If b rises first, then d should be 1.
If c rises first, then d should be 0. */

module tb_top;
  reg a, b, c, d;
  reg clk;
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
  end

  // Stimulus generation
  initial begin   
    a = 0; b = 0; c = 0; d = 0;
    repeat (10) @(posedge clk); // Wait for some cycles

    // Example stimulus pattern
    @(posedge clk); a = 1; b = 0; c = 0; d = 0; // Rising edge of a
    @(posedge clk); a = 0; b = 1; c = 0; d = 1; // Rising edge of b, d should be 1
    @(posedge clk); a = 1; b = 0; c = 0; d = 0; // Rising edge of a
    @(posedge clk); a = 0; b = 0; c = 1; d = 0; // Rising edge of c, d should be 0

    repeat (30) @(posedge clk); // Run additional cycles to ensure assertion evaluation
    $finish; // End simulation
  end

  // Define sequences for the assertion
  sequence wait_for_b_or_c;
    @(posedge a) (b || c);
  endsequence

  sequence b_first;
    @(posedge b) (d == 1);
  endsequence

  sequence c_first;
    @(posedge c) (d == 0);
  endsequence

  // Property to check the behavior
  property check_a_b_c_d_behavior;
    wait_for_b_or_c |-> (b_first or c_first);
  endproperty

  // Instantiate the property as an assertion
  P1: assert property (check_a_b_c_d_behavior)
    $display("PASSED at TIME=%0d with a=%0b b=%0b c=%0b d=%0b", $time, a, b, c, d);
  else
    $error("FAILED at TIME=%0d with a=%0b b=%0b c=%0b d=%0b", $time, a, b, c, d);

  // Dump waveform
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end
endmodule

//Logfile Output
[2025-05-21 12:55:35 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May 21 08:55:37 2025

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
CPU time: .591 seconds to compile + .582 seconds to elab + .497 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 21 08:55 2025
PASSED at TIME=135 with a=0 b=0 c=1 d=0
$finish called from file "testbench.sv", line 31.
$finish at simulation time                  435
           V C S   S i m u l a t i o n   R e p o r t 
Time: 435 ns
CPU Time:      0.510 seconds;       Data structure size:   0.0Mb
Wed May 21 08:55:39 2025
Done    
