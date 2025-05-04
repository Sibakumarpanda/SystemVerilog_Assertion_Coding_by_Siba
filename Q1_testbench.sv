//1. Immediate assertions: if a and b are always equal
module immediate_assert;
  reg a,b; 
  reg clk;  
  always #5 clk = ~clk;  
  initial begin    
    $monitor ("\na=%0b b=%0b ", a, b);
     clk<=0;
     a<=0;
     b<=0;

     #10
     a<=0;
     b<=1;
  
     #10
     a<=1;
     b<=0;
  
     #10
     a<=1;
     b<=1;

     #15 $finish;    
  end

  property a_equals_b;
    @(posedge clk) a == b;
  endproperty

  P1: assert property (a_equals_b);
    
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end    
endmodule
// Log File Output
[2025-05-04 09:09:07 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sun May  4 05:09:08 2025

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
       immediate_assert
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module immediate_assert
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .418 seconds to compile + .396 seconds to elab + .364 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  4 05:09 2025

a=0 b=0 

a=0 b=1 
"testbench.sv", 36: immediate_assert.P1: started at 15ns failed at 15ns
	Offending '(a == b)'

a=1 b=0 
"testbench.sv", 36: immediate_assert.P1: started at 25ns failed at 25ns
	Offending '(a == b)'

a=1 b=1 
$finish called from file "testbench.sv", line 28.
$finish at simulation time                   45
           V C S   S i m u l a t i o n   R e p o r t 
Time: 45 ns
CPU Time:      0.380 seconds;       Data structure size:   0.0Mb
Sun May  4 05:09:09 2025
Done    
    


