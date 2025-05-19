//Q50. If signal_a is active, then signal_b was active 3 cycles ago.
//means , If signal_a is active at any given clock cycle, we must check whether signal_b was active 3 cycles earlier.
module tb_top;  
  logic clk;
  logic rst_n;
  logic signal_a;
  logic signal_b;
 
  always #5 clk = ~clk; // 10ns period, 100 MHz clock
  // Reset logic
  initial begin
    clk = 0;
    rst_n = 0;
    #10 rst_n = 1; // Release reset after 10ns
  end

  // Stimulus generation 
  initial begin
    signal_a = 0; signal_b = 0;

    // Case 1: signal_a is high, signal_b was high 3 cycles ago
    #20 signal_a = 1; signal_b = 1; // signal_b active 3 cycles ago
    #10 signal_a = 0; signal_b = 0; // signal_a and signal_b go low

    // Case 2: signal_a is high, but signal_b was not high 3 cycles ago (this should fail)
    #20 signal_a = 1; signal_b = 0; // signal_b was low 3 cycles ago
    #10 signal_a = 0; signal_b = 0; // signal_a and signal_b go low

    #20 $finish;
  end

  // Property: if signal_a is active, then signal_b was active 3 cycles ago
  property signal_b_was_active_3_cycles_ago;
    @(posedge clk)
    disable iff (!rst_n)
    //signal_a |-> ##3 signal_b; // signal_b must be high 3 cycles ago when signal_a is high
    
    signal_a |-> $past (signal_b==1,3);
  endproperty
  
  A_signal_check: assert property (signal_b_was_active_3_cycles_ago)
    $display("PASSED at time %0t: signal_a active, signal_b was active 3 cycles ago", $time);
  else
    $error("FAILED at time %0t: signal_a active, but signal_b was not active 3 cycles ago", $time);

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end
endmodule

//Logfile Output
[2025-05-19 07:28:53 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Mon May 19 03:28:54 2025

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
CPU time: .425 seconds to compile + .410 seconds to elab + .439 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 19 03:28 2025
"testbench.sv", 49: tb_top.A_signal_check: started at 25ns failed at 25ns
	Offending '$past((signal_b == 1), 3)'
Error: "testbench.sv", 49: tb_top.A_signal_check: at time 25 ns
FAILED at time 25: signal_a active, but signal_b was not active 3 cycles ago
PASSED at time 55: signal_a active, signal_b was active 3 cycles ago
$finish called from file "testbench.sv", line 36.
$finish at simulation time                   80
           V C S   S i m u l a t i o n   R e p o r t 
Time: 80 ns
CPU Time:      0.450 seconds;       Data structure size:   0.0Mb
Mon May 19 03:28:56 2025
Done    
    
