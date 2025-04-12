//This program includes seqA shows timing relationship, 
// seqB shows logical relationship
// seqA and seqB Shows multiple sequences
module sequence_assertion_example;
   bit clk;
   bit x, y;
  
  always #2 clk = ~clk;
  
  //Input conditions
  initial begin
        x =  0;
        y  = 0;
    #4  x = 1;
        y = 1;
    #6  x = 0;
    #6  y = 0;
    #10 x = 1;
    #20 y = 1;
    #20; $finish;
  end

  //Timing Relationship
  sequence seqA;
    x ##5 y ;
  endsequence

  //Logical Relationship
  sequence seqB;
    x && y;
  endsequence

  //property includes two sequences using overlapped implication operator
  property seq_assert;
    @(posedge clk) 
    seqA |-> seqB;
  endproperty
  
  //check the condition inside the property 
  P1: assert property(seq_assert) 
    $info("assertion passed"); 
    else 
      $error("assertion failed");

initial begin                                                                                       
  $dumpfile                                                                                         
  ("waveform.vcd");                                                                                 
  $dumpvars();                                                                                      
end       
endmodule
//Log file Results
[2025-04-12 16:45:44 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat Apr 12 12:45:45 2025

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
       sequence_assertion_example
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module sequence_assertion_example
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .258 seconds to compile + .231 seconds to elab + .251 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 12 12:45 2025
Info: "testbench.sv", 41: sequence_assertion_example.P1: at time 50 ns
assertion passed
Info: "testbench.sv", 41: sequence_assertion_example.P1: at time 54 ns
assertion passed
Info: "testbench.sv", 41: sequence_assertion_example.P1: at time 58 ns
assertion passed
Info: "testbench.sv", 41: sequence_assertion_example.P1: at time 62 ns
assertion passed
$finish called from file "testbench.sv", line 21.
$finish at simulation time                   66
           V C S   S i m u l a t i o n   R e p o r t 
Time: 66 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Sat Apr 12 12:45:46 2025
Finding VCD file...
./waveform.vcd
[2025-04-12 16:45:46 UTC] Opening EPWave...
Done    
