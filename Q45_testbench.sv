//Q45. In a RESP operation, request must be true immediately, grant must be true 3 clock cycles later, followed by request being false, and then grant being false. WAA for this.

/*Means the Requirement is :

In a RESP operation:

request must be asserted (1) on [cycle N , request == 1]

Then, grant must be asserted 3 clock cycles later [ on cycle N+3, grant == 1]

Followed by request being deasserted (0) [ on cycle N+4,request == 0]

Then, grant must also be deasserted (0) [ on cycle N+5,grant == 0] */

module tb_top; 
  logic clk;
  logic request;
  logic grant;
  
  initial clk = 0;
  always #5 clk = ~clk; // 10 time unit period
   
  // Stimulus generation for all combinations
  initial begin
   
    request = 0;
    grant = 0;

    // Wait 2 cycles
    repeat (2) @(posedge clk);

    // Generate a valid RESP sequence
    request = 1;
    @(posedge clk); // cycle 1
    request = 1;
    @(posedge clk); // cycle 2
    request = 1;
    @(posedge clk); // cycle 3
    request = 1; grant = 1; // grant after 3 cycles
    @(posedge clk); // cycle 4
    request = 0; grant = 1;
    @(posedge clk); // cycle 5
    request = 0; grant = 0;
    @(posedge clk); // cycle 6

    // Now, test invalid sequences (to trigger assertion failure)

    // 1. Grant too early
    request = 1;
    @(posedge clk);
    request = 1; grant = 1; // invalid: grant before 3 cycles
    @(posedge clk);
    request = 0;
    @(posedge clk);
    grant = 0;
    @(posedge clk);

    // 2. Request not deasserted after grant
    request = 1;
    @(posedge clk);
    request = 1;
    @(posedge clk);
    request = 1;
    @(posedge clk);
    grant = 1;
    @(posedge clk);
    request = 1; // should be 0
    @(posedge clk);
    grant = 0;
    @(posedge clk);

    // 3. Grant not deasserted
    request = 1;
    @(posedge clk);
    request = 1;
    @(posedge clk);
    request = 1;
    @(posedge clk);
    grant = 1;
    @(posedge clk);
    request = 0;
    @(posedge clk);
    grant = 1; // should be 0
    @(posedge clk);

    $display("Testbench completed.");
    $finish;
  end
  
   // RESP Operation Assertion (Write Assertion Always)
  property p_resp_operation;
    @(posedge clk)
      request ##3 grant ##1 !request ##1 !grant;
  endproperty
        
  P1:assert property (p_resp_operation)   
    $display("PASSED at TIME=%0d : RESP protocol Success: expected grant 3 cycles after request, followed by request deassert, then grant deassert",$time);    
  else      
    $error("FAILED at TIME=%0d : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert",$time);   
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end       
endmodule

//Logfile Output
[2025-05-17 05:45:38 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Sat May 17 01:45:38 2025

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
CPU time: .247 seconds to compile + .230 seconds to elab + .210 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 17 01:45 2025
"testbench.sv", 101: tb_top.P1: started at 5ns failed at 5ns
	Offending 'request'
Error: "testbench.sv", 101: tb_top.P1: at time 5 ns
FAILED at TIME=5 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 15ns failed at 15ns
	Offending 'request'
Error: "testbench.sv", 101: tb_top.P1: at time 15 ns
FAILED at TIME=15 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 65ns failed at 65ns
	Offending 'request'
Error: "testbench.sv", 101: tb_top.P1: at time 65 ns
FAILED at TIME=65 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 75ns failed at 75ns
	Offending 'request'
Error: "testbench.sv", 101: tb_top.P1: at time 75 ns
FAILED at TIME=75 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 45ns failed at 75ns
	Offending 'grant'
Error: "testbench.sv", 101: tb_top.P1: at time 75 ns
FAILED at TIME=75 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
PASSED at TIME=75 : RESP protocol Success: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 55ns failed at 85ns
	Offending 'grant'
Error: "testbench.sv", 101: tb_top.P1: at time 85 ns
FAILED at TIME=85 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
PASSED at TIME=85 : RESP protocol Success: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 105ns failed at 105ns
	Offending 'request'
Error: "testbench.sv", 101: tb_top.P1: at time 105 ns
FAILED at TIME=105 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 115ns failed at 115ns
	Offending 'request'
Error: "testbench.sv", 101: tb_top.P1: at time 115 ns
FAILED at TIME=115 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 85ns failed at 115ns
	Offending 'grant'
Error: "testbench.sv", 101: tb_top.P1: at time 115 ns
FAILED at TIME=115 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 95ns failed at 125ns
	Offending 'grant'
Error: "testbench.sv", 101: tb_top.P1: at time 125 ns
FAILED at TIME=125 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 125ns failed at 165ns
	Offending '(!request)'
Error: "testbench.sv", 101: tb_top.P1: at time 165 ns
FAILED at TIME=165 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 145ns failed at 175ns
	Offending 'grant'
Error: "testbench.sv", 101: tb_top.P1: at time 175 ns
FAILED at TIME=175 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 135ns failed at 175ns
	Offending '(!request)'
Error: "testbench.sv", 101: tb_top.P1: at time 175 ns
FAILED at TIME=175 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 155ns failed at 185ns
	Offending 'grant'
Error: "testbench.sv", 101: tb_top.P1: at time 185 ns
FAILED at TIME=185 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 165ns failed at 195ns
	Offending 'grant'
Error: "testbench.sv", 101: tb_top.P1: at time 195 ns
FAILED at TIME=195 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 175ns failed at 205ns
	Offending 'grant'
Error: "testbench.sv", 101: tb_top.P1: at time 205 ns
FAILED at TIME=205 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
"testbench.sv", 101: tb_top.P1: started at 225ns failed at 225ns
	Offending 'request'
Error: "testbench.sv", 101: tb_top.P1: at time 225 ns
FAILED at TIME=225 : RESP protocol violated: expected grant 3 cycles after request, followed by request deassert, then grant deassert
Testbench completed.
$finish called from file "testbench.sv", line 91.
$finish at simulation time                  235
           V C S   S i m u l a t i o n   R e p o r t 
Time: 235 ns
CPU Time:      0.240 seconds;       Data structure size:   0.0Mb
Sat May 17 01:45:39 2025
Done
    
