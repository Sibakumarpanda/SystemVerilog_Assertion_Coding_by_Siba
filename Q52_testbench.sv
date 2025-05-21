//Q52. Write an assertion such that A high for 5 cycles and B high after 4 continuous highs of A and finally both A and B are high.

/* Means :
A stays high for 5 continuous cycles.
B goes high after 4 continuous highs of A.
Finally, both A and B are high at the same time.
*/
module tb_top;
  reg A;
  reg B;
  reg clk;
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
  end
  
  initial begin
    // Generate all possible combinations of A and B
    A = 0; B = 0;
    repeat (10) @(posedge clk); // Wait for some cycles

    // Example stimulus pattern
    @(posedge clk); A = 1; B = 0; // Cycle 1
    $display("Cycle 1: A=%0b, B=%0b", A, B);
    @(posedge clk); A = 1; B = 0; // Cycle 2
    $display("Cycle 2: A=%0b, B=%0b", A, B);
    @(posedge clk); A = 1; B = 0; // Cycle 3
    $display("Cycle 3: A=%0b, B=%0b", A, B);
    @(posedge clk); A = 1; B = 1; // Cycle 4 (B goes high after 4 cycles of A)
    $display("Cycle 4: A=%0b, B=%0b", A, B);
    @(posedge clk); A = 1; B = 1; // Cycle 5 (Both A and B are high)
    $display("Cycle 5: A=%0b, B=%0b", A, B);

    repeat (30) @(posedge clk); // Run additional cycles to ensure assertion evaluation

    $finish; // End simulation
  end

  // Define a sequence for A being high for 5 continuous cycles
  sequence A_high_5_cycles;
    (A == 1) ##1 (A == 1) ##1 (A == 1) ##1 (A == 1) ##1 (A == 1);
  endsequence

  // Define a sequence for B going high after 4 continuous cycles of A being high
  sequence B_high_after_4_A;
    (A == 1) ##1 (A == 1) ##1 (A == 1) ##1 (A == 1) ##1 (B == 1);
  endsequence

  // Define a sequence for both A and B being high at the same time
  sequence A_and_B_high;
    (A == 1 && B == 1);
  endsequence

  // Property to check the behavior
  property check_A_B_behavior;
    @(posedge clk)
    A_high_5_cycles |-> B_high_after_4_A ##1 A_and_B_high;
  endproperty

  P1: assert property (check_A_B_behavior)
    $display("PASSED at TIME=%0d with A=%0b B= %0b", $time, A, B);
  else
    $error("FAILED at TIME=%0d with A=%0b B= %0b", $time, A, B);
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end
endmodule

//Logfile Output
[2025-05-21 12:53:23 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May 21 08:53:25 2025

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
CPU time: .462 seconds to compile + .476 seconds to elab + .410 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 21 08:53 2025
Cycle 1: A=1, B=0
Cycle 2: A=1, B=0
Cycle 3: A=1, B=0
Cycle 4: A=1, B=1
Cycle 5: A=1, B=1
PASSED at TIME=205 with A=1 B= 1
PASSED at TIME=215 with A=1 B= 1
PASSED at TIME=225 with A=1 B= 1
PASSED at TIME=235 with A=1 B= 1
PASSED at TIME=245 with A=1 B= 1
PASSED at TIME=255 with A=1 B= 1
PASSED at TIME=265 with A=1 B= 1
PASSED at TIME=275 with A=1 B= 1
PASSED at TIME=285 with A=1 B= 1
PASSED at TIME=295 with A=1 B= 1
PASSED at TIME=305 with A=1 B= 1
PASSED at TIME=315 with A=1 B= 1
PASSED at TIME=325 with A=1 B= 1
PASSED at TIME=335 with A=1 B= 1
PASSED at TIME=345 with A=1 B= 1
PASSED at TIME=355 with A=1 B= 1
PASSED at TIME=365 with A=1 B= 1
PASSED at TIME=375 with A=1 B= 1
PASSED at TIME=385 with A=1 B= 1
PASSED at TIME=395 with A=1 B= 1
PASSED at TIME=405 with A=1 B= 1
PASSED at TIME=415 with A=1 B= 1
PASSED at TIME=425 with A=1 B= 1
PASSED at TIME=435 with A=1 B= 1
$finish called from file "testbench.sv", line 43.
$finish at simulation time                  445
           V C S   S i m u l a t i o n   R e p o r t 
Time: 445 ns
CPU Time:      0.440 seconds;       Data structure size:   0.0Mb
Wed May 21 08:53:27 2025
Done    
    
    
