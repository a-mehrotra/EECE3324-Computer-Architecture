// Written by Dr. Marpaung  
// Not to be published outside NEU.edu domain without a written permission/consent from Dr. Marpaung
// All Rights Reserved 

// THIS IS NOT THE TESTBENCH THAT SHALL BE USED TO GRADE YOUR INDIVIDUAL PROJECT
// THE PURPOSE OF THIS TESTBENCH IS TO GET YOU STARTED
// A MORE COMPLICATED TESTBENCH WILL BE USED TO FULLY TEST YOUR DESIGN
// THIS TESTBENCH MAY CONTAIN BUGS

`timescale 1ns/10ps
module simpletarmtb();

reg  [31:0] instrbus;
reg  [31:0] instrbusin[0:209];
wire [63:0] iaddrbus, daddrbus;
reg  [63:0] iaddrbusout[0:209], daddrbusout[0:209];
wire [63:0] databus;
reg  [63:0] databusk, databusin[0:209], databusout[0:209];
reg         clk, reset;
reg         clkd;

reg [63:0] dontcare;
reg [24*8:1] iname[0:209];
integer error, k, ntests;

    parameter ADDI  = 10'b1000100000;
    
cpu5arm dut(.reset(reset),.clk(clk),.iaddrbus(iaddrbus),.ibus(instrbus),.daddrbus(daddrbus),.databus(databus));

initial begin
// This test file runs the following program.

iname[0] = "ADDI R1, R31, #1";           // R1 = 1
iname[1] = "ADDI R2, R31, #2";           // R2 = 2
iname[2] = "ADDI R3, R31, #3";           // R3 = 3
iname[3] = "ADDI R4, R31, #4";           // R4 = 4
iname[4] = "ADDI R5, R31, #5";           // R5 = 5
iname[5] = "NOP";
iname[6] = "NOP";
iname[7] = "NOP";
iname[8] = "NOP";

dontcare = 64'hx;

//* ADDI  R1, R31, #1
iaddrbusout[0] = 64'h0000_0000_0000_0000;
//            opcode Imm        Rn          Rd
instrbusin[0]={ADDI, 12'h001, 5'b11111, 5'b00001};

daddrbusout[0] = 64'h0000_0000_0000_0001;
databusin[0] = 64'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[0] = dontcare;

//* ADDI  R2, R31, #2
iaddrbusout[1] = 64'h0000_0000_0000_0004;
//            opcode Imm        Rn          Rd
instrbusin[1]={ADDI, 12'h002, 5'b11111, 5'b00010};

daddrbusout[1] = 64'h0000_0000_0000_0002;
databusin[1] = 64'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[1] = dontcare;

//* ADDI  R3, R31, #3
iaddrbusout[2] = 64'h0000_0000_0000_0008;
//            opcode Imm        Rn          Rd
instrbusin[2]={ADDI, 12'h003, 5'b11111, 5'b00011};

daddrbusout[2] = 64'h0000_0000_0000_0003;
databusin[2] = 64'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[2] = dontcare;


// ADDITIONAL NO-OPS TO FINISH OUT THE LOGIC CHECKS IN PIPE
//* ADDI R4, R31, #4
iaddrbusout[3] = 64'h0000_0000_0000_000C;
//            opcode Imm        Rn          Rd
instrbusin[3]={ADDI, 12'h004, 5'b11111, 5'b00100};

daddrbusout[3] = 64'h0000_0000_0000_0004;
databusin[3] = 64'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[3] = dontcare;

//* NOP
iaddrbusout[4] = 64'h0000_0000_0000_0010;
//            opcode Imm        Rn          Rd
instrbusin[4]={ADDI, 12'h005, 5'b11111, 5'b00101};

daddrbusout[4] = 64'h0000_0000_0000_0005;
databusin[4] = 64'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[4] = dontcare;

//* NOP
iaddrbusout[5] = 64'h0000_0000_0000_0014;
//            opcode Imm        Rn          Rd
instrbusin[5]=32'b00000000000000000000000000000000;

daddrbusout[5] = 64'h0000_0000_0000_0006;
databusin[5] = 64'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[5] = dontcare;

iaddrbusout[6] = 64'h0000_0000_0000_0018;
//            opcode Imm        Rn          Rd
instrbusin[6]=32'b00000000000000000000000000000000;

daddrbusout[6] = 64'h0000_0000_0000_0007;
databusin[6] = 64'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[6] = dontcare;

iaddrbusout[7] = 64'h0000_0000_0000_001C;
//            opcode Imm        Rn          Rd
instrbusin[7]=32'b00000000000000000000000000000000;

daddrbusout[7] = 64'h0000_0000_0000_0008;
databusin[7] = 64'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[7] = dontcare;

ntests = 7;

$timeformat(-9,1,"ns",12);

end


//assumes positive edge FF.
//testbench reads databus when clk high, writes databus when clk low.
assign databus = clkd ? 64'bz : databusk;

//Change inputs in middle of period (falling edge).
initial begin
  error = 0;
  clkd =1;
  clk=1;
  $display ("Time=%t\n  clk=%b", $realtime, clk);
  databusk = 64'bz;

  //extended reset to set up PC MUX
  reset = 1;
  $display ("reset=%b", reset);
  #5
  clk=0;
  clkd=0;
  $display ("Time=%t\n  clk=%b", $realtime, clk);
  #5

  clk=1;
  clkd=1;
  $display ("Time=%t\n  clk=%b", $realtime, clk);
  #5
  clk=0;
  clkd=0;
  $display ("Time=%t\n  clk=%b", $realtime, clk);
  #5
  $display ("Time=%t\n  clk=%b", $realtime, clk);

for (k=0; k<= 7; k=k+1) begin
    clk=1;
    $display ("Time=%t\n  clk=%b", $realtime, clk);
    #2
    clkd=1;
    #3
    $display ("Time=%t\n  clk=%b", $realtime, clk);
    reset = 0;
    $display ("reset=%b", reset);


    //set load data for 3rd previous instruction
    if (k >=3)
      databusk = databusin[k-3];

    //check PC for this instruction
    if (k >= 0) begin
      $display ("  Testing PC for instruction %d", k);
      $display ("    Your iaddrbus =    %b", iaddrbus);
      $display ("    Correct iaddrbus = %b", iaddrbusout[k]);
      if (iaddrbusout[k] !== iaddrbus) begin
        $display ("    -------------ERROR. A Mismatch Has Occured-----------");
        error = error + 1;
      end
    end

    //put next instruction on ibus
    instrbus=instrbusin[k];
    $display ("  instrbus=%b %b %b %b %b for instruction %d: %s", instrbus[31:26], instrbus[25:21], instrbus[20:16], instrbus[15:11], instrbus[10:0], k, iname[k]);

    //check data address from 3rd previous instruction
    if ( (k >= 3) && (daddrbusout[k-3] !== dontcare) ) begin
      $display ("  Testing data address for instruction %d:", k-3);
      $display ("  %s", iname[k-3]);
      $display ("    Your daddrbus =    %b", daddrbus);
      $display ("    Correct daddrbus = %b", daddrbusout[k-3]);
      if (daddrbusout[k-3] !== daddrbus) begin
        $display ("    -------------ERROR. A Mismatch Has Occured-----------");
        error = error + 1;
      end
    end

    //check store data from 3rd previous instruction
    if ( (k >= 3) && (databusout[k-3] !== dontcare) ) begin
      $display ("  Testing store data for instruction %d:", k-3);
      $display ("  %s", iname[k-3]);
      $display ("    Your databus =    %b", databus);
      $display ("    Correct databus = %b", databusout[k-3]);
      if (databusout[k-3] !== databus) begin
        $display ("    -------------ERROR. A Mismatch Has Occured-----------");
        error = error + 1;
      end
    end

    clk = 0;
    $display ("Time=%t\n  clk=%b", $realtime, clk);
    #2
    clkd = 0;
    #3
    $display ("Time=%t\n  clk=%b", $realtime, clk);
  end

  if ( error !== 0) begin
    $display("--------- SIMULATION UNSUCCESFUL - MISMATCHES HAVE OCCURED ----------");
    $display(" No. Of Errors = %d", error);
  end
  if ( error == 0)
    $display("---------YOU DID IT!! SIMULATION SUCCESFULLY FINISHED----------");
end

endmodule