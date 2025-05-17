# *****************************
# SystemVerilog_Assertion_Coding_by_Siba
# 👯 Acknowledgments : System Verilog community members , Open Source resources and Verification experts who have helped a lot and guided me.
# 🤔 Encouragement   : Don't forget to star this repository if you find it helpful throughout your learning !!!
# ⚡ GitHub Repo     : https://github.com/Sibakumarpanda/SystemVerilog_Assertion_Coding_by_Siba
# *****************************
# -------->  Problem Sets for Practice <-------
# Q1. Immediate assertions: if a and b are always equal
# Q2. Concurrent assertions: if c is high on a clock cycle, then on next cycle, value of a and b is equal
# Q3. Sequence samples values of a and b on every positive edge of clk and evaluates to true if both a and b are equal.
# Q4. If the signal “a” change from a value of 0/x/z to 1 between two positive edges of clock, then $rose(a) will evaluate true.
# Q5. Write an assertion check to make sure that a signal is high for a minimum of 2 cycles and a maximum of 6 cycles.
# Q6. Write an assertion check to make sure that when (a==1), in the same cycle if “b” is true and the following cycle “c” is true then this property passes.
# Q7. Write an assertion check to make sure that when (a==1) matches on any clock cycle, then in next cycle if “b” is true and a cycle later if “c” is true, then following property will pass.
# Q8. when “a” is true, then next cycle “b” is evaluated and then if found true, next cycle “c” is evaluated, and if found true, the property passes.
# Q9. Write an assertion checker to make sure that an output signal(mysignal) never goes X?
# Q10. Write an assertion to make sure that the state variable in a state machine is always one hot value.
# Q11. Write an assertion to make sure that a 5-bit grant signal only has one bit set at any time? (only one req granted at a time)
# Q12. Write an assertion which checks that once a valid request(req) is asserted by the master, the arbiter provides a grant(gnt) within 2 to 5 clock cycles.
# Q13. There are 2 signals x_sig and y_sig. On next clock of x_sig we should get y_sig. Write an assertion and also a cover property for the same. The assertion should be disabled when rst_n is high.
# Q14. Signal x should remain high or stable until signal y is asserted. Write an assertion for this.
# Q15. Write an assertion or property to check if signal y is reflected upon signal x immediately.
# Q16. Write a property/assertion to check if signal "a" is toggling.
# Q17. Write an assertion to check glitch detection in a signal.
# Q18. Write an assertion to check clock gating.
# Q19. Write an assertion/property to check time period/frequency of a signal/clock signal.
# Q20. Write an property to check if signal "x" is equal to previous "x", signal y would be 0 .
# Q21. Check that "writedata" should not go to unknown when "write_enable" becomes 0   .
# Q22. Write an assertion to make sure FSM does not get stuck in current State except 'IDLE' .
# Q23. Make sure signal toggles in the pattern "010101..." or "101010..." .
# Q24. Write an assertion check to make sure that a signal is high for a minimum of 2 cycles and maximum of 6 cycles.
# Q25. If there's an uncorrectable err during an ADD request, err_cnt should be incremented in the same cycle and an interrupt should be flagged in the next cycle.
# Q26. Are following assertions equivalent:
           @(posedge clk) req |=> ##2 $rose(ack);
           @(posedge clk) req |-> ##3 $rose(ack);
