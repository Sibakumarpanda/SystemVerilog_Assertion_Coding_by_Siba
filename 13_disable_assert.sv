//DUT
module andgate(
  input A,
  input B,
  output Y,
  input clk,
  input rst);

  assign Y = A&&B;

endmodule
//TB
module and_gate_tb;
  reg A;
  reg B;
  reg clk;
  wire Y;
  reg rst;

  //Design instantiation
  andgate inst(.A(A), .B(B), .Y(Y), .clk(clk), .rst(rst));

  always #5 clk = ~clk;
  initial
   begin
    rst <=1; //reset is asserted
    clk<=1;
    A<=0;
    B<=0;

    #10
    A<=0;
    B<=1;
 
    #12
    rst <=0;//reset is deasserted
    A<=1;
    B<=0;

    #10
    A<=1;
    B<=1;

    #30 $finish;
   end
  
//-------------------------------------------------------
// Disable iff is used to disable the property when the
// reset is active. Assertion output is disable whether it
// failure or pass.
// It is used when we don't want to check some conditions
//-------------------------------------------------------
  property disable_assert;
    @(posedge clk) 
    disable iff(rst)  //disable if reset is assereted
    A&&B;
  endproperty

  P1:assert property (disable_assert)   
    $display("PASSED at TIME=%0d with A=%0b B= %0b",$time ,A,B);    
  else      
    $error("FAILED at TIME=%0d with A=%0b B= %0b",$time ,A,B);       
initial
begin
  $dumpfile("waveform.vcd");
  $dumpvars();
end    
endmodule
//Log file Results
 [2025-04-12 16:18:21 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat Apr 12 12:18:22 2025

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
       and_gate_tb
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module and_gate_tb
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .269 seconds to compile + .254 seconds to elab + .227 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 12 12:18 2025
"testbench.sv", 48: and_gate_tb.P1: started at 30ns failed at 30ns
	Offending '(A && B)'
Error: "testbench.sv", 48: and_gate_tb.P1: at time 30 ns
FAILED at TIME=30 with A=1 B= 0
PASSED at TIME=40 with A=1 B= 1
PASSED at TIME=50 with A=1 B= 1
PASSED at TIME=60 with A=1 B= 1
$finish called from file "testbench.sv", line 33.
$finish at simulation time                   62
           V C S   S i m u l a t i o n   R e p o r t 
Time: 62 ns
CPU Time:      0.260 seconds;       Data structure size:   0.0Mb
Sat Apr 12 12:18:23 2025
Finding VCD file...
./waveform.vcd
[2025-04-12 16:18:23 UTC] Opening EPWave...
Done   
