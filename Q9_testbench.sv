//Q9. Write an assertion checker to make sure that an output signal(mysignal) never goes X?
module test_mysignal_check;
  logic clk;
  //logic [0:0] mysignal; // 1-bit signal
  logic mysignal; // 1-bit signal

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus with valid and invalid (X) values
  initial begin
    #3  mysignal = 0;
    #10 mysignal = 1;
    #10 mysignal = 1'bx;  // This will trigger the assertion
    #10 mysignal = 0;
    #10 mysignal = 1'bz;  // This will trigger the assertion
    #10 $finish;
  end

  // Assertion to check that mysignal is never X or Z
  property never_unknown;
    @(posedge clk)
    !$isunknown(mysignal); // passes if signal is 0 or 1 and Fails if signal is x
  endproperty

  check_mysignal: assert property (never_unknown)
    $display("PASSED: mysignal = %b at time %0t", mysignal, $time);
  else
    $error("FAILED: mysignal = %b , mysignal is X or Z at time %0t",mysignal, $time);

  // For waveform generation
  initial begin
    //$dumpfile("mysignal.vcd");
    //$dumpvars(0, test_mysignal_check); // Like this also we can write
    $dumpfile("waveform.vcd");
    $dumpvars();
  end

endmodule

//Log file output    
[2025-05-07 05:07:34 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Wed May  7 01:07:35 2025

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
       test_mysignal_check
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module test_mysignal_check
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .249 seconds to compile + .226 seconds to elab + .199 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  7 01:07 2025
PASSED: mysignal = 0 at time 5
PASSED: mysignal = 1 at time 15
"testbench.sv", 32: test_mysignal_check.check_mysignal: started at 25ns failed at 25ns
	Offending '(!$isunknown(mysignal))'
Error: "testbench.sv", 32: test_mysignal_check.check_mysignal: at time 25 ns
FAILED: mysignal = x , mysignal is X or Z at time 25
PASSED: mysignal = 0 at time 35
"testbench.sv", 32: test_mysignal_check.check_mysignal: started at 45ns failed at 45ns
	Offending '(!$isunknown(mysignal))'
Error: "testbench.sv", 32: test_mysignal_check.check_mysignal: at time 45 ns
FAILED: mysignal = z , mysignal is X or Z at time 45
$finish called from file "testbench.sv", line 22.
$finish at simulation time                   53
           V C S   S i m u l a t i o n   R e p o r t 
Time: 53 ns
CPU Time:      0.280 seconds;       Data structure size:   0.0Mb
Wed May  7 01:07:36 2025
Done
    
