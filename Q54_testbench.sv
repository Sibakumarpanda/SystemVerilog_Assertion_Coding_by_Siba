//Q54. What are different types of assertions?

Assertions in SystemVerilog are used to verify the behavior of a design by checking specific conditions during simulation. 
They are a powerful tool for design verification and can be categorized into several types based on their usage and characteristics. 
Here are the main types of assertions:
  
1. Immediate Assertions: 
Purpose: Immediate assertions are evaluated at the point in the code where they appear. 
         They are typically used for simple checks that need to be performed instantaneously.
Syntax:  assert(expression);
Example: assert(a == b) else $error("a is not equal to b");
Characteristics: Immediate assertions are executed as procedural statements and are typically used for simple checks within procedural code.
    
2. Concurrent Assertions:  
Purpose: Concurrent assertions are evaluated over time and are used to check temporal properties of the design. 
         They are more powerful and flexible than immediate assertions.
Syntax: Defined using property and assert constructs.
Example:

property p;
  @(posedge clk) a |-> b;
endproperty
assert property (p);
  
Characteristics: Concurrent assertions can monitor sequences of events and are evaluated in parallel with the simulation. 
                 They are typically used for complex temporal checks.  
                   
                   
3. Cover Properties:                  
Purpose:  Cover properties are used to check if certain conditions or sequences occur during simulation. They are useful for coverage analysis.
Syntax:   Defined using cover construct.
Example:  cover property (@(posedge clk) a && b); 
  
Characteristics: Cover properties do not affect the simulation outcome but provide information about whether specific conditions were met.
  
4. Assume Properties:  
Purpose: Assume properties are used to specify assumptions about the environment or inputs to the design. 
         They are often used in formal verification.
Syntax: Defined using assume construct.
Example:  assume property (@(posedge clk) a == 1);
  
Characteristics: Assume properties are used to constrain the inputs or environment in formal verification, helping to focus the verification effort.
  
  
5. Sequence and Property Constructs:  
Purpose: Sequences and properties are used to define complex temporal behaviors that can be checked using assertions.
Syntax:  sequence and property constructs are used to define sequences of events and properties based on those sequences.
Example:  
  
sequence s;
  a ##1 b;
endsequence
  
property p;
  @(posedge clk) s |-> c;
endproperty
assert property (p);
  
Characteristics: Sequences allow the definition of ordered events, and properties use these sequences to specify conditions to be checked.                   
