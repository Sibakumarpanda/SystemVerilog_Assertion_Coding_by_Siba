//Q63. What is the difference between an overlapping and non overlapping implication operator?

1. Overlapping Implication (|->)
Meaning: If the antecedent is true in a given clock cycle, the consequent starts evaluation in the same cycle.

Timeline:
Time:         T0   T1   T2 ...
Antecedent:   1    -    -
Consequent:   ↑ start evaluating here (T0)

Use case: Use when the consequent must happen immediately or starts at the same time as the antecedent.

Example:

property p_overlapping;
  a |-> b ##1 c;
endproperty
  
In above : If a is true at time T0, then: b must be true at T0 ,c must be true at T1
    
2. Non-Overlapping Implication (|=>)  
Meaning: If the antecedent is true in a given clock cycle, the consequent starts evaluation in the next cycle.
  
Timeline:

Time:         T0   T1   T2 ...
Antecedent:   1    -    -
Consequent:        ↑ start evaluating here (T1)
  
Use case:Use when the consequent must happen after the antecedent (i.e., strictly sequential behavior).

Example:

property p_nonoverlapping;
  a |=> b ##1 c;
endproperty
  
In above : If a is true at time T0, then: b must be true at T1 ,c must be true at T2  
