/* Q26. Are following assertions equivalent:
       @(posedge clk) req |=> ##2 $rose(ack);
       @(posedge clk) req |-> ##3 $rose(ack);
       
*/

Assertion-1:

 @(posedge clk) req |=> ##2 $rose(ack);

Type: Non-overlapped implication (|=>)

Semantics:

When req is true on a clock edge (say at cycle t), the RHS (##2 $rose(ack)) is checked starting from t+1.

##2 $rose(ack) means that $rose(ack) should occur on cycle t+3 (2 clocks after the implication starts).

t:      req == 1
t+1:    start counting delay (RHS evaluated , 1 clock cycle after req)
t+3:    $rose(ack) must be true


Assertion-2:

@(posedge clk) req |-> ##3 $rose(ack);
Type: Overlapped implication (|->)

Semantics:

When req is true on a clock edge (say at cycle t), the RHS (##3 $rose(ack)) is checked starting from t itself.

##3 $rose(ack) means that $rose(ack) should occur on cycle t+3 (3 clocks after t).

t:      req == 1
t:      RHS evaluated at same clock cycle as req
t+3:    $rose(ack) must be true


Comparison between both :

| Feature | Assertion 1 (|=> ##2) | Assertion 2 (|-> ##3) |
|--------------------------|------------------------------------|------------------------------------|
| Implication type | Non-overlapped | Overlapped |
| When RHS starts | 1 cycle after req | Same cycle as req |
| When $rose(ack) occurs | At t+3 | At t+3 |
| Practical difference | Slightly different trigger timing | Immediate trigger |


Summary:
Both assertions check that $rose(ack) happens 3 cycles after req becomes true. 

But:

The first assertion triggers on the next clock after req, while
The second assertion starts checking immediately.

While they both validate $rose(ack) at the same cycle (t+3), the implication type affects the precise triggering behavior and timing semantics, 
which may matter if used in formal verification tools or simulations that are sensitive to assertion types.
