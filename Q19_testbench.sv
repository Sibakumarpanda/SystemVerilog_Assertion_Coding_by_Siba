/* NOTE:
('1, current_time = $realtime): This part of the sequence is evaluated at the current clock edge. 
 The expression '1 is a placeholder that always evaluates to true, 
 and current_time = $realtime assigns the current simulation time to the variable current_time.
   
|=>: This is the implication operator in SystemVerilog assertions. It means that the expression on the right-hand side should hold true in the next clock cycle if the expression on the left-hand side is true in the current clock cycle.
  
(clk_period == $realtime - current_time): This part of the sequence is evaluated in the next clock cycle. It checks if the variable clk_period is equal to the difference between the current simulation time ($realtime) and the previously stored current_time.
   
In summary, the assertion checks that the period of the clock signal clk is equal to the value stored in the variable clk_period. 

It does this by capturing the simulation time at the current clock edge and then comparing the difference in simulation time at the next clock edge to the expected clock period.

If the clock period is not as expected, the assertion will fail, indicating that the clock frequency is not as specified. This can be useful for verifying that the clock signal in a design is operating at the correct frequency. 
*/

//Q19. Write an assertion/property to check time period/frequency of a signal/clock signal.
module frequency_check_assert_example1_tb;  
  bit clk;
  bit a,b ;  
  time clk_period = 10ns;
  
  always #5 clk=~clk;    // Here clock period =10ns , Clock frquency = 100MHZ
  
  initial begin
    for (int i=0; i<10; i++) begin      
      {a,b }=$random;
     // $display ("At TIME %0d : a=%0d b=%0d c=%0d d=%0d",$time , a,b,c ,d);
      
      @(posedge clk);
    end
    #10 $finish ;
  end
    
  property clk_freq_check;
     realtime current_time; //The variable current_time of type realtime, which is used to store the current simulation time.    
    @(posedge clk)    
    (('1,current_time=$realtime) |=> (clk_period==$realtime-current_time));    
  endproperty
    
  P1:assert property (clk_freq_check)    
    $info ("PASSED: Assertion Passsed while checking frequency of clk signal at TIME=%0d ",$realtime);    
  else    
    $error("FAILED: Assertion Failed  while checking frequency of clk signal at TIME=%0d ",$realtime);
    
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end  
endmodule
    
//Logfile output
[2025-05-09 09:21:46 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Fri May  9 05:21:47 2025

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
       frequency_check_assert_example1_tb
TimeScale is 1 ns / 1 ns
Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module frequency_check_assert_example1_tb
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .428 seconds to compile + .469 seconds to elab + .369 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May  9 05:21 2025
Info: "testbench.sv", 33: frequency_check_assert_example1_tb.P1: at time 15 ns
PASSED: Assertion Passsed while checking frequency of clk signal at TIME=15 
Info: "testbench.sv", 33: frequency_check_assert_example1_tb.P1: at time 25 ns
PASSED: Assertion Passsed while checking frequency of clk signal at TIME=25 
Info: "testbench.sv", 33: frequency_check_assert_example1_tb.P1: at time 35 ns
PASSED: Assertion Passsed while checking frequency of clk signal at TIME=35 
Info: "testbench.sv", 33: frequency_check_assert_example1_tb.P1: at time 45 ns
PASSED: Assertion Passsed while checking frequency of clk signal at TIME=45 
Info: "testbench.sv", 33: frequency_check_assert_example1_tb.P1: at time 55 ns
PASSED: Assertion Passsed while checking frequency of clk signal at TIME=55 
Info: "testbench.sv", 33: frequency_check_assert_example1_tb.P1: at time 65 ns
PASSED: Assertion Passsed while checking frequency of clk signal at TIME=65 
Info: "testbench.sv", 33: frequency_check_assert_example1_tb.P1: at time 75 ns
PASSED: Assertion Passsed while checking frequency of clk signal at TIME=75 
Info: "testbench.sv", 33: frequency_check_assert_example1_tb.P1: at time 85 ns
PASSED: Assertion Passsed while checking frequency of clk signal at TIME=85 
Info: "testbench.sv", 33: frequency_check_assert_example1_tb.P1: at time 95 ns
PASSED: Assertion Passsed while checking frequency of clk signal at TIME=95 
$finish called from file "testbench.sv", line 20.
$finish at simulation time                  105
           V C S   S i m u l a t i o n   R e p o r t 
Time: 105 ns
CPU Time:      0.420 seconds;       Data structure size:   0.0Mb
Fri May  9 05:21:49 2025
Done
    
    
