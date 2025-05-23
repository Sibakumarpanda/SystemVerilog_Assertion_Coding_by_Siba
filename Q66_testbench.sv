//Q66. Is nested implication allowed in SVA?

Yes, nested implications are allowed in SystemVerilog Assertions (SVA). 
Nested implications enable you to express complex temporal relationships and dependencies between sequences. 
However, when using nested implications, it's important to understand the semantics and ensure that the logic is clear and correctly captures the intended behavior.

Understanding Nested Implications:

Nested implications involve using implication operators (|-> or |=>) within the consequent or antecedent of another implication. This allows you to build hierarchical or conditional assertions that depend on multiple levels of conditions.

Example:

property nested_implication_example;
  @(posedge clk)
  A |-> (B |-> C);
endproperty

Explanation:

Outer Implication (A |-> (B |-> C)):
Antecedent: A is the condition that triggers the evaluation of the consequent.
Consequent: The consequent is itself an implication: (B |-> C).

Inner Implication (B |-> C):
Antecedent: B is the condition that triggers the evaluation of C.
Consequent: C must be true if B is true.
