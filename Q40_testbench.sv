//Q40. Signal_a and signal_b can only be asserted together for one cycle; in the next cycle, at least one of them must be deasserted.
module tb_top;
  reg clk, reset;
  reg signal_a, signal_b;
  
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus for signal_a and signal_b
  initial begin
    reset = 1;
    signal_a = 0;
    signal_b = 0;
    #10 reset = 0;

    // Valid cases where signal_a and signal_b are asserted together for one cycle
    #10 signal_a = 1; signal_b = 1;  // Both asserted together
    #10 signal_a = 0; signal_b = 0;  // Both deasserted

    #20 signal_a = 1; signal_b = 1;  // Both asserted together
    #10 signal_a = 0; signal_b = 1;  // signal_a deasserted, signal_b asserted

    // Invalid case where both signal_a and signal_b are asserted for two consecutive cycles
    #10 signal_a = 1; signal_b = 1;  // Both asserted together
    #10 signal_a = 1; signal_b = 1;  // Both still asserted (violation)
    
    #30 $finish;
  end

  // Property: Ensure that signal_a and signal_b are asserted together for only one cycle , in the next cycle, at least one of them must be deasserted.
  property signal_a_and_b_asserted_together_for_one_cycle;
    @(posedge clk)
    disable iff (reset)
    //(signal_a == 1 && signal_b == 1) |=> (signal_a == 0 || signal_b == 0);  // At least one must be deasserted in the next cycle
    (signal_a == 1 && signal_b == 1) |-> (! $past(signal_a) || ! $past(signal_b)); 
  endproperty
   
  P1:assert property (signal_a_and_b_asserted_together_for_one_cycle)   
    $display("PASSED at TIME=%0d with signal_a=%0b ,signal_b=%0b,next_signal_a=%0b ,next_signal_b=%0b",$time ,signal_a,signal_b,$past(signal_a),$past(signal_b));    
  else      
    $error("FAILED at TIME=%0d with signal_a=%0b ,signal_b=%0b ,next_signal_a=%0b ,next_signal_b=%0b",$time ,signal_a,signal_b,$past(signal_a),$past(signal_b));   

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end   
endmodule

//Logfile output
[2025-05-16 05:48:22 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Fri May 16 01:48:24 2025

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
CPU time: .479 seconds to compile + .546 seconds to elab + .383 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 16 01:48 2025
PASSED at TIME=25 with signal_a=1 ,signal_b=1,next_signal_a=0 ,next_signal_b=0
PASSED at TIME=55 with signal_a=1 ,signal_b=1,next_signal_a=0 ,next_signal_b=0
PASSED at TIME=75 with signal_a=1 ,signal_b=1,next_signal_a=0 ,next_signal_b=1
"testbench.sv", 42: tb_top.P1: started at 85ns failed at 85ns
	Offending '((!$past(signal_a)) || (!$past(signal_b)))'
Error: "testbench.sv", 42: tb_top.P1: at time 85 ns
FAILED at TIME=85 with signal_a=1 ,signal_b=1 ,next_signal_a=1 ,next_signal_b=1
"testbench.sv", 42: tb_top.P1: started at 95ns failed at 95ns
	Offending '((!$past(signal_a)) || (!$past(signal_b)))'
Error: "testbench.sv", 42: tb_top.P1: at time 95 ns
FAILED at TIME=95 with signal_a=1 ,signal_b=1 ,next_signal_a=1 ,next_signal_b=1
"testbench.sv", 42: tb_top.P1: started at 105ns failed at 105ns
	Offending '((!$past(signal_a)) || (!$past(signal_b)))'
Error: "testbench.sv", 42: tb_top.P1: at time 105 ns
FAILED at TIME=105 with signal_a=1 ,signal_b=1 ,next_signal_a=1 ,next_signal_b=1
$finish called from file "testbench.sv", line 30.
$finish at simulation time                  110
           V C S   S i m u l a t i o n   R e p o r t 
Time: 110 ns
CPU Time:      0.430 seconds;       Data structure size:   0.0Mb
Fri May 16 01:48:25 2025
Done
    
