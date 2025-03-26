// Possible Assertions in Synchronous FIFO 
  property reset;
    @(posedge clk)
    (rst==0 |=> (wr_ptr==0 && rd_ptr==0 && fifo_cnt==0 && full==0 && empty==1));
  endproperty
  
  property fifo_full;
    @(posedge clk)
    disable iff(!rst)
    (fifo_cnt > 7|-> full==1 );
  endproperty
  
  property fifo_not_full;
    @(posedge clk)
    disable iff(!rst)
    (fifo_cnt < 8|-> !full);
  endproperty
  
  property fifo_should_go_full;
    @(posedge clk)
    disable iff(!rst)
    (fifo_cnt==7 && rd==0 && wr==1|=> full);
  endproperty
  
  property full_write_full;
    @(posedge clk) 
    disable iff (!rst)
    (full && wr && !rd |=> full && $stable(wr_ptr) );
  endproperty
  
  property fifo_empty;
    @(posedge clk)
    disable iff(!rst)
    (fifo_cnt==0 |-> empty );
  endproperty
    
  property empty_read;
    @(posedge clk) 
    disable iff(!rst)
    (empty && rd && !wr |=> empty);
  endproperty
  /////////////////////////////////  
  assert property(reset)
    begin
      $display($time, ": Assertion Passed: The design passed the reset condition");
      $display("Read pointer, write pointer, fifo count, full flag and empty flag are now reset");
    end
    else
      $display("Assertion Failed: The design failed the reset condition");
      
  assert property(fifo_full)
    begin
      $display($time, ": Assertion Passed: The design passed the fifo full condition.");
      $display("Fifo full flag is high");
    end
    else
      $display($time, ": Assertion Failed: The design failed the fifo full condition.");
   
  assert property(fifo_not_full)
    begin
      $display($time, ": Assertion Passed: The design passed the fifo not full condition.");
      $display("Fifo full flag is not high");
    end
    else
      $display($time, ": Assertion Failed: The design failed the fifo not full condition.");
    
    
  assert property(fifo_should_go_full)
    begin
      $display($time, ": Assertion Passed: The design passed the fifo should go full condition.");
    end
    else
      $display($time, ": Assertion Failed: The design failed the fifo should go full condition.");
   
    
  assert property(full_write_full)
    begin
      $display($time, ": Assertion Passed: The design passed the write in full fifo condition.");
      $display("You are writing in a full fifo and fifo full flag is high");
    end
    else
      $display($time, ": Assertion Failed: The design failed the write in full fifo condition.");
  
    
  assert property(fifo_empty)
    begin
      $display($time, ": Assertion Passed: The design passed the fifo empty condition.");
      $display("Fifo empty flag is high");
    end
    else
      $display($time, ": Assertion Failed: The design failed the fifo empty condition.");
   
  assert property(empty_read)
    begin
      $display($time, ": Assertion Passed: The design passed the fifo empty read condition.");
      $display("You are trying to read from empty fifo, fifo empty flag is high");
    end
    else
      $display($time, ": Assertion Failed: The design failed the fifo empty read condition.");
   

//1. Asynchronous reset assertions
  // Reset startup check //
  // need this at the very begining of the simulation //
  property async_rst_startup;
	  @(posedge i_clk) !i_rst_n |-> ##1 (wr_ptr==0 && rd_ptr == 0 && o_empty);
  endproperty
  
  // rst check in general
  property async_rst_chk;
	  @(negedge i_rst_n) 1'b1 |-> ##1 @(posedge i_clk) (wr_ptr==0 && rd_ptr == 0 && o_empty);
  endproperty

//2.Check data written at a location is the same data read when read_ptr reaches that location
  sequence rd_detect(ptr);
    ##[0:$] (rd_en && !o_empty && (rd_ptr == ptr));
  endsequence
  
  property data_wr_rd_chk(wrPtr);
    // local variable
    integer ptr, data;
    @(posedge i_clk) disable iff(!i_rst_n)
    (wr_en && !o_full, ptr = wrPtr, data = i_data, $display($time, " wr_ptr=%h, i_fifo=%h",wr_ptr, i_data))
    |-> ##1 first_match(rd_detect(ptr), $display($time, " rd_ptr=%h, o_fifo=%h",rd_ptr, o_data)) ##0  o_data == data;
  endproperty

//3.Rule-1: Never write to FIFO if it's Full!
  property dont_write_if_full;
    // @(posedge i_clk) disable iff(!i_rst_n) o_full |-> ##1 $stable(wr_ptr);
    // alternative way of writing the same assertion
    @(posedge i_clk) disable iff(!i_rst_n) wr_en && o_full |-> ##1 wr_ptr == $past(wr_ptr);
  endproperty

//4.Rule-2: Never read from an Empty FIFO!
  property dont_read_if_empty;
    @(posedge i_clk) disable iff(!i_rst_n) rd_en && o_empty |-> ##1 $stable(rd_ptr);
  endproperty

//5.On successful write, write_ptr should only increment by 1
   property inc_wr_one;
      @(posedge i_clk) disable iff(!i_rst_n) wr_en && !o_full |-> ##1 (wr_ptr-1'b1 == $past(wr_ptr));
   endproperty
