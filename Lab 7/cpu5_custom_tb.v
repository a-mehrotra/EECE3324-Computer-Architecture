//Property of Prof. J. Marpaung and Northeastern University
//Not to be distributed elsewhere without a written consent from Prof. J. Marpaung
//All Rights Reserved
//Edited by Aryan Mehrotra

`timescale 1ns/10ps

module cpu5_custom_tb();
//Input and Output declarations
reg  [31:0] instrbus;
reg  [31:0] instrbusin[0:64];
wire [31:0] iaddrbus, daddrbus;
reg  [31:0] iaddrbusout[0:64], daddrbusout[0:64];
wire [31:0] databus;
reg  [31:0] databusk, databusin[0:64], databusout[0:64];
reg         clk, reset;
reg         clkd;

reg [31:0] dontcare;
reg [24*8:1] iname[0:64];
integer error, k, ntests;

//Opcodes 
parameter Rformat	= 6'b000000;
parameter ADDI		= 6'b000011;
parameter SUBI		= 6'b000010;
parameter XORI		= 6'b000001;
parameter ANDI		= 6'b001111;
parameter ORI		= 6'b001100;
parameter LW		= 6'b011110;
parameter SW		= 6'b011111;
parameter BEQ		= 6'b110000;
parameter BNE		= 6'b110001;
parameter ADD		= 6'b000011;
parameter SUB		= 6'b000010;
parameter XOR		= 6'b000001;
parameter AND		= 6'b000111;
parameter OR		= 6'b000100;
parameter SLT		= 6'b110110;
parameter SLE		= 6'b110111;

// Registers
parameter R0 = 5'b00000;
parameter R1 = 5'b00001;
parameter R2 = 5'b00010;
parameter R3 = 5'b00011;
parameter R4 = 5'b00100;
parameter R5 = 5'b00101;
parameter R6 = 5'b00110;
parameter R7 = 5'b00111;
parameter R8 = 5'b01000;
parameter R9 = 5'b01001;
parameter R10 = 5'b01010;
parameter R11 = 5'b01011;
parameter R12 = 5'b01100;
parameter R13 = 5'b01101;
parameter R14 = 5'b01110;
parameter R15 = 5'b01111;
parameter R16 = 5'b10000;
parameter R17 = 5'b10001;
parameter R18 = 5'b10010;
parameter R19 = 5'b10011;
parameter R20 = 5'b10100;
parameter R21 = 5'b10101;
parameter R22 = 5'b10110;
parameter R23 = 5'b10111;
parameter R24 = 5'b11000;
parameter R25 = 5'b11001;
parameter R26 = 5'b11010;
parameter R27 = 5'b11011;
parameter R28 = 5'b11100;
parameter R29 = 5'b11101;
parameter R30 = 5'b11110;
parameter R31 = 5'b11111;

cpu5 dut(.reset(reset),.clk(clk),.iaddrbus(iaddrbus),.ibus(instrbus),.daddrbus(daddrbus),.databus(databus));

initial begin
// This test file runs the following program.
iname[0] = "ADDI  R20, R0, #-1";
iname[1] = "ADDI  R19, R0, #2";
iname[2] = "ADDI  R18, R0, #4";
iname[3] = "LW    R24, 0(R20)";
iname[4] = "LW    R25, 0(R18)";
iname[5] = "SW    800(R18), R22";
iname[6] = "SW    2(R0), R21";
iname[7] = "ADD   R26, R22, R21"; 
iname[8] = "SUBI  R17, R20, E9A3";
iname[9] = "SUB   R23, R22, R25";
iname[10] = "XORI R29, R24, B38D";    
iname[11] = "ANDI R27, R24, #0";     
iname[12] = "AND  R28, R24, R0"; 
iname[13] = "XOR  R6, R24, R17";
iname[14] = "ORI  R20, R24, C142";
iname[15] = "OR   R30, R19, R22";
iname[16] = "SW   0(R26),  R26";
iname[17] = "SW   0(R17),  R27";
iname[18] = "SW   500(R18),  R28"; 
iname[19] = "SW   600(R19),  R24";
iname[20] = "SW   0(R20),  R30";
iname[21] = "SLT  R1,  R19,  R22";  // Setting R1 to 32'h00000001 (since, R19 < R22).
iname[22] = "ADDI R5,  R0, #1";
iname[23] = "SUBI R6,  R21, #1";
iname[24] = "BNE  R0,  R19, #10";   // Branching to (32'h00000060 + 32'h00000004 + 32'h00000028 = 32'h0000008C) since, R0 != R1.
iname[25] = "ADDI R8,  R0, #1";    // Delay Slot
//Branched Location - 32'h0000008C //
iname[26] = "SLE  R2,  R0, R0";    // Setting R2 to 32'h00000001 (since, R0 = R0).
iname[27] = "NOP";
iname[28] = "NOP";
iname[29] = "BEQ  R22,  R18, #25";   // NOT Branching since, R22 != R18. 
iname[30] = "NOP";                 // Delay Slot
iname[31] = "BEQ  R2,  R2, #10";   // Branching to (32h'0000000A0 + 32'h00000004 + 32'h00000028 = 32'h000000CC)
iname[32] = "ADDI R9, R0, #1";    // Delay Slot
//Branched Location - 32'h000000CC //
iname[33] = "NOP";
iname[34] = "NOP";
iname[35] = "NOP";
iname[36] = "SUBI  R12, R26, 0048";
iname[37] = "ADDI  R13, R19, 41A3";
iname[38] = "ORI  R14, R26, F0F0";
iname[39] = "LW    R15, 20(R22)";
iname[40] = "LW    R16, 10(R26)";
iname[41] = "SW    750(R25), R8";
iname[42] = "SW    25(R0), R21";
iname[43] = "SUB   R1, R6, R26";
iname[44] = "ADDI  R17, R25, 1596";
iname[45] = "ADD   R7, R19, R18";
iname[46] = "ANDI R27, R29, #10";     
iname[47] = "AND  R2, R24, R0";     
iname[48] = "XORI R19, R21, 1776";
iname[49] = "XOR  R9, R26, R23";
iname[50] = "ORI  R25, R5, 20D6";
iname[51] = "OR   R20, R29, R18";
iname[52] = "SW   65(R26),  R26";
iname[53] = "SW   709(R17),  R27";
iname[54] = "SW   3596(R18),  R28"; 
iname[55] = "SW   29(R19),  R29";
iname[56] = "SW   47(R20),  R30";
iname[57] = "SLT  R1,  R18,  R20";  // Setting R1 to 32'h00000001 (since, R18 < R20).
iname[58] = "ADDI R7,  R0, #1";
iname[59] = "ADDI R8,  R0, #1";
iname[60] = "BNE  R0,  R18, #10";   // Branching to (32'h00000138 + 32'h00000004 + 32'h00000028 = 32'h00000164) since, R21 != R0.
iname[61] = "ADDI R5,  R0, #1";    // Delay Slot
//Branched Location - 32'h00000164 //
iname[62] = "SLE  R2,  R0, R0";    // Setting R2 to 32'h00000001 (since, R0 = R0).
iname[63] = "NOP";
iname[64] = "NOP";

dontcare = 32'hx;

//* ADDI  R20, R0, #-1
iaddrbusout[0] = 32'h00000000;
//            opcode source1   dest      Immediate...
instrbusin[0]={ADDI, R0, R20, 16'hFFFF};

daddrbusout[0] = dontcare;
databusin[0] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[0] = dontcare;

//* ADDI  R19, R0, #2
iaddrbusout[1] = 32'h00000004;
//            opcode source1   dest      Immediate...
instrbusin[1]={ADDI, R0, R19, 16'h0002};

daddrbusout[1] = dontcare;
databusin[1] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[1] = dontcare;

//* ADDI  R18, R0, #2
iaddrbusout[2] = 32'h00000008;
//            opcode source1   dest      Immediate...
instrbusin[2]={ADDI, R0, R18, 16'h0004};

daddrbusout[2] = dontcare;
databusin[2] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[2] = dontcare;

//* LW     R24, 0(R20)
iaddrbusout[3] = 32'h0000000C;
//            opcode source1   dest      Immediate...
instrbusin[3]={LW, R20, R24, 16'h0000};

daddrbusout[3] = 32'hFFFFFFFF;
databusin[3] = 32'hCCCCCCCC;
databusout[3] = dontcare;

//* LW     R25, 0(R18)
iaddrbusout[4] = 32'h00000010;
//            opcode source1   dest      Immediate...
instrbusin[4]={LW, R18, R25, 16'h0000};

daddrbusout[4] = dontcare;
databusin[4] = 32'hAAAAAAAA;
databusout[4] = dontcare;

//* SW     800(R18), R22
iaddrbusout[5] = 32'h00000014;
//            opcode source1   dest      Immediate...
instrbusin[5]={SW, R18, R22, 16'h0800};

daddrbusout[5] = 32'h00000804;
databusin[5] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[5] = dontcare;

//* SW     2(R0), R21
iaddrbusout[6] = 32'h00000018;
//            opcode source1   dest      Immediate...
instrbusin[6]={SW, R0, R21, 16'h0002};

daddrbusout[6] = 32'h00000002;
databusin[6] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[6] = dontcare;

//* ADD   R26, R22, R21
iaddrbusout[7] = 32'h0000001C;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[7]={Rformat, R22, R21, R26, 5'b00000, ADD};

daddrbusout[7] = dontcare;
databusin[7] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[7] = dontcare;

//* SUBI  R17, R20, E9A3
iaddrbusout[8] = 32'h00000020;
//            opcode source1   dest      Immediate...
instrbusin[8]={SUBI, R20, R17, 16'hE9A3};

daddrbusout[8] = dontcare;
databusin[8] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[8] = dontcare;

//* SUB   R23, R22, R25
iaddrbusout[9] = 32'h00000024;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[9]={Rformat, R22, R25, R23, 5'b00000, SUB};

daddrbusout[9] = dontcare;
databusin[9] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[9] = dontcare;

//* XORI   R29, R24, B38D
iaddrbusout[10] = 32'h00000028;
//            opcode source1   dest      Immediate...
instrbusin[10]={XORI, R24, R29, 16'hB38D};

daddrbusout[10] = dontcare;
databusin[10] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[10] = dontcare;

//* ANDI   R27, R24, #0             
iaddrbusout[11] = 32'h0000002C;
//            opcode source1   dest      Immediate...
instrbusin[11]={ANDI, R24, R27, 16'h0000};

daddrbusout[11] = dontcare;
databusin[11] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[11] = dontcare;

//* AND    R28, R24, R0           
iaddrbusout[12] = 32'h00000030;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[12]={Rformat, R24, R0, R28, 5'b00000, AND};

daddrbusout[12] = dontcare;
databusin[12] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[12] = dontcare;

//* XOR    R6, R24, R17
iaddrbusout[13] = 32'h00000034;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[13]={Rformat, R24, R17, R6, 5'b00000, XOR};

daddrbusout[13] = dontcare;
databusin[13] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[13] = dontcare;

//* ORI    R20, R24, C142
iaddrbusout[14] = 32'h00000038;
//            opcode source1   dest      Immediate...
instrbusin[14]={ORI, R24, R20, 16'hC142};

daddrbusout[14] = dontcare;
databusin[14] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[14] = dontcare;

//* OR     R30, R19, R22
iaddrbusout[15] = 32'h0000003C;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[15]={Rformat, R19, R22, R30, 5'b00000, OR};

daddrbusout[15] = dontcare;
databusin[15] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[15] =  dontcare;

//* SW     0(R26),  R26
iaddrbusout[16] = 32'h00000040;
//            opcode source1   dest      Immediate...
instrbusin[16]={SW, R26, R26, 16'h0000};

daddrbusout[16] = dontcare;
databusin[16] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[16] = dontcare;

//18* SW     0(R17),  R27
iaddrbusout[17] = 32'h00000044;
//            opcode source1   dest      Immediate...
instrbusin[17]={SW, R17, R27, 16'h0000};

daddrbusout[17] = 32'h0000165C;
databusin[17] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[17] = 32'h00000000;

//19* SW     500(R18),  R28           
iaddrbusout[18] = 32'h00000048;
//            opcode source1   dest      Immediate...
instrbusin[18]={SW, R18, R28, 16'h0500};

daddrbusout[18] = 32'h00000504;
databusin[18] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[18] = 32'h00000000;

//20* SW     600(R19),  R24
iaddrbusout[19] = 32'h0000004C;
//            opcode source1   dest      Immediate...
instrbusin[19]={SW, R19, R24, 16'h0600};

daddrbusout[19] = 32'h00000602;
databusin[19] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[19] = 32'hCCCCCCCC;

//21* SW     0(R20),  R11
iaddrbusout[20] = 32'h00000050;
//            opcode source1   dest      Immediate...
instrbusin[20]={SW, R20, R11, 16'h0000};

daddrbusout[20] = 32'hFFFFCDCE;
databusin[20] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[20] = dontcare;

//22* SLT  R1,  R19,  R22
iaddrbusout[21] = 32'h00000054;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[21]={Rformat, R19, R22, R1, 5'b00000, SLT};
daddrbusout[21] = dontcare;
databusin[21]   = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[21]  = dontcare;

//* ADDI R5,  R0, #1
iaddrbusout[22] = 32'h00000058;
//            opcode source1   dest      Immediate...
instrbusin[22]={ADDI, R0, R5, 16'h0001};
daddrbusout[22] = dontcare;
databusin[22] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[22] = dontcare;

//* SUBI R6,  R21, #1
iaddrbusout[23] = 32'h0000005C;
//            opcode source1   dest      Immediate...
instrbusin[23]={SUBI, R21, R6, 16'h0001};
daddrbusout[23] = dontcare;
databusin[23] =   32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[23] =  dontcare;

//* BNE  R0,  R19, #10
iaddrbusout[24] = 32'h00000060;
//            opcode source1   dest      Immediate...
instrbusin[24]={BNE, R19, R0, 16'h000A};
daddrbusout[24] = dontcare;
databusin[24] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[24] = dontcare;

//* ADDI R8,  R0, #1
iaddrbusout[25] = 32'h00000064;
//            opcode source1   dest      Immediate...
instrbusin[25]={ADDI, R0, R8, 16'h0001};
daddrbusout[25] = dontcare;
databusin[25] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[25] = dontcare;

//* SLE  R2,  R0, R0
iaddrbusout[26] = 32'h0000008C;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[26]={Rformat, R0, R0, R2, 5'b00000, SLE};
daddrbusout[26] = dontcare;
databusin[26] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[26] = dontcare;

//* NOP
iaddrbusout[27] = 32'h00000090;
//                   oooooosssssdddddiiiiiiiiiiiiiiii
instrbusin[27] = 32'b00000000000000000000000000000000;
daddrbusout[27] = dontcare;
databusin[27] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[27] = dontcare;

//* NOP
iaddrbusout[28] = 32'h00000094;
//                   oooooosssssdddddiiiiiiiiiiiiiiii
instrbusin[28] = 32'b00000000000000000000000000000000;
daddrbusout[28] = dontcare;
databusin[28]  = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[28] = dontcare;

//* BEQ  R22,  R18, #25
iaddrbusout[29] = 32'h00000098;
//            opcode source1   dest      Immediate...
instrbusin[29]={BEQ, R18, R22, 16'h0019};
daddrbusout[29] = dontcare;
databusin[29] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[29] = dontcare;

//* NOP
iaddrbusout[30] = 32'h0000009C;
//                   oooooosssssdddddiiiiiiiiiiiiiiii
instrbusin[30] = 32'b00000000000000000000000000000000;
daddrbusout[30] = dontcare;
databusin[30] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[30] = dontcare;

//* BEQ  R2,  R2, #10
iaddrbusout[31] = 32'h000000A0;
//            opcode source1   dest      Immediate...
instrbusin[31]={BEQ, R2, R2, 16'h000A};
daddrbusout[31] = dontcare;
databusin[31] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[31] = dontcare;

//* ADDI R9, R0, #1
iaddrbusout[32] = 32'h000000A4;
//            opcode source1   dest      Immediate...
instrbusin[32]={ADDI, R0, R9, 16'h0001};
daddrbusout[32] = dontcare;
databusin[32] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[32] = dontcare;

//* NOP
iaddrbusout[33] = 32'h000000CC;
//                   oooooosssssdddddiiiiiiiiiiiiiiii
instrbusin[33] = 32'b00000000000000000000000000000000;
daddrbusout[33] = dontcare;
databusin[33] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[33] = dontcare;

//* NOP
iaddrbusout[34] = 32'h000000D0;
//                   oooooosssssdddddiiiiiiiiiiiiiiii
instrbusin[34] = 32'b00000000000000000000000000000000;
daddrbusout[34] = dontcare;
databusin[34] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[34] = dontcare;

//* NOP
iaddrbusout[35] = 32'h000000D4;
//                   oooooosssssdddddiiiiiiiiiiiiiiii
instrbusin[35] = 32'b00000000000000000000000000000000;
daddrbusout[35] = dontcare;
databusin[35] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[35] = dontcare;

//* SUBI  R12, R26, 0048
iaddrbusout[36] = 32'h000000D8;
//            opcode source1   dest      Immediate...
instrbusin[36]={SUBI, R12, R26, 16'h0048};

daddrbusout[36] = dontcare;
databusin[36] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[36] = dontcare;

//* ADDI  R13, R19, 41A3
iaddrbusout[37] = 32'h000000DC;
//            opcode source1   dest      Immediate...
instrbusin[37]={ADDI, R13, R19, 16'h41A3};

daddrbusout[37] = dontcare;
databusin[37] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[37] = dontcare;

//* ORI  R14, R26, F0F0
iaddrbusout[38] = 32'h000000E0;
//            opcode source1   dest      Immediate...
instrbusin[38]={ORI, R14, R26, 16'hF0F0};

daddrbusout[38] = dontcare;
databusin[38] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[38] = dontcare;

//* LW    R15, 20(R22)
iaddrbusout[39] = 32'h000000E4;
//            opcode source1   dest      Immediate...
instrbusin[39]={LW, R15, R22, 16'h0020};

daddrbusout[39] = dontcare;
databusin[39] = 32'hCCCCCCCC;
databusout[39] = dontcare;

//* LW    R16, 10(R26)
iaddrbusout[40] = 32'h000000E8;
//            opcode source1   dest      Immediate...
instrbusin[40]={LW, R16, R26, 16'h0010};

daddrbusout[40] = dontcare;
databusin[40] = 32'hAAAAAAAA;
databusout[40] = dontcare;

//* SW    750(R25), R8
iaddrbusout[41] = 32'h000000EC;
//            opcode source1   dest      Immediate...
instrbusin[41]={SW, R25, R8, 16'h0750};

daddrbusout[41] = 32'hAAAAB1FA;
databusin[41] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[41] = dontcare;

//* SW    25(R0), R21
iaddrbusout[42] = 32'h000000F0;
//            opcode source1   dest      Immediate...
instrbusin[42]={SW, R0, R21, 16'h0025};

daddrbusout[42] = 32'h00000025;
databusin[42] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[42] = dontcare;

//* SUB   R1, R6, R26
iaddrbusout[43] = 32'h000000F4;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[43]={Rformat, R6, R26, R1, 5'b00000, SUB};

daddrbusout[43] = dontcare;
databusin[43] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[43] = dontcare;

//* ADDI  R17, R25, 1596
iaddrbusout[44] = 32'h000000F8;
//            opcode source1   dest      Immediate...
instrbusin[44]={ADDI, R25, R17, 16'h1596};

daddrbusout[44] = dontcare;
databusin[44] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[44] = dontcare;

//* ADD   R7, R19, R18
iaddrbusout[45] = 32'h000000FC;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[45]={Rformat, R19, R18, R7, 5'b00000, ADD};

daddrbusout[45] = dontcare;
databusin[45] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[45] = dontcare;

//* ANDI R27, R29, #10
iaddrbusout[46] = 32'h00000100;
//            opcode source1   dest      Immediate...
instrbusin[46]={ANDI, R27, R29, 16'h0010};

daddrbusout[46] = dontcare;
databusin[46] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[46] = dontcare;

//* AND  R2, R24, R0            
iaddrbusout[47] = 32'h00000104;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[47]={Rformat, R24, R0, R2, 5'b00000, AND};

daddrbusout[47] = dontcare;
databusin[47] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[47] = dontcare;

//* XORI R19, R21, 1776         
iaddrbusout[48] = 32'h00000108;
//            opcode source1   dest      Immediate...
instrbusin[48]={XORI, R21, R19, 16'h1776};

daddrbusout[48] = dontcare;
databusin[48] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[48] = dontcare;

//* XOR  R9, R26, R23
iaddrbusout[49] = 32'h0000010C;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[49]={Rformat, R26, R23, R9, 5'b00000, XOR};

daddrbusout[49] = dontcare;
databusin[49] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[49] = dontcare;

//* ORI  R25, R5, 20D6
iaddrbusout[50] = 32'h00000110;
//            opcode source1   dest      Immediate...
instrbusin[50]={ORI, R5, R25, 16'h20D6};

daddrbusout[50] = dontcare;
databusin[50] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[50] = dontcare;

//* OR   R20, R29, R18
iaddrbusout[51] = 32'h00000114;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[51]={Rformat, R29, R18, R20, 5'b00000, OR};

daddrbusout[51] = dontcare;
databusin[51] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[51] =  dontcare;

//* SW     65(R26),  R26
iaddrbusout[52] = 32'h00000118;
//            opcode source1   dest      Immediate...
instrbusin[52]={SW, R26, R26, 16'h0065};

daddrbusout[52] = dontcare;
databusin[52] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[52] = dontcare;

//18* SW     709(R17),  R27
iaddrbusout[53] = 32'h0000011C;
//            opcode source1   dest      Immediate...
instrbusin[53]={SW, R17, R27, 16'h0709};

daddrbusout[53] = 32'hAAAAC749;
databusin[53] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[53] = 32'h00000000;

//19* SW     3596(R18),  R28           
iaddrbusout[54] = 32'h00000120;
//            opcode source1   dest      Immediate...
instrbusin[54]={SW, R18, R28, 16'h3596};

daddrbusout[54] = 32'h0000359A;
databusin[54] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[54] = 32'h00000000;

//20* SW     29(R19),  R29
iaddrbusout[55] = 32'h00000124;
//            opcode source1   dest      Immediate...
instrbusin[55]={SW, R19, R29, 16'h0029};

daddrbusout[55] = dontcare;
databusin[55] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[55] = 32'h00000000;

//21* SW     47(R20),  R30
iaddrbusout[56] = 32'h00000128;
//            opcode source1   dest      Immediate...
instrbusin[56]={SW, R20, R30, 16'h0047};

daddrbusout[56] = 32'h0000004B;
databusin[56] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[56] = dontcare;

//22* SLT  R1,  R18,  R20
iaddrbusout[57] = 32'h0000012C;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[57]={Rformat, R18, R20, R1, 5'b00000, SLT};
daddrbusout[57] = dontcare;
databusin[57]   = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[57]  = dontcare;

//* ADDI R7,  R0, #1
iaddrbusout[58] = 32'h00000130;
//            opcode source1   dest      Immediate...
instrbusin[58]={ADDI, R0, R7, 16'h0001};
daddrbusout[58] = dontcare;
databusin[58] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[58] = dontcare;

//* ADDI R8,  R0, #1
iaddrbusout[59] = 32'h00000134;
//            opcode source1   dest      Immediate...
instrbusin[59]={ADDI, R0, R8, 16'h0001};
daddrbusout[59] = dontcare;
databusin[59] =   32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[59] =  dontcare;

//* BNE  R0,  R18, #10
iaddrbusout[60] = 32'h00000138;
//            opcode source1   dest      Immediate...
instrbusin[60]={BNE, R18, R0, 16'h000A};
daddrbusout[60] = dontcare;
databusin[60] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[60] = dontcare;

//* ADDI R5,  R0, #1
iaddrbusout[61] = 32'h0000013C;
//            opcode source1   dest      Immediate...
instrbusin[61]={ADDI, R0, R5, 16'h0001};
daddrbusout[61] = dontcare;
databusin[61] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[61] = dontcare;

//* SLE  R2,  R0, R0
iaddrbusout[62] = 32'h00000164;
//             opcode   source1   source2   dest      shift     Function...
instrbusin[62]={Rformat, R0, R0, R2, 5'b00000, SLE};
daddrbusout[62] = dontcare;
databusin[62] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[62] = dontcare;

//* NOP
iaddrbusout[63] = 32'h00000168;
//                   oooooosssssdddddiiiiiiiiiiiiiiii
instrbusin[63] = 32'b00000000000000000000000000000000;
daddrbusout[63] = dontcare;
databusin[63] = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[63] = dontcare;

//* NOP
iaddrbusout[64] = 32'h0000016C;
//                   oooooosssssdddddiiiiiiiiiiiiiiii
instrbusin[64] = 32'b00000000000000000000000000000000;
daddrbusout[64] = dontcare;
databusin[64]  = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
databusout[64] = dontcare;

// (no. instructions) + (no. loads) + 2*(no. stores) = 64 + 4 + 2*14 = 96
ntests = 96;

$timeformat(-9,1,"ns",12);

end


//assumes positive edge FF.
//testbench reads databus when clk high, writes databus when clk low.
assign databus = clkd ? 32'bz : databusk;

//Change inputs in middle of period (falling edge).
initial begin
  error = 0;
  clkd =1;
  clk=1;
  $display ("Time=%t\n  clk=%b", $realtime, clk);
  databusk = 32'bz;

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

for (k=0; k<= 64; k=k+1) begin
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
