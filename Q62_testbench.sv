//Q62. What is an implication operator?
In SystemVerilog Assertions (SVA), the implication operator (|-> and |=>) is used to express temporal implication — that is, to specify a condition that must hold over time after a certain condition (called the antecedent) becomes true.
There are two types of implication operators in SVA:
    
1. Overlapping Implication (|->) / Same cycle Implication Operator
  
Syntax: antecedent |-> consequent

Meaning: If the antecedent is true in a given cycle, then the consequent must be true starting in the same cycle.

Use case: When the consequence must occur in parallel with or right after the antecedent.

Example:

property p1;
  req |-> ##1 grant;
endproperty
  
Interpretation: If req is true in a given clock cycle, then grant must be true exactly 1 cycle later.
    
2. Non-Overlapping Implication (|=>) / Next cycle Implication Operator
  
Syntax: antecedent |=> consequent

Meaning: If the antecedent is true in a given cycle, then the consequent must be true starting in the next cycle.

Use case: When the consequence should happen after the antecedent, not simultaneously.

Example:

property p2;
  start |=> ##1 done;
endproperty  
Interpretation: If start is true in a given cycle, then done must be true 2 cycles later (because ##1 is one cycle after the first cycle after start).    
