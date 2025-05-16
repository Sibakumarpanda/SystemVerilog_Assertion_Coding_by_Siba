//Q37. How can all assertion be turned off during simulation (with active assertions)?

In SystemVerilog, all assertions can be globally turned off during simulation.
even if they are actively written in the code, using the compiler directive or runtime control mechanisms, it can be turned off.

1. Disable Assertions Using Compiler Directive:  
You can disable all assertions at compile time using:
Syntax:  
`define ASSERT_OFF
Then, wrap all your assertions with an ifdef block:
  
`ifndef ASSERT_OFF
 assert property (my_property);
`endif
   
This way, assertions won't be compiled into the simulation if ASSERT_OFF is defined.
  
2. Disable Assertions at Runtime (Preferred for Simulation):    
Most simulators support turning assertions on or off dynamically during simulation, without removing them from the code.
For Synopsys VCS, Use the command-line option:
+disable_assertions    
Or inside the simulation (in your testbench):  
$assertoff; //This disables all active assertions globally.                                     
$asserton; //To re-enable them:                                      
You can also disable assertions in specific modules as below:
$assertoff(0, my_module);  
                                                                  
For Cadence Xcelium, we can use below:
+noassert 
$assertkill;  // Kills all assertions
                                 
3.Use SVA Control with System Functions:
                                 
Function	                 Description
                                 
$assertoff	               Disables all immediate and concurrent assertions globally
$asserton	                 Re-enables assertions
$assertkill	               Terminates assertions permanently (used in some simulators)
$assertcontrol(...)	       Fine control over which assertions to enable/disable 
                                 
4. Example Snippet:
                                 
initial begin
  $display("Disabling assertions during reset...");
  $assertoff;    // Turn off all assertions
  reset = 1;
  #50;
  reset = 0;
  $asserton;     // Turn assertions back on
end
                                 
5. Summary:
                                 
Method	                               When to Use	                                     Example
                                 
+disable_assertions / $assertoff	    During simulation runtime	                         $assertoff;
ifdef + ASSERT_OFF	                  At compile time to exclude assertions	             \ifndef ASSERT_OFF`
Module-specific disable	              Disable assertions in a certain module	           $assertoff(0, my_mod);      

  
