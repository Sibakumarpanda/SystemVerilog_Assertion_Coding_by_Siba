//Q16. Write a property/assertion to check if signal "a" is toggling.

module tb_top;
  // Declare signal 'a'
  logic clk;
  logic rst_n;
  logic a;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus for signal 'a'
  initial begin
    rst_n = 0;
    a = 0;    
    
    #10 rst_n = 1; //10
    
    // Toggling pattern
    #10 a = 1; //20
    #10 a = 0; 
    #10 a = 1;
    #10 a = 0;
    #10 a = 1;
    #10 $finish;
  end

  // Assertion to check toggling
  // This checks that 'a' eventually toggles value on rising edge of clk
  property a_toggles;
    @(posedge clk) 
    disable iff (!rst_n)
      $rose(a) or $fell(a); // signal should either rise or fall
  endproperty

  // You can use either an assertion or a cover (or both)
  assert property (a_toggles) 
    begin      
      $display("PASSED: Signal 'a' is Toggling at time %0t", $time);
    end
  else
    begin      
      $error("FAILED: Signal 'a' is Not Toggling  at time %0t", $time);
    end
    
 initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end
endmodule

//Log file output
[2025-05-09 02:43:04 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu May  8 22:43:05 2025

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
CPU time: .420 seconds to compile + .360 seconds to elab + .372 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  8 22:43 2025
"testbench.sv", 42: tb_top.unnamed$$_4: started at 15ns failed at 15ns
	Offending '$fell(a)'
Error: "testbench.sv", 42: tb_top.unnamed$$_4: at time 15 ns
FAILED: Signal 'a' is Not Toggling  at time 15
PASSED: Signal 'a' is Toggling at time 25
PASSED: Signal 'a' is Toggling at time 35
PASSED: Signal 'a' is Toggling at time 45
PASSED: Signal 'a' is Toggling at time 55
PASSED: Signal 'a' is Toggling at time 65
$finish called from file "testbench.sv", line 30.
$finish at simulation time                   70
           V C S   S i m u l a t i o n   R e p o r t 
Time: 70 ns
CPU Time:      0.420 seconds;       Data structure size:   0.0Mb
Thu May  8 22:43:06 2025    
