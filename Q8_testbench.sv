//Q8. when “a” is true, then next cycle “b” is evaluated and then if found true, next cycle “c” is evaluated, and if found true, the property passes.
module test_assertion;
  logic clk;
  logic a, b, c;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Stimulus to test different cases
  initial begin
    // Case 1: all pass
    #3  a = 0; b = 0; c = 0;
    #7  a = 1; // t=10ns
    #10 b = 1; // t=20ns (b is true after a)
    #10 c = 1; // t=30ns (c is true after b)

    // Case 2: b fails -> c not checked
    #10 a = 1; // t=40ns
    #10 b = 0; // t=50ns (b false, c ignored)
    #10 c = 0; // t=60ns

    // Case 3: b true, c fails -> assertion fails
    #10 a = 1; // t=70ns
    #10 b = 1; // t=80ns
    #10 c = 0; // t=90ns -> this causes assertion failure

    #10 $finish;
  end
    
 // Define a sequence: if b is true, then next cycle c must be true
  sequence b_then_c;
    b ##1 c;
  endsequence

  // Define a property: if a is true, then in the next cycle b_then_c must hold
  property a_then_b_then_c;
    @(posedge clk)
    a |-> ##1 b_then_c;
  endproperty

  P1: assert property (a_then_b_then_c)
      $display("PASSED at TIME=%0t with a=%0b b=%0b c=%0b ", $time, a, b, c);
    else
      $error("FAILED at TIME=%0t with a=%0b b=%0b c=%0b ", $time, a, b, c);

  initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end    
  endmodule
    
//Log file output
[2025-05-07 04:51:38 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May  7 00:51:39 2025

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
       test_assertion
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module test_assertion
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .245 seconds to compile + .221 seconds to elab + .197 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  7 00:51 2025
PASSED at TIME=35 with a=1 b=1 c=1 
PASSED at TIME=45 with a=1 b=1 c=1 
"testbench.sv", 47: test_assertion.P1: started at 45ns failed at 55ns
	Offending 'b'
Error: "testbench.sv", 47: test_assertion.P1: at time 55 ns
FAILED at TIME=55 with a=1 b=0 c=1 
PASSED at TIME=55 with a=1 b=0 c=1 
"testbench.sv", 47: test_assertion.P1: started at 55ns failed at 65ns
	Offending 'b'
Error: "testbench.sv", 47: test_assertion.P1: at time 65 ns
FAILED at TIME=65 with a=1 b=0 c=0 
"testbench.sv", 47: test_assertion.P1: started at 65ns failed at 75ns
	Offending 'b'
Error: "testbench.sv", 47: test_assertion.P1: at time 75 ns
FAILED at TIME=75 with a=1 b=0 c=0 
"testbench.sv", 47: test_assertion.P1: started at 75ns failed at 95ns
	Offending 'c'
Error: "testbench.sv", 47: test_assertion.P1: at time 95 ns
FAILED at TIME=95 with a=1 b=1 c=0 
$finish called from file "testbench.sv", line 32.
$finish at simulation time                  100
           V C S   S i m u l a t i o n   R e p o r t 
Time: 100 ns
CPU Time:      0.240 seconds;       Data structure size:   0.0Mb
Wed May  7 00:51:40 2025
Done    
