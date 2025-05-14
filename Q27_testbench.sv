//Q27. Write an assertion such that ,everytime when the valid signal goes high, the count is incremented.
module tb_top;
  logic clk;
  logic rst;
  logic valid;
  logic [7:0] count;
  logic [7:0] count_prev;

  // Clock generation
  always #5 clk = ~clk;

  // Store previous count to compare
  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      count_prev <= 0;
    else
      count_prev <= count;
  end 

  // ASSERTION: If valid is high at current cycle, then count must increment in the next cycle
  property p_valid_increments_count;
    @(posedge clk)
    disable iff (rst)
    valid |=> (count == count_prev + 1);
  endproperty
    
  P1:assert property (p_valid_increments_count)    
    $info ("PASSED: Count incremented after valid went high at time %0t ",$realtime);    
   else    
     $error("FAILED: Count did not increment after valid went high at time %0t ",$realtime);   

  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end    
    
  // STIMULUS
  initial begin
    
    clk = 0; 
    rst = 1; 
    valid = 0; 
    count = 0;
    #12 rst = 0;

    // Stimulus patterns
    #10 valid = 1; count = 1;   // Expect count to increment to 1
    #10 valid = 0; count = 1;   // valid low, no increment expected
    #10 valid = 1; count = 2;   // valid high, count should go to 2
    #10 valid = 1; count = 3;   // valid high again, count to 3
    #10 valid = 0; count = 3;
    #10 valid = 1; count = 4;

    #20 $finish;
  end

endmodule

//Logfile output
[2025-05-14 03:18:54 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Tue May 13 23:18:55 2025

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
CPU time: .395 seconds to compile + .314 seconds to elab + .398 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 13 23:18 2025
"testbench.sv", 30: tb_top.P1: started at 25ns failed at 35ns
	Offending '(count == (count_prev + 1))'
Error: "testbench.sv", 30: tb_top.P1: at time 35 ns
FAILED: Count did not increment after valid went high at time 35 
Info: "testbench.sv", 30: tb_top.P1: at time 55 ns
PASSED: Count incremented after valid went high at time 55 
"testbench.sv", 30: tb_top.P1: started at 55ns failed at 65ns
	Offending '(count == (count_prev + 1))'
Error: "testbench.sv", 30: tb_top.P1: at time 65 ns
FAILED: Count did not increment after valid went high at time 65 
"testbench.sv", 30: tb_top.P1: started at 75ns failed at 85ns
	Offending '(count == (count_prev + 1))'
Error: "testbench.sv", 30: tb_top.P1: at time 85 ns
FAILED: Count did not increment after valid went high at time 85 
$finish called from file "testbench.sv", line 57.
$finish at simulation time                   92
           V C S   S i m u l a t i o n   R e p o r t 
Time: 92 ns
CPU Time:      0.460 seconds;       Data structure size:   0.0Mb
Tue May 13 23:18:57 2025
Done    
