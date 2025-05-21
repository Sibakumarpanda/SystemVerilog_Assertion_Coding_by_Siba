//Q51. If the state machine reaches active1 state, it will eventually reach active2 state

module tb_top;

  reg clk;
  reg reset;
  reg input_1, input_2;
  
  logic [1:0] state;

  // Define state enum
  typedef enum logic [1:0] {
    idle    = 2'b00,
    active1 = 2'b01,
    active2 = 2'b10,
    other   = 2'b11
  } state_t;

  // State machine
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= idle;
    end else begin
      case (state)
        idle:    state <= input_1 ? active1 : idle;
        active1: state <= input_2 ? active2 : active1;
        active2: state <= active2;
        default: state <= idle;
      endcase
    end
  end

  // Property and Assertion
  property active1_to_active2;
    @(posedge clk)
    disable iff (reset)
    state == active1 |-> ##[1:$] state == active2;
  endproperty

  assert property (active1_to_active2)
    else $fatal(1, "Assertion failed: active1 did not eventually reach active2");
  
  always #5 clk = ~clk;

  // Testbench Stimulus
  initial begin
    clk = 0;
    reset = 1;
    input_1 = 0;
    input_2 = 0;

    #10 reset = 0;
    #10 input_1 = 1;  // Go to active1
    #10 input_2 = 1;  // Go to active2
    #10 input_1 = 0;
    #10 input_2 = 0;
    #50 $finish;
  end
endmodule

//Logfile output
[2025-05-21 04:01:31 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May 21 00:01:32 2025

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
CPU time: .433 seconds to compile + .575 seconds to elab + .414 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 21 00:01 2025
$finish called from file "testbench.sv", line 63.
$finish at simulation time                  100
           V C S   S i m u l a t i o n   R e p o r t 
Time: 100 ns
CPU Time:      0.430 seconds;       Data structure size:   0.0Mb
Wed May 21 00:01:34 2025
Done
    
