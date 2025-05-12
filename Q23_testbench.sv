//Q23. Make sure signal toggles in the pattern "010101..." or "101010..." 
//This means the signal must alternate between 0 and 1 on every positive clock edge, without repeating the same value twice in a row (i.e., no "00" or "11").
module tb_top;
  logic clk;
  logic rst_n;
  logic signal;

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset
  initial begin
    rst_n = 0;
    #12 rst_n = 1;
  end

  // Assertion: signal must alternate every clock cycle
  // I.e., pattern must be 010101... or 101010...
  property toggle_pattern;
    @(posedge clk)
    disable iff (!rst_n)
    signal != $past(signal);
  endproperty
   
  P1:assert property (toggle_pattern)    
    $info ("PASSED: Signal toggling Passed at TIME=%0d ",$realtime);    
   else    
     $error("FAILED: Signal failed to toggle at TIME=%0d ",$realtime);   

  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  // Stimulus to test the pattern
  initial begin
    signal = 0;
    @(posedge rst_n);
    
    // Valid pattern: 010101...
    repeat (5) begin
      @(posedge clk);
      signal = ~signal;
    end

    // Invalid pattern: 00
    @(posedge clk);
    signal = signal;  // Holds value, no toggle (should fail)

    // Wait and re-sync
    @(posedge clk);
    signal = ~signal;

    // Valid pattern: 101010...
    repeat (5) begin
      @(posedge clk);
      signal = ~signal;
    end

    $display("Test completed");
    $finish;
  end
endmodule
    
//Logfile output
 [2025-05-12 06:39:44 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Mon May 12 02:39:45 2025

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
CPU time: .320 seconds to compile + .294 seconds to elab + .300 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 12 02:39 2025
"testbench.sv", 29: tb_top.P1: started at 15ns failed at 15ns
	Offending '(signal != $past(signal))'
Error: "testbench.sv", 29: tb_top.P1: at time 15 ns
FAILED: Signal failed to toggle at TIME=15 
Info: "testbench.sv", 29: tb_top.P1: at time 25 ns
PASSED: Signal toggling Passed at TIME=25 
Info: "testbench.sv", 29: tb_top.P1: at time 35 ns
PASSED: Signal toggling Passed at TIME=35 
Info: "testbench.sv", 29: tb_top.P1: at time 45 ns
PASSED: Signal toggling Passed at TIME=45 
Info: "testbench.sv", 29: tb_top.P1: at time 55 ns
PASSED: Signal toggling Passed at TIME=55 
Info: "testbench.sv", 29: tb_top.P1: at time 65 ns
PASSED: Signal toggling Passed at TIME=65 
"testbench.sv", 29: tb_top.P1: started at 75ns failed at 75ns
	Offending '(signal != $past(signal))'
Error: "testbench.sv", 29: tb_top.P1: at time 75 ns
FAILED: Signal failed to toggle at TIME=75 
Info: "testbench.sv", 29: tb_top.P1: at time 85 ns
PASSED: Signal toggling Passed at TIME=85 
Info: "testbench.sv", 29: tb_top.P1: at time 95 ns
PASSED: Signal toggling Passed at TIME=95 
Info: "testbench.sv", 29: tb_top.P1: at time 105 ns
PASSED: Signal toggling Passed at TIME=105 
Info: "testbench.sv", 29: tb_top.P1: at time 115 ns
PASSED: Signal toggling Passed at TIME=115 
Test completed
$finish called from file "testbench.sv", line 66.
$finish at simulation time                  125
           V C S   S i m u l a t i o n   R e p o r t 
Time: 125 ns
CPU Time:      0.310 seconds;       Data structure size:   0.0Mb
Mon May 12 02:39:46 2025
Done   

