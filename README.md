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
