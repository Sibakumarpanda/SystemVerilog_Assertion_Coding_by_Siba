//Q10. Write an assertion to make sure that the state variable in a state machine is always one hot value.
module test_one_hot_state_machine;

  logic clk;
  logic reset;
  logic [3:0] state; // 4-bit state variable

  // State encoding for a simple state machine (one-hot encoding)
  typedef enum logic [3:0] {
    S0 = 4'b0001,
    S1 = 4'b0010,
    S2 = 4'b0100,
    S3 = 4'b1000
  } state_t;

  state_t current_state, next_state;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Reset logic
  initial begin
    reset = 0;
    #3 reset = 1; // reset after 3ns
    #5 reset = 0; // deassert reset
  end

  // Simple state machine logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset)
      current_state <= S0; // Reset state to S0
    else
      current_state <= next_state;
  end

  always_comb begin
    case (current_state)
      S0: next_state = S1; // Go to S1
      S1: next_state = S2; // Go to S2
      S2: next_state = S3; // Go to S3
      S3: next_state = S0; // Go to S0
      default: next_state = S0; // Default to S0
    endcase
  end

  // Assertion to ensure one-hot encoding of the state
  property one_hot_state;
    @(posedge clk)
    (current_state != 0) && (current_state & (current_state - 1)) == 0;
  endproperty

  assert_one_hot: assert property (one_hot_state)
    $display("PASSED: State is one-hot at time %0t", $time);
  else
    $error("FAILED: State is not one-hot at time %0t", $time);
    
  // Stop the simulation after 200ns (or after some clock cycles)
  initial begin
    #200 $finish; // Stop after 50ns (5 clock cycles)
  end  

  // For waveform generation
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end
endmodule
    
//Log file output
[2025-05-07 05:41:34 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May  7 01:41:34 2025

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
       test_one_hot_state_machine
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module test_one_hot_state_machine
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _332_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .254 seconds to compile + .221 seconds to elab + .209 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  7 01:41 2025
PASSED: State is one-hot at time 5
PASSED: State is one-hot at time 15
PASSED: State is one-hot at time 25
PASSED: State is one-hot at time 35
PASSED: State is one-hot at time 45
PASSED: State is one-hot at time 55
PASSED: State is one-hot at time 65
PASSED: State is one-hot at time 75
PASSED: State is one-hot at time 85
PASSED: State is one-hot at time 95
PASSED: State is one-hot at time 105
PASSED: State is one-hot at time 115
PASSED: State is one-hot at time 125
PASSED: State is one-hot at time 135
PASSED: State is one-hot at time 145
PASSED: State is one-hot at time 155
PASSED: State is one-hot at time 165
PASSED: State is one-hot at time 175
PASSED: State is one-hot at time 185
PASSED: State is one-hot at time 195
$finish called from file "testbench.sv", line 63.
$finish at simulation time                  200
           V C S   S i m u l a t i o n   R e p o r t 
Time: 200 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Wed May  7 01:41:35 2025
Done
    
