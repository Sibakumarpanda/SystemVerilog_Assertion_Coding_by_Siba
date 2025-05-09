/* NOTE:
Detecting a glitch on a signal means identifying if a signal changes value momentarily and 
then returns to its original value too quickly—typically in less than a clock period, or without synchronization to a clock edge.

SystemVerilog assertions (SVA) are clocked, so glitches that occur within a clock cycle can be tricky to detect unless your testbench runs at a high frequency 
or you simulate with delta cycles (zero-delay transitions). 
One way to catch glitches is to use multiple sampling points or detect a value change that doesn’t persist.
  
In this example testbench that uses a sampled version of a signal to detect if the signal changes for only one cycle and returns to its original value (i.e., a 1-cycle pulse/glitch):
    
    
The property checks if:

signal is different from its previous value ($past(signal)) → it changed;

but it's the same as two cycles ago ($past(signal,2)) → it returned to its original state;

This pattern indicates a 1-cycle pulse, often considered a glitch.

glitch_detected is a runtime flag you could monitor in waveform.

Would you like to detect glitches that are shorter than one clock cycle using a more advanced method like event sampling or time-based checks? (detecting glitches shorter than one clock cycle,)

let's dive into detecting glitches shorter than one clock cycle, which are often caused by asynchronous logic or combinational hazards. 
Since traditional SystemVerilog assertions are clocked, they typically won't catch sub-cycle (combinational) glitches directly. However, you can approach this in two ways:


2. Use a Fast Clock in Assertion Logic (Glitch Detection via Oversampling)
If you're constrained to use assertions, the workaround is to clock the assertions with a much faster sampling clock, assuming your simulator allows this.

Oversampling Clocked Assertion:

logic fast_clk;

initial begin
  fast_clk = 0;
  forever #1 fast_clk = ~fast_clk; // 1ns period, fast sampling
end

property glitch_with_oversampling;
  @(posedge fast_clk)
    (signal !== $past(signal));
endproperty

assert property (glitch_with_oversampling)
  else $error("Glitch detected on signal at %0t", $time);
*/

//Q17. Write an assertion to check glitch detection in a signal.

module tb_top;

  logic clk, rst_n;
  logic signal;
  //logic glitch_detected;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    rst_n = 0;
    signal = 0;
    #12 rst_n = 1; //12ns

    // Normal stable signal
    #10 signal = 1; //22ns
    #10 signal = 1; //32ns
    #10 signal = 0; //42ns
    #10 signal = 0; //52ns

    // Introduce a glitch: pulse high for 1 cycle
    #10 signal = 1; //62ns
    #10 signal = 0; //72ns

    // Another normal transition
    #10 signal = 1; //82ns
    #10 signal = 0; //92ns
    
    #10 $finish;    //112ns
  end

  // Assertion to detect 1-cycle glitch (glitch = signal changes for 1 cycle and returns)
  property glitch_detect;
    @(posedge clk) 
    disable iff (!rst_n)
      (signal != $past(signal) && signal == $past(signal,2));
  endproperty

  // Optional: Raise a flag
/*  always @(posedge clk)
    if (rst_n && (signal != $past(signal) && signal == $past(signal,2)))
      glitch_detected <= 1;
    else
      glitch_detected <= 0; */

    
  assert property (glitch_detect) 
    begin      
      $display("PASSED: Glitch Not detected on signal at time %0t", $time);
    end
  else
    begin      
      $error("FAILED: Glitch detected on signal at time %0t", $time);
    end

  initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end

endmodule
//Logfile output
[2025-05-09 02:46:43 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu May  8 22:46:44 2025

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
CPU time: .351 seconds to compile + .342 seconds to elab + .312 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  8 22:46 2025
"testbench.sv", 53: tb_top.unnamed$$_4: started at 15ns failed at 15ns
	Offending '((signal != $past(signal)) && (signal == $past(signal, 2)))'
Error: "testbench.sv", 53: tb_top.unnamed$$_4: at time 15 ns
FAILED: Glitch detected on signal at time 15
"testbench.sv", 53: tb_top.unnamed$$_4: started at 25ns failed at 25ns
	Offending '((signal != $past(signal)) && (signal == $past(signal, 2)))'
Error: "testbench.sv", 53: tb_top.unnamed$$_4: at time 25 ns
FAILED: Glitch detected on signal at time 25
"testbench.sv", 53: tb_top.unnamed$$_4: started at 35ns failed at 35ns
	Offending '((signal != $past(signal)) && (signal == $past(signal, 2)))'
Error: "testbench.sv", 53: tb_top.unnamed$$_4: at time 35 ns
FAILED: Glitch detected on signal at time 35
"testbench.sv", 53: tb_top.unnamed$$_4: started at 45ns failed at 45ns
	Offending '((signal != $past(signal)) && (signal == $past(signal, 2)))'
Error: "testbench.sv", 53: tb_top.unnamed$$_4: at time 45 ns
FAILED: Glitch detected on signal at time 45
"testbench.sv", 53: tb_top.unnamed$$_4: started at 55ns failed at 55ns
	Offending '((signal != $past(signal)) && (signal == $past(signal, 2)))'
Error: "testbench.sv", 53: tb_top.unnamed$$_4: at time 55 ns
FAILED: Glitch detected on signal at time 55
"testbench.sv", 53: tb_top.unnamed$$_4: started at 65ns failed at 65ns
	Offending '((signal != $past(signal)) && (signal == $past(signal, 2)))'
Error: "testbench.sv", 53: tb_top.unnamed$$_4: at time 65 ns
FAILED: Glitch detected on signal at time 65
PASSED: Glitch Not detected on signal at time 75
PASSED: Glitch Not detected on signal at time 85
PASSED: Glitch Not detected on signal at time 95
$finish called from file "testbench.sv", line 35.
$finish at simulation time                  102
           V C S   S i m u l a t i o n   R e p o r t 
Time: 102 ns
CPU Time:      0.330 seconds;       Data structure size:   0.0Mb
Thu May  8 22:46:46 2025
Done    
