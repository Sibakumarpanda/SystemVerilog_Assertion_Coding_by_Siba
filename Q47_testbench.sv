//Q47. Req must eventually be followed by ack, which must be followed 1 cycle later by done.WAA for this.
/*Request (req) must eventually be followed by Acknowledgment (ack).
Acknowledgment (ack) must be followed 1 cycle later by Done (done).
*/

module tb_top;
  logic req;
  logic ack;
  logic done; 
  logic clk;
  logic rst_n;

  // Clock generation for simulation
  always #5 clk = ~clk;  
  
  // Reset logic
  initial begin
    clk = 0;
    rst_n = 0;
    #10 rst_n = 1; // Reset release after 10ns
  end

  // Stimulus generation
  initial begin
      
    req = 0; ack = 0; done = 0;
    #15 req = 1; ack = 0; done = 0;
    #10 req = 1; ack = 1; done = 0; // ack is 1 after req
    #5  req = 1; ack = 1; done = 1; // done follows ack after 1 cycle
    #10 req = 0; ack = 0; done = 0;
    #20 req = 1; ack = 0; done = 0;
    #10 req = 1; ack = 1; done = 0; // ack follows req
    #5  req = 1; ack = 1; done = 1; // done follows ack after 1 cycle
    
  end
  
  // Request must eventually be followed by acknowledgment,
  // acknowledgment must be followed 1 cycle later by done.  
  // Assertion: whenever req is high, ack must be high eventually,
  // and done must be high exactly one cycle after ack.
    
  property req_ack_done;
    @(posedge clk)
      disable iff (!rst_n) 
    (req == 1'b1) |-> ##[1:2] (ack == 1'b1) |-> ##1 (done == 1'b1) ;  
  endproperty
        
  P1:assert property (req_ack_done)   
    $display("PASSED at TIME=%0d : Ack followed by done in time after req",$time);    
  else      
    $error("FAILED at TIME=%0d : Ack not followed by done in time after req",$time); 
    
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end       
endmodule

//Logfile Output
[2025-05-19 07:22:46 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Mon May 19 03:22:47 2025

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
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _333_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .436 seconds to compile + .350 seconds to elab + .366 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 19 03:22 2025
"testbench.sv", 52: tb_top.P1: started at 25ns failed at 45ns
	Offending '(done == 1'b1)'
