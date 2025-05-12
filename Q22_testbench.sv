//Q22. Write an assertion to make sure FSM does not get stuck in current State except 'IDLE'
typedef enum logic [2:0] {
  IDLE,
  STATE_A,
  STATE_B,
  STATE_C
} fsm_state_t;

fsm_state_t current_state;

module tb_top;  
  logic clk;
  logic rst_n;
  fsm_state_t current_state;

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset logic
  initial begin
    rst_n = 0;
    #10 rst_n = 1;
  end
  
   // Test stimulus covering all transitions
  initial begin
    @(posedge rst_n);
    repeat (2) @(posedge clk);

    // State sequence: IDLE -> A -> A -> A -> A (should trigger assertion)
    current_state = IDLE; @(posedge clk);
    current_state = STATE_A; @(posedge clk);
    current_state = STATE_A; @(posedge clk);
    current_state = STATE_A; @(posedge clk);
    current_state = STATE_A; @(posedge clk);  // <-- assertion should fire here

    // IDLE case — allowed to stay in IDLE
    current_state = IDLE;
    repeat (10) @(posedge clk);  // No assertion error

    // State sequence: B -> C -> A (should pass)
    current_state = STATE_B; @(posedge clk);
    current_state = STATE_B; @(posedge clk);
    current_state = STATE_C; @(posedge clk);
    current_state = STATE_A; @(posedge clk);

    $display("Test complete.");
    $finish;
  end

  // Assertion: FSM must not be stuck in a state (except IDLE) for more than 3 cycles
  property fsm_not_stuck;
    int stuck_count;
    @(posedge clk)
    disable iff (!rst_n)
    (current_state != IDLE) |-> ##1
      (current_state == $past(current_state) && current_state != IDLE) [*3] ##1
      (current_state != $past(current_state));
  endproperty
    
  P1:assert property (fsm_not_stuck)    
    $info ("PASSED: FSM Not stuck in state %0d for more than 3 cycles  at TIME=%0d ",current_state,$realtime);    
   else    
     $error("FAILED: FSM got stuck in state %0d for more than 3 cycles at TIME=%0d ",current_state,$realtime);   

  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end 
endmodule

//Logfile output
[2025-05-12 06:37:50 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Mon May 12 02:37:51 2025

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
CPU time: .334 seconds to compile + .266 seconds to elab + .276 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 12 02:37 2025
"testbench.sv", 66: tb_top.P1: started at 75ns failed at 85ns
	Offending '((current_state == $past(current_state)) && (current_state != IDLE))'
Error: "testbench.sv", 66: tb_top.P1: at time 85 ns
FAILED: FSM got stuck in state 0 for more than 3 cycles at TIME=85 
"testbench.sv", 66: tb_top.P1: started at 65ns failed at 85ns
	Offending '((current_state == $past(current_state)) && (current_state != IDLE))'
Error: "testbench.sv", 66: tb_top.P1: at time 85 ns
FAILED: FSM got stuck in state 0 for more than 3 cycles at TIME=85 
"testbench.sv", 66: tb_top.P1: started at 55ns failed at 85ns
	Offending '((current_state == $past(current_state)) && (current_state != IDLE))'
Error: "testbench.sv", 66: tb_top.P1: at time 85 ns
FAILED: FSM got stuck in state 0 for more than 3 cycles at TIME=85 
Info: "testbench.sv", 66: tb_top.P1: at time 85 ns
PASSED: FSM Not stuck in state 0 for more than 3 cycles  at TIME=85 
"testbench.sv", 66: tb_top.P1: started at 195ns failed at 205ns
	Offending '((current_state == $past(current_state)) && (current_state != IDLE))'
Error: "testbench.sv", 66: tb_top.P1: at time 205 ns
FAILED: FSM got stuck in state 1 for more than 3 cycles at TIME=205 
"testbench.sv", 66: tb_top.P1: started at 185ns failed at 205ns
	Offending '((current_state == $past(current_state)) && (current_state != IDLE))'
Error: "testbench.sv", 66: tb_top.P1: at time 205 ns
FAILED: FSM got stuck in state 1 for more than 3 cycles at TIME=205 
Test complete.
$finish called from file "testbench.sv", line 53.
$finish at simulation time                  215
           V C S   S i m u l a t i o n   R e p o r t 
Time: 215 ns
CPU Time:      0.310 seconds;       Data structure size:   0.0Mb
Mon May 12 02:37:52 2025
Done
    
    
    

