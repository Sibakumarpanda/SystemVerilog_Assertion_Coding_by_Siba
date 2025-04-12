module formal_argument_assertion_example;
  bit clk;
  bit a,b,c,d;

  always #5 clk = ~clk;
  
  initial begin
      a=0; b=0;
      c=0; d=0;
  #15 a=1; b=0;
      c=0; d=1;
  #10 a=1; b=1;
      c=1; d=1;
  #10 a=1; b=0;
      c=1; d=1;
  #10 a=1; b=1;
      c=1; d=0;
  #20;
      $finish;
   end

  sequence notype_seq (X,Y);
    X && Y;
  endsequence

  sequence withtype_seq (bit X, bit Y);
    X && Y;
  endsequence

  property a_b_notype_prop(a,b);
    @ (posedge clk)
    a |-> notype_seq(a,b);
  endproperty

  property c_d_type_prop(bit c, bit d);
    @ (posedge clk)
    c |-> withtype_seq(c,d);
  endproperty

 a_b_notype_assert : assert property (a_b_notype_prop(a,b))
   $info("ASSERTION PASSED");
 else
   $error("ASSERTION FAILED");
   
 c_d_type_assert: assert property (c_d_type_prop(c,d))
   $info("ASSERTION PASSED");
 else
    $error("ASSERTION FAILED");
    
  initial begin
      $dumpfile("waveform.vcd");
      $dumpvars();
  end    
endmodule
//Log file Results
[2025-04-12 16:28:43 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat Apr 12 12:28:44 2025

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
       formal_argument_assertion_example
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module formal_argument_assertion_example
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .243 seconds to compile + .228 seconds to elab + .210 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 12 12:28 2025
"testbench.sv", 41: formal_argument_assertion_example.a_b_notype_assert: started at 25ns failed at 25ns
	Offending '(a && b)'
Error: "testbench.sv", 41: formal_argument_assertion_example.a_b_notype_assert: at time 25 ns
ASSERTION FAILED
Info: "testbench.sv", 41: formal_argument_assertion_example.a_b_notype_assert: at time 35 ns
ASSERTION PASSED
Info: "testbench.sv", 46: formal_argument_assertion_example.c_d_type_assert: at time 35 ns
ASSERTION PASSED
"testbench.sv", 41: formal_argument_assertion_example.a_b_notype_assert: started at 45ns failed at 45ns
	Offending '(a && b)'
Error: "testbench.sv", 41: formal_argument_assertion_example.a_b_notype_assert: at time 45 ns
ASSERTION FAILED
Info: "testbench.sv", 46: formal_argument_assertion_example.c_d_type_assert: at time 45 ns
ASSERTION PASSED
Info: "testbench.sv", 41: formal_argument_assertion_example.a_b_notype_assert: at time 55 ns
ASSERTION PASSED
"testbench.sv", 46: formal_argument_assertion_example.c_d_type_assert: started at 55ns failed at 55ns
	Offending '(c && d)'
Error: "testbench.sv", 46: formal_argument_assertion_example.c_d_type_assert: at time 55 ns
ASSERTION FAILED
$finish called from file "testbench.sv", line 20.
$finish at simulation time                   65
           V C S   S i m u l a t i o n   R e p o r t 
Time: 65 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Sat Apr 12 12:28:45 2025
Finding VCD file...
./waveform.vcd
[2025-04-12 16:28:45 UTC] Opening EPWave...
Done   
