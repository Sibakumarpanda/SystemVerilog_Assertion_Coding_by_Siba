module fell;  
  bit clk,a,b;  
  always #5 clk = ~clk; //clock generation

initial begin
      a=0; b=0;
  #15 a=1; b=0;  //15
  #10 a=0; b=1;  //25
  #10 a=1; b=0;  //35
  #10 a=0; b=0;  //45
  #10 a=1; b=1;  //55
  #10 a=0; b=0;  //65
  #10 a=1; b=1;  //75
  #10 a=1; b=0;  //85
  #10 a=1; b=0;  //95
  #10 a=0; b=0;  //105
  #10 a=1; b=0;  //115
  #10 a=0; b=0;  //125
  #10 a=1; b=0;  //135
  #10 a=1; b=0;  //145
  #10;
  $finish;
end
  property fell_assert;  
    @(posedge clk) 
    a |-> $fell(b);  
  endproperty  

  P1:assert property (fell_assert)   
    $display("PASSED at TIME=%0d with a=%0b b= %0b",$time ,a,b);    
  else      
    $error("FAILED at TIME=%0d with a=%0b b= %0b",$time ,a,b);   

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end    
endmodule  
// Log file Output
[2025-04-12 15:31:53 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat Apr 12 11:31:54 2025

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
       fell
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module fell
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .258 seconds to compile + .246 seconds to elab + .208 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 12 11:31 2025
"testbench.sv", 32: fell.P1: started at 25ns failed at 25ns
	Offending '$fell(b)'
Error: "testbench.sv", 32: fell.P1: at time 25 ns
FAILED at TIME=25 with a=0 b= 1
PASSED at TIME=45 with a=0 b= 0
"testbench.sv", 32: fell.P1: started at 65ns failed at 65ns
	Offending '$fell(b)'
Error: "testbench.sv", 32: fell.P1: at time 65 ns
FAILED at TIME=65 with a=0 b= 0
"testbench.sv", 32: fell.P1: started at 85ns failed at 85ns
	Offending '$fell(b)'
Error: "testbench.sv", 32: fell.P1: at time 85 ns
FAILED at TIME=85 with a=1 b= 0
PASSED at TIME=95 with a=1 b= 0
"testbench.sv", 32: fell.P1: started at 105ns failed at 105ns
	Offending '$fell(b)'
Error: "testbench.sv", 32: fell.P1: at time 105 ns
FAILED at TIME=105 with a=0 b= 0
"testbench.sv", 32: fell.P1: started at 125ns failed at 125ns
	Offending '$fell(b)'
Error: "testbench.sv", 32: fell.P1: at time 125 ns
FAILED at TIME=125 with a=0 b= 0
"testbench.sv", 32: fell.P1: started at 145ns failed at 145ns
	Offending '$fell(b)'
Error: "testbench.sv", 32: fell.P1: at time 145 ns
FAILED at TIME=145 with a=1 b= 0
$finish called from file "testbench.sv", line 23.
$finish at simulation time                  155
           V C S   S i m u l a t i o n   R e p o r t 
Time: 155 ns
CPU Time:      0.260 seconds;       Data structure size:   0.0Mb
Sat Apr 12 11:31:55 2025
Finding VCD file...
./waveform.vcd
[2025-04-12 15:31:55 UTC] Opening EPWave...
Done    
