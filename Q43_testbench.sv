//Q43. Write an assertion such that ,If signal_a is received while signal_b is inactive, then on the next cycle signal_c must be inactive, and signal_b must be asserted.
//Means , If signal_a is received while signal_b is inactive, then on the next cycle, signal_c must be inactive and signal_b must be asserted.

module tb_top;
  logic clk;
  logic signal_a;
  logic signal_b;
  logic signal_c;
 
  initial clk = 0;
  always #5 clk = ~clk;  // 10 time unit clock period
  
  // Stimulus generation
  initial begin
    // Initialize
    signal_a = 0;
    signal_b = 0;
    signal_c = 0;

    // Apply all 4 combinations of signal_a and signal_b
    // Combination 1: a=0, b=0
    @(posedge clk);
    signal_a = 0; signal_b = 0; signal_c = 0;

    // Combination 2: a=0, b=1
    @(posedge clk);
    signal_a = 0; signal_b = 1; signal_c = 0;

    // Combination 3: a=1, b=0 -> Should trigger the assertion
    @(posedge clk);
    signal_a = 1; signal_b = 0; signal_c = 1; // violating signal_c
    @(posedge clk); // Next cycle: simulate violation
    signal_c = 1; signal_b = 0; // Will cause assertion to fail

    // Combination 4: a=1, b=1
    @(posedge clk);
    signal_a = 1; signal_b = 1; signal_c = 0;

    // Fixing the previous violation for a valid test
    @(posedge clk);
    signal_a = 1; signal_b = 0; signal_c = 0;
    @(posedge clk); // Next cycle
    signal_c = 0; signal_b = 1; // Should pass

    // Finish simulation
    @(posedge clk);
    $display("Testbench completed.");
    $finish;
  end
    
  property p_check_signals;
    @(posedge clk)
      (signal_a && !signal_b) |=> (!signal_c && signal_b);
  endproperty
    
  P1:assert property (p_check_signals)   
    $display("PASSED at TIME=%0d signal_c is inactive or signal_b is not asserted on next cycle after signal_a received while signal_b is inactive",$time);    
  else      
    $error("FAILED at TIME=%0d signal_c is not inactive or signal_b is not asserted on next cycle after signal_a received while signal_b is inactive",$time);   

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end   
endmodule

//Logfile output
[2025-05-17 05:42:02 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat May 17 01:42:03 2025

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
CPU time: .262 seconds to compile + .229 seconds to elab + .211 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 17 01:42 2025
"testbench.sv", 61: tb_top.P1: started at 35ns failed at 45ns
	Offending '((!signal_c) && signal_b)'
Error: "testbench.sv", 61: tb_top.P1: at time 45 ns
FAILED at TIME=45 signal_c is not inactive or signal_b is not asserted on next cycle after signal_a received while signal_b is inactive
PASSED at TIME=55 signal_c is inactive or signal_b is not asserted on next cycle after signal_a received while signal_b is inactive
Testbench completed.
$finish called from file "testbench.sv", line 51.
$finish at simulation time                   75
           V C S   S i m u l a t i o n   R e p o r t 
Time: 75 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Sat May 17 01:42:04 2025
Done
    
