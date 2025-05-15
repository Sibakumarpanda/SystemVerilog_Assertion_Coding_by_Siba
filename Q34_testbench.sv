//Q34. Write an assertion to make sure that a 5-bit grant signal only has one bit set at any time.
// we can write an assertion that checks that only one bit is high in the signal at any given time.
module tb_top;  
  reg [4:0] grant_signal; // 5-bit grant signal
  // Stimulus for the grant signal (can be set in the testbench)
  initial begin
    // Apply different combinations of stimulus (0 to 31 combinations)
    grant_signal = 5'b00000; 
    #10;
    grant_signal = 5'b00001; 
    #10;
    grant_signal = 5'b00010; 
    #10;
    grant_signal = 5'b00100; 
    #10;
    grant_signal = 5'b01000;
    #10;
    grant_signal = 5'b10000; 
    #10;
    grant_signal = 5'b00011; //invalid, more than one bit set
    #10; 
    grant_signal = 5'b11111; //invalid, more than one bit set
    #10;  
    grant_signal = 5'b00101; //invalid, more than one bit set
    #10; 
    $finish;
  end

  property grant_signal_check;
    @(posedge grant_signal)     
    (grant_signal != 5'b00000) && // Not all bits are 0
    (grant_signal == (grant_signal & -grant_signal));  // Only one bit is set
  endproperty
    
  P1: assert property (grant_signal_check) 
    begin      
      $display("PASSED: only one bit is high in the signal at any given time %0t", $time);
    end
  else
    begin      
      $error("FAILED: only one bit is not high in the signal at any given time %0t", $time);
    end

  initial begin
   $dumpfile("waveform.vcd");
   $dumpvars();
  end
endmodule

//Logfile Ouput    
[2025-05-15 11:18:17 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu May 15 07:18:18 2025

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
CPU time: .406 seconds to compile + .492 seconds to elab + .371 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 15 07:18 2025
"testbench.sv", 40: tb_top.P1: started at 10ns failed at 10ns
	Offending '((grant_signal != 5'b0) && (grant_signal == (grant_signal & (-grant_signal))))'
Error: "testbench.sv", 40: tb_top.P1: at time 10 ns
FAILED: only one bit is not high in the signal at any given time 10
PASSED: only one bit is high in the signal at any given time 60
$finish called from file "testbench.sv", line 30.
$finish at simulation time                   90
           V C S   S i m u l a t i o n   R e p o r t 
Time: 90 ns
CPU Time:      0.380 seconds;       Data structure size:   0.0Mb
Thu May 15 07:18:20 2025
Done
    
