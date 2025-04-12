module onehot0;  
  bit clk,a;  
  logic [4:0] b;  
always #5 clk = ~clk; //clock generation
initial begin
  a=0; b=5'b00000;
  #15 a=1; b=5'b00100;  //15
  #10 a=0; b=5'b01000;  //25
  #10 a=1; b=5'b01000;  //35
  #10 a=0; b=5'b01000;  //45
  #10 a=1; b=5'b10000;  //55
  #10 a=0; b=5'b10000;  //65
  #10 a=1; b=5'b11000;  //75
  #10 a=0; b=5'b01100;  //85
  #10 a=1; b=5'b01100;  //95
  #10 a=0; b=5'b01000;  //105
  #10 a=1; b=5'b11100;  //115
  #10 a=0; b=5'b01000;  //125
  #10 a=1; b=5'b00000;  //135
  #10 a=1; b=5'b00100;  //145
  #10;
  $finish;
end
 //property definition
 property sva_onehot0;  
   @(posedge clk) 
   a |-> $onehot0(b);  
 endproperty  
  
  P1:assert property (sva_onehot0)   
    $display("PASSED at TIME=%0d with a=%0b b= %0b",$time ,a,b);    
  else      
    $error("FAILED at TIME=%0d with a=%0b b= %0b",$time ,a,b);  

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end  
endmodule  
//Log file output
[2025-04-12 15:24:56 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat Apr 12 11:24:57 2025

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
       onehot0
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module onehot0
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _332_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .311 seconds to compile + .256 seconds to elab + .235 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 12 11:24 2025
PASSED at TIME=25 with a=0 b= 1000
PASSED at TIME=45 with a=0 b= 1000
PASSED at TIME=65 with a=0 b= 10000
"testbench.sv", 33: onehot0.P1: started at 85ns failed at 85ns
	Offending '$onehot0(b)'
Error: "testbench.sv", 33: onehot0.P1: at time 85 ns
FAILED at TIME=85 with a=0 b= 1100
"testbench.sv", 33: onehot0.P1: started at 105ns failed at 105ns
	Offending '$onehot0(b)'
Error: "testbench.sv", 33: onehot0.P1: at time 105 ns
FAILED at TIME=105 with a=0 b= 1000
"testbench.sv", 33: onehot0.P1: started at 125ns failed at 125ns
	Offending '$onehot0(b)'
Error: "testbench.sv", 33: onehot0.P1: at time 125 ns
FAILED at TIME=125 with a=0 b= 1000
PASSED at TIME=145 with a=1 b= 100
$finish called from file "testbench.sv", line 24.
$finish at simulation time                  155
           V C S   S i m u l a t i o n   R e p o r t 
Time: 155 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Sat Apr 12 11:24:58 2025
Finding VCD file...
./waveform.vcd
[2025-04-12 15:24:58 UTC] Opening EPWave...
Done    
