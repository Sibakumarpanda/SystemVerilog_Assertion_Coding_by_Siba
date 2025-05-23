//Q71. How can you disable an assertion during active reset time?

/*In SystemVerilog, you can disable assertions during active reset time using the disable iff construct. 
This construct allows you to specify a condition under which the assertion is disabled, effectively preventing it from being evaluated when the condition is true. 
This is particularly useful for disabling assertions during reset, when signal values might not be valid or meaningful.
  
Example: Disabling Assertions During Active Reset
Suppose you have a reset signal rst_n that is active low (meaning the system is in reset when rst_n is 0). You can use disable iff to disable assertions during this reset period. */
    
module tb_top;
  logic clk;
  logic rst_n;
  logic signal;

  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
  end

  // Stimulus generation
  initial begin
    
    rst_n = 0; // Start with reset active
    signal = 0;

    repeat (10) @(posedge clk); // Wait for some cycles

    rst_n = 1; // Deactivate reset
    @(posedge clk); signal = 1;
    @(posedge clk); signal = 0;

    rst_n = 0; // Activate reset again
    @(posedge clk); signal = 1; // This should not trigger the assertion

    $finish; 
  end

  // Assertion to check signal behavior
  property signal_assertion;
    @(posedge clk)
    disable iff (!rst_n) // Disable assertion when reset is active
    signal == 1;
  endproperty

  assert property (signal_assertion)
    $display("PASSED: Signal is high at TIME=%0d", $time);
  else
    $error("FAILED: Signal is not high at TIME=%0d", $time);
 
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end
endmodule

//Logfile Output
[2025-05-23 09:31:01 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Fri May 23 05:31:02 2025

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
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _333_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .558 seconds to compile + .548 seconds to elab + .431 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 23 05:31 2025
"testbench.sv", 48: tb_top.unnamed$$_2: started at 95ns failed at 95ns
	Offending '(signal == 1)'
Error: "testbench.sv", 48: tb_top.unnamed$$_2: at time 95 ns
FAILED: Signal is not high at TIME=95
"testbench.sv", 48: tb_top.unnamed$$_2: started at 105ns failed at 105ns
	Offending '(signal == 1)'
Error: "testbench.sv", 48: tb_top.unnamed$$_2: at time 105 ns
FAILED: Signal is not high at TIME=105
$finish called from file "testbench.sv", line 38.
$finish at simulation time                  125
           V C S   S i m u l a t i o n   R e p o r t 
Time: 125 ns
CPU Time:      0.500 seconds;       Data structure size:   0.0Mb
Fri May 23 05:31:05 2025
Done
    
