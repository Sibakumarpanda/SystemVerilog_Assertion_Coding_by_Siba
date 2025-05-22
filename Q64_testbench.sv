//Q64. Can implication operator be used in sequences?

The implication operators (|-> and |=>) are not used directly inside sequences in SystemVerilog Assertions (SVA). 
Instead, they are used in properties, which then use sequences to define temporal behavior.

Why Can't You Use |-> or |=> in Sequences?

A sequence defines a series of events or conditions over time. It just specifies "what happens when."
An implication (|-> or |=>) expresses a conditional behavior: "If this happens, then that must follow." 
This is semantically different and belongs to a property.
  
You define your behavior with a sequence, and then use a property with an implication operator.

Example:

sequence handshake_seq;
  req ##1 ack;
endsequence

property handshake_property;
  req |-> handshake_seq;
endproperty

assert property (handshake_property);
  
  
Here: handshake_seq is a sequence: req followed by ack after 1 cycle.
handshake_property uses an implication operator (|->) to say: If req is true, then ack must follow according to the sequence.
  
Incorrect Example (for clarity): This will cause a compile error.

sequence bad_seq;
  req |-> ack; //  INVALID: implication not allowed in sequence
endsequence

Summary: 
                    
Implication operators (|->, |=>) are only valid in property constructs, not in sequence blocks.
Use sequences to define temporal patterns and then properties to assert conditions using implications.  
