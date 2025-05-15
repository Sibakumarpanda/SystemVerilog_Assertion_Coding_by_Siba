//Q35. Write an assertion which checks that once a valid request is asserted by the master, the arbiter provides a grant within 2 to 5 clock cycles
module tb_top;
  reg req;       // Master request signal
  reg grant;     // Arbiter grant signal
  reg clk;       // Clock signal
  
  initial begin   
    clk = 0;
    req = 0;
    grant = 0;

    // Apply stimulus combinations
    #5 req = 1; grant = 0;  // Request asserted, grant not yet given
    #3 grant = 1;           // Grant asserted after 3 clock cycles
    #7 req = 0; grant = 0;  // Request deasserted
    #10 req = 1; grant = 0; // Request asserted again
    #4 grant = 1;           // Grant asserted after 4 clock cycles
    #15 req = 0; grant = 0; // Request deasserted again
    #20 req = 1; grant = 0; // Request asserted again
    #6 grant = 1;           // Grant asserted after 6 clock cycles (invalid scenario)
    #25 $finish;
  end

  always begin
    #5 clk = ~clk;  // Clock period of 10 time units
  end    
  property req_grant_signal_check;
    @(posedge clk) 
    disable iff (!req) 
    //(req == 1'b1) |->  (grant == 1'b1 && ($time - $past(grant)) >= 2 && ($time - $past(grant)) <= 5); // Grant is within 2 to 5 clock cycles
    //$rose(req) |-> ##[2:5] $rose(grant);
    (req == 1'b1) |->  ##[2:5] (grant== 1'b1);
  endproperty
    
  P1: assert property (req_grant_signal_check) 
    begin      
      $display("PASSED: once a valid request is asserted by the master, the arbiter provides a grant within 2 to 5 clock cycles at time %0t", $time);
    end
  else
    begin      
      $error("FAILED: once a valid request is asserted by the master, the arbiter not provides a grant within 2 to 5 clock cycles at time %0t", $time);
    end

  initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end
endmodule

//Logfile Output
[2025-05-15 11:40:16 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu May 15 07:40:18 2025

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
CPU time: .379 seconds to compile + .349 seconds to elab + .351 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 15 07:40 2025
PASSED: once a valid request is asserted by the master, the arbiter provides a grant within 2 to 5 clock cycles at time 85
$finish called from file "testbench.sv", line 26.
$finish at simulation time                   95
           V C S   S i m u l a t i o n   R e p o r t 
Time: 95 ns
CPU Time:      0.370 seconds;       Data structure size:   0.0Mb
Thu May 15 07:40:19 2025
Done
    