# Q27. Write an assertion such that ,everytime when the valid signal goes high, the count is incremented.
# Q28. Write an assertion such that ,If the state machine reaches STATE=active1, it will eventually reach STATE=active2
# Q29. Write an assertion such that ,When there's a no_space_err, the no_space_ctr_incr signal is flagged for exactly once clock
# Q30. Write an assertion such that ,If signal_a is active, then signal_b was active 3 cycles ago.
# Q31. Write an assertion for a synchronous FIFO of depth = 16 for the following scenarios. Assume a clock signal(clk), write and read enable signals, full flag and a word counter signal.
# Q32. Write an assertion checker to make sure that an output signal never goes X.
# Q33. Write an assertion check to make sure that a signal is high for a minimum of 2 cycles and a maximum of 6 cycles
# Q34. Write an assertion to make sure that a 5-bit grant signal only has one bit set at any time.
# Q35. Write an assertion which checks that once a valid request is asserted by the master, the arbiter provides a grant within 2 to 5 clock cycles
# Q36. How can you disable an assertion during active reset time?
# Q37. How can all assertion be turned off during simulation (with active assertions)?
# Q38. As long as signal_a is up, signal_b should not be asserted. Write an assertion for this.
# Q39. The signal_a is a pulse. it can only be asserted for one cycle, and must be deasserted in the next cycle. Write an assertion for this.
# Q40. Signal_a and signal_b can only be asserted together for one cycle; in the next cycle, at least one of them must be deasserted.
# Q41. When signal_a is asserted, signal_b must be asserted, and must remain up until one of the signals signal_c or signal_d is asserted
# Q42. After signal_a is asserted, signal_b must be deasserted, and must stay down until the next signal_a.
# Q43. Write an assertion such that ,If signal_a is received while signal_b is inactive, then on the next cycle signal_c must be inactive, and signal_b must be asserted.
# Q44. signal_a must not be asserted together with signal_b or with signal_c.
# Q45. In a RESP operation, request must be true immediately, grant must be true 3 clock cycles later, followed by request being false, and then grant being false. WAA for this.
# Q46. Request must true at the current cycle,grant must become true sometime between 1 cycle after request and the end of time.
# Q47. Req must eventually be followed by ack, which must be followed 1 cycle later by done.WAA for this.
# Q48. The active-low reset must be low for at least 6 clock cycles.WAA for this.
# Q49. Enable must remain true throughout the entire ack to done sequence. WAA for this.
# Q50. If signal_a is active, then signal_b was active 3 cycles ago.
# Q51. If the state machine reaches active1 state, it will eventually reach active2 state.
# Q52. Write an assertion such that A high for 5 cycles and B high after 4 continuous highs of A and finally both A and B are high.
# Q53. Write an assertion such that On rose of a, wait for rose of b or c. If b comes first, then d should be 1. If c comes first d should be zero.
# Q54. What are different types of assertions? 
# Q55. What are the differences between Immediate and Concurrent
# Q56. What are the advantages of writing a checker using SVA (SystemVerilog Assertions) as compared to writing it using a procedural SystemVerilog code?
# Q57. What are the different ways to write assertions for a design unit? What is a sequence as used in writing SystemVerilog Assertions?
# Q58. Is there a difference between $rose(tst_signal) and @posedge(tst_signal )? 
# Q59. Is it possible to have concurrent assertions implemented inside a class?
# Q60. What is a sequence repetition operator? What are the three different type of repetition operators used in sequences?
# Q61. Write an assertion check to make sure that a signal is high for a minimum of 2 cycles and a maximum of 6 cycles. 
# Q62. What is an implication operator? 
# Q63. What is the difference between an overlapping and non  overlapping implication operator? 
# Q64. Can implication operator be used in sequences?
# Q65 Are following assertions equivalent? 
     a) @(posedge clk) req |=> ##10 $rose(ack);
     b) @(posedge clk) req |-> ##11 $rose(ack);
# Q66. Is nested implication allowed in SVA? 
# Q67. What does the system task $past() do?
# Q68. Write an assertion checker to make sure that an output signal never goes X? 
# Q69. Write an assertion to make sure that the state variable in a state machine is always one hot value. Write an assertion to make sure that a 5-bit grant signal only has one bit set at any time? (only one req granted at a time) 
# Q70. Write an assertion which checks that once a valid request is asserted by the master, the arbiter provides a grant within 2 to 5 clock cycles
# Q71. How can you disable an assertion during active reset time? 
# Q72. What’s the difference between assert and assume directives in SystemVerilog?
# Q73. What is bind construct used in SystemVerilog for? 
# Q74. How can all assertions be turned off during simulation?
# Q75. What are the different ways in which a clock can be specified to a property used for assertion?
