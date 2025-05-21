//Q55. What are the differences between Immediate and Concurrent Assertion

Immediate and concurrent assertions are two types of assertions in SystemVerilog, each serving different purposes and having distinct characteristics. 
Here are the key differences between them:

1. Immediate Assertions-:

Evaluation Timing: Immediate assertions are evaluated at the exact point in the procedural code where they appear. 
                   They are executed immediately during simulation.

Usage Context:     They are used within procedural blocks such as initial, always, or task blocks.
                   Suitable for simple checks that need to be performed instantaneously, such as verifying the value of a variable at a specific point in time.
                     
Syntax:            The syntax is straightforward: assert(expression);

Example:           assert(a == b) else $error("a is not equal to b");

Behavior:          If the condition in the assertion is false, the specified action (such as $error) is executed immediately.
                   They do not have temporal logic capabilities and cannot check sequences of events over time.
                     
Scope:             Immediate assertions are local to the block in which they are defined and are part of the procedural execution flow.
                     
2. Concurrent Assertions-:
                     
Evaluation Timing: Concurrent assertions are evaluated over time, typically synchronized with a clock or other event. 
                   They are checked continuously throughout the simulation.Usage Context:
                   They are used outside of procedural blocks and are part of the declarative context of the module.
                   Suitable for complex temporal checks, such as verifying sequences of events or conditions that span multiple clock cycles.
                     
Syntax:            Defined using property and assert constructs.
  
Example:

property p;
  @(posedge clk) a |-> b;
endproperty
assert property (p);
  
Behavior: They can include temporal logic, allowing them to monitor sequences of events and conditions over time.
          If the condition specified by the property is violated, the assertion triggers an error or other specified action.
            
Scope:    Concurrent assertions are global within the module and are evaluated in parallel with the simulation, independent of the procedural execution flow.
