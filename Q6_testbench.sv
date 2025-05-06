//Q6. Write an assertion check to make sure that when (a==1), in the same cycle if “b” is true and the following cycle “c” is true then this property passes

module signal_a_high_with_duration_example;
  logic clk;
  logic a,b,c;
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10 time units clock period
  end
  // Test sequence
  initial begin    
    a = 1;
    b = 1;
    #10;
    c = 1;
    #10;
   
    a = 0;
    b = 1;
    #10;
    c = 1;
    #10;

    
    a = 1;
    b = 0;
    #10;
    c = 1;
    #10;
   
    a = 1;
    b = 1;
    #10;
    c = 0;
    #10;

    $finish;
  end
   
  //When a == 1, if b is true in the same cycle, and c is true in the next cycle, then the property passes.
  //This is best expressed using SystemVerilog Assertions (SVA) with temporal operators like ##1 (next cycle 
  property a_b_then_c;
    @(posedge clk) 
    (a == 1 && b) |-> ##1 c;
  endproperty
  
 P1:assert property (a_b_then_c)   
   $display("PASSED at TIME=%0d with a=%0b ",$time ,a);    
  else      
    $error("FAILED at TIME=%0d with a=%0b ",$time ,a);

  initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end  
endmodule

//Logfile output
[2025-05-06 04:41:21 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Tue May  6 00:41:22 2025

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
CPU time: .248 seconds to compile + .224 seconds to elab + .211 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  6 00:41 2025
PASSED at TIME=15 with a=1 
PASSED at TIME=25 with a=0 
"testbench.sv", 56: signal_a_high_with_duration_example.P1: started at 65ns failed at 75ns
	Offending 'c'
Error: "testbench.sv", 56: signal_a_high_with_duration_example.P1: at time 75 ns
FAILED at TIME=75 with a=1 
$finish called from file "testbench.sv", line 43.
$finish at simulation time                   80
           V C S   S i m u l a t i o n   R e p o r t 
Time: 80 ns
CPU Time:      0.240 seconds;       Data structure size:   0.0Mb
Tue May  6 00:41:23 2025
Done
   
