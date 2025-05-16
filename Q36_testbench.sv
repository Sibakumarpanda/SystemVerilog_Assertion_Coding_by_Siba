//Q36. How can you disable an assertion during active reset time?
Ans :
In SystemVerilog, if you want to disable an assertion during an active reset, the best way is to use the disable iff construct. 
This disables the assertion when a specified condition (typically the reset signal) is true.
  
Example: 
  
property p_example;
  @(posedge clk)
  disable iff (reset)  // Assertion disabled when reset is high (active)
  some_condition |=> some_response;
endproperty

assert property (p_example);
  
  
Explanation:
  
disable iff (reset) tells the assertion to be inactive when reset is high.

This means the assertion is not evaluated or triggered when reset is active.

disable iff is synchronous, meaning the disabling condition is sampled on the same clock edge as the assertion trigger.

If reset is active-low, then we need to write as below:So it disables the assertion while reset is active (i.e., when reset_n is 0).

disable iff (!reset_n)
