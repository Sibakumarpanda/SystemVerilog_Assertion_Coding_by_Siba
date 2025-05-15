//Q33. Write an assertion check to make sure that a signal is high for a minimum of 2 cycles and a maximum of 6 cycles
module tb_top;
  logic clk;
  logic rst;
  logic sig;

  // Clock generation
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    clk = 0;
    rst = 1;
    sig = 0;

    #10 rst = 0;

    // VALID: high for 2 cycles
    sig = 1; #10;
    sig = 0; #10;

    // VALID: high for 6 cycles
    sig = 1; repeat(6) #10;
    sig = 0; #10;

    // INVALID: high for 1 cycle (too short)
    sig = 1; #10;
    sig = 0; #10;

    // INVALID: high for 7 cycles (too long)
    sig = 1; repeat(7) #10;
    sig = 0; #10;

    $finish;
  end

  // === Property: sig must be high for 2–6 cycles, then low ===
  property sig_high_duration_check;
    @(posedge clk) 
    disable iff (rst)
      sig |=> sig[*1:5] ##1 !sig;
  endproperty

  // === Assertion ===
  assert property (sig_high_duration_check)
    else $fatal("ERROR: sig was high for less than 2 or more than 6 cycles at time %0t", $time);

endmodule

//Logfile Output
[2025-05-15 11:06:20 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu May 15 07:06:21 2025

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

Warning-[SVA-IAU] Invalid argument used
testbench.sv, 49
tb_top, "$fatal("ERROR: sig was high for less than 2 or more than 6 cycles at time %0t", $time);"
  The first argument ""ERROR: sig was high for less than 2 or more than 6 
  cycles at time %0t"" used in '$fatal' is not valid. Only integer values 0,1 
  and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.

Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module tb_top
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .464 seconds to compile + .486 seconds to elab + .412 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 15 07:06 2025
"testbench.sv", 48: tb_top.unnamed$$_1: started at 15ns failed at 25ns
	Offending 'sig'
Fatal: "testbench.sv", 48: tb_top.unnamed$$_1: at time 25 ns
ERROR: sig was high for less than 2 or more than 6 cycles at time 25
$finish called from file "testbench.sv", line 48.
$finish at simulation time                   25
           V C S   S i m u l a t i o n   R e p o r t 
Time: 25 ns
Done
    
