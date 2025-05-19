//Q46. Request must true at the current cycle,grant must become true sometime between 1 cycle after request and the end of time.

/*Request must be true during the current cycle.
  Grant must become true sometime between 1 cycle after the request and the end of time.
*/

module tb_top;    
  logic request;
  logic grant;
  logic clk;
  logic rst_n;

  initial clk=0;
  always #5 clk = ~clk;  // Example clock generation, 10ns period
  
  // Stimulus generation
  initial begin
    
    rst_n = 0;
    #10 rst_n = 1; // Reset release after 10ns    
    request = 0; grant = 0;    
    #15 request = 1; grant = 0;    
    #15 grant = 0;
    #15 grant = 0;        
    #10 request = 1; grant = 1; // This will pass as grant became 1
    #10 request = 1; grant = 0;
    #5  grant = 1;              // This satisfies the condition (grant became 1 in time)
    #10 request = 0; grant = 0;
    #20 $finish;
  end
   
  // Assume that request and grant are driven by your design under test (DUT)
  // Request must be true at current cycle, Grant must be true in the next cycle after request or any subsequent cycle until the end of time.
  // Assertion: whenever request is high, grant must be high at some point in the future
  
  property grant_within_acceptable_time;
    @(posedge clk)
    disable iff (!rst_n) 
    (request == 1'b1) |-> ##[1:$] (grant == 1'b1);
  endproperty
        
  P1:assert property (grant_within_acceptable_time)   
    $display("PASSED at TIME=%0d : Grant high within acceptable time after request",$time);    
  else      
    $error("FAILED at TIME=%0d : Grant not high within acceptable time after request",$time);   
    
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end         
endmodule

//Logfile Output
[2025-05-19 07:20:24 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Mon May 19 03:20:25 2025

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
CPU time: .372 seconds to compile + .360 seconds to elab + .348 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 19 03:20 2025
$finish called from file "testbench.sv", line 38.
$finish at simulation time                  110
           V C S   S i m u l a t i o n   R e p o r t 
Time: 110 ns
CPU Time:      0.400 seconds;       Data structure size:   0.0Mb
Mon May 19 03:20:27 2025
Finding VCD file...
./waveform.vcd
[2025-05-19 07:20:27 UTC] Opening EPWave...
Done
    
