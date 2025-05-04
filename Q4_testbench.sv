//4. If the signal “a” change from a value of 0/x/z to 1 between two positive edges of clock, then $rose(a) will evaluate true.
module check_rose_a_example;
  logic clk;
  logic a;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10 time units clock period
  end

  // Test sequence
  initial begin
    // Initialize 'a' to x
    a = 'x;
    #10;  // Wait for one clock cycle

    // Test transition from x to 1
    a = 1;
    #10;  // Wait for one clock cycle

    // Test transition from 0 to 1
    a = 0;
    #10;  // Wait for one clock cycle
    a = 1;
    #10;  // Wait for one clock cycle

    // Test transition from z to 1
    a = 'z;
    #10;  // Wait for one clock cycle
    a = 1;
    #10;  // Wait for one clock cycle

    // Test no transition (1 to 1)
    a = 1;
    #10;  // Wait for one clock cycle

    // Test transition from 0 to 0
    a = 0;
    #10;  // Wait for one clock cycle

    $finish;
  end
  
 // Property to check if 'a' rose from 0/x/z to 1
  property a_rose_from_0_x_z_to_1;
    @(posedge clk) 
    $rose(a);
  endproperty
  
 P1:assert property (a_rose_from_0_x_z_to_1)   
   $display("PASSED at TIME=%0d with a=%0b ",$time ,a);    
  else      
    $error("FAILED at TIME=%0d with a=%0b ",$time ,a);

  initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end  
endmodule
// Log file output
[2025-05-04 09:23:18 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sun May  4 05:23:19 2025

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
       check_rose_a_example
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module check_rose_a_example
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .358 seconds to compile + .357 seconds to elab + .328 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  4 05:23 2025
"testbench.sv", 53: check_rose_a_example.P1: started at 5ns failed at 5ns
	Offending '$rose(a)'
Error: "testbench.sv", 53: check_rose_a_example.P1: at time 5 ns
FAILED at TIME=5 with a=x 
PASSED at TIME=15 with a=1 
"testbench.sv", 53: check_rose_a_example.P1: started at 25ns failed at 25ns
	Offending '$rose(a)'
Error: "testbench.sv", 53: check_rose_a_example.P1: at time 25 ns
FAILED at TIME=25 with a=0 
PASSED at TIME=35 with a=1 
"testbench.sv", 53: check_rose_a_example.P1: started at 45ns failed at 45ns
	Offending '$rose(a)'
Error: "testbench.sv", 53: check_rose_a_example.P1: at time 45 ns
FAILED at TIME=45 with a=z 
PASSED at TIME=55 with a=1 
"testbench.sv", 53: check_rose_a_example.P1: started at 65ns failed at 65ns
	Offending '$rose(a)'
Error: "testbench.sv", 53: check_rose_a_example.P1: at time 65 ns
FAILED at TIME=65 with a=1 
"testbench.sv", 53: check_rose_a_example.P1: started at 75ns failed at 75ns
	Offending '$rose(a)'
Error: "testbench.sv", 53: check_rose_a_example.P1: at time 75 ns
FAILED at TIME=75 with a=0 
$finish called from file "testbench.sv", line 43.
$finish at simulation time                   80
           V C S   S i m u l a t i o n   R e p o r t 
Time: 80 ns
CPU Time:      0.340 seconds;       Data structure size:   0.0Mb
Sun May  4 05:23:21 2025
Finding VCD file...
./waveform.vcd
[2025-05-04 09:23:21 UTC] Opening EPWave...
Done
   
   
