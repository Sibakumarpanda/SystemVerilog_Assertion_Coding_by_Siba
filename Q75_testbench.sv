//Q75. What are the different ways in which a clock can be specified to a property used for assertion?

In SystemVerilog Assertions (SVA), specifying a clock to a property is crucial because it determines the timing and synchronization of the assertion evaluation. 
There are several ways to specify a clock for a property, allowing flexibility in how assertions are triggered and evaluated. Here are the different methods:
    
1. Event-Based Clock Specification:
  
The most common way to specify a clock in a property is by using an event expression, typically a rising edge of a clock signal. 
This is done using the @ operator followed by the event expression.
  
Syntax: @(event_expression)
  
Example:

property p;
  @(posedge clk) a |-> b;
endproperty
  
Explanation: The property p is evaluated on the rising edge of clk.  
  
  
2. Implicit Clocking:
  
If a property is defined within a module that has a default clocking block, the property can implicitly use the clock specified in that block.
  
Clocking Block:

clocking default_cb @(posedge clk);
  default input #1step output #1step;
endclocking
  
Property Using Implicit Clock:

property p;
  a |-> b; // Implicitly uses the clock from the default clocking block
endproperty
    
3. Global Clocking:
  
In some verification environments, a global clocking scheme might be used where a clock is specified at a higher level, such as in a testbench or environment configuration.  
Example:

property p;
  @(global_clk) a |-> b;
endproperty
  
Explanation: global_clk is a signal defined at a higher level, used to synchronize assertions across multiple modules or components.  
  
  
4. Using Multiple Clocks:
  
Properties can be defined to use multiple clocks by specifying different event expressions for different parts of the property. 
  
Example:

property p;
  @(posedge clk1) a |-> @(posedge clk2) b;
endproperty
  
Explanation: The antecedent a is evaluated on the rising edge of clk1, and the consequent b is evaluated on the rising edge of clk2.  
    
5. Parameterized Clock:  
In more advanced usage, a property can be parameterized to accept a clock signal as an argument, allowing the same property to be used with different clocks.  
Example:
  
property p(input logic clk);
  @(posedge clk) a |-> b;
endproperty

assert property (p(clk1));
assert property (p(clk2));
  
Summary:
  
Event-Based Clock Specification:   Directly specify the clock using an event expression.
Implicit Clocking:                 Use the default clocking block within a module.
Global Clocking:                   Use a clock defined at a higher level for synchronization across components.
Multiple Clocks:                   Specify different clocks for different parts of a property.
Parameterized Clock:               Define properties that can be used with different clocks by passing the clock as a parameter.  
