module consecutive_repetition; //Syntax: b[*3]
  bit clk;
  bit a,b;

  always #5 clk = ~clk; 

initial begin
  a=0; b=0;
  #15 a=1; b=0;  //15
  #10 a=0; b=1;  //25
  #10 a=0; b=1;  //35
  #10 a=0; b=1;  //45
  #10 a=1; b=1;  //55
  #10 a=0; b=1;  //65
  #10 a=0; b=1;  //75
  #10 a=0; b=0;  //85
  #10 a=1; b=0;  //95
  #10 a=0; b=0;  //105
  #10 a=1; b=1;  //115
  #10 a=0; b=1;  //125
  #10 a=0; b=1;  //135
  #10 a=0; b=0;  //145
  #10 a=0; b=0;  //155
  #10;
  $finish;
end

 property consecutive_repetition_assert;
   @(posedge clk) 
   a |-> ##1 b[*3];
 endproperty
 
  //P1:assert property (consecutive_repetition_assert)   ;

  P1:assert property (consecutive_repetition_assert)   
    $display("PASSED at TIME=%0d with a=%0b b= %0b",$time ,a,b);    //Automatically it will through error ,even if we will not add error statement
  //else      
  //  $error("FAILED at TIME=%0d with a=%0b b= %0b",$time ,a,b); */
  
  initial begin
      $dumpfile("waveform.vcd");
      $dumpvars();
  end  
endmodule
//NOTE
/*Repetition Operators
Key Difference:
a[*3] = a ##1 a ##1 a (strictly consecutive) //consecutive_repetition
Specifies that the expression a must be true for exactly 3 consecutive clock cycles.
a[=3] = //Nonconsecutive_repetition
Specifies that the expression a must be true exactly 3 times, but not necessarily
consecutively.
a[->3] = ... a ... a ... a ... (anywhere, but exactly 3 times) //Go to _repetition -Need to check the functionality
Consecutive Repetition with Implication
Purpose: Specifies that the expression a must be true for 3 consecutive clock cycles, and each occurrence implies the next.
*/
	  
//Log file Results
[2025-04-12 16:32:40 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat Apr 12 12:32:41 2025

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
       consecutive_repetition
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module consecutive_repetition
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _332_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .262 seconds to compile + .230 seconds to elab + .238 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 12 12:32 2025
PASSED at TIME=55 with a=1 b= 1
"testbench.sv", 35: consecutive_repetition.P1: started at 65ns failed at 95ns
	Offending 'b'
"testbench.sv", 35: consecutive_repetition.P1: started at 105ns failed at 115ns
	Offending 'b'
"testbench.sv", 35: consecutive_repetition.P1: started at 125ns failed at 155ns
	Offending 'b'
$finish called from file "testbench.sv", line 25.
$finish at simulation time                  165
           V C S   S i m u l a t i o n   R e p o r t 
Time: 165 ns
CPU Time:      0.240 seconds;       Data structure size:   0.0Mb
Sat Apr 12 12:32:42 2025
Finding VCD file...
./waveform.vcd
[2025-04-12 16:32:42 UTC] Opening EPWave...
Done    
