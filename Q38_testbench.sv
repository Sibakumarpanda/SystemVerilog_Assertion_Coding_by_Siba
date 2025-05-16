//Q38. As long as signal_a is up, signal_b should not be asserted. Write an assertion for this.
module tb_top;
  reg clk, reset;
  reg signal_a, signal_b;
  
  initial clk = 0;
  always #5 clk = ~clk;
  
  // Stimulus
  initial begin   
    reset = 1;
    signal_a = 0;
    signal_b = 0;
    
    $display("Disabling all assertions during simulations in reset condition ");
    $assertoff;    // Turn off all assertions, this is just to understand how assertoff works

    #10 reset = 0;
    
    $display("Enabling all assertions during simulations now ");
    $asserton;     // Turn assertions back on ,this is just to understand how asserton works
       
    // Valid condition: A low, B toggling
    #10 signal_b = 1;
    #10 signal_b = 0;

    // A goes high, B must remain low
    #10 signal_a = 1; signal_b = 0;
    #10 signal_b = 0;
    #10 signal_b = 0;

    // Invalid condition: B goes high while A is high
    #10 signal_b = 1;  // Assertion should fire here
    // Recovery
    #10 signal_a = 0; signal_b = 0;
    
    #20 $finish;  
  end

  // Assertion: signal_b must remain 0 as long as signal_a is 1
  property no_b_while_a;
    @(posedge clk)
    disable iff (reset)
    signal_a |-> !signal_b throughout (signal_a);
  endproperty
    
  P1:assert property (no_b_while_a)   
    $display("PASSED at TIME=%0d with signal_a=%0b signal_b= %0b",$time ,signal_a,signal_b);    
  else      
    $error("FAILED at TIME=%0d with signal_a=%0b signal_b= %0b",$time ,signal_a,signal_b);   

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end   
endmodule

//Log file output
[2025-05-16 05:05:41 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Fri May 16 01:05:43 2025

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
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _332_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .476 seconds to compile + .485 seconds to elab + .432 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 16 01:05 2025
Disabling all assertions during simulations in reset condition 
Stopping new assertion attempts at time 0ns: level = 0 arg = * (from inst tb_top (testbench.sv:20))
Enabling all assertions during simulations now 
Starting assertion attempts at time 10ns: level = 0 arg = * (from inst tb_top (testbench.sv:25))
PASSED at TIME=45 with signal_a=1 signal_b= 0
PASSED at TIME=55 with signal_a=1 signal_b= 0
PASSED at TIME=65 with signal_a=1 signal_b= 0
"testbench.sv", 55: tb_top.P1: started at 75ns failed at 75ns
	Offending '(!signal_b)'
Error: "testbench.sv", 55: tb_top.P1: at time 75 ns
FAILED at TIME=75 with signal_a=1 signal_b= 1
$finish called from file "testbench.sv", line 43.
$finish at simulation time                  100
           V C S   S i m u l a t i o n   R e p o r t 
Time: 100 ns
CPU Time:      0.470 seconds;       Data structure size:   0.0Mb
Fri May 16 01:05:45 2025
Done    
    
