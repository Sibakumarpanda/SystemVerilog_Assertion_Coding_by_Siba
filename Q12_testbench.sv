//Q12. Write an assertion which checks that once a valid request(req) is asserted by the master, the arbiter provides a grant(gnt) within 2 to 5 clock cycles.
module test_arbiter_grant;
  logic clk;
  logic req;   // Request signal from master
  logic gnt;   // Grant signal from arbiter

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
  end

  // Stimulus to test different cases
  initial begin
    // Case 1: Request is asserted and grant happens within 2-5 cycles
    #3  req = 1;  // Request asserted at t=3ns
    #5  gnt = 1;  // Grant within 5 clock cycles (t=8ns)
    
    #15 req = 0;  // Request deasserted at t=18ns
    
    #5  req = 1;  // Request asserted again at t=23
    #10 gnt = 1;  // Grant happens at t=33, which is within the 2-5 clock cycles
    
    #20 req = 0;  // Request deasserted at t=53
    
    #10 req = 1;  // Request asserted again at t=63
    #8  gnt = 1;  // Grant happens too soon (t=71), which is within 2 clock cycles, and should pass.

    #10 $finish;
  end

  // Assertion to check grant within 2 to 5 clock cycles after request is asserted
  property req_to_grant_within_2_to_5_cycles;
    @(posedge clk)
    (req == 1) |-> ##[2:5] gnt == 1;
  endproperty

  // Assertion check
  P1: assert property (req_to_grant_within_2_to_5_cycles)
    $display("PASSED: Grant within 2-5 clock cycles at time %0t", $time);
  else
    $error("FAILED: Grant not within 2-5 clock cycles at time %0t", $time);

  // For waveform generation
  initial begin
    $dumpfile("arbiter_grant.vcd");
    $dumpvars(0, test_arbiter_grant);
  end
endmodule
    
//Logfile output
[2025-05-07 10:45:42 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May  7 06:45:43 2025

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
       test_arbiter_grant
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module test_arbiter_grant
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .246 seconds to compile + .237 seconds to elab + .209 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  7 06:45 2025
PASSED: Grant within 2-5 clock cycles at time 25
PASSED: Grant within 2-5 clock cycles at time 35
PASSED: Grant within 2-5 clock cycles at time 55
PASSED: Grant within 2-5 clock cycles at time 65
PASSED: Grant within 2-5 clock cycles at time 75
$finish called from file "testbench.sv", line 31.
$finish at simulation time                   86
           V C S   S i m u l a t i o n   R e p o r t 
Time: 86 ns
CPU Time:      0.260 seconds;       Data structure size:   0.0Mb
Wed May  7 06:45:44 2025
Done
    
