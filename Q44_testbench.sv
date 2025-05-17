//Q44. signal_a must not be asserted together with signal_b or with signal_c
//Means :This assertion checks that whenever signal_a is high, both signal_b and signal_c must be low.

module tb_top;
  logic clk;
  logic signal_a;
  logic signal_b;
  logic signal_c;

  initial clk = 0;
  always #5 clk = ~clk;  // 10 time unit clock
 
  // Stimulus generation
  initial begin
    signal_a = 0;
    signal_b = 0;
    signal_c = 0;

    // Wait a cycle
    @(posedge clk);

    // Test all 8 combinations of a, b, c
    for (int i = 0; i < 8; i++) begin
      {signal_a, signal_b, signal_c} = i;
      @(posedge clk);
    end

    $display("Test completed.");
    $finish;
  end
  
   // Assertion: signal_a must not be high together with signal_b or signal_c
  property p_a_exclusive;
    @(posedge clk)
      !(signal_a && (signal_b || signal_c));
  endproperty

  assert property (p_a_exclusive)
    else $error("Assertion failed: signal_a must not be high with signal_b or signal_c.");
        
  P1:assert property (p_a_exclusive)   
    $display("PASSED at TIME=%0d signal_a must not be high with signal_b or signal_c",$time);    
  else      
    $error("FAILED at TIME=%0d signal_a must not be high with signal_b or signal_c",$time);   

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end   
endmodule

//LogFile Output
[2025-05-17 05:44:19 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat May 17 01:44:19 2025

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
CPU time: .242 seconds to compile + .221 seconds to elab + .199 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 17 01:44 2025
PASSED at TIME=5 signal_a must not be high with signal_b or signal_c
PASSED at TIME=15 signal_a must not be high with signal_b or signal_c
PASSED at TIME=25 signal_a must not be high with signal_b or signal_c
PASSED at TIME=35 signal_a must not be high with signal_b or signal_c
PASSED at TIME=45 signal_a must not be high with signal_b or signal_c
PASSED at TIME=55 signal_a must not be high with signal_b or signal_c
"testbench.sv", 41: tb_top.unnamed$$_3: started at 65ns failed at 65ns
	Offending '(!(signal_a && (signal_b || signal_c)))'
Error: "testbench.sv", 41: tb_top.unnamed$$_3: at time 65 ns
Assertion failed: signal_a must not be high with signal_b or signal_c.
"testbench.sv", 45: tb_top.P1: started at 65ns failed at 65ns
	Offending '(!(signal_a && (signal_b || signal_c)))'
Error: "testbench.sv", 45: tb_top.P1: at time 65 ns
FAILED at TIME=65 signal_a must not be high with signal_b or signal_c
"testbench.sv", 41: tb_top.unnamed$$_3: started at 75ns failed at 75ns
	Offending '(!(signal_a && (signal_b || signal_c)))'
Error: "testbench.sv", 41: tb_top.unnamed$$_3: at time 75 ns
Assertion failed: signal_a must not be high with signal_b or signal_c.
"testbench.sv", 45: tb_top.P1: started at 75ns failed at 75ns
	Offending '(!(signal_a && (signal_b || signal_c)))'
Error: "testbench.sv", 45: tb_top.P1: at time 75 ns
FAILED at TIME=75 signal_a must not be high with signal_b or signal_c
Test completed.
$finish called from file "testbench.sv", line 32.
$finish at simulation time                   85
           V C S   S i m u l a t i o n   R e p o r t 
Time: 85 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Sat May 17 01:44:20 2025
Done    
