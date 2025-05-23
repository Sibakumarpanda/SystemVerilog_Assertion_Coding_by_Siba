//Q70. Write an assertion which checks that once a valid request is asserted by the master, the arbiter provides a grant within 2 to 5 clock cycles

module tb_top;  
  logic clk;
  logic request;  // Request signal from the master
  logic grant;    // Grant signal from the arbiter
 
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
  end

  // Stimulus generation
  initial begin
    
    request = 0;
    grant = 0;

    repeat (10) @(posedge clk); // Wait for some cycles

    // Test various scenarios
    @(posedge clk); request = 1; grant = 0; // Request asserted
    @(posedge clk); request = 1; grant = 0; // Cycle 1
    @(posedge clk); request = 1; grant = 1; // Cycle 2 (Valid grant within 2 cycles)
    @(posedge clk); request = 0; grant = 0;

    @(posedge clk); request = 1; grant = 0; // Request asserted
    @(posedge clk); request = 1; grant = 0; // Cycle 1
    @(posedge clk); request = 1; grant = 0; // Cycle 2
    @(posedge clk); request = 1; grant = 0; // Cycle 3
    @(posedge clk); request = 1; grant = 1; // Cycle 4 (Valid grant within 4 cycles)
    @(posedge clk); request = 0; grant = 0;

    @(posedge clk); request = 1; grant = 0; // Request asserted
    @(posedge clk); request = 1; grant = 0; // Cycle 1
    @(posedge clk); request = 1; grant = 0; // Cycle 2
    @(posedge clk); request = 1; grant = 0; // Cycle 3
    @(posedge clk); request = 1; grant = 0; // Cycle 4
    @(posedge clk); request = 1; grant = 1; // Cycle 5 (Valid grant within 5 cycles)
    @(posedge clk); request = 0; grant = 0;

    @(posedge clk); request = 1; grant = 0; // Request asserted
    @(posedge clk); request = 1; grant = 0; // Cycle 1
    @(posedge clk); request = 1; grant = 0; // Cycle 2
    @(posedge clk); request = 1; grant = 0; // Cycle 3
    @(posedge clk); request = 1; grant = 0; // Cycle 4
    @(posedge clk); request = 1; grant = 0; // Cycle 5 (Invalid, no grant)
    @(posedge clk); request = 0; grant = 0;

    $finish; 
  end

  // Assertion to check grant within 2 to 5 cycles after request
  property grant_within_2_to_5_cycles;
    @(posedge clk)
    request |-> ##[2:5] grant; // Grant must be asserted within 2 to 5 cycles after request
  endproperty

  assert property (grant_within_2_to_5_cycles)
    $display("PASSED: Grant provided within 2 to 5 cycles at TIME=%0d", $time);
  else
    $error("FAILED: Grant not provided within 2 to 5 cycles at TIME=%0d", $time);
 
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end
endmodule
    
//Logfile Output    
[2025-05-23 05:39:54 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Fri May 23 01:39:55 2025

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
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _333_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .490 seconds to compile + .477 seconds to elab + .408 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 23 01:39 2025
PASSED: Grant provided within 2 to 5 cycles at TIME=135
"testbench.sv", 63: tb_top.unnamed$$_2: started at 125ns failed at 175ns
	Offending 'grant'
Error: "testbench.sv", 63: tb_top.unnamed$$_2: at time 175 ns
FAILED: Grant not provided within 2 to 5 cycles at TIME=175
"testbench.sv", 63: tb_top.unnamed$$_2: started at 135ns failed at 185ns
	Offending 'grant'
Error: "testbench.sv", 63: tb_top.unnamed$$_2: at time 185 ns
FAILED: Grant not provided within 2 to 5 cycles at TIME=185
PASSED: Grant provided within 2 to 5 cycles at TIME=195
PASSED: Grant provided within 2 to 5 cycles at TIME=195
PASSED: Grant provided within 2 to 5 cycles at TIME=195
"testbench.sv", 63: tb_top.unnamed$$_2: started at 185ns failed at 235ns
	Offending 'grant'
Error: "testbench.sv", 63: tb_top.unnamed$$_2: at time 235 ns
FAILED: Grant not provided within 2 to 5 cycles at TIME=235
"testbench.sv", 63: tb_top.unnamed$$_2: started at 195ns failed at 245ns
	Offending 'grant'
Error: "testbench.sv", 63: tb_top.unnamed$$_2: at time 245 ns
FAILED: Grant not provided within 2 to 5 cycles at TIME=245
PASSED: Grant provided within 2 to 5 cycles at TIME=265
PASSED: Grant provided within 2 to 5 cycles at TIME=265
PASSED: Grant provided within 2 to 5 cycles at TIME=265
PASSED: Grant provided within 2 to 5 cycles at TIME=265
"testbench.sv", 63: tb_top.unnamed$$_2: started at 255ns failed at 305ns
	Offending 'grant'
Error: "testbench.sv", 63: tb_top.unnamed$$_2: at time 305 ns
FAILED: Grant not provided within 2 to 5 cycles at TIME=305
"testbench.sv", 63: tb_top.unnamed$$_2: started at 265ns failed at 315ns
	Offending 'grant'
Error: "testbench.sv", 63: tb_top.unnamed$$_2: at time 315 ns
FAILED: Grant not provided within 2 to 5 cycles at TIME=315
$finish called from file "testbench.sv", line 54.
$finish at simulation time                  335
           V C S   S i m u l a t i o n   R e p o r t 
Time: 335 ns
CPU Time:      0.450 seconds;       Data structure size:   0.0Mb
Fri May 23 01:39:57 2025
Done
    
