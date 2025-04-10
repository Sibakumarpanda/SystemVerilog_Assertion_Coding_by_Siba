//TB Code
module non_overlapped_assertion;  
  bit clk,a,b,valid;  
  always #5 clk = ~clk; //clock generation
  
  initial begin
    valid=1;
    
        a=1; b=1;
    #15 a=1; b=0;
    #10 b=1;
    #12 b=0;
    #10 a=0; b=1;
        valid=0;
    #15 a=1; b=0;
    #100 $finish;
  end
  
  property non_overlap_assert;
    @(posedge clk) 
    valid |=> (a ##3 b);
  endproperty
      
  P1:assert property (non_overlap_assert)   
    $display("PASSED at TIME=%0d  with valid= %0d a=%0d b= %0d",$time ,valid,a,b);    
  else      
    $error("FAILED at TIME=%0d with valid= %0d a=%0d b= %0d",$time ,valid,a,b);

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end   
endmodule

//Log file results
[2025-04-10 15:23:41 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu Apr 10 11:23:42 2025

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
       Non_overlapped_assertion
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module Non_overlapped_assertion
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .390 seconds to compile + .296 seconds to elab + .306 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 10 11:23 2025
"testbench.sv", 27: Non_overlapped_assertion.P1: started at 5ns failed at 45ns
	Offending 'b'
Error: "testbench.sv", 27: Non_overlapped_assertion.P1: at time 45 ns
FAILED at TIME=45 with valid= 1 a=1 b= 0
"testbench.sv", 27: Non_overlapped_assertion.P1: started at 45ns failed at 55ns
	Offending 'a'
Error: "testbench.sv", 27: Non_overlapped_assertion.P1: at time 55 ns
FAILED at TIME=55 with valid= 0 a=0 b= 1
PASSED at TIME=55  with valid= 0 a=0 b= 1
"testbench.sv", 27: Non_overlapped_assertion.P1: started at 25ns failed at 65ns
	Offending 'b'
Error: "testbench.sv", 27: Non_overlapped_assertion.P1: at time 65 ns
FAILED at TIME=65 with valid= 0 a=1 b= 0
"testbench.sv", 27: Non_overlapped_assertion.P1: started at 35ns failed at 75ns
	Offending 'b'
Error: "testbench.sv", 27: Non_overlapped_assertion.P1: at time 75 ns
FAILED at TIME=75 with valid= 0 a=1 b= 0
$finish called from file "testbench.sv", line 18.
$finish at simulation time                  162
           V C S   S i m u l a t i o n   R e p o r t 
Time: 162 ns
CPU Time:      0.330 seconds;       Data structure size:   0.0Mb
Thu Apr 10 11:23:43 2025    
