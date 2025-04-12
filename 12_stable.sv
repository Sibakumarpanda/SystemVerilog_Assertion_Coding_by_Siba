module stable;  
  bit clk,a,b;  
  always #5 clk = ~clk; 

initial begin
      a=0; b=0;
  #15 a=1; b=0;  //15
  #10 a=0; b=0;  //25
  #10 a=1; b=1;  //35
  #10 a=0; b=0;  //45
  #10 a=1; b=1;  //55
  #10 a=0; b=0;  //65
  #10 a=1; b=1;  //75
  #10 a=1; b=1;  //85
  #10 a=1; b=0;  //95
  #10 a=0; b=0;  //105
  #10 a=1; b=0;  //115
  #10 a=0; b=1;  //125
  #10 a=1; b=0;  //135
  #10 a=1; b=0;  //145
  #10;
  $finish;
end
  property stable_assert;  
    @(posedge clk) 
    a |-> $stable(b);  
  endproperty  

  P1:assert property (stable_assert)   
    $display("PASSED at TIME=%0d with a=%0b b= %0b",$time ,a,b);    
  else      
    $error("FAILED at TIME=%0d with a=%0b b= %0b",$time ,a,b);   
initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
end  
endmodule 
//NOTE
/*$stable Function
Purpose: $stable is used to check if a signal has remained unchanged over a specified number of clock cycles. 
It is useful for verifying that a signal is stable or constant over time.
Syntax: $stable(expression, [number_of_ticks])
expression: The signal or expression you want to check for stability.
number_of_ticks: Optional argument specifying the number of clock cycles over which the signal should remain unchanged.
If omitted, it defaults to 1, meaning the signal should be stable over the current and previous cycle. */  
    
//Log file Result
[2025-04-12 16:11:29 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat Apr 12 12:11:30 2025

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
       stable
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module stable
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .262 seconds to compile + .256 seconds to elab + .225 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 12 12:11 2025
PASSED at TIME=25 with a=0 b= 0
"testbench.sv", 31: stable.P1: started at 45ns failed at 45ns
	Offending '$stable(b)'
Error: "testbench.sv", 31: stable.P1: at time 45 ns
FAILED at TIME=45 with a=0 b= 0
"testbench.sv", 31: stable.P1: started at 65ns failed at 65ns
	Offending '$stable(b)'
Error: "testbench.sv", 31: stable.P1: at time 65 ns
FAILED at TIME=65 with a=0 b= 0
"testbench.sv", 31: stable.P1: started at 85ns failed at 85ns
	Offending '$stable(b)'
Error: "testbench.sv", 31: stable.P1: at time 85 ns
FAILED at TIME=85 with a=1 b= 1
PASSED at TIME=95 with a=1 b= 0
"testbench.sv", 31: stable.P1: started at 105ns failed at 105ns
	Offending '$stable(b)'
Error: "testbench.sv", 31: stable.P1: at time 105 ns
FAILED at TIME=105 with a=0 b= 0
PASSED at TIME=125 with a=0 b= 1
"testbench.sv", 31: stable.P1: started at 145ns failed at 145ns
	Offending '$stable(b)'
Error: "testbench.sv", 31: stable.P1: at time 145 ns
FAILED at TIME=145 with a=1 b= 0
$finish called from file "testbench.sv", line 23.
$finish at simulation time                  155
           V C S   S i m u l a t i o n   R e p o r t 
Time: 155 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Sat Apr 12 12:11:31 2025
Finding VCD file...
./waveform.vcd
[2025-04-12 16:11:31 UTC] Opening EPWave...
Done    
    
