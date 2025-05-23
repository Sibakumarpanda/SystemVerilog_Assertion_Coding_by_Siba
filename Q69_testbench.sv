//Q69. Write an assertion to make sure that the state variable in a state machine is always one hot value. Write an assertion to make sure that a 5-bit grant signal only has one bit set at any time? (only one req granted at a time)
module tb_top; 
  logic clk;
  logic [4:0] state;  // 5-bit state variable for one-hot encoding
  logic [4:0] grant;  // 5-bit grant signal
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
  end

  // Stimulus generation
  initial begin  
    state = 5'b00001; // Start with a valid one-hot state
    grant = 5'b00000; // No grant initially

    repeat (10) @(posedge clk); // Wait for some cycles

    // Test various scenarios for state
    @(posedge clk); state = 5'b00010; // Valid one-hot
    @(posedge clk); state = 5'b00100; // Valid one-hot
    @(posedge clk); state = 5'b01000; // Valid one-hot
    @(posedge clk); state = 5'b10000; // Valid one-hot
    @(posedge clk); state = 5'b11000; // Invalid (not one-hot)
    @(posedge clk); state = 5'b00000; // Invalid (no bits set)

    // Test various scenarios for grant
    @(posedge clk); grant = 5'b00001; // Valid (one bit set)
    @(posedge clk); grant = 5'b00010; // Valid (one bit set)
    @(posedge clk); grant = 5'b00100; // Valid (one bit set)
    @(posedge clk); grant = 5'b01000; // Valid (one bit set)
    @(posedge clk); grant = 5'b10000; // Valid (one bit set)
    @(posedge clk); grant = 5'b11000; // Invalid (multiple bits set)
    @(posedge clk); grant = 5'b00000; // Valid (no bits set)

    $finish; 
  end

  // Assertion to check one-hot encoding of state
  property one_hot_state;
    @(posedge clk)
    $onehot(state); // Ensures only one bit is set in state
  endproperty

  assert property (one_hot_state)
    $display("PASSED: State is one-hot at TIME=%0d with state=%b", $time, state);
  else
    $error("FAILED: State is not one-hot at TIME=%0d with state=%b", $time, state);

  // Assertion to check one-hot encoding of grant
  property one_hot_grant;
    @(posedge clk)
    $onehot0(grant); // Ensures only one bit is set in grant, or all bits are zero
  endproperty

  assert property (one_hot_grant)
    $display("PASSED: Grant is one-hot at TIME=%0d with grant=%b", $time, grant);
  else
    $error("FAILED: Grant is not one-hot at TIME=%0d with grant=%b", $time, grant);
  
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end
endmodule

//Logfile Output
[2025-05-23 05:37:50 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Fri May 23 01:37:52 2025

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
CPU time: .460 seconds to compile + .497 seconds to elab + .402 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 23 01:37 2025
PASSED: State is one-hot at TIME=5 with state=00001
PASSED: Grant is one-hot at TIME=5 with grant=00000
PASSED: State is one-hot at TIME=15 with state=00001
PASSED: Grant is one-hot at TIME=15 with grant=00000
PASSED: State is one-hot at TIME=25 with state=00001
PASSED: Grant is one-hot at TIME=25 with grant=00000
PASSED: State is one-hot at TIME=35 with state=00001
PASSED: Grant is one-hot at TIME=35 with grant=00000
PASSED: State is one-hot at TIME=45 with state=00001
PASSED: Grant is one-hot at TIME=45 with grant=00000
PASSED: State is one-hot at TIME=55 with state=00001
PASSED: Grant is one-hot at TIME=55 with grant=00000
PASSED: State is one-hot at TIME=65 with state=00001
PASSED: Grant is one-hot at TIME=65 with grant=00000
PASSED: State is one-hot at TIME=75 with state=00001
PASSED: Grant is one-hot at TIME=75 with grant=00000
PASSED: State is one-hot at TIME=85 with state=00001
PASSED: Grant is one-hot at TIME=85 with grant=00000
PASSED: State is one-hot at TIME=95 with state=00001
PASSED: Grant is one-hot at TIME=95 with grant=00000
PASSED: State is one-hot at TIME=105 with state=00010
PASSED: Grant is one-hot at TIME=105 with grant=00000
PASSED: State is one-hot at TIME=115 with state=00100
PASSED: Grant is one-hot at TIME=115 with grant=00000
PASSED: State is one-hot at TIME=125 with state=01000
PASSED: Grant is one-hot at TIME=125 with grant=00000
PASSED: State is one-hot at TIME=135 with state=10000
PASSED: Grant is one-hot at TIME=135 with grant=00000
PASSED: State is one-hot at TIME=145 with state=11000
PASSED: Grant is one-hot at TIME=145 with grant=00000
"testbench.sv", 49: tb_top.unnamed$$_2: started at 155ns failed at 155ns
	Offending '$onehot(state)'
Error: "testbench.sv", 49: tb_top.unnamed$$_2: at time 155 ns
FAILED: State is not one-hot at TIME=155 with state=00000
PASSED: Grant is one-hot at TIME=155 with grant=00000
"testbench.sv", 49: tb_top.unnamed$$_2: started at 165ns failed at 165ns
	Offending '$onehot(state)'
Error: "testbench.sv", 49: tb_top.unnamed$$_2: at time 165 ns
FAILED: State is not one-hot at TIME=165 with state=00000
PASSED: Grant is one-hot at TIME=165 with grant=00001
"testbench.sv", 49: tb_top.unnamed$$_2: started at 175ns failed at 175ns
	Offending '$onehot(state)'
Error: "testbench.sv", 49: tb_top.unnamed$$_2: at time 175 ns
FAILED: State is not one-hot at TIME=175 with state=00000
PASSED: Grant is one-hot at TIME=175 with grant=00010
"testbench.sv", 49: tb_top.unnamed$$_2: started at 185ns failed at 185ns
	Offending '$onehot(state)'
Error: "testbench.sv", 49: tb_top.unnamed$$_2: at time 185 ns
FAILED: State is not one-hot at TIME=185 with state=00000
PASSED: Grant is one-hot at TIME=185 with grant=00100
"testbench.sv", 49: tb_top.unnamed$$_2: started at 195ns failed at 195ns
	Offending '$onehot(state)'
Error: "testbench.sv", 49: tb_top.unnamed$$_2: at time 195 ns
FAILED: State is not one-hot at TIME=195 with state=00000
PASSED: Grant is one-hot at TIME=195 with grant=01000
"testbench.sv", 49: tb_top.unnamed$$_2: started at 205ns failed at 205ns
	Offending '$onehot(state)'
Error: "testbench.sv", 49: tb_top.unnamed$$_2: at time 205 ns
FAILED: State is not one-hot at TIME=205 with state=00000
PASSED: Grant is one-hot at TIME=205 with grant=10000
"testbench.sv", 49: tb_top.unnamed$$_2: started at 215ns failed at 215ns
	Offending '$onehot(state)'
Error: "testbench.sv", 49: tb_top.unnamed$$_2: at time 215 ns
FAILED: State is not one-hot at TIME=215 with state=00000
PASSED: Grant is one-hot at TIME=215 with grant=11000
$finish called from file "testbench.sv", line 40.
$finish at simulation time                  225
           V C S   S i m u l a t i o n   R e p o r t 
Time: 225 ns
CPU Time:      0.450 seconds;       Data structure size:   0.0Mb
Fri May 23 01:37:54 2025
Done    
