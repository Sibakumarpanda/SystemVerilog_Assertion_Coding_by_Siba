/* CLOCK GATING:

1. Clock gating is a technique used to reduce power consumption by disabling the clock to certain parts of the circuit
   when they are not in use. 
   
2. To write a SystemVerilog assertion (SVA) that checks for clock gating, we can create a property that ensures that the clock is only gated (i.e., stopped) 
   when the enable signal is low, and it is not accidentally held or pulsed in a way that could create timing issues.
   
3. We need to assert that when the enable signal (clk_en) is low, the gated clock signal (clk_out) should be low.

4. When the enable signal (clk_en) is high, the clock signal (clk_out) should follow the source clock (clk), 
   either being high or low depending on the source clock's state.

5. The module tests the following combinations:

   When clk_en = 0: clk_out should be held low (gated off).

   When clk_en = 1: clk_out should follow clk.

6. Invalid Cases:

   If clk_en = 0 and clk_out is not 0 (violating the gate-off condition).

   If clk_en = 1 and clk_out does not follow clk (violating the gating behavior).

7. Possible Test Inputs: You can try various combinations of clk_en and observe the behavior.

   Scenario 1: clk_en = 0, clk_out = 0 (Correct behavior).

   Scenario 2: clk_en = 0, clk_out = 1 (Error, invalid clock gating).

   Scenario 3: clk_en = 1, clk_out = ~clk (Correct behavior, clk_out follows clk).

   Scenario 4: clk_en = 1, clk_out = ~clk (Correct behavior).

8. This approach helps to verify whether your clock gating logic is functioning correctly 
   and that no glitches or unexpected behaviors occur when the clock is gated.

*/
//Q18. Write an assertion to check clock gating.

module tb_top;

  // Declare signals
  logic clk, rst_n;
  logic clk_en, clk_out;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10 ns clock period
  end

  // Stimulus to simulate different scenarios for testing
  initial begin
    rst_n = 0;
    clk_en = 0;
    clk_out = 0;
    
    #10 rst_n = 1; // Release reset

    // Case 1: clk_en = 0, clk_out should be held low
    #10 clk_en = 0; clk_out = 1;  // Error: clk_out should be 0 when clk_en is 0
    #10 clk_out = 0;             // Correct: clk_out is 0 when clk_en is 0

    // Case 2: clk_en = 1, clk_out should follow clk
    #10 clk_en = 1; clk_out = ~clk; // Correct: clk_out follows clk
    #10 clk_en = 1; clk_out = ~clk; // Correct: clk_out follows clk

    #10 $finish;
  end

  // Assertion to check clock gating behavior
  // When clk_en is low, clk_out must be 0 (gated clock)
  // When clk_en is high, clk_out should follow clk
  property clk_gating_check;
    @(posedge clk or negedge rst_n)
      disable iff (!rst_n)
        (clk_en == 0 && clk_out !== 0) || 
        (clk_en == 1 && clk_out !== clk);
  endproperty

  // Assert property: the clock gating behavior should hold
    
  assert property (clk_gating_check) 
    begin      
      $display("PASSED: Clock gating violation Not detected at at time %0t", $time);
    end
  else
    begin      
      $error("FAILED: Clock gating violation detected at time %0t", $time);
    end

  initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end  

endmodule
//Logfile output
[2025-05-09 02:53:49 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu May  8 22:53:50 2025

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
CPU time: .362 seconds to compile + .326 seconds to elab + .372 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  8 22:53 2025
"testbench.sv", 46: tb_top.unnamed$$_4: started at 15ns failed at 15ns
	Offending '(((clk_en == 0) && (clk_out !== 0)) || ((clk_en == 1) && (clk_out !== clk)))'
Error: "testbench.sv", 46: tb_top.unnamed$$_4: at time 15 ns
FAILED: Clock gating violation detected at time 15
PASSED: Clock gating violation Not detected at at time 25
"testbench.sv", 46: tb_top.unnamed$$_4: started at 35ns failed at 35ns
	Offending '(((clk_en == 0) && (clk_out !== 0)) || ((clk_en == 1) && (clk_out !== clk)))'
Error: "testbench.sv", 46: tb_top.unnamed$$_4: at time 35 ns
FAILED: Clock gating violation detected at time 35
"testbench.sv", 46: tb_top.unnamed$$_4: started at 45ns failed at 45ns
	Offending '(((clk_en == 0) && (clk_out !== 0)) || ((clk_en == 1) && (clk_out !== clk)))'
Error: "testbench.sv", 46: tb_top.unnamed$$_4: at time 45 ns
FAILED: Clock gating violation detected at time 45
"testbench.sv", 46: tb_top.unnamed$$_4: started at 55ns failed at 55ns
	Offending '(((clk_en == 0) && (clk_out !== 0)) || ((clk_en == 1) && (clk_out !== clk)))'
Error: "testbench.sv", 46: tb_top.unnamed$$_4: at time 55 ns
FAILED: Clock gating violation detected at time 55
$finish called from file "testbench.sv", line 31.
$finish at simulation time                   60
           V C S   S i m u l a t i o n   R e p o r t 
Time: 60 ns
CPU Time:      0.330 seconds;       Data structure size:   0.0Mb
Thu May  8 22:53:51 2025
Done
    