Error: "testbench.sv", 52: tb_top.P1: at time 45 ns
FAILED at TIME=45 : Ack not followed by done in time after req
PASSED at TIME=95 : Ack followed by done in time after req
PASSED at TIME=105 : Ack followed by done in time after req
PASSED at TIME=115 : Ack followed by done in time after req
PASSED at TIME=125 : Ack followed by done in time after req
PASSED at TIME=135 : Ack followed by done in time after req
PASSED at TIME=145 : Ack followed by done in time after req
PASSED at TIME=155 : Ack followed by done in time after req
PASSED at TIME=165 : Ack followed by done in time after req
PASSED at TIME=175 : Ack followed by done in time after req
PASSED at TIME=185 : Ack followed by done in time after req
PASSED at TIME=195 : Ack followed by done in time after req
PASSED at TIME=205 : Ack followed by done in time after req
PASSED at TIME=215 : Ack followed by done in time after req
PASSED at TIME=225 : Ack followed by done in time after req
PASSED at TIME=235 : Ack followed by done in time after req
PASSED at TIME=245 : Ack followed by done in time after req
PASSED at TIME=255 : Ack followed by done in time after req
PASSED at TIME=265 : Ack followed by done in time after req
PASSED at TIME=275 : Ack followed by done in time after req
PASSED at TIME=285 : Ack followed by done in time after req
PASSED at TIME=295 : Ack followed by done in time after req
PASSED at TIME=305 : Ack followed by done in time after req
PASSED at TIME=315 : Ack followed by done in time after req
PASSED at TIME=325 : Ack followed by done in time after req
PASSED at TIME=335 : Ack followed by done in time after req
PASSED at TIME=345 : Ack followed by done in time after req
PASSED at TIME=355 : Ack followed by done in time after req
PASSED at TIME=365 : Ack followed by done in time after req
PASSED at TIME=375 : Ack followed by done in time after req
PASSED at TIME=385 : Ack followed by done in time after req
PASSED at TIME=395 : Ack followed by done in time after req
PASSED at TIME=405 : Ack followed by done in time after req
PASSED at TIME=415 : Ack followed by done in time after req
PASSED at TIME=425 : Ack followed by done in time after req
PASSED at TIME=435 : Ack followed by done in time after req
PASSED at TIME=445 : Ack followed by done in time after req
PASSED at TIME=455 : Ack followed by done in time after req
PASSED at TIME=465 : Ack followed by done in time after req
PASSED at TIME=475 : Ack followed by done in time after req
PASSED at TIME=485 : Ack followed by done in time after req
PASSED at TIME=495 : Ack followed by done in time after req
PASSED at TIME=505 : Ack followed by done in time after req
PASSED at TIME=515 : Ack followed by done in time after req
PASSED at TIME=525 : Ack followed by done in time after req
PASSED at TIME=535 : Ack followed by done in time after req
PASSED at TIME=545 : Ack followed by done in time after req
PASSED at TIME=555 : Ack followed by done in time after req
PASSED at TIME=565 : Ack followed by done in time after req
PASSED at TIME=575 : Ack followed by done in time after req
PASSED at TIME=585 : Ack followed by done in time after req
PASSED at TIME=595 : Ack followed by done in time after req
PASSED at TIME=605 : Ack followed by done in time after req
PASSED at TIME=615 : Ack followed by done in time after req
PASSED at TIME=625 : Ack followed by done in time after req
PASSED at TIME=635 : Ack followed by done in time after req
PASSED at TIME=645 : Ack followed by done in time after req
PASSED at TIME=655 : Ack followed by done in time after req
PASSED at TIME=665 : Ack followed by done in time after req
PASSED at TIME=675 : Ack followed by done in time after req
PASSED at TIME=685 : Ack followed by done in time after req
PASSED at TIME=695 : Ack followed by done in time after req
PASSED at TIME=705 : Ack followed by done in time after req
PASSED at TIME=715 : Ack followed by done in time after req
PASSED at TIME=725 : Ack followed by done in time after req
PASSED at TIME=735 : Ack followed by done in time after req
PASSED at TIME=745 : Ack followed by done in time after req
PASSED at TIME=755 : Ack followed by done in time after req
PASSED at TIME=765 : Ack followed by done in time after req
PASSED at TIME=775 : Ack followed by done in time after req
PASSED at TIME=785 : Ack followed by done in time after req
PASSED at TIME=795 : Ack followed by done in time after req
PASSED at TIME=805 : Ack followed by done in time after req
PASSED at TIME=815 : Ack followed by done in time after req
PASSED at TIME=825 : Ack followed by done in time after req
PASSED at TIME=835 : Ack followed by done in time after req
PASSED at TIME=845 : Ack followed by done in time after req
PASSED at TIME=855 : Ack followed by done in time after req
PASSED at TIME=865 : Ack followed by done in time after req
PASSED at TIME=875 : Ack followed by done in time after req
PASSED at TIME=885 : Ack followed by done in time after req
PASSED at TIME=895 : Ack followed by done in time after req
PASSED at TIME=905 : Ack followed by done in time after req
PASSED at TIME=915 : Ack followed by done in time after req
PASSED at TIME=925 : Ack followed by done in time after req
PASSED at TIME=935 : Ack followed by done in time after req
PASSED at TIME=945 : Ack followed by done in time after req
PASSED at TIME=955 : Ack followed by done in time after req
PASSED at TIME=965 : Ack followed by done in time after req
PASSED at TIME=975 : Ack followed by done in time after req
PASSED at TIME=985 : Ack followed by done in time after req
PASSED at TIME=995 : Ack followed by done in time after req
PASSED at TIME=1005 : Ack followed by done in time after req
PASSED at TIME=1015 : Ack followed by done in time after req
PASSED at TIME=1025 : Ack followed by done in time after req
PASSED at TIME=1035 : Ack followed by done in time after req
PASSED at TIME=1045 : Ack followed by done in time after req
PASSED at TIME=1055 : Ack followed by done in time after req
PASSED at TIME=1065 : Ack followed by done in time after req
PASSED at TIME=1075 : Ack followed by done in time after req
PASSED at TIME=1085 : Ack followed by done in time after req
PASSED at TIME=1095 : Ack followed by done in time after req
PASSED at TIME=1105 : Ack followed by done in time after req
PASSED at TIME=1115 : Ack followed by done in time after req
PASSED at TIME=1125 : Ack followed by done in time after req
PASSED at TIME=1135 : Ack followed by done in time after req
PASSED at TIME=1145 : Ack followed by done in time after req
PASSED at TIME=1155 : Ack followed by done in time after req
PASSED at TIME=1165 : Ack followed by done in time after req
PASSED at TIME=1175 : Ack followed by done in time after req
PASSED at TIME=1185 : Ack followed by done in time after req
PASSED at TIME=1195 : Ack followed by done in time after req
PASSED at TIME=1205 : Ack followed by done in time after req
PASSED at TIME=1215 : Ack followed by done in time after req
PASSED at TIME=1225 : Ack followed by done in time after req
PASSED at TIME=1235 : Ack followed by done in time after req
PASSED at TIME=1245 : Ack followed by done in time after req
PASSED at TIME=1255 : Ack followed by done in time after req
PASSED at TIME=1265 : Ack followed by done in time after req
PASSED at TIME=1275 : Ack followed by done in time after req
PASSED at TIME=1285 : Ack followed by done in time after req
PASSED at TIME=1295 : Ack followed by done in time after req
PASSED at TIME=1305 : Ack followed by done in time after req
PASSED at TIME=1315 : Ack followed by done in time after req
PASSED at TIME=1325 : Ack followed by done in time after req
PASSED at TIME=1335 : Ack followed by done in time after req
PASSED at TIME=1345 : Ack followed by done in time after req
PASSED at TIME=1355 : Ack followed by done in time after req
PASSED at TIME=1365 : Ack followed by done in time after req
PASSED at TIME=1375 : Ack followed by done in time after req
PASSED at TIME=1385 : Ack followed by done in time after req
PASSED at TIME=1395 : Ack followed by done in time after req
PASSED at TIME=1405 : Ack followed by done in time after req
PASSED at TIME=1415 : Ack followed by done in time after req
PASSED at TIME=1425 : Ack followed by done in time after req
PASSED at TIME=1435 : Ack followed by done in time after req
PASSED at TIME=1445 : Ack followed by done in time after req
PASSED at TIME=1455 : Ack followed by done in time after req
PASSED at TIME=1465 : Ack followed by done in time after req
PASSED at TIME=1475 : Ack followed by done in time after req
PASSED at TIME=1485 : Ack followed by done in time after req
PASSED at TIME=1495 : Ack followed by done in time after req
PASSED at TIME=1505 : Ack followed by done in time after req
PASSED at TIME=1515 : Ack followed by done in time after req
PASSED at TIME=1525 : Ack followed by done in time after req
PASSED at TIME=1535 : Ack followed by done in time after req
PASSED at TIME=1545 : Ack followed by done in time after req
PASSED at TIME=1555 : Ack followed by done in time after req
PASSED at TIME=1565 : Ack followed by done in time after req
PASSED at TIME=1575 : Ack followed by done in time after req
PASSED at TIME=1585 : Ack followed by done in time after req
PASSED at TIME=1595 : Ack followed by done in time after req
PASSED at TIME=1605 : Ack followed by done in time after req
PASSED at TIME=1615 : Ack followed by done in time after req
PASSED at TIME=1625 : Ack followed by done in time after req
PASSED at TIME=1635 : Ack followed by done in time after req
PASSED at TIME=1645 : Ack followed by done in time after req
PASSED at TIME=1655 : Ack followed by done in time after req
PASSED at TIME=1665 : Ack followed by done in time after req
PASSED at TIME=1675 : Ack followed by done in time after req
PASSED at TIME=1685 : Ack followed by done in time after req
PASSED at TIME=1695 : Ack followed by done in time after req
PASSED at TIME=1705 : Ack followed by done in time after req
PASSED at TIME=1715 : Ack followed by done in time after req
PASSED at TIME=1725 : Ack followed by done in time after req
PASSED at TIME=1735 : Ack followed by done in time after req
PASSED at TIME=1745 : Ack followed by done in time after req
PASSED at TIME=1755 : Ack followed by done in time after req
PASSED at TIME=1765 : Ack followed by done in time after req
PASSED at TIME=1775 : Ack followed by done in time after req
PASSED at TIME=1785 : Ack followed by done in time after req
PASSED at TIME=1795 : Ack followed by done in time after req
PASSED at TIME=1805 : Ack followed by done in time after req
PASSED at TIME=1815 : Ack followed by done in time after req
PASSED at TIME=1825 : Ack followed by done in time after req
PASSED at TIME=1835 : Ack followed by done in time after req
PASSED at TIME=1845 : Ack followed by done in time after req
PASSED at TIME=1855 : Ack followed by done in time after req
PASSED at TIME=1865 : Ack followed by done in time after req
PASSED at TIME=1875 : Ack followed by done in time after req
PASSED at TIME=1885 : Ack followed by done in time after req
PASSED at TIME=1895 : Ack followed by done in time after req
PASSED at TIME=1905 : Ack followed by done in time after req
PASSED at TIME=1915 : Ack followed by done in time after req
PASSED at TIME=1925 : Ack followed by done in time after req
PASSED at TIME=1935 : Ack followed by done in time after req
PASSED at TIME=1945 : Ack followed by done in time after req
PASSED at TIME=1955 : Ack followed by done in time after req
PASSED at TIME=1965 : Ack followed by done in time after req
PASSED at TIME=1975 : Ack followed by done in time after req
PASSED at TIME=1985 : Ack followed by done in time after req
PASSED at TIME=1995 : Ack followed by done in time after req
PASSED at TIME=2005 : Ack followed by done in time after req
PASSED at TIME=2015 : Ack followed by done in time after req
PASSED at TIME=2025 : Ack followed by done in time after req
PASSED at TIME=2035 : Ack followed by done in time after req
PASSED at TIME=2045 : Ack followed by done in time after req
PASSED at TIME=2055 : Ack followed by done in time after req
PASSED at TIME=2065 : Ack followed by done in time after req
PASSED at TIME=2075 : Ack followed by done in time after req
PASSED at TIME=2085 : Ack followed by done in time after req
PASSED at TIME=2095 : Ack followed by done in time after req
PASSED at TIME=2105 : Ack followed by done in time after req
PASSED at TIME=2115 : Ack followed by done in time after req
PASSED at TIME=2125 : Ack followed by done in time after req
PASSED at TIME=2135 : Ack followed by done in time after req
PASSED at TIME=2145 : Ack followed by done in time after req
PASSED at TIME=2155 : Ack followed by done in time after req
PASSED at TIME=2165 : Ack followed by done in time after req
PASSED at TIME=2175 : Ack followed by done in time after req
PASSED at TIME=2185 : Ack followed by done in time after req
PASSED at TIME=2195 : Ack followed by done in time after req
PASSED at TIME=2205 : Ack followed by done in time after req
PASSED at TIME=2215 : Ack followed by done in time after req
PASSED at TIME=2225 : Ack followed by done in time after req
PASSED at TIME=2235 : Ack followed by done in time after req
PASSED at TIME=2245 : Ack followed by done in time after req
PASSED at TIME=2255 : Ack followed by done in time after req
PASSED at TIME=2265 : Ack followed by done in time after req
PASSED at TIME=2275 : Ack followed by done in time after req
PASSED at TIME=2285 : Ack followed by done in time after req
PASSED at TIME=2295 : Ack followed by done in time after req
PASSED at TIME=2305 : Ack followed by done in time after req
PASSED at TIME=2315 : Ack followed by done in time after req
PASSED at TIME=2325 : Ack followed by done in time after req
PASSED at TIME=2335 : Ack followed by done in time after req
PASSED at TIME=2345 : Ack followed by done in time after req
PASSED at TIME=2355 : Ack followed by done in time after req
PASSED at TIME=2365 : Ack followed by done in time after req
PASSED at TIME=2375 : Ack followed by done in time after req
PASSED at TIME=2385 : Ack followed by done in time after req
PASSED at TIME=2395 : Ack followed by done in time after req
PASSED at TIME=2405 : Ack followed by done in time after req
PASSED at TIME=2415 : Ack followed by done in time after req
PASSED at TIME=2425 : Ack followed by done in time after req
PASSED at TIME=2435 : Ack followed by done in time after req
PASSED at TIME=2445 : Ack followed by done in time after req
PASSED at TIME=2455 : Ack followed by done in time after req
PASSED at TIME=2465 : Ack followed by done in time after req
PASSED at TIME=2475 : Ack followed by done in time after req
PASSED at TIME=2485 : Ack followed by done in time after req
PASSED at TIME=2495 : Ack followed by done in time after req
PASSED at TIME=2505 : Ack followed by done in time after req
PASSED at TIME=2515 : Ack followed by done in time after req
PASSED at TIME=2525 : Ack followed by done in time after req
PASSED at TIME=2535 : Ack followed by done in time after req
PASSED at TIME=2545 : Ack followed by done in time after req
PASSED at TIME=2555 : Ack followed by done in time after req
PASSED at TIME=2565 : Ack followed by done in time after req
PASSED at TIME=2575 : Ack followed by done in time after req
PASSED at TIME=2585 : Ack followed by done in time after req
PASSED at TIME=2595 : Ack followed by done in time after req
PASSED at TIME=2605 : Ack followed by done in time after req
PASSED at TIME=2615 : Ack followed by done in time after req
PASSED at TIME=2625 : Ack followed by done in time after req
PASSED at TIME=2635 : Ack followed by done in time after req
PASSED at TIME=2645 : Ack followed by done in time after req
PASSED at TIME=2655 : Ack followed by done in time after req
PASSED at TIME=2665 : Ack followed by done in time after req
PASSED at TIME=2675 : Ack followed by done in time after req
PASSED at TIME=2685 : Ack followed by done in time after req
PASSED at TIME=2695 : Ack followed by done in time after req
PASSED at TIME=2705 : Ack followed by done in time after req
PASSED at TIME=2715 : Ack followed by done in time after req
PASSED at TIME=2725 : Ack followed by done in time after req
PASSED at TIME=2735 : Ack followed by done in time after req
PASSED at TIME=2745 : Ack followed by done in time after req
PASSED at TIME=2755 : Ack followed by done in time after req
PASSED at TIME=2765 : Ack followed by done in time after req
PASSED at TIME=2775 : Ack followed by done in time after req
PASSED at TIME=2785 : Ack followed by done in time after req
PASSED at TIME=2795 : Ack followed by done in time after req
PASSED at TIME=2805 : Ack followed by done in time after req
PASSED at TIME=2815 : Ack followed by done in time after req
PASSED at TIME=2825 : Ack followed by done in time after req
PASSED at TIME=2835 : Ack followed by done in time after req
PASSED at TIME=2845 : Ack followed by done in time after req
PASSED at TIME=2855 : Ack followed by done in time after req
PASSED at TIME=2865 : Ack followed by done in time after req
PASSED at TIME=2875 : Ack followed by done in time after req
PASSED at TIME=2885 : Ack followed by done in time after req
PASSED at TIME=2895 : Ack followed by done in time after req
PASSED at TIME=2905 : Ack followed by done in time after req
PASSED at TIME=2915 : Ack followed by done in time after req
PASSED at TIME=2925 : Ack followed by done in time after req
PASSED at TIME=2935 : Ack followed by done in time after req
PASSED at TIME=2945 : Ack followed by done in time after req
PASSED at TIME=2955 : Ack followed by done in time after req
PASSED at TIME=2965 : Ack followed by done in time after req
PASSED at TIME=2975 : Ack followed by done in time after req
PASSED at TIME=2985 : Ack followed by done in time after req
PASSED at TIME=2995 : Ack followed by done in time after req
PASSED at TIME=3005 : Ack followed by done in time after req
PASSED at TIME=3015 : Ack followed by done in time after req
PASSED at TIME=3025 : Ack followed by done in time after req
PASSED at TIME=3035 : Ack followed by done in time after req
PASSED at TIME=3045 : Ack followed by done in time after req
PASSED at TIME=3055 : Ack followed by done in time after req
PASSED at TIME=3065 : Ack followed by done in time after req
PASSED at TIME=3075 : Ack followed by done in time after req
PASSED at TIME=3085 : Ack followed by done in time after req
PASSED at TIME=3095 : Ack followed by done in time after req
PASSED at TIME=3105 : Ack followed by done in time after req
PASSED at TIME=3115 : Ack followed by done in time after req
PASSED at TIME=3125 : Ack followed by done in time after req
PASSED at TIME=3135 : Ack followed by done in time after req
PASSED at TIME=3145 : Ack followed by done in time after req
PASSED at TIME=3155 : Ack followed by done in time after req
PASSED at TIME=3165 : Ack followed by done in time after req
PASSED at TIME=3175 : Ack followed by done in time after req
PASSED at TIME=3185 : Ack followed by done in time after req
PASSED at TIME=3195 : Ack followed by done in time after req
PASSED at TIME=3205 : Ack followed by done in time after req
PASSED at TIME=3215 : Ack followed by done in time after req
PASSED at TIME=3225 : Ack followed by done in time after req
PASSED at TIME=3235 : Ack followed by done in time after req
PASSED at TIME=3245 : Ack followed by done in time after req
PASSED at TIME=3255 : Ack followed by done in time after req
PASSED at TIME=3265 : Ack followed by done in time after req
PASSED at TIME=3275 : Ack followed by done in time after req
PASSED at TIME=3285 : Ack followed by done in time after req
PASSED at TIME=3295 : Ack followed by done in time after req
PASSED at TIME=3305 : Ack followed by done in time after req
PASSED at TIME=3315 : Ack followed by done in time after req
PASSED at TIME=3325 : Ack followed by done in time after req
PASSED at TIME=3335 : Ack followed by done in time after req
PASSED at TIME=3345 : Ack followed by done in time after req
PASSED at TIME=3355 : Ack followed by done in time after req
PASSED at TIME=3365 : Ack followed by done in time after req
PASSED at TIME=3375 : Ack followed by done in time after req
PASSED at TIME=3385 : Ack followed by done in time after req
PASSED at TIME=3395 : Ack followed by done in time after req
PASSED at TIME=3405 : Ack followed by done in time after req
PASSED at TIME=3415 : Ack followed by done in time after req
PASSED at TIME=3425 : Ack followed by done in time after req    
