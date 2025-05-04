//2. Concurrent assertions: if c is high on a clock cycle, then on next cycle, value of a and b is equal
module concurrent_example; 
  bit clk;
  bit a,b,c;
always #5 clk = ~clk; 

initial begin
      a=0; b=0;
  #15 a=1; b=0; c=0; //15
  #10 a=0; b=1; c=0; //25
  #10 a=0; b=1; c=0; //35
  #10 a=0; b=0; c=1; //45
  #10 a=0; b=1; c=0; //55
  #10 a=0; b=0; c=1; //65
  #10 a=0; b=0; c=0; //75
  #10 a=1; b=0; c=0; //85
  #10 a=0; b=1; c=0; //95
  #10 a=0; b=0; c=0; //105
  #10 a=0; b=1; c=0; //115
  #10 a=0; b=0; c=0; //125
  #10 a=0; b=1; c=0; //135
  #10 a=0; b=0; c=1; //145
  #10 a=0; b=0; c=0; //155
  #10;
  $finish;
end
property check_a_b_equal_on_next_cycle;
  @(posedge clk) 
  c |-> ##1 (a == b);
endproperty
  
P1:assert property (check_a_b_equal_on_next_cycle)   
   $display("PASSED at TIME=%0d with a=%0b b= %0b c=%0b",$time ,a,b,c);    
  else      
    $error("FAILED at TIME=%0d with a=%0b b= %0b c=%0b",$time ,a,b,c);

initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end  
endmodule
  
// Log File output  
[2025-05-04 09:13:18 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sun May  4 05:13:19 2025

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
       concurrent_example
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module concurrent_example
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _333_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .368 seconds to compile + .387 seconds to elab + .327 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  4 05:13 2025
"testbench.sv", 36: concurrent_example.P1: started at 55ns failed at 65ns
	Offending '(a == b)'
Error: "testbench.sv", 36: concurrent_example.P1: at time 65 ns
FAILED at TIME=65 with a=0 b= 0 c=1
PASSED at TIME=85 with a=1 b= 0 c=0
$finish called from file "testbench.sv", line 27.
$finish at simulation time                  165
           V C S   S i m u l a t i o n   R e p o r t 
Time: 165 ns
CPU Time:      0.340 seconds;       Data structure size:   0.0Mb
Sun May  4 05:13:21 2025
Done
  
