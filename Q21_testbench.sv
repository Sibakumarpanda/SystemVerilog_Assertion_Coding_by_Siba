//Q21. Check that "writedata" should not go to unknown when "write_enable" becomes 0 
/*
Stimulus:
Test Case 1: write_enable = 0, writedata = 'x' — This should fail the assertion because writedata is x when write_enable is 0.
Test Case 2: write_enable = 0, writedata = 'z' — This should fail the assertion because writedata is z when write_enable is 0.
Test Case 3: write_enable = 0, writedata = 8'b00000000 — This should pass the assertion because writedata is a valid value and not unknown.
Test Case 4: write_enable = 1, writedata = 'x' — The assertion is disabled when write_enable = 1, so this case will pass even though writedata is x.
Test Case 5: write_enable = 1, writedata = 8'b10101010 — This will pass because writedata is a valid value, and the assertion is disabled when write_enable = 1.
*/
module tb_top;   
    reg clk;
    reg rst_n;
    reg write_enable;
    reg [7:0] writedata;  // 8-bit data for example
    
    always begin
        #5 clk = ~clk;  // Clock with 10 time units period
    end

    // Testbench stimulus
    initial begin        
        clk = 0;
        rst_n = 0;
        write_enable = 1;
        writedata = 8'b00000000;  // No unknown state

        // Reset the design
        #10 rst_n = 1;

        // Test Case 1: write_enable = 0, writedata = 'x' (should fail)
        write_enable = 0;
        writedata = 'x;  // writedata should not be 'x' when write_enable is 0
        #10;

        // Test Case 2: write_enable = 0, writedata = 'z' (should fail)
        writedata = 'z;  // writedata should not be 'z' when write_enable is 0
        #10;

        // Test Case 3: write_enable = 0, writedata = 0 (should pass)
        writedata = 8'b00000000;  // writedata is valid
        #10;

        // Test Case 4: write_enable = 1, writedata = 'x' (should pass, because assertion is disabled)
        write_enable = 1;
        writedata = 'x;  // Assertion does not check when write_enable is 1
        #10;

        // Test Case 5: write_enable = 1, writedata = 8'b10101010 (should pass)
        writedata = 8'b10101010;  // writedata is valid
        #10;       
        $finish;
    end  
   property check_write_enable_writdata;
    @(posedge clk) 
     disable iff (!rst_n) 
     (write_enable == 0) |-> (writedata !== 'bx && writedata !== 'bz) ;
   endproperty
  
   P1:assert property (check_write_enable_writdata)    
     $info ("PASSED: Assertion Passsed while checking relation between write_enable and writedata at TIME=%0d ",$realtime);    
   else    
     $error("FAILED: Assertion Failed  while checking relation between write_enable and writedata at TIME=%0d ",$realtime);
    
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end  
endmodule 
     
//Log File output
[2025-05-12 02:10:36 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sun May 11 22:10:37 2025

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
CPU time: .375 seconds to compile + .348 seconds to elab + .338 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 11 22:10 2025
Info: "testbench.sv", 61: tb_top.P1: at time 15 ns
PASSED: Assertion Passsed while checking relation between write_enable and writedata at TIME=15 
Info: "testbench.sv", 61: tb_top.P1: at time 25 ns
PASSED: Assertion Passsed while checking relation between write_enable and writedata at TIME=25 
Info: "testbench.sv", 61: tb_top.P1: at time 35 ns
PASSED: Assertion Passsed while checking relation between write_enable and writedata at TIME=35 
$finish called from file "testbench.sv", line 50.
$finish at simulation time                   60
           V C S   S i m u l a t i o n   R e p o r t 
Time: 60 ns
CPU Time:      0.350 seconds;       Data structure size:   0.0Mb
Sun May 11 22:10:38 2025
Done     
     
  
  
  
