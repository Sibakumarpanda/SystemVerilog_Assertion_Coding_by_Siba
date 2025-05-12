//Q24. Write an assertion check to make sure that a signal is high for a minimum of 2 cycles and maximum of 6 cycles
module tb_top;
  logic clk;
  logic rst_n;
  logic signal;

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset logic
  initial begin
    rst_n = 0;
    #12 rst_n = 1;
  end

  // === Assertion: Signal stays high for between 2 and 6 cycles ===
  property signal_high_duration;
    @(posedge clk)
    disable iff (!rst_n)
    signal && !$past(signal) |-> signal [*1:5] ##1 !signal;
  endproperty
    
   P1:assert property (signal_high_duration)    
    $info ("PASSED: Signal was not high for between 2 and 6 cycles at time=%0d ",$realtime);    
   else    
     $error("FAILED: Signal was not high for between 2 and 6 cycles at time =%0d ",$realtime);   

  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end  

  // === Stimulus ===
  initial begin
    signal = 0;
    @(posedge rst_n);
    
    // Case 1: Valid - signal high for exactly 2 cycles
    @(posedge clk); signal = 1;
    @(posedge clk); signal = 1;
    @(posedge clk); signal = 0;

    // Case 2: Valid - signal high for 6 cycles
    repeat (6) @(posedge clk) signal = 1;
    @(posedge clk); signal = 0;

    // Case 3: Invalid - signal high for 1 cycle (too short)
    @(posedge clk); signal = 1;
    @(posedge clk); signal = 0; // <-- assertion should fire

    // Case 4: Invalid - signal high for 7 cycles (too long)
    repeat (7) @(posedge clk) signal = 1; // <-- assertion should fire on 7th cycle
    @(posedge clk); signal = 0;

    // Case 5: Valid - signal toggles with allowed durations
    repeat (3) begin
      repeat ($urandom_range(2,6)) @(posedge clk) signal = 1;
      @(posedge clk); signal = 0;
    end
    $display("Test completed.");
    $finish;
  end
endmodule
     
//Logfile output
[2025-05-12 06:41:42 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Mon May 12 02:41:43 2025

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
CPU time: .349 seconds to compile + .289 seconds to elab + .285 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 12 02:41 2025
Info: "testbench.sv", 27: tb_top.P1: at time 45 ns
PASSED: Signal was not high for between 2 and 6 cycles at time=45 
"testbench.sv", 27: tb_top.P1: started at 55ns failed at 105ns
	Offending '(!signal)'
Error: "testbench.sv", 27: tb_top.P1: at time 105 ns
FAILED: Signal was not high for between 2 and 6 cycles at time =105 
Info: "testbench.sv", 27: tb_top.P1: at time 135 ns
PASSED: Signal was not high for between 2 and 6 cycles at time=135 
"testbench.sv", 27: tb_top.P1: started at 145ns failed at 195ns
	Offending '(!signal)'
Error: "testbench.sv", 27: tb_top.P1: at time 195 ns
FAILED: Signal was not high for between 2 and 6 cycles at time =195 
Info: "testbench.sv", 27: tb_top.P1: at time 265 ns
PASSED: Signal was not high for between 2 and 6 cycles at time=265 
Info: "testbench.sv", 27: tb_top.P1: at time 315 ns
PASSED: Signal was not high for between 2 and 6 cycles at time=315 
Test completed.
$finish called from file "testbench.sv", line 66.
$finish at simulation time                  345
           V C S   S i m u l a t i o n   R e p o r t 
Time: 345 ns
CPU Time:      0.340 seconds;       Data structure size:   0.0Mb
Mon May 12 02:41:44 2025
Done     
     

