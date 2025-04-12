module without_ended_assertion;
  bit clk;
  bit a,b;
  always #5 clk = ~clk; 
initial 
  begin 
      a=1;
  #57 b=1;
  #10 a=0;
  #15 b=0;
  #10 a=1;
  #10 b=0;
  #10 a=1;
  #10 b=1;
  #200;
  $finish;
  end
  
  //sequence 1
  sequence seq_1;
    @(posedge clk)
    a;
  endsequence
  
  //sequence 2
  sequence seq_2;
    @(posedge clk)
    ##4 b;
  endsequence

  property without_ended_assert;
    @(posedge clk) 
    seq_1 |-> ##4 seq_2;
    
  endproperty

  P1:assert property (without_ended_assert)   
    $display("PASSED at TIME=%0d with a=%0b b= %0b",$time ,a,b);    
  else      
    $error("FAILED at TIME=%0d with a=%0b b= %0b",$time ,a,b);   
    
  initial 
    begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end    
endmodule
//Log file output
 [2025-04-12 16:25:19 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat Apr 12 12:25:20 2025

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
       without_ended_assertion
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module without_ended_assertion
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _333_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .249 seconds to compile + .245 seconds to elab + .213 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 12 12:25 2025
"testbench.sv", 39: without_ended_assertion.P1: started at 5ns failed at 85ns
	Offending 'b'
Error: "testbench.sv", 39: without_ended_assertion.P1: at time 85 ns
FAILED at TIME=85 with a=0 b= 0
"testbench.sv", 39: without_ended_assertion.P1: started at 15ns failed at 95ns
	Offending 'b'
Error: "testbench.sv", 39: without_ended_assertion.P1: at time 95 ns
FAILED at TIME=95 with a=1 b= 0
"testbench.sv", 39: without_ended_assertion.P1: started at 25ns failed at 105ns
	Offending 'b'
Error: "testbench.sv", 39: without_ended_assertion.P1: at time 105 ns
FAILED at TIME=105 with a=1 b= 0
"testbench.sv", 39: without_ended_assertion.P1: started at 35ns failed at 115ns
	Offending 'b'
Error: "testbench.sv", 39: without_ended_assertion.P1: at time 115 ns
FAILED at TIME=115 with a=1 b= 0
PASSED at TIME=125 with a=1 b= 1
PASSED at TIME=135 with a=1 b= 1
PASSED at TIME=145 with a=1 b= 1
PASSED at TIME=175 with a=1 b= 1
PASSED at TIME=185 with a=1 b= 1
PASSED at TIME=195 with a=1 b= 1
PASSED at TIME=205 with a=1 b= 1
PASSED at TIME=215 with a=1 b= 1
PASSED at TIME=225 with a=1 b= 1
PASSED at TIME=235 with a=1 b= 1
PASSED at TIME=245 with a=1 b= 1
PASSED at TIME=255 with a=1 b= 1
PASSED at TIME=265 with a=1 b= 1
PASSED at TIME=275 with a=1 b= 1
PASSED at TIME=285 with a=1 b= 1
PASSED at TIME=295 with a=1 b= 1
PASSED at TIME=305 with a=1 b= 1
PASSED at TIME=315 with a=1 b= 1
$finish called from file "testbench.sv", line 18.
$finish at simulation time                  322
           V C S   S i m u l a t i o n   R e p o r t 
Time: 322 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Sat Apr 12 12:25:21 2025
Finding VCD file...
./waveform.vcd
[2025-04-12 16:25:21 UTC] Opening EPWave...
Done   
