//Q32. Write an assertion checker to make sure that an output signal never goes X.

module tb_top;
  logic clk;
  logic rst;
  logic [7:0] input_signal;   // input signal
  logic output_signal;        // DUT output signal under test
  
  always #5 clk = ~clk;

  // Stimulus generation
  initial begin
    clk = 0;
    rst = 1;
    input_signal = 8'h00;

    #10 rst = 0;

    // Apply stimulus combinations
    input_signal = 8'hAA;  #10;
    input_signal = 8'h55;  #10;
    input_signal = 8'hFF;  #10;
    input_signal = 8'h00;  #10;

    // Introduce undefined (X) to test robustness
    input_signal = 8'hxx;  #10;

    $finish;
  end
  
  // Temporary mock logic to simulate output
  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      output_signal <= 0;
    else
      output_signal <= input_signal; // Just example logic
  end
  
  // === PROPERTY: Output must never be X ===
  property output_never_x;
    @(posedge clk) 
    disable iff (rst)
      !$isunknown(output_signal);
  endproperty
    
  P1: assert property (output_never_x) 
    begin      
      $display("PASSED: output_signal didnot went to X at time %0t", $time);
    end
  else
    begin      
      $error("FAILED: output_signal went to X at time %0t", $time);
    end

  initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end

endmodule

//Logfile output
[2025-05-15 11:04:36 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu May 15 07:04:37 2025

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
CPU time: .433 seconds to compile + .374 seconds to elab + .352 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 15 07:04 2025
PASSED: output_signal didnot went to X at time 15
PASSED: output_signal didnot went to X at time 25
PASSED: output_signal didnot went to X at time 35
PASSED: output_signal didnot went to X at time 45
PASSED: output_signal didnot went to X at time 55
$finish called from file "testbench.sv", line 31.
$finish at simulation time                   60
           V C S   S i m u l a t i o n   R e p o r t 
Time: 60 ns
CPU Time:      0.440 seconds;       Data structure size:   0.0Mb
Thu May 15 07:04:39 2025
Done    
