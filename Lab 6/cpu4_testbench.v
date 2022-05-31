//Property of Prof. J. Marpaung and Northeastern University
//Not to be distributed elsewhere without a written consent from Prof. J. Marpaung
//All Rights Reserved


`timescale 1ns/10ps
module cpu4_testbench();

reg [0:31] ibus;
reg [0:31] ibusin[0:23];
wire [0:31] daddrbus;
reg [0:31] daddrbusout[0:23];
wire [0:31] databus;
reg [0:31] databusk, databusin[0:23], databusout[0:23];
reg clk;
reg clkd;

reg [0:31] dontcare;
reg [24*8:1] iname[0:23];
integer error, k, ntests;

parameter ADDI = 6'b000011;
parameter SUBI = 6'b000010;
parameter XORI = 6'b000001;
parameter ANDI = 6'b001111;
parameter ORI = 6'b001100;
parameter LW = 6'b011110;
parameter SW = 6'b011111;
parameter Rformat = 6'b000000;
parameter ADD = 6'b000011;
parameter SUB = 6'b000010;
parameter XOR = 6'b000001;
parameter AND = 6'b000111;
parameter OR = 6'b000100;

cpu4 dut(.clk(clk),.ibus(ibus),.daddrbus(daddrbus),.databus(databus));

initial begin
// This test file runs the following program.

iname[0] = "ADDI  R20, R0, #-1";
iname[1] = "ADDI  R21, R0, #1";
iname[2] = "ADDI  R22, R0, #2";
iname[3] = "LW    R24, 0(R20)";
iname[4] = "LW    R25, 0(R21)";
iname[5] = "SW    1000(R22), R20";
iname[6] = "SW    2(R0), R21";
iname[7] = "ADD   R26, R24, R25";
iname[8] = "SUBI  R17, R24, 6420";
iname[9] = "SUB   R27, R24, R25";
iname[10] = "ANDI R18, R24, #0";     
iname[11] = "AND  R28, R24, R0";     
iname[12] = "XORI  R19, R24, 6420";
iname[13] = "XOR   R29, R24, R25";
iname[14] = "ORI   R20, R24, 6420";
iname[15] = "OR    R30, R24, R25";
iname[16] = "SW    0(R26),  R26";
iname[17] = "SW    0(R17),  R27";
iname[18] = "SW    1000(R18),  R28"; 
iname[19] = "SW    0(R19),  R29";
iname[20] = "SW    0(R20),  R30";
iname[21] = "NOP";
iname[22] = "NOP";
iname[23] = "NOP";

dontcare = 32'hx;

// 1* ADDI  R20, R0, #-1
//            opcode source1   dest      Immediate...
ibusin[0]={ADDI, 5'b00000, 5'b10100, 16'hFFFF};

daddrbusout[0] = dontcare;
databusin[0] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[0] = dontcare;

// 2* ADDI  R21, R0, #1
//            opcode source1   dest      Immediate...
ibusin[1]={ADDI, 5'b00000, 5'b10101, 16'h0001};

daddrbusout[1] = dontcare;
databusin[1] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[1] = dontcare;

// 3* ADDI  R22, R0, #2
//            opcode source1   dest      Immediate...
ibusin[2]={ADDI, 5'b00000, 5'b10110, 16'h0002};

daddrbusout[2] = dontcare;
databusin[2] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[2] = dontcare;

// 4* LW     R24, 0(R20)
//            opcode source1   dest      Immediate...
ibusin[3]={LW, 5'b10100, 5'b11000, 16'h0000};

daddrbusout[3] = 32'hFFFFFFFF;
databusin[3] = 32'hCCCCCCCC;
databusout[3] = dontcare;

// 5* LW     R25, 0(R21)
//            opcode source1   dest      Immediate...
ibusin[4]={LW, 5'b10101, 5'b11001, 16'h0000};

daddrbusout[4] = 32'h00000001;
databusin[4] = 32'hAAAAAAAA;
databusout[4] = dontcare;

// 6* SW     1000(R22), R20
//            opcode source1   dest      Immediate...
ibusin[5]={SW, 5'b10110, 5'b10100, 16'h1000};

daddrbusout[5] = 32'h00001002;
databusin[5] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[5] = 32'hFFFFFFFF;

// 7* SW     2(R0), R21
//            opcode source1   dest      Immediate...
ibusin[6]={SW, 5'b00000, 5'b10101, 16'h0002};

daddrbusout[6] = 32'h00000002;
databusin[6] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[6] = 32'h00000001;

// 8* ADD   R26, R24, R25
//             opcode   source1   source2   dest      shift     Function...
ibusin[7]={Rformat, 5'b11000, 5'b11001, 5'b11010, 5'b00000, ADD};

daddrbusout[7] = dontcare;
databusin[7] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[7] = dontcare;

// 9* SUBI  R17, R24, 6420
//            opcode source1   dest      Immediate...
ibusin[8]={SUBI, 5'b11000, 5'b10001, 16'h6420};

daddrbusout[8] = dontcare;
databusin[8] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[8] = dontcare;

// 10* SUB   R27, R24, R25
//             opcode   source1   source2   dest      shift     Function...
ibusin[9]={Rformat, 5'b11000, 5'b11001, 5'b11011, 5'b00000, SUB};
daddrbusout[9] = dontcare;
databusin[9] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[9] = dontcare;

// 11* ANDI   R18, R24, #0             
//            opcode source1   dest      Immediate...
ibusin[10]={ANDI, 5'b11000, 5'b10010, 16'h0000};

daddrbusout[10] = dontcare;
databusin[10] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[10] = dontcare;

// 12* AND    R28, R24, R0           
//             opcode   source1   source2   dest      shift     Function...
ibusin[11]={Rformat, 5'b11000, 5'b00000, 5'b11100, 5'b00000, AND};

daddrbusout[11] = dontcare;
databusin[11] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[11] = dontcare;

// 13* XORI   R19, R24, 6420
//            opcode source1   dest      Immediate...
ibusin[12]={XORI, 5'b11000, 5'b10011, 16'h6420};

daddrbusout[12] = dontcare;
databusin[12] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[12] = dontcare;

// 14* XOR    R29, R24, R25
//             opcode   source1   source2   dest      shift     Function...
ibusin[13]={Rformat, 5'b11000, 5'b11001, 5'b11101, 5'b00000, XOR};

daddrbusout[13] = dontcare;
databusin[13] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[13] = dontcare;

// 15* ORI    R20, R24, 6420
//            opcode source1   dest      Immediate...
ibusin[14]={ORI, 5'b11000, 5'b10100, 16'h6420};

daddrbusout[14] = dontcare;
databusin[14] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[14] = dontcare;

// 16* OR     R30, R24, R25
//             opcode   source1   source2   dest      shift     Function...
ibusin[15]={Rformat, 5'b11000, 5'b11001, 5'b11110, 5'b00000, OR};

daddrbusout[15] = dontcare;
databusin[15] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[15] =  dontcare;

// 17* SW     0(R26),  R26
//            opcode source1   dest      Immediate...
ibusin[16]={SW, 5'b11010, 5'b11010, 16'h0000};

daddrbusout[16] = 32'h77777776;
databusin[16] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[16] = 32'h77777776;

// 18* SW     0(R17),  R27
//            opcode source1   dest      Immediate...
ibusin[17]={SW, 5'b10001, 5'b11011, 16'h0000};

daddrbusout[17] = 32'hCCCC68AC;
databusin[17] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[17] = 32'h22222222;

// 19* SW     1000(R18),  R28           
//            opcode source1   dest      Immediate...
ibusin[18]={SW, 5'b10010, 5'b11100, 16'h1000};

daddrbusout[18] = 32'h00001000;
databusin[18] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[18] = 32'h00000000;

// 20* SW     0(R19),  R29
//            opcode source1   dest      Immediate...
ibusin[19]={SW, 5'b10011, 5'b11101, 16'h0000};

daddrbusout[19] = 32'hCCCCA8EC;
databusin[19] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[19] = 32'h66666666;

// 21* SW     0(R20),  R30
//            opcode source1   dest      Immediate...
ibusin[20]={SW, 5'b10100, 5'b11110, 16'h0000};

daddrbusout[20] = 32'hCCCCECEC;
databusin[20] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[20] = 32'hEEEEEEEE;

// 22* NOP
//                   oooooosssssdddddiiiiiiiiiiiiiiii
ibusin[21] = 32'b00000000000000000000000000000000;

daddrbusout[21] = dontcare;
databusin[21] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[21] = dontcare;

// 23* NOP
//                   oooooosssssdddddiiiiiiiiiiiiiiii
ibusin[22] = 32'b00000000000000000000000000000000;

daddrbusout[22] = dontcare;
databusin[22] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[22] = dontcare;

// 24* NOP
//                   oooooosssssdddddiiiiiiiiiiiiiiii
ibusin[23] = 32'b00000000000000000000000000000000;

daddrbusout[23] = dontcare;
databusin[23] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[23] = dontcare;

// (no. loads) + 2*(no. stores) = 2 + 2*7 = 16
ntests = 16;

$timeformat(-9,1,"ns",12);

end


//assumes positive edge FF.
//testbench reads databus when clk high, writes databus when clk low.
assign databus = clkd ? 32'bz : databusk;

//Change inputs in middle of period (falling edge).
initial begin
  error = 0;
  clkd =0;
  clk=0;
  $display ("Time=%t\n  clk=%b", $realtime, clk);
  databusk = 32'bz;

  #25
  $display ("Time=%t\n  clk=%b", $realtime, clk);

  for (k=0; k<= 23; k=k+1) begin
    clk=1;
    $display ("Time=%t\n  clk=%b", $realtime, clk);
    #5
    clkd=1;
    #20
    $display ("Time=%t\n  clk=%b", $realtime, clk);

    //set load data for 3rd previous instruction
    if (k >=3)
      databusk = databusin[k-3];

    //put next instruction on ibus
    ibus=ibusin[k];
    $display ("  ibus=%b %b %b %b %b for instruction %d: %s", ibus[0:5], ibus[6:10], ibus[11:15], ibus[16:20], ibus[21:31], k, iname[k]);

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
    #5
    clkd = 0;
    #20
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
