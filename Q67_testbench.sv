//Q67. What does the system task $past() do?

In SystemVerilog Assertions (SVA), the $past() system function is used to access the value of a signal or expression from previous simulation cycles. 
This function is particularly useful for creating assertions that need to verify conditions based on historical values of signals, allowing you to check temporal properties over time.
   
Accessing Historical Values:
  
$past(expression, n) retrieves the value of expression from n simulation cycles ago.
If n is omitted, it defaults to 1, meaning it returns the value from the previous cycle.
   
Usage Context:
$past() is used within concurrent assertions to compare the current value of a signal with its value from previous cycles.
It is not valid in procedural code outside of assertions.
   
Syntax:
$past(expression, n)  
   
expression: The signal or expression whose past value you want to access.
n: The number of cycles back you want to access. Defaults to 1 if omitted.
  
Example:
  
property stable_signal;
  @(posedge clk)
  signal == $past(signal);
endproperty
   
This property checks that signal remains stable (unchanged) from the previous cycle.
  
Considerations:
$past() can only be used in contexts where the simulation history is available, such as within assertions.
It requires that the simulation maintains a history of signal values, which is typically managed by the assertion engine.   
    
Use Cases:  
Stability Checks: Verify that a signal remains unchanged over a specified number of cycles.
Edge Detection: Check for transitions by comparing current and past values.
Temporal Conditions: Implement conditions that depend on historical values, such as ensuring a signal was high for a certain number of cycles before a change.
  
Example Scenario: Suppose you want to assert that a signal enable remains high for at least 3 consecutive cycles before another signal start becomes high:

property enable_stable_before_start;
  @(posedge clk)
  $past(enable, 3) && $past(enable, 2) && $past(enable, 1) |-> start;
endproperty   
