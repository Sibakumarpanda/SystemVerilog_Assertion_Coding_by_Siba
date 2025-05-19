//49. Enable must remain true throughout the entire ack to done sequence. WAA for this.
//Means , When ack is asserted, enable must remain 1 until done is asserted.

module tb_top;
  logic clk, rst_n;
  logic ack, done, enable;
 
  always #5 clk = ~clk;
  // Reset logic
  initial begin
    clk = 0;
    rst_n = 0;
    #12 rst_n = 1;
  end

  // Stimulus generation (includes multiple test scenarios)
  initial begin
    enable = 1; ack = 0; done = 0;

    // Case 1: enable remains high — should pass
    #20 ack = 1;
    #10 done = 1;
    #10 ack = 0; done = 0;

    // Case 2: enable goes low before done — should fail
    #20 ack = 1;
    #5 enable = 0;  // Illegal: enable goes low before done
    #5 done = 1;
    #10 ack = 0; done = 0; enable = 1;    
    #20 $finish;
  end

  // Property: enable must remain high between ack and done
  property enable_during_ack_to_done;
    @(posedge clk)
      disable iff (!rst_n)
      ack |=> (!done)[*0:$] ##1 done |-> enable throughout (!done);
  endproperty
 
  A_enable_hold: assert property (enable_during_ack_to_done)
    $display("PASSED at time %0t: enable held during ack to done", $time);
  else
    $error("FAILED at time %0t: enable dropped before done after ack", $time);

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end

endmodule

//Logfile Output
[2025-05-19 07:27:16 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Mon May 19 03:27:18 2025

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
CPU time: .439 seconds to compile + .346 seconds to elab + .381 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 19 03:27 2025
"testbench.sv", 46: tb_top.A_enable_hold: started at 25ns failed at 35ns
	Offending '(!done)'
Error: "testbench.sv", 46: tb_top.A_enable_hold: at time 35 ns
FAILED at time 35: enable dropped before done after ack
"testbench.sv", 46: tb_top.A_enable_hold: started at 65ns failed at 75ns
	Offending 'enable'
Error: "testbench.sv", 46: tb_top.A_enable_hold: at time 75 ns
FAILED at time 75: enable dropped before done after ack
"testbench.sv", 46: tb_top.A_enable_hold: started at 35ns failed at 75ns
	Offending 'enable'
Error: "testbench.sv", 46: tb_top.A_enable_hold: at time 75 ns
FAILED at time 75: enable dropped before done after ack
$finish called from file "testbench.sv", line 35.
$finish at simulation time                  100
           V C S   S i m u l a t i o n   R e p o r t 
Time: 100 ns
CPU Time:      0.450 seconds;       Data structure size:   0.0Mb
Mon May 19 03:27:19 2025
Done
    
    
