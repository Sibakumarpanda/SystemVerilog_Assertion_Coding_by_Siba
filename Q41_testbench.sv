//Q41. When signal_a is asserted, signal_b must be asserted and must remain up until one of the signals signal_c or signal_d is asserted

module tb_top;
  // Declare signals
  reg clk, reset;
  reg signal_a, signal_b, signal_c, signal_d;
 
  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin
    reset = 1;
    signal_a = 0;
    signal_b = 0;
    signal_c = 0;
    signal_d = 0;

    #10 reset = 0;

    // Valid scenario
    #10 signal_a = 1; signal_b = 1;
    #10 signal_a = 0;
    #10 signal_b = 1;
    #10 signal_c = 1;  // Ends the requirement

    // Reset all
    #10 signal_c = 0; signal_b = 0;

    // Invalid scenario: signal_b drops before signal_c or signal_d is high
    #10 signal_a = 1; signal_b = 1;
    #10 signal_a = 0;
    #10 signal_b = 0;  // Violation: signal_b deasserted before signal_c or signal_d
    #10 signal_d = 1;
    #30 $finish;
  end

  // Property: signal_b must be high when signal_a is asserted and stay high until signal_c or signal_d is asserted
  property b_holds_after_a_until_c_or_d;
    @(posedge clk)
    disable iff (reset)
    //signal_a |=> (signal_b throughout (!signal_c && !signal_d)[*0:$]);
    signal_a |=> signal_b and (signal_b throughout (!signal_c && !signal_d)[*1:$]);
  endproperty
    
  P1:assert property (b_holds_after_a_until_c_or_d)   
    $display("PASSED at TIME=%0d signal_b stay high after signal_a until signal_c or signal_d was asserted",$time );    
  else      
    $error("FAILED at TIME=%0d signal_b did not stay high after signal_a until signal_c or signal_d was asserted",$time );   

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end        
endmodule

//Logfile Output
[2025-05-17 05:37:14 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat May 17 01:37:15 2025

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
CPU time: .248 seconds to compile + .228 seconds to elab + .199 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 17 01:37 2025
PASSED at TIME=35 signal_b stay high after signal_a until signal_c or signal_d was asserted
PASSED at TIME=85 signal_b stay high after signal_a until signal_c or signal_d was asserted
$finish called from file "testbench.sv", line 38.
$finish at simulation time                  130
           V C S   S i m u l a t i o n   R e p o r t 
Time: 130 ns
CPU Time:      0.240 seconds;       Data structure size:   0.0Mb
Sat May 17 01:37:16 2025
Done
    
