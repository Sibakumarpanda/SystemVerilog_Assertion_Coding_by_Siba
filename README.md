# *****************************
# SystemVerilog_Assertion_Coding_by_Siba
# 👯 Acknowledgments : System Verilog community members , Open Source resources and Verification experts who have helped a lot in guiding me.
# 🤔 Encouragement   : Don't forget to star this repository if you find it helpful throughout your learning !!!
# ⚡ GitHub Repo     : https://github.com/Sibakumarpanda/SystemVerilog_Assertion_Coding_by_Siba
# *****************************
# -------->  Problem Sets for Practice <-------
# 1. Immediate assertions: if a and b are always equal
# 2. Concurrent assertions: if c is high on a clock cycle, then on next cycle, value of a and b is equal
# 3. Sequence samples values of a and b on every positive edge of clk and evaluates to true if both a and b are equal.
# 4. If the signal “a” change from a value of 0/x/z to 1 between two positive edges of clock, then $rose(a) will evaluate true.
# 5. Write an assertion check to make sure that a signal is high for a minimum of 2 cycles and a maximum of 6 cycles.
# 6. Write an assertion check to make sure that when (a==1), in the same cycle if “b” is true and the following cycle “c” is true then this property passes.
# 7. Write an assertion check to make sure that when (a==1) matches on any clock cycle, then in next cycle if “b” is true and a cycle later if “c” is true, then following property will pass.
# 8. when “a” is true, then next cycle “b” is evaluated and then if found true, next cycle “c” is evaluated, and if found true, the property passes.
# 9. Write an assertion checker to make sure that an output signal(mysignal) never goes X?
# 10. Write an assertion to make sure that the state variable in a state machine is always one hot value.
# 11. Write an assertion to make sure that a 5-bit grant signal only has one bit set at any time? (only one req granted at a time)
# 12. Write an assertion which checks that once a valid request(req) is asserted by the master, the arbiter provides a grant(gnt) within 2 to 5 clock cycles.
# 13. There are 2 signals x_sig and y_sig. On next clock of x_sig we should get y_sig. Write an assertion and also a cover property for the same. The assertion should be disabled when rst_n is high.
# 14. Signal x should remain high or stable until signal y is asserted. Write an assertion for this.
# 15. Write an assertion or property to check if signal y is reflected upon signal x immediately.
# 16. Write a property/assertion to check if signal "a" is toggling.
# 17. Write an assertion to check glitch detection in a signal.
# 18. Write an assertion to check clock gating.
# 19. Write an assertion/property to check time period/frequency of a signal/clock signal.
# 20. Write an property to check if signal "x" is equal to previous "x", signal y would be 0 .
# 21. Check that "writedata" should not go to unknown when "write_enable" becomes 0   .
# 22. Write an assertion to make sure FSM does not get stuck in current State except 'IDLE' .
# 23. Make sure signal toggles in the pattern "010101..." or "101010..." .
# 24. Write an assertion check to make sure that a signal is high for a minimum of 2 cycles and maximum of 6 cycles.
# 25. If there's an uncorrectable err during an ADD request, err_cnt should be incremented in the same cycle and an interrupt should be flagged in the next cycle.
# 26. Are following assertions equivalent:
           @(posedge clk) req |=> ##2 $rose(ack);
           @(posedge clk) req |-> ##3 $rose(ack);
# 27. Write an assertion such that ,everytime when the valid signal goes high, the count is incremented.
# 28. Write an assertion such that ,If the state machine reaches STATE=active1, it will eventually reach STATE=active2
# 29. Write an assertion such that ,When there's a no_space_err, the no_space_ctr_incr signal is flagged for exactly once clock
# 30. Write an assertion such that ,If signal_a is active, then signal_b was active 3 cycles ago.
# 31. Write an assertion for a synchronous FIFO of depth = 16 for the following scenarios. Assume a clock signal(clk), write and read enable signals, full flag and a word counter signal.
    a) If the word count is >15, FIFO full flag set.
    b) If the word count is 15 and a new write operation happens without a simultaneous read, then the FIFO full flag is set.


