//5. Write an assertion check to make sure that a signal is high for a minimum of 2 cycles and a maximum of 6 cycles.
// NOTE
/* Difference between thw below to assertion - A good Fundamental to Learn
(a == 1) ##1 (a == 1):
This checks if a is high on the current cycle and remains high on the next cycle. The ##1 operator introduces a delay of one cycle.

(a == 1) |=> (a == 1): 
The |=> operator is a sequence implication operator. It checks if a is high on the current cycle, and if so, it implies that a should be high on the next cycle. 
This is a stronger condition than ##1, as it requires the implication to hold whenever the antecedent (a == 1) is true.
*/

module signal_a_high_with_duration_example;
  logic clk;
  logic a;
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10 time units clock period
  end

  // Test sequence
  initial begin
    // Test 'a' high for 1 cycle (should fail)
    a = 1;
    #10;
    a = 0;
    #10;

    // Test 'a' high for 2 cycles (should pass)
    a = 1;
    #20;
    a = 0;
    #10;

    // Test 'a' high for 6 cycles (should pass)
    a = 1;
    #60;
    a = 0;
    #10;

    // Test 'a' high for 7 cycles (should fail)
    a = 1;
    #70;
    a = 0;
    #10;

    $finish;
  end
  
 // Sequence to track the duration of 'a' being high
  sequence a_high_duration;
    (a == 1) ##1 (a == 1) [*0:4] ##1 (a == 0);
  endsequence

  // Property to check if 'a' is high for 2 to 6 cycles
  property a_high_for_min_max_cycles;
    @(posedge clk) 
    a_high_duration;
  endproperty
  
 P1:assert property (a_high_for_min_max_cycles)   
   $display("PASSED at TIME=%0d with a=%0b ",$time ,a);    
  else      
    $error("FAILED at TIME=%0d with a=%0b ",$time ,a);

  initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end  
endmodule
//Logfile output
[2025-05-04 09:26:16 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sun May  4 05:26:17 2025

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
       signal_a_high_with_duration_example
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module signal_a_high_with_duration_example
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .384 seconds to compile + .398 seconds to elab + .324 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  4 05:26 2025
"testbench.sv", 54: signal_a_high_with_duration_example.P1: started at 15ns failed at 15ns
	Offending '(a == 1)'
Error: "testbench.sv", 54: signal_a_high_with_duration_example.P1: at time 15 ns
FAILED at TIME=15 with a=0 
PASSED at TIME=15 with a=0 
"testbench.sv", 54: signal_a_high_with_duration_example.P1: started at 45ns failed at 45ns
	Offending '(a == 1)'
Error: "testbench.sv", 54: signal_a_high_with_duration_example.P1: at time 45 ns
FAILED at TIME=45 with a=0 
PASSED at TIME=45 with a=0 
PASSED at TIME=45 with a=0 
"testbench.sv", 54: signal_a_high_with_duration_example.P1: started at 55ns failed at 105ns
	Offending '(a == 0)'
Error: "testbench.sv", 54: signal_a_high_with_duration_example.P1: at time 105 ns
FAILED at TIME=105 with a=1 
"testbench.sv", 54: signal_a_high_with_duration_example.P1: started at 115ns failed at 115ns
	Offending '(a == 1)'
Error: "testbench.sv", 54: signal_a_high_with_duration_example.P1: at time 115 ns
FAILED at TIME=115 with a=0 
PASSED at TIME=115 with a=0 
PASSED at TIME=115 with a=0 
PASSED at TIME=115 with a=0 
PASSED at TIME=115 with a=0 
PASSED at TIME=115 with a=0 
"testbench.sv", 54: signal_a_high_with_duration_example.P1: started at 125ns failed at 175ns
	Offending '(a == 0)'
Error: "testbench.sv", 54: signal_a_high_with_duration_example.P1: at time 175 ns
FAILED at TIME=175 with a=1 
"testbench.sv", 54: signal_a_high_with_duration_example.P1: started at 135ns failed at 185ns
	Offending '(a == 0)'
Error: "testbench.sv", 54: signal_a_high_with_duration_example.P1: at time 185 ns
FAILED at TIME=185 with a=1 
"testbench.sv", 54: signal_a_high_with_duration_example.P1: started at 195ns failed at 195ns
	Offending '(a == 1)'
Error: "testbench.sv", 54: signal_a_high_with_duration_example.P1: at time 195 ns
FAILED at TIME=195 with a=0 
PASSED at TIME=195 with a=0 
PASSED at TIME=195 with a=0 
PASSED at TIME=195 with a=0 
PASSED at TIME=195 with a=0 
PASSED at TIME=195 with a=0 
$finish called from file "testbench.sv", line 39.
$finish at simulation time                  200
           V C S   S i m u l a t i o n   R e p o r t 
Time: 200 ns
CPU Time:      0.350 seconds;       Data structure size:   0.0Mb
Sun May  4 05:26:19 2025
Finding VCD file...
./waveform.vcd
[2025-05-04 09:26:19 UTC] Opening EPWave...
Done
   
   
