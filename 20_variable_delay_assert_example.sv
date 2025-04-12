module variable_delay_assert_example;
  bit clk;
  bit a,b;
  int parameter_delay;
  
  always #5 clk = ~clk;

//input conditions
initial begin
  parameter_delay = 2;
      a=1; b = 0;
  #20 a=0; b = 1;
  #10 a=1;
  #15 a=0; b = 1;
  #10 a=1; b = 0;
  #15;
  $finish;
end 
    
//copy the parameter delay value to variable delay and works like while loop 
// and check the delay upto zero
sequence delay_sequence(variable_delay);
  int delay;
  (1,delay=variable_delay) ##0 first_match((1,delay=delay-1) [*0:$] ##0 delay <=0);
endsequence

//checking the condition
a_1: assert property
     (@(posedge clk) 
     a |-> delay_sequence(parameter_delay) |-> b)
     $info("assertion passed"); 
  else 
     $error("assertion failed");

initial begin 
  $dumpfile ("waveform.vcd");
  $dumpvars();
end
  
endmodule  
//Log file results
[2025-04-12 16:41:52 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat Apr 12 12:41:52 2025

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
       variable_delay_assert_example
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module variable_delay_assert_example
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .252 seconds to compile + .227 seconds to elab + .221 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr 12 12:41 2025
"testbench.sv", 31: variable_delay_assert_example.a_1: started at 5ns failed at 15ns
	Offending 'b'
Error: "testbench.sv", 31: variable_delay_assert_example.a_1: at time 15 ns
assertion failed
Info: "testbench.sv", 31: variable_delay_assert_example.a_1: at time 35 ns
assertion passed
Info: "testbench.sv", 31: variable_delay_assert_example.a_1: at time 55 ns
assertion passed
Info: "testbench.sv", 31: variable_delay_assert_example.a_1: at time 65 ns
assertion passed
$finish called from file "testbench.sv", line 19.
$finish at simulation time                   70
           V C S   S i m u l a t i o n   R e p o r t 
Time: 70 ns
CPU Time:      0.250 seconds;       Data structure size:   0.0Mb
Sat Apr 12 12:41:53 2025
Finding VCD file...
./waveform.vcd
[2025-04-12 16:41:53 UTC] Opening EPWave...
Done  
