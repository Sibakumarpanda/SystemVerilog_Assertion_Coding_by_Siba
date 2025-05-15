//Q31. Write an assertion for a synchronous FIFO of depth = 16 for the full and empty scenarios.
module tb_fifo_top;  
    reg clk;
    reg write_enable;
    reg read_enable;
    wire full_flag;
    wire empty_flag;
    wire [3:0] word_count;  // Assuming depth = 16, word_count is 4-bits

    // Clock generation (Assumed clock)
    always #5 clk = ~clk;

    // Testbench stimulus and assertions
    initial begin
        clk = 0;
        write_enable = 0;
        read_enable = 0;

        // Test 1: Ensure FIFO behaves correctly when full
        // Fill the FIFO to make it full (16 writes)
        repeat(16) begin
            write_enable = 1;
            #10; // Time delay for each write operation
           
        end

        // Assert the FIFO is full when word_count reaches 16 and full_flag is asserted
        assert(word_count == 16) 
        else 
            $fatal("FIFO should be full but word_count is %0d", word_count);

        // Assert full_flag is asserted when FIFO is full
        assert(full_flag == 1) 
        else 
            $fatal("FIFO should be full but full_flag is not asserted");

        // Ensure no writes occur when FIFO is full (write_enable should be 0)
        write_enable = 1;
        #10;
        assert(full_flag == 1 && write_enable == 0) 
        else 
            $fatal("Write should be disabled when FIFO is full");

        // Test 2: Ensure FIFO behaves correctly when empty
        // Empty the FIFO by reading all the data (16 reads)
        read_enable = 1;
        repeat(16) begin
            #10; // Time delay for each read operation
        end

        // Assert the FIFO is empty when word_count reaches 0 and empty_flag is asserted
        assert(word_count == 0) 
        else 
            $fatal("FIFO should be empty but word_count is %0d", word_count);

        // Assert empty_flag is asserted when FIFO is empty
        assert(empty_flag == 1) 
        else 
            $fatal("FIFO should be empty but empty_flag is not asserted");

        // Ensure no reads occur when FIFO is empty (read_enable should be 0)
        read_enable = 1;
        #10;
        assert(empty_flag == 1 && read_enable == 0) 
        else 
            $fatal("Read should be disabled when FIFO is empty");

        // Test 3: Ensure word_count stays within the valid range (0 <= word_count <= 16)
        assert(word_count >= 0 && word_count <= 16) 
        else 
            $fatal("word_count is out of bounds: %0d", word_count);

        // Test 4: Ensure that no writes can happen when FIFO is full and no reads when FIFO is empty
        // Assert no writes when FIFO is full
        assert((full_flag == 0 && write_enable == 1) || (full_flag == 1 && write_enable == 0)) 
        else 
            $fatal("Write should be disabled when FIFO is full");

        // Assert no reads when FIFO is empty
        assert((empty_flag == 0 && read_enable == 1) || (empty_flag == 1 && read_enable == 0)) 
        else
            $fatal("Read should be disabled when FIFO is empty");

        $finish;
    end
endmodule

//Logfile output
[2025-05-15 11:01:37 UTC] vcs -full64 -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' design.sv testbench.sv  && ./simv +vcs+lic+wait  
                         Chronologic VCS (TM)
       Version U-2023.03-SP2_Full64 -- Thu May 15 07:01:39 2025

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
       tb_fifo_top
TimeScale is 1 ns / 1 ns

Warning-[SVA-IAU] Invalid argument used
testbench.sv, 32
tb_fifo_top, "$fatal("FIFO should be full but word_count is %0d", word_count);"
  The first argument ""FIFO should be full but word_count is %0d"" used in 
  '$fatal' is not valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.


Warning-[SVA-IAU] Invalid argument used
testbench.sv, 37
tb_fifo_top, "$fatal("FIFO should be full but full_flag is not asserted");"
  The first argument ""FIFO should be full but full_flag is not asserted"" 
  used in '$fatal' is not valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.


Warning-[SVA-IAU] Invalid argument used
testbench.sv, 44
tb_fifo_top, "$fatal("Write should be disabled when FIFO is full");"
  The first argument ""Write should be disabled when FIFO is full"" used in 
  '$fatal' is not valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.


Warning-[SVA-IAU] Invalid argument used
testbench.sv, 56
tb_fifo_top, "$fatal("FIFO should be empty but word_count is %0d", word_count);"
  The first argument ""FIFO should be empty but word_count is %0d"" used in 
  '$fatal' is not valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.


Warning-[SVA-IAU] Invalid argument used
testbench.sv, 61
tb_fifo_top, "$fatal("FIFO should be empty but empty_flag is not asserted");"
  The first argument ""FIFO should be empty but empty_flag is not asserted"" 
  used in '$fatal' is not valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.


Warning-[SVA-IAU] Invalid argument used
testbench.sv, 68
tb_fifo_top, "$fatal("Read should be disabled when FIFO is empty");"
  The first argument ""Read should be disabled when FIFO is empty"" used in 
  '$fatal' is not valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.


Warning-[SVA-IAU] Invalid argument used
testbench.sv, 73
tb_fifo_top, "$fatal("word_count is out of bounds: %0d", word_count);"
  The first argument ""word_count is out of bounds: %0d"" used in '$fatal' is 
  not valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.


Warning-[SVA-IAU] Invalid argument used
testbench.sv, 79
tb_fifo_top, "$fatal("Write should be disabled when FIFO is full");"
  The first argument ""Write should be disabled when FIFO is full"" used in 
  '$fatal' is not valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.


Warning-[SVA-IAU] Invalid argument used
testbench.sv, 84
tb_fifo_top, "$fatal("Read should be disabled when FIFO is empty");"
  The first argument ""Read should be disabled when FIFO is empty"" used in 
  '$fatal' is not valid. Only integer values 0,1 and 2 are allowed. 
  Refer to SystemVerilog LRM (1800-2012), section 20.10.

Starting vcs inline pass...

1 module and 0 UDP read.
recompiling module tb_fifo_top
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../simv ]; then chmod a-x ../simv; fi
g++  -o ../simv      -rdynamic  -Wl,-rpath='$ORIGIN'/simv.daidir -Wl,-rpath=./simv.daidir -Wl,-rpath=/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib -L/apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib  -Wl,-rpath-link=./   objs/amcQw_d.o   _331_archive_1.so   SIM_l.o       rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs    -lvcsnew -lsimprofile -luclinative /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive          /apps/vcsmx/vcs/U-2023.03-SP2/linux64/lib/vcs_save_restore_new.o -ldl  -lc -lm -lpthread -ldl 
../simv up to date
CPU time: .488 seconds to compile + .520 seconds to elab + .462 seconds to link
Chronologic VCS simulator copyright 1991-2023
Contains Synopsys proprietary information.
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  May 15 07:01 2025
"testbench.sv", 30: tb_fifo_top.unnamed$$_0: started at 160ns failed at 160ns
	Offending '(word_count == 16)'
Fatal: "testbench.sv", 30: tb_fifo_top.unnamed$$_0: at time 160 ns
FIFO should be full but word_count is z
$finish called from file "testbench.sv", line 30.
$finish at simulation time                  160
           V C S   S i m u l a t i o n   R e p o r t 
Time: 160 ns
Done
