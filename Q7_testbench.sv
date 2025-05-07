//Q7. Write an assertion check to make sure that when (a==1) matches on any clock cycle, then in next cycle if “b” is true and a cycle later if “c” is true, then following property will pass.

module signal_a_high_with_duration_example;
  logic clk;
  logic a,b,c;
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10 time units clock period
  end
  // Test stimulus
  initial begin
    // Initialize
    a = 0; b = 0; c = 0;

    // Apply stimulus to test various scenarios
    #10 a = 1; // time 10ns
    #10 b = 1; // time 20ns (next cycle)
    #10 c = 1; // time 30ns (cycle after that)

    #10 a = 0; b = 0; c = 0; // reset

    #10 a = 1; // a=1 again
    #10 b = 0; // b fails here -> assertion should fail
    #10 c = 1;
        
    #10 a = 1; // a=1 again
    #10 b = 1; 
    #10 c = 0; //Assertion should fail here

    #20 $finish;
  end
    
  //when (a==1) matches on any clock cycle, then in next cycle if “b” is true and a cycle later if “c” is true, 
  //then following property will pass.
  // Assertion: a==1 -> next cycle b==1 -> next cycle c==1
  property a_b_then_c;
    @(posedge clk)
    a |-> ##1 b ##1 c;
  endproperty
  
 P1:assert property (a_b_then_c)   
   $display("PASSED at TIME=%0d with a=%0b b=%0b c=%0b ",$time ,a,b,c);    
  else      
    $error("FAILED at TIME=%0d with a=%0b b=%0b c=%0b ",$time ,a,b,c);

  initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end
  
endmodule
//Log File output
[2025-05-07 04:40:42 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May  7 00:40:42 2025

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
CPU time: .244 seconds to compile + .219 seconds to elab + .196 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  7 00:40 2025
PASSED at TIME=35 with a=1 b=1 c=1 
"testbench.sv", 46: signal_a_high_with_duration_example.P1: started at 35ns failed at 45ns
	Offending 'b'
Error: "testbench.sv", 46: signal_a_high_with_duration_example.P1: at time 45 ns
FAILED at TIME=45 with a=0 b=0 c=0 
"testbench.sv", 46: signal_a_high_with_duration_example.P1: started at 25ns failed at 45ns
	Offending 'c'
Error: "testbench.sv", 46: signal_a_high_with_duration_example.P1: at time 45 ns
FAILED at TIME=45 with a=0 b=0 c=0 
"testbench.sv", 46: signal_a_high_with_duration_example.P1: started at 55ns failed at 65ns
	Offending 'b'
Error: "testbench.sv", 46: signal_a_high_with_duration_example.P1: at time 65 ns
FAILED at TIME=65 with a=1 b=0 c=0 
"testbench.sv", 46: signal_a_high_with_duration_example.P1: started at 65ns failed at 75ns
	Offending 'b'
Error: "testbench.sv", 46: signal_a_high_with_duration_example.P1: at time 75 ns
FAILED at TIME=75 with a=1 b=0 c=1 
"testbench.sv", 46: signal_a_high_with_duration_example.P1: started at 75ns failed at 85ns
	Offending 'b'
Error: "testbench.sv", 46: signal_a_high_with_duration_example.P1: at time 85 ns
FAILED at TIME=85 with a=1 b=0 c=1 
"testbench.sv", 46: signal_a_high_with_duration_example.P1: started at 85ns failed at 105ns
	Offending 'c'
Error: "testbench.sv", 46: signal_a_high_with_duration_example.P1: at time 105 ns
FAILED at TIME=105 with a=1 b=1 c=0 
"testbench.sv", 46: signal_a_high_with_duration_example.P1: started at 95ns failed at 115ns
	Offending 'c'
Error: "testbench.sv", 46: signal_a_high_with_duration_example.P1: at time 115 ns
FAILED at TIME=115 with a=1 b=1 c=0 
$finish called from file "testbench.sv", line 34.
$finish at simulation time                  120
           V C S   S i m u l a t i o n   R e p o r t 
Time: 120 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Wed May  7 00:40:43 2025
Done
   
   
