//DUT Code
module and_gate_dut(
              input A,
              input B,
              output Y,
             input clk);
  
   assign Y = A&&B; 
  
endmodule
//TB code
module and_Gate_tb_concurrent_assert;  
  reg A;
  reg B;
  reg clk;
  wire Y;
and_gate_dut inst(.A(A), .B(B), .Y(Y), .clk(clk));

always #5 clk = ~clk;
  
initial begin
  $monitor ("\nA=%0b B=%0b Y=%0b", A, B, Y);
  clk<=0;
  A<=0;
  B<=0;
  
  #10
  A<=0;
  B<=1;
  
  #10
  A<=1;
  B<=0;
  
  #10
  A<=1;
  B<=1;
  #15 $finish;
end

sequence seq;
  @(posedge clk) 
  (A==1 && B==1);
endsequence

property ppt;
  seq;
endproperty

assert property (ppt) 
  $display("%0t, A=1 and B=1, Assertion PASS",$time);
else 
  $display("%0t, A=%0b and B=%0b,Assertion FAIL", $time,A,B);

 initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
 end
endmodule
  
//Log file Results
[2025-04-10 15:34:08 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu Apr 10 11:34:09 2025

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
       and_Gate_tb_concurrent_assert
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module and_Gate_tb_concurrent_assert
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .349 seconds to compile + .314 seconds to elab + .360 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 10 11:34 2025

A=0 B=0 Y=0
"testbench.sv", 44: and_Gate_tb_concurrent_assert.unnamed$$_1: started at 5ns failed at 5ns
	Offending '((A == 1) && (B == 1))'
5, A=0 and B=0,Assertion FAIL

A=0 B=1 Y=0
"testbench.sv", 44: and_Gate_tb_concurrent_assert.unnamed$$_1: started at 15ns failed at 15ns
	Offending '((A == 1) && (B == 1))'
15, A=0 and B=1,Assertion FAIL

A=1 B=0 Y=0
"testbench.sv", 44: and_Gate_tb_concurrent_assert.unnamed$$_1: started at 25ns failed at 25ns
	Offending '((A == 1) && (B == 1))'
25, A=1 and B=0,Assertion FAIL

A=1 B=1 Y=1
35, A=1 and B=1, Assertion PASS
$finish called from file "testbench.sv", line 32.
$finish at simulation time                   45
           V C S   S i m u l a t i o n   R e p o r t 
Time: 45 ns
CPU Time:      0.340 seconds;       Data structure size:   0.0Mb
Thu Apr 10 11:34:10 2025
Finding VCD file...
./waveform.vcd
[2025-04-10 15:34:10 UTC] Opening EPWave...
Done
