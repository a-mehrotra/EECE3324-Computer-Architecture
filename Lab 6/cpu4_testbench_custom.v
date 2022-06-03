//Property of Prof. J. Marpaung and Northeastern University
//Modified by Sam Bolduc and Aryan Mehrotra
//Not to be distributed elsewhere without a written consent from Prof. J. Marpaung
//All Rights Reserved


`timescale 1ns/10ps
module cpu4_testbench_custom();

reg [0:31] ibus;
reg [0:31] ibusin[0:37];
wire [0:31] daddrbus;
reg [0:31] daddrbusout[0:37];
wire [0:31] databus;
reg [0:31] databusk, databusin[0:37], databusout[0:37];
reg clk;
reg clkd;

reg [0:31] dontcare;
reg [24*8:1] iname[0:37];
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

//                src dest imm
iname[0] = "ORI  R20, R0, #-2";
iname[1] = "SUBI  R21, R0, #1";
iname[2] = "XORI  R22, R0, #5";
//                dest  src
iname[3] = "LW    R31, 0(R21)"; 
iname[4] = "LW    R14, 0(R20)";
//                imm  src   dest
iname[5] = "SW    1100(R22), R21";
iname[6] = "SW    4(R0), R20";
iname[7] = "SUB   R26, R14, R31";
iname[8] = "ANDI  R17, R31, A937";
iname[9] = "XOR   R27, R14, R31";
iname[10] = "AND  R18, R14, R22";     
iname[11] = "ADD  R28, R22, R26";     
iname[12] = "ORI  R19, R17, 8D93";
iname[13] = "OR   R29, R14, R31";
iname[14] = "XORI   R24, R14, C137";
iname[15] = "SUB    R30, R17, R26";
//               imm  src   dest
iname[16] = "SW    0(R27),  R27";
iname[17] = "SW    0(R31),  R26";
iname[18] = "SW    1001(R18),  R17"; 
iname[19] = "SW    0(R28),  R18";
iname[20] = "SW    0(R21),  R20";

iname[21] = "XORI  R15, R28, #97DC";
iname[22] = "ANDI  R12, R21, #3";
iname[23] = "ORI  R13, R0, #6C2A";
//                 dest  src
iname[24] = "LW    R11, 0(R31)"; 
iname[25] = "LW    R10, 0(R18)";
iname[26] = "LW    R9, 0(R27)";
//              imm  src   dest
iname[27] = "SW    9(R31), R18";
iname[28] = "SW    0101(R18), R17";
iname[29] = "ADDI  R6, R31, 03D2";
iname[30] = "SW   0(R11), R29";
iname[31] = "SW   0(R10), R18";     
iname[32] = "SW   0(R9), R27";     
iname[33] = "SW   0(R20), R22";     
iname[34] = "LW   R1, 0(R11)";   
iname[35] = "NOP";
iname[36] = "NOP";
iname[37] = "NOP";

dontcare = 32'hx;

// 1* ORI  R20, R0, #-2
//            opcode source1   dest      Immediate...
ibusin[0]={ORI, 5'b00000, 5'b10100, 16'hFFFE};

daddrbusout[0] = dontcare;
databusin[0] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[0] = dontcare;

// 2* SUBI  R21, R0, #1
//            opcode source1   dest      Immediate...
ibusin[1]={SUBI, 5'b00000, 5'b10101, 16'h0001};

daddrbusout[1] = dontcare;
databusin[1] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[1] = dontcare;

// 3* XORI  R22, R0, #5
//            opcode source1   dest      Immediate...
ibusin[2]={XORI, 5'b00000, 5'b10110, 16'h0005};

daddrbusout[2] = dontcare;
databusin[2] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[2] = dontcare;

// 4* LW    R31, 0(R20)
//            opcode source1   dest      Immediate...
ibusin[3]={LW, 5'b10100, 5'b11111, 16'h0000};

daddrbusout[3] = 32'hFFFFFFFE;
databusin[3] = 32'hBBBBBBBB;
databusout[3] = dontcare;

// 5* LW    R14, 0(R21)
//            opcode source1   dest      Immediate...
ibusin[4]={LW, 5'b10101, 5'b01110, 16'h0000};

daddrbusout[4] = 32'hFFFFFFFF;
databusin[4] = 32'hEEEEEEEE;
databusout[4] = dontcare;

// 6* SW    1100(R22), R21
//            opcode source1   dest      Immediate...
ibusin[5]={SW, 5'b10110, 5'b10101, 16'h1100};

daddrbusout[5] = 32'h00001105;
databusin[5] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[5] = 32'hFFFFFFFF;

// 7* SW     SW    4(R0), R20
//            opcode source1   dest      Immediate...
ibusin[6]={SW, 5'b00000, 5'b10100, 16'h0004};

daddrbusout[6] = 32'h00000004;
databusin[6] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[6] = 32'hFFFFFFFE;

// 8* SUB   R26, R14, R31
//             opcode   source1   source2   dest      shift     Function...
ibusin[7]={Rformat, 5'b01110, 5'b11111, 5'b11010, 5'b00000, SUB};

daddrbusout[7] = dontcare;
databusin[7] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[7] = dontcare;

// 9* ANDI  R17, R31, A937
//            opcode source1   dest      Immediate...
ibusin[8]={ANDI, 5'b11111, 5'b10001, 16'hA937};

daddrbusout[8] = dontcare;
databusin[8] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[8] = dontcare;

// 10* XOR   R27, R14, R31
//             opcode   source1   source2   dest      shift     Function...
ibusin[9]={Rformat, 5'b01110, 5'b11111, 5'b11011, 5'b00000, XOR};
daddrbusout[9] = dontcare;
databusin[9] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[9] = dontcare;

// 11* AND  R18, R14, R22             
//             opcode   source1   source2   dest      shift     Function...
ibusin[10]={Rformat, 5'b01110, 5'b10110, 5'b10010, 5'b00000, AND};

daddrbusout[10] = dontcare;
databusin[10] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[10] = dontcare;

// 12* ADD  R28, R22, R26          
//             opcode   source1   source2   dest      shift     Function...
ibusin[11]={Rformat, 5'b11010, 5'b10110, 5'b11100, 5'b00000, ADD};

daddrbusout[11] = dontcare;
databusin[11] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[11] = dontcare;

// 13* ORI  R19, R17, BD93
//            opcode source1   dest      Immediate...
ibusin[12]={XORI, 5'b10001, 5'b10011, 16'h8D93};

daddrbusout[12] = dontcare;
databusin[12] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[12] = dontcare;

// 14* OR   R29, R14, R31
//             opcode   source1   source2   dest      shift     Function...
ibusin[13]={Rformat, 5'b01110, 5'b11111, 5'b11101, 5'b00000, OR};

daddrbusout[13] = dontcare;
databusin[13] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[13] = dontcare;

// 15* XORI   R24, R14, C137
//            opcode source1   dest      Immediate...
ibusin[14]={XORI, 5'b11000, 5'b01110, 16'hC137};

daddrbusout[14] = dontcare;
databusin[14] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[14] = dontcare;

// 16* SUB    R30, R17, R26
//             opcode   source1   source2   dest      shift     Function...
ibusin[15]={Rformat, 5'b11010, 5'b10001, 5'b11110, 5'b00000, SUB};

daddrbusout[15] = dontcare;
databusin[15] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[15] =  dontcare;

// 17* SW    0(R27),  R27
//            opcode source1   dest      Immediate...
ibusin[16]={SW, 5'b11011, 5'b11011, 16'h0000};

daddrbusout[16] = 32'h55555555;
databusin[16] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[16] = 32'h55555555;

// 18* SW    0(R31),  R26
//            opcode source1   dest      Immediate...
ibusin[17]={SW, 5'b11111, 5'b11010, 16'h0000};

daddrbusout[17] = 32'hBBBBBBBB;
databusin[17] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[17] = 32'h33333333;

// 19* SW    1001(R18),  R17         
//            opcode source1   dest      Immediate...
ibusin[18]={SW, 5'b10010, 5'b10001, 16'h1001};

daddrbusout[18] = 32'h00001005;
databusin[18] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[18] = 32'hBBBBA933;

// 20* SW    0(R28),  R18
//            opcode source1   dest      Immediate...
ibusin[19]={SW, 5'b11100, 5'b10010, 16'h0000};

daddrbusout[19] = 32'h33333338;
databusin[19] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[19] = 32'h00000004;

// 21* SW    0(R21),  R20
//            opcode source1   dest      Immediate...
ibusin[20]={SW, 5'b10101, 5'b10100, 16'h0000};

daddrbusout[20] = 32'hFFFFFFFF;
databusin[20] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[20] = 32'hFFFFFFFE;


// 22* XORI  R15, R28, #97DC
//            opcode source1   dest      Immediate...
ibusin[21]={XORI, 5'b11100, 5'b01111, 16'h97DC};

daddrbusout[21] = dontcare;
databusin[21] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[21] = dontcare;

// 23* ANDI  R12, R21, #3
//            opcode source1   dest      Immediate...
ibusin[22]={ANDI, 5'b10101, 5'b01100, 16'h0003};

daddrbusout[22] = dontcare;
databusin[22] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[22] = dontcare;

// 24* ORI  R13, R0, #6C2A
//            opcode source1   dest      Immediate...
ibusin[23]={ORI, 5'b00000, 5'b01101, 16'h6C2A};

daddrbusout[23] = dontcare;
databusin[23] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[23] = dontcare;

// 25* LW    R11, 0(R31)
//            opcode source1   dest      Immediate...
ibusin[24]={LW, 5'b11111, 5'b01011, 16'h0000};

daddrbusout[24] = 32'hBBBBBBBB;
databusin[24] = 32'h9F4C31AB;
databusout[24] = dontcare;

// 26* LW    R10, 0(R18)
//            opcode source1   dest      Immediate...
ibusin[25]={LW, 5'b10010, 5'b01010, 16'h0000};

daddrbusout[25] = 32'h00000004;
databusin[25] = 32'hF4A7BD31;
databusout[25] = dontcare;

// 27* LW    R9, 0(R27)
//            opcode source1   dest      Immediate...
ibusin[26]={LW, 5'b11011, 5'b01001, 16'h0000};

daddrbusout[26] = 32'h55555555;
databusin[26] = 32'h7691A4CE;
databusout[26] = dontcare;

// 28* SW    9(R31), R18
//       opcode source1   dest      Immediate...
ibusin[27]={SW, 5'b11111, 5'b10010, 16'h0009};

daddrbusout[27] = 32'hBBBBBBC4;
databusin[27] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[27] = 32'h00000004;

// 29* SW    0101(R18), R17
//       opcode source1   dest      Immediate...
ibusin[28]={SW, 5'b10010, 5'b10001, 16'h0101};

daddrbusout[28] = 32'h00000105;
databusin[28] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[28] = 32'hBBBBA933;

// 30* ADDI  R6, R31, 03D2
//            opcode source1   dest      Immediate...
ibusin[29]={ADDI, 5'b11111, 5'b00110, 16'h03D2};
daddrbusout[29] = dontcare;
databusin[29] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[29] = dontcare;
        
// 31* SW   0(R11), R29           
//       opcode source1   dest      Immediate...
ibusin[30]={SW, 5'b01011, 5'b11101, 16'h0000};

daddrbusout[30] = 32'h9F4C31AB;
databusin[30] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[30] = 32'hFFFFFFFF;

// 32* SW   0(R10), R18      
//       opcode source1   dest      Immediate...
ibusin[31]={SW, 5'b01010, 5'b10010, 16'h0000};

daddrbusout[31] = 32'hF4A7BD31;
databusin[31] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[31] = 32'h00000004;

// 33* SW   0(R9), R27
//       opcode source1   dest      Immediate...
ibusin[32]={SW, 5'b01001, 5'b11011, 16'h0000};

daddrbusout[32] = 32'h7691A4CE;
databusin[32] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[32] = 32'h55555555;

// 34* SW   0(R20), R22    
//       opcode source1   dest      Immediate...
ibusin[33]={SW, 5'b10100, 5'b10110, 16'h0000};

daddrbusout[33] = 32'hFFFFFFFE;
databusin[33] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[33] = 32'h00000005;

// 35* LW   R1, 0(R11)
//            opcode source1   dest      Immediate...
ibusin[34]={LW, 5'b01011, 5'b00001, 16'h0000};

daddrbusout[34] = 32'h9F4C31AB;
databusin[34] = 32'hEF2AD43D;
databusout[34] = dontcare;

// 36* NOP
//                   oooooosssssdddddiiiiiiiiiiiiiiii
ibusin[35] = 32'b00000000000000000000000000000000;

daddrbusout[35] = dontcare;
databusin[35] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[35] = dontcare;

// 37* NOP
//                   oooooosssssdddddiiiiiiiiiiiiiiii
ibusin[36] = 32'b00000000000000000000000000000000;

daddrbusout[36] = dontcare;
databusin[36] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[36] = dontcare;

// 38* NOP
//                   oooooosssssdddddiiiiiiiiiiiiiiii
ibusin[37] = 32'b00000000000000000000000000000000;

daddrbusout[37] = dontcare;
databusin[37] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[37] = dontcare;

// (no. loads) + 2*(no. stores) = 6 + 2*13 = 32
ntests = 32;

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

  for (k=0; k<= 37; k=k+1) begin
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
