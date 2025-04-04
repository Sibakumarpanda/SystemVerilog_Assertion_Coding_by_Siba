//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_assertion.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : Possible Assertions for Synchronous FIFO verification
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

module synch_fifo_assertion(clk,reset,re,we,data_in,data_out,full,empty);
  
  parameter DATA_WIDTH=32;
  parameter ADDR_WIDTH=3;
  
  input clk,reset;
  input re, we; 
  input [DATA_WIDTH-1:0]data_in;                       //input [31:0]data_in; //32bit
  output full,empty;    
  output reg [DATA_WIDTH-1:0]data_out;                //output reg [31:0]data_out; //32bit  
  reg [ADDR_WIDTH-1:0] waddr;                        //3bit-write pointer address
  reg [ADDR_WIDTH-1:0] raddr;                       //3bit-read pointer address  
  reg [DATA_WIDTH-1:0] mem [(2**ADDR_WIDTH-1):0];  //reg [31:0] mem [8]; Memory= width x Depth=32 x8
    
  property SYNCH_FIFO_RESET_CONDITION_CHECK;
     @(posedge clk) 
    reset |-> (raddr===0) && (waddr===0) && (empty===1) && (full===0);
  endproperty
  
  P1:assert property (SYNCH_FIFO_RESET_CONDITION_CHECK)     
    `uvm_info("P1", $sformatf("Assertion for SYNCH_FIFO_RESET_CONDITION_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
  else    
    //`uvm_error("P1", $sformatf("Assertion for SYNCH_FIFO_RESET_CONDITION_CHECK FAILED at TIME=%0dns",$time))
    `uvm_warning("P1", $sformatf("Assertion for SYNCH_FIFO_RESET_CONDITION_CHECK FAILED at TIME=%0dns",$time))
    
  property SYNCH_FIFO_EMPTY_CONDITION_CHECK;
     @(posedge clk) disable iff (reset)
    empty == (waddr == raddr);
  endproperty
    
  P2:assert property (SYNCH_FIFO_EMPTY_CONDITION_CHECK)    
    `uvm_info("P2", $sformatf("Assertion for SYNCH_FIFO_EMPTY_CONDITION_CHECK  PASSED at TIME=%0dns", $time), UVM_LOW)
    else    
      `uvm_error("P2", $sformatf("Assertion for SYNCH_FIFO_EMPTY_CONDITION_CHECK  FAILED at TIME=%0dns",$time))
      
  property SYNCH_FIFO_FULL_CONDITION_CHECK;
     @(posedge clk) disable iff (reset)
    full == ((waddr -raddr)==7);
  endproperty
    
  P3:assert property (SYNCH_FIFO_FULL_CONDITION_CHECK)    
      `uvm_info("P3", $sformatf("Assertion for SYNCH_FIFO_FULL_CONDITION_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
    else    
      `uvm_error("P3", $sformatf("Assertion for SYNCH_FIFO_FULL_CONDITION_CHECK  FAILED at TIME=%0dns",$time))
  
  property SYNCH_FIFO_FULL_ATTEMPTED_WRITE;
     @(posedge clk) disable iff (reset)
    full && we && !re |-> $stable(waddr);
  endproperty
    
  P4:assert property (SYNCH_FIFO_FULL_ATTEMPTED_WRITE)    
      `uvm_info("P4", $sformatf("Assertion for SYNCH_FIFO_FULL_ATTEMPTED_WRITE  PASSED at TIME=%0dns", $time), UVM_LOW)
    else    
      `uvm_error("P4", $sformatf("Assertion for SYNCH_FIFO_FULL_ATTEMPTED_WRITE  FAILED at TIME=%0dns",$time)) 
      
  property SYNCH_FIFO_EMPTY_ATTEMPTED_READ;
     @(posedge clk) disable iff (reset)
    empty && re && !we |-> $stable(raddr);
  endproperty
    
  P5:assert property (SYNCH_FIFO_EMPTY_ATTEMPTED_READ)    
      `uvm_info("P5", $sformatf("Assertion for SYNCH_FIFO_EMPTY_ATTEMPTED_READ  PASSED at TIME=%0dns", $time), UVM_LOW)
    else    
      `uvm_error("P5", $sformatf("Assertion for SYNCH_FIFO_EMPTY_ATTEMPTED_READ  FAILED at TIME=%0dns",$time)) 
  
  property SYNCH_FIFO_DATA_WRITE_READ_CHECK;
     @(posedge clk) disable iff (reset)
    // (we && !full) |-> (mem[waddr] == data_in);
    (re && !empty) |-> (data_out == mem[raddr]);
  endproperty
    
  P9:assert property (SYNCH_FIFO_DATA_WRITE_READ_CHECK)    
      `uvm_info("P9", $sformatf("Assertion for SYNCH_FIFO_DATA_WRITE_READ_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
    else    
      `uvm_error("P9", $sformatf("Assertion for SYNCH_FIFO_DATA_WRITE_READ_CHECK  FAILED at TIME=%0dns",$time))    
      
  property SYNCH_FIFO_DEPTH_CHECK;
    @(posedge clk) disable iff (reset)
    ((waddr - raddr) <= 8); // FIFO Depth=8
  endproperty
    
  P10:assert property (SYNCH_FIFO_DEPTH_CHECK)    
      `uvm_info("P10", $sformatf("Assertion for SYNCH_FIFO_DEPTH_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
    else    
      `uvm_error("P10", $sformatf("Assertion for SYNCH_FIFO_DEPTH_CHECK  FAILED at TIME=%0dns",$time))  
      
  property SYNCH_FIFO_WRITE_POINTER_WRAPAROUND_CHECK;
     @(posedge clk) disable iff (reset)
    (waddr == 8) |-> (waddr == 0); // FIFO Depth=8
  endproperty
    
  P11:assert property (SYNCH_FIFO_WRITE_POINTER_WRAPAROUND_CHECK)    
      `uvm_info("P11", $sformatf("Assertion for SYNCH_FIFO_WRITE_POINTER_WRAPAROUND_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
  else    
      `uvm_error("P11", $sformatf("Assertion for SYNCH_FIFO_WRITE_POINTER_WRAPAROUND_CHECK  FAILED at TIME=%0dns",$time)) 
    
  property SYNCH_FIFO_READ_POINTER_WRAPAROUND_CHECK;
     @(posedge clk) disable iff (reset)
    (raddr == 8) |-> (raddr == 0);
  endproperty
    
  P12:assert property (SYNCH_FIFO_READ_POINTER_WRAPAROUND_CHECK)    
      `uvm_info("P12", $sformatf("Assertion for SYNCH_FIFO_READ_POINTER_WRAPAROUND_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
    else    
      `uvm_error("P12", $sformatf("Assertion for SYNCH_FIFO_READ_POINTER_WRAPAROUND_CHECK  FAILED at TIME=%0dns",$time)) 
      
  property SYNCH_FIFO_EMPTY_TO_NONEMPTY_TRANSITION_CHECK;
     @(posedge clk) disable iff (reset)
    ((empty && we) |-> !empty);
  endproperty
    
  P13:assert property (SYNCH_FIFO_EMPTY_TO_NONEMPTY_TRANSITION_CHECK)    
      `uvm_info("P13", $sformatf("Assertion for SYNCH_FIFO_EMPTY_TO_NONEMPTY_TRANSITION_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
    else    
      `uvm_error("P13", $sformatf("Assertion for SYNCH_FIFO_EMPTY_TO_NONEMPTY_TRANSITION_CHECK  FAILED at TIME=%0dns",$time))
      
  property SYNCH_FIFO_FULL_TO_NONFULL_TRANSITION_CHECK;
     @(posedge clk) disable iff (reset)
    ((full && re) |-> !full);
  endproperty
    
  P14:assert property (SYNCH_FIFO_FULL_TO_NONFULL_TRANSITION_CHECK)   
      `uvm_info("P14", $sformatf("Assertion for SYNCH_FIFO_FULL_TO_NONFULL_TRANSITION_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
      else    
      `uvm_error("P14", $sformatf("Assertion for SYNCH_FIFO_FULL_TO_NONFULL_TRANSITION_CHECK  FAILED at TIME=%0dns",$time)) 
        
  property SYNCH_FIFO_INVALID_WRITE_WHEN_FULL;
     @(posedge clk) disable iff (reset)
    !(full && we);
  endproperty
    
  P15:assert property (SYNCH_FIFO_INVALID_WRITE_WHEN_FULL)   
      `uvm_info("P15", $sformatf("Assertion for SYNCH_FIFO_INVALID_WRITE_WHEN_FULL PASSED at TIME=%0dns", $time), UVM_LOW)
      else   
      `uvm_error("P15", $sformatf("Assertion for SYNCH_FIFO_INVALID_WRITE_WHEN_FULL  FAILED at TIME=%0dns",$time))      
      
  property SYNCH_FIFO_INVALID_READ_WHEN_EMPTY;
     @(posedge clk) disable iff (reset)
     !(empty && re);
  endproperty
    
  P16:assert property (SYNCH_FIFO_INVALID_READ_WHEN_EMPTY)   
       `uvm_info("P16", $sformatf("Assertion for SYNCH_FIFO_INVALID_READ_WHEN_EMPTY PASSED at TIME=%0dns", $time), UVM_LOW)
      else    
       `uvm_error("P16", $sformatf("Assertion for SYNCH_FIFO_INVALID_READ_WHEN_EMPTY FAILED at TIME=%0dns",$time)) 
        
  property SYNCH_FIFO_UNDERFLOW_CHECK;
     @(posedge clk) disable iff (reset)
     !(re && empty);
  endproperty
    
  P17:assert property (SYNCH_FIFO_UNDERFLOW_CHECK)   
      `uvm_info("P17", $sformatf("Assertion for SYNCH_FIFO_UNDERFLOW_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
      else    
      `uvm_error("P17", $sformatf("Assertion for SYNCH_FIFO_UNDERFLOW_CHECK FAILED at TIME=%0dns",$time))
        
  property SYNCH_FIFO_OVERFLOW_CHECK;
     @(posedge clk) disable iff (reset)
     !(we && full);
  endproperty
    
  P18:assert property (SYNCH_FIFO_OVERFLOW_CHECK)   
      `uvm_info("P18", $sformatf("Assertion for SYNCH_FIFO_OVERFLOW_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
      else    
      `uvm_error("P18", $sformatf("Assertion for SYNCH_FIFO_OVERFLOW_CHECK FAILED at TIME=%0dns",$time))  
        
  property SYNCH_FIFO_DATA_PROPAGATION_CHECK;
     @(posedge clk) disable iff (reset)
    // ((we && !full) |-> mem[waddr] == data_in);
    ((re && !empty) |-> data_out == mem[raddr]);
  endproperty
                                  
  P19:assert property (SYNCH_FIFO_DATA_PROPAGATION_CHECK)   
      `uvm_info("P19", $sformatf("Assertion for SYNCH_FIFO_DATA_PROPAGATION_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
      else    
      `uvm_error("P19", $sformatf("Assertion for SYNCH_FIFO_DATA_PROPAGATION_CHECK FAILED at TIME=%0dns",$time)) 
        
  property SYNCH_FIFO_CLOCK_DOMAIN_CROSS_CHECK;
     @(posedge clk) disable iff (reset)
    (waddr == raddr);
  endproperty
    
  P20:assert property (SYNCH_FIFO_CLOCK_DOMAIN_CROSS_CHECK)   
      `uvm_info("P20", $sformatf("Assertion for SYNCH_FIFO_CLOCK_DOMAIN_CROSS_CHECK PASSED at TIME=%0dns", $time), UVM_LOW)
     else    
      `uvm_error("P20", $sformatf("Assertion for SYNCH_FIFO_CLOCK_DOMAIN_CROSS_CHECK FAILED at TIME=%0dns",$time))      
    
  
endmodule :synch_fifo_assertion
