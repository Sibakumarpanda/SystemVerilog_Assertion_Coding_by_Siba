//Q48. The active-low reset must be low for at least 6 clock cycles.WAA for this

module tb_top;  
  logic clk;
  logic rst_n;
 
  always #5 clk = ~clk;  // 10ns period, 100 MHz clock
  
  // Reset logic: active-low reset
  initial begin
    clk = 0;
    rst_n = 1;  // Initially, reset is de-asserted (high)
    #5  rst_n = 0; // Assert reset low at time 5ns
    #50 rst_n = 1; // Deassert reset after 50ns (long enough for 6 cycles)
  end
  
  // Stimulus generation for simulation (optional)
  initial begin
    #100; // Wait for reset behavior
    $finish;
  end
        
  property reset_duration_check;
    @(posedge clk)
      disable iff (rst_n == 1'b1) // Only check when reset is active (low)
     // (rst_n == 1'b0) |-> ##[6:$] (rst_n == 1'b0); // Reset must stay low for 6 or more cycles
    $fell(rst_n) |=> rst_n[*6];
  endproperty
        
  P1:assert property (reset_duration_check)   
    $display("PASSED at TIME=%0d : Reset Held low for at least 6 clock cycles!",$time);    
  else      
    $error("FAILED at TIME=%0d : Reset was not held low for at least 6 clock cycles!",$time); 
        
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end   
    
  // Add a monitor to debug the value of rst_n
  initial begin
    $monitor("At time=%0t, rst_n=%0b", $time, rst_n);
  end  
endmodule

//Logfile Output
[2025-05-19 07:25:06 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Mon May 19 03:25:07 2025

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
CPU time: .448 seconds to compile + .360 seconds to elab + .412 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 19 03:25 2025
At time=0, rst_n=1
At time=5, rst_n=0
"testbench.sv", 33: tb_top.P1: started at 15ns failed at 25ns
	Offending 'rst_n'
Error: "testbench.sv", 33: tb_top.P1: at time 25 ns
FAILED at TIME=25 : Reset was not held low for at least 6 clock cycles!
At time=55, rst_n=1
$finish called from file "testbench.sv", line 22.
$finish at simulation time                  100
           V C S   S i m u l a t i o n   R e p o r t 
Time: 100 ns
CPU Time:      0.430 seconds;       Data structure size:   0.0Mb
Mon May 19 03:25:09 2025
Done
    
    
