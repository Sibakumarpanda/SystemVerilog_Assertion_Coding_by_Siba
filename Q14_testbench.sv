//Q14. Signal x should remain high or stable until signal y is asserted. Write an assertion for this.
module test_x_until_y_assertion;
  logic clk;      // Clock signal
  logic rst_n;    // Reset signal (active-low)
  logic x;        // Signal x
  logic y;        // Signal y
  
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
  end

  // Stimulus to test different cases
  initial begin
    // Reset the signals
    rst_n = 0;
    x = 0;
    y = 0;
    #3 rst_n = 1;  // Release reset after 3ns
    
    // Case 1: x remains high until y is asserted
    #10 x = 1;   // At time 13ns, x is high
    #10 y = 0;   // At time 23ns, y is still not asserted
    #10 x = 1;   // At time 33ns, x remains high
    #10 y = 1;   // At time 43ns, y is asserted (x remains high)
    
    // Case 2: x is not high when y is asserted (assertion fails)
    #10 x = 0;   // At time 53ns, x is low
    #10 y = 0;   // At time 63ns, y is still not asserted
    #10 x = 1;   // At time 73ns, x becomes high again
    #10 y = 1;   // At time 83ns, y is asserted (but x was low before)
    
    // Case 3: Reset, assertion is disabled during reset period
    #10 rst_n = 0;  // At time 93ns, reset is asserted (deassert x, y)
    #10 x = 1;  // At time 103ns, x is high but y is not asserted
    #10 y = 1;  // At time 113ns, y is asserted (assertion disabled)
    
    #20 $finish;  // End the simulation
  end

  // Assertion: x must remain high until y is asserted
  property x_remain_high_until_y_asserted;
    @(posedge clk)
    disable iff (rst_n)              // Disable assertion when rst_n is high
    (y == 1) |-> ##[0:$] (x == 1);  // Ensure x remains high until y is asserted
  endproperty

   // Assertion check
  assert_x_until_y: assert property (x_remain_high_until_y_asserted)
    begin
      // Display message on successful assertion
      $display("PASSED: x remains high until y is asserted at time %0t", $time);
    end
  else
    begin
      // Display message on failed assertion
      $error("FAILED: x did not remain high until y was asserted at time %0t", $time);
    end
  
  // For waveform generation
  initial begin
    $dumpfile("x_until_y.vcd");
    $dumpvars();
  end
endmodule

//Log file output
[2025-05-07 10:50:20 UTC] xrun -Q -unbuffered '-timescale' '1ns/1ns' '-sysv' '-access' '+rw' design.sv testbench.sv  
TOOL:	xrun	23.09-s001: Started on May 07, 2025 at 06:50:20 EDT
xrun: 23.09-s001: (c) Copyright 1995-2023 Cadence Design Systems, Inc.
	Top level design units:
		test_x_until_y_assertion
Loading snapshot worklib.test_x_until_y_assertion:sv .................... Done
xcelium> source /xcelium23.09/tools/xcelium/files/xmsimrc
xcelium> run
PASSED: x remains high until y is asserted at time 95
PASSED: x remains high until y is asserted at time 105
PASSED: x remains high until y is asserted at time 115
PASSED: x remains high until y is asserted at time 125
Simulation complete via $finish(1) at time 133 NS + 0
./testbench.sv:41     #20 $finish;  // End the simulation
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on May 07, 2025 at 06:50:21 EDT  (total: 00:00:01)
Done
    
