//Q61. Write an assertion check to make sure that a signal is high for a minimum of 2 cycles and a maximum of 6 cycles.
module tb_top;
  logic clk;
  logic signal;
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
  end

  // Stimulus generation
  initial begin    
    signal = 0;
    repeat (10) @(posedge clk); // Wait for some cycles

    // Test various scenarios
    @(posedge clk); signal = 1; // Cycle 1
    @(posedge clk); signal = 1; // Cycle 2 (Minimum condition met)
    @(posedge clk); signal = 0; // Cycle 3

    @(posedge clk); signal = 1; // Cycle 1
    @(posedge clk); signal = 1; // Cycle 2
    @(posedge clk); signal = 1; // Cycle 3
    @(posedge clk); signal = 1; // Cycle 4
    @(posedge clk); signal = 1; // Cycle 5
    @(posedge clk); signal = 1; // Cycle 6 (Maximum condition met)
    @(posedge clk); signal = 0; // Cycle 7

    @(posedge clk); signal = 1; // Cycle 1
    @(posedge clk); signal = 1; // Cycle 2
    @(posedge clk); signal = 1; // Cycle 3
    @(posedge clk); signal = 0; // Cycle 4

    @(posedge clk); signal = 1; // Cycle 1
    @(posedge clk); signal = 1; // Cycle 2
    @(posedge clk); signal = 1; // Cycle 3
    @(posedge clk); signal = 1; // Cycle 4
    @(posedge clk); signal = 1; // Cycle 5
    @(posedge clk); signal = 1; // Cycle 6
    @(posedge clk); signal = 1; // Cycle 7 (Exceeds maximum condition)
    $finish; 
  end

  // Define a sequence for the signal being high
  sequence signal_high;
    (signal == 1) [*2:6]; // Signal must be high for a minimum of 2 cycles and a maximum of 6 cycles
  endsequence

  // Property to check the behavior
  property check_signal_duration;
    @(posedge clk)
    signal_high |-> ##1 (signal == 0); // After the sequence, signal should go low
  endproperty

  assert property (check_signal_duration)
    $display("PASSED at TIME=%0d with signal=%0b", $time, signal);
  else
    $error("FAILED at TIME=%0d with signal=%0b", $time, signal);

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end
endmodule

//Logfile Output
[2025-05-22 16:51:18 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu May 22 12:51:19 2025

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
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _332_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .508 seconds to compile + .469 seconds to elab + .410 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 22 12:51 2025
PASSED at TIME=135 with signal=1
"testbench.sv", 61: tb_top.unnamed$$_2: started at 145ns failed at 165ns
	Offending '(signal == 0)'
Error: "testbench.sv", 61: tb_top.unnamed$$_2: at time 165 ns
FAILED at TIME=165 with signal=1
"testbench.sv", 61: tb_top.unnamed$$_2: started at 155ns failed at 175ns
	Offending '(signal == 0)'
Error: "testbench.sv", 61: tb_top.unnamed$$_2: at time 175 ns
FAILED at TIME=175 with signal=1
"testbench.sv", 61: tb_top.unnamed$$_2: started at 165ns failed at 185ns
	Offending '(signal == 0)'
Error: "testbench.sv", 61: tb_top.unnamed$$_2: at time 185 ns
FAILED at TIME=185 with signal=1
"testbench.sv", 61: tb_top.unnamed$$_2: started at 175ns failed at 195ns
	Offending '(signal == 0)'
Error: "testbench.sv", 61: tb_top.unnamed$$_2: at time 195 ns
FAILED at TIME=195 with signal=0
PASSED at TIME=205 with signal=1
"testbench.sv", 61: tb_top.unnamed$$_2: started at 215ns failed at 235ns
	Offending '(signal == 0)'
Error: "testbench.sv", 61: tb_top.unnamed$$_2: at time 235 ns
FAILED at TIME=235 with signal=0
PASSED at TIME=245 with signal=1
"testbench.sv", 61: tb_top.unnamed$$_2: started at 255ns failed at 275ns
	Offending '(signal == 0)'
Error: "testbench.sv", 61: tb_top.unnamed$$_2: at time 275 ns
FAILED at TIME=275 with signal=1
"testbench.sv", 61: tb_top.unnamed$$_2: started at 265ns failed at 285ns
	Offending '(signal == 0)'
Error: "testbench.sv", 61: tb_top.unnamed$$_2: at time 285 ns
FAILED at TIME=285 with signal=1
"testbench.sv", 61: tb_top.unnamed$$_2: started at 275ns failed at 295ns
	Offending '(signal == 0)'
Error: "testbench.sv", 61: tb_top.unnamed$$_2: at time 295 ns
FAILED at TIME=295 with signal=1
$finish called from file "testbench.sv", line 46.
$finish at simulation time                  305
           V C S   S i m u l a t i o n   R e p o r t 
Time: 305 ns
CPU Time:      0.410 seconds;       Data structure size:   0.0Mb
Thu May 22 12:51:21 2025
Done    
