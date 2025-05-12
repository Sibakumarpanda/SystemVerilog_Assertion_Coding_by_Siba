//Q25. If there's an uncorrectable err during an ADD request, err_cnt should be incremented in the same cycle and an interrupt should be flagged in the next cycle
module tb_top;
  logic clk;
  logic rst_n;
  logic uncorr_err;
  logic is_add_req;
  logic interrupt;
  int err_cnt;

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset logic
  initial begin
    rst_n = 0;
    #12 rst_n = 1;
  end

  // === Property: Error counter must increment same cycle, interrupt next cycle ===
  property err_handling;
    int prev_err_cnt;
    @(posedge clk)
    disable iff (!rst_n)
    (uncorr_err && is_add_req, prev_err_cnt = err_cnt) |=> (err_cnt == prev_err_cnt + 1) ##1 (interrupt);
  endproperty
    
   P1:assert property (err_handling)    
     $info ("PASSED: Error handling assertion Passed at time %0t ",$realtime);    
   else    
     $error("FAILED: Error handling assertion Failed at time %0t ",$realtime);   

  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end    
    
  // === Stimulus ===
  initial begin
    uncorr_err = 0;
    is_add_req = 0;
    err_cnt = 0;
    interrupt = 0;

    @(posedge rst_n);
    @(posedge clk);

    // Valid Case: ADD + uncorr_err -> err_cnt++, interrupt next cycle
    @(posedge clk);
    is_add_req = 1;
    uncorr_err = 1;

    @(posedge clk); // same cycle: err_cnt++
    is_add_req = 0;
    uncorr_err = 0;
    interrupt = 1;

    @(posedge clk); // reset interrupt
    interrupt = 0;

    // Invalid Case: ADD + uncorr_err but interrupt delayed (should fail)
    @(posedge clk);
    is_add_req = 1;
    uncorr_err = 1;

    @(posedge clk); // err_cnt++ OK, but no interrupt
    is_add_req = 0;
    uncorr_err = 0;
    interrupt = 0; // <-- assertion should fail here

    @(posedge clk); // interrupt comes late
    interrupt = 1;

    $display("Simulation complete.");
    $finish;
  end
endmodule

//Logfile Output
[2025-05-12 06:43:24 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Mon May 12 02:43:25 2025

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
CPU time: .344 seconds to compile + .276 seconds to elab + .292 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 12 02:43 2025
"testbench.sv", 31: tb_top.P1: started at 35ns failed at 45ns
	Offending '(err_cnt == (prev_err_cnt + 1))'
Error: "testbench.sv", 31: tb_top.P1: at time 45 ns
FAILED: Error handling assertion Failed at time 45 
Simulation complete.
$finish called from file "testbench.sv", line 79.
$finish at simulation time                   75
           V C S   S i m u l a t i o n   R e p o r t 
Time: 75 ns
CPU Time:      0.320 seconds;       Data structure size:   0.0Mb
Mon May 12 02:43:27 2025
Done     
     
