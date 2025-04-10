//DUT Code
module and_gate_dut(
              input A,
              input B,
              output Y,
             input clk);
  
   assign Y = A&&B;   
endmodule
//TB Code
module AND_Gate_tb_immediate_assert;
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
 always @(posedge clk) 
  begin 
  assert (A==0 && B==0) 
    $display("%0t, A=0 and B=0, assertion failed\n",$time);
  
  else assert (A==0 && B==1) 
    $display("%0t, A=0 and B=1, assertion failed\n",$time);
  
  else assert (A==1 && B==0) 
    $display("%0t, A=1 and B=0, assertion failed\n",$time);
  
  else assert (A==1 && B==1) 
    $display("%0t, A=1 and B=1,assertion Success\n",$time);
  
  else 
    $display("%0t fail\n",$time);
  end
  
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end  
endmodule 

// Log File Results
[2025-04-10 15:08:11 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu Apr 10 11:08:12 2025

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
       AND_Gate_tb_immediate_assert
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module AND_Gate_tb_immediate_assert
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .328 seconds to compile + .289 seconds to elab + .298 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 10 11:08 2025

A=0 B=0 Y=0
5, A=0 and B=0, assertion failed


A=0 B=1 Y=0
"testbench.sv", 36: AND_Gate_tb_immediate_assert.unnamed$$_0: started at 15ns failed at 15ns
	Offending '((A == 1'b0) && (B == 1'b0))'
15, A=0 and B=1, assertion failed


A=1 B=0 Y=0
"testbench.sv", 36: AND_Gate_tb_immediate_assert.unnamed$$_0: started at 25ns failed at 25ns
	Offending '((A == 1'b0) && (B == 1'b0))'
"testbench.sv", 39: AND_Gate_tb_immediate_assert.unnamed$$_0.unnamed$$_1: started at 25ns failed at 25ns
	Offending '((A == 1'b0) && (B == 1'b1))'
25, A=1 and B=0, assertion failed


A=1 B=1 Y=1
"testbench.sv", 36: AND_Gate_tb_immediate_assert.unnamed$$_0: started at 35ns failed at 35ns
	Offending '((A == 1'b0) && (B == 1'b0))'
"testbench.sv", 39: AND_Gate_tb_immediate_assert.unnamed$$_0.unnamed$$_1: started at 35ns failed at 35ns
	Offending '((A == 1'b0) && (B == 1'b1))'
"testbench.sv", 42: AND_Gate_tb_immediate_assert.unnamed$$_0.unnamed$$_1.unnamed$$_2: started at 35ns failed at 35ns
	Offending '((A == 1'b1) && (B == 1'b0))'
35, A=1 and B=1,assertion Success

$finish called from file "testbench.sv", line 30.
$finish at simulation time                   45
           V C S   S i m u l a t i o n   R e p o r t 
Time: 45 ns
CPU Time:      0.320 seconds;       Data structure size:   0.0Mb
Thu Apr 10 11:08:13 2025
Done
