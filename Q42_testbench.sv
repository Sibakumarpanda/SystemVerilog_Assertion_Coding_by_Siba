//Q42. After signal_a is asserted, signal_b must be deasserted, and must stay down until the next signal_a.

module tb_top;  
  reg clk, reset;
  reg signal_a, signal_b;
 
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus generation
  initial begin
    reset = 1;
    signal_a = 0;
    signal_b = 0;
    #10 reset = 0;

    // Valid case
    #10 signal_a = 1; signal_b = 0;   // a pulse, b low
    #10 signal_a = 0;
    #30 signal_b = 0;                // b remains low
    #10 signal_a = 1;                // next a pulse, resets the rule
    #10 signal_a = 0;

    // Invalid case: b goes high before next a
    #10 signal_a = 1; signal_b = 0;
    #10 signal_a = 0;
    #10 signal_b = 1;                // violation: b should stay low
    #10 signal_a = 1;                // resets rule again
    #10 signal_a = 0;
    #20 $finish;
  end

  // Assertion: After signal_a is high, signal_b must be 0 until next signal_a
  property b_low_after_a_until_next_a;
    @(posedge clk)
    disable iff (reset)
    signal_a |=> (!signal_b throughout ( !signal_a [*1:$] ##1 signal_a ));
    //signal_a |=>  (!signal_b ##1 (!signal_a && !signal_b)[*0:$] ##1 signal_a);
  endproperty
    
  P1:assert property (b_low_after_a_until_next_a)   
    $display("PASSED at TIME=%0d signal_b was deasserted between signal_a pulses",$time );    
  else      
    $error("FAILED at TIME=%0d signal_b was not deasserted between signal_a pulses",$time );   

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end         
endmodule

//LogFile Output
[2025-05-17 05:39:35 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat May 17 01:39:36 2025

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
CPU time: .245 seconds to compile + .227 seconds to elab + .197 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 17 01:39 2025
PASSED at TIME=75 signal_b was deasserted between signal_a pulses
PASSED at TIME=95 signal_b was deasserted between signal_a pulses
"testbench.sv", 46: tb_top.P1: started at 95ns failed at 115ns
	Offending '(!signal_b)'
Error: "testbench.sv", 46: tb_top.P1: at time 115 ns
FAILED at TIME=115 signal_b was not deasserted between signal_a pulses
"testbench.sv", 46: tb_top.P1: started at 125ns failed at 135ns
	Offending '(!signal_b)'
Error: "testbench.sv", 46: tb_top.P1: at time 135 ns
FAILED at TIME=135 signal_b was not deasserted between signal_a pulses
$finish called from file "testbench.sv", line 34.
$finish at simulation time                  150
           V C S   S i m u l a t i o n   R e p o r t 
Time: 150 ns
CPU Time:      0.260 seconds;       Data structure size:   0.0Mb
Sat May 17 01:39:37 2025
Done
    
