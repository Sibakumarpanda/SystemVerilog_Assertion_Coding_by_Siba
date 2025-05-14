//Q29. Write an assertion such that ,When there's a no_space_err, the no_space_ctr_incr signal is flagged for exactly once clock
//Mean , when no_space_err is active, the no_space_ctr_incr signal must be high for exactly one clock cycle

module tb_top;
  logic clk;
  logic rst;
  logic no_space_err;
  logic no_space_ctr_incr;
 
  always #5 clk = ~clk;

  // ASSERTION: When no_space_err is high, no_space_ctr_incr should be high for exactly one clock cycle
  property p_no_space_err_one_cycle_incr;
    @(posedge clk)
    disable iff (rst)
    no_space_err |-> ##1 no_space_ctr_incr && !no_space_ctr_incr;
  endproperty
    
  P1:assert property (p_no_space_err_one_cycle_incr)    
    $info ("PASSED: no_space_ctr_incr was high for exactly one clock cycle when no_space_err was high at time %0t ",$realtime);    
   else    
     $error("FAILED: no_space_ctr_incr was not high for exactly one clock cycle when no_space_err was high at time %0t ",$realtime);   

  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end    
  
  initial begin
    // Initialize
    clk = 0; rst = 1; no_space_err = 0; no_space_ctr_incr = 0;
    #12 rst = 0;
    // Stimulus patterns
    #10 no_space_err = 1; no_space_ctr_incr = 1;   // no_space_err is active, no_space_ctr_incr is high for exactly 1 cycle
    #10 no_space_err = 0; no_space_ctr_incr = 0;   // no_space_err is inactive, no_space_ctr_incr should stay low
    #10 no_space_err = 1; no_space_ctr_incr = 1;   // no_space_err is active, no_space_ctr_incr is high for exactly 1 cycle
    #10 no_space_err = 1; no_space_ctr_incr = 1;   // no_space_err is active, no_space_ctr_incr should be high for only 1 cycle
    #10 no_space_err = 1; no_space_ctr_incr = 0;   // no_space_err is active, but no_space_ctr_incr must stay low when no_space_err is low
    #10 no_space_err = 0; no_space_ctr_incr = 0;    // no_space_err is inactive, no_space_ctr_incr should stay low
    #20 $finish;
  end
endmodule
    
//Logfile output
[2025-05-14 03:20:58 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Tue May 13 23:20:59 2025

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
       tb_top
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module tb_top
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .419 seconds to compile + .366 seconds to elab + .376 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 13 23:21 2025
"testbench.sv", 23: tb_top.P1: started at 25ns failed at 35ns
	Offending '(no_space_ctr_incr && (!no_space_ctr_incr))'
Error: "testbench.sv", 23: tb_top.P1: at time 35 ns
FAILED: no_space_ctr_incr was not high for exactly one clock cycle when no_space_err was high at time 35 
"testbench.sv", 23: tb_top.P1: started at 45ns failed at 55ns
	Offending '(no_space_ctr_incr && (!no_space_ctr_incr))'
Error: "testbench.sv", 23: tb_top.P1: at time 55 ns
FAILED: no_space_ctr_incr was not high for exactly one clock cycle when no_space_err was high at time 55 
"testbench.sv", 23: tb_top.P1: started at 55ns failed at 65ns
	Offending '(no_space_ctr_incr && (!no_space_ctr_incr))'
Error: "testbench.sv", 23: tb_top.P1: at time 65 ns
FAILED: no_space_ctr_incr was not high for exactly one clock cycle when no_space_err was high at time 65 
"testbench.sv", 23: tb_top.P1: started at 65ns failed at 75ns
	Offending '(no_space_ctr_incr && (!no_space_ctr_incr))'
Error: "testbench.sv", 23: tb_top.P1: at time 75 ns
FAILED: no_space_ctr_incr was not high for exactly one clock cycle when no_space_err was high at time 75 
$finish called from file "testbench.sv", line 47.
$finish at simulation time                   92
           V C S   S i m u l a t i o n   R e p o r t 
Time: 92 ns
CPU Time:      0.390 seconds;       Data structure size:   0.0Mb
Tue May 13 23:21:01 2025
Done
    
    
