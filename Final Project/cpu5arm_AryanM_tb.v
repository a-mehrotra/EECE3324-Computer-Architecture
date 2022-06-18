`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: cpu5arm_AryanM_tb
// Description: Test bench for ARM LEGV8 CPU
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module cpu5arm_AryanM_tb();
    reg  [31:0] instrbus;
    reg  [31:0] instrbusin[0:209];
    wire [63:0] iaddrbus, daddrbus;
    reg  [63:0] iaddrbusout[0:209], daddrbusout[0:209];
    wire [63:0] databus;
    reg  [63:0] databusk, databusin[0:209], databusout[0:209];
    reg         clk, reset;
    reg         clkd;
    
    reg [63:0] dontcare, activez;
    reg [24*8:1] iname[0:209];
    integer error, k, ntests;
    
    //R-Format
    parameter ADD   = 11'b00101000000;
    parameter ADDS  = 11'b00101000001;
    parameter AND   = 11'b00101000010;
    parameter ANDS  = 11'b00101000011;
    parameter EOR   = 11'b00101000100;
    parameter ENOR  = 11'b00101000101;
    parameter LSL   = 11'b00101000110;
    parameter LSR   = 11'b00101000111;
    parameter ORR   = 11'b00101001000;
    parameter SUB   = 11'b00101001001;
    parameter SUBS  = 11'b00101001010;
    //I-Format
    parameter ADDI  = 10'b1000100000;
    parameter ADDIS = 10'b1000100000;
    parameter ANDI  = 10'b1000100010;
    parameter ANDIS = 10'b1000100011;
    parameter EORI  = 10'b1000100100;
    parameter ENORI = 10'b1000100101;
    parameter ORRI  = 10'b1000100110;
    parameter SUBI  = 10'b1000100111;
    parameter SUBIS = 10'b1000101000;
    //D-Format
    parameter LDUR  = 11'b11010000000;
    parameter STUR  = 11'b11010000001;
    //IM-Format
    parameter MOVZ  = 9'b110010101;
    //B-Format
    parameter B     = 6'b000011;
    //CB-Format
    parameter CBZ   = 8'b11110100;
    parameter CBNZ  = 8'b11110101;
    parameter BEQ   = 8'b01110100;
    parameter BNE   = 8'b01110101;
    parameter BLT   = 8'b01110110;
    parameter BGE   = 8'b01110111;
    
    // Registers
    parameter X0    = 5'b00000;
    parameter X1    = 5'b00001;
    parameter X2    = 5'b00010;
    parameter X3    = 5'b00011;
    parameter X4    = 5'b00100;
    parameter X5    = 5'b00101;
    parameter X6    = 5'b00110;
    parameter X7    = 5'b00111;
    parameter X8    = 5'b01000;
    parameter X9    = 5'b01001;
    parameter X10   = 5'b01010;
    parameter X11   = 5'b01011;
    parameter X12   = 5'b01100;
    parameter X13   = 5'b01101;
    parameter X14   = 5'b01110;
    parameter X15   = 5'b01111;
    parameter X16   = 5'b10000;
    parameter X17   = 5'b10001;
    parameter X18   = 5'b10010;
    parameter X19   = 5'b10011;
    parameter X20   = 5'b10100;
    parameter X21   = 5'b10101;
    parameter X22   = 5'b10110;
    parameter X23   = 5'b10111;
    parameter X24   = 5'b11000;
    parameter X25   = 5'b11001;
    parameter X26   = 5'b11010;
    parameter X27   = 5'b11011;
    parameter X28   = 5'b11100;
    parameter X29   = 5'b11101;
    parameter X30   = 5'b11110;
    parameter XZR   = 5'b11111;
    
    cpu5arm dut(.ibus(instrbus), 
                .clk(clk), 
                .reset(reset), 
                .iaddrbus(iaddrbus), 
                .daddrbus(daddrbus), 
                .databus(databus));
        
    initial begin
    // This test file runs the following program.
    iname[0] =  "ADDI   X5, XZR, #-1";
    iname[1] =  "ADDI   X8, XZR, #15";
    iname[2] =  "ADDI   X10, XZR, #20";
    iname[3] =  "LDUR   X11, [X8, #60]";
    iname[4] =  "LDUR   X12, [X10, #20]";
    iname[5] =  "EORI   X13, XZR, 3A8C";
    iname[6] =  "STUR   X14, [X10, #250]";
    iname[7] =  "STUR   X15, [X5, #0]";
    iname[8] =  "ADD    X0, X10, X11";
    iname[9] =  "ORR    X1, X5, X8";
    iname[10] = "AND    X2, X11, X12";
    iname[11] = "ORRI   X3, X14, F0F0";
    iname[12] = "SUB    X4, X11, X10";
    iname[13] = "SUB    X6, X13, X14";
    iname[14] = "SUB    X9, X0, X10";
    iname[15] = "EOR    X7, X13, X15";
    iname[16] = "ENOR   X16, X3, X2";
    iname[17] = "EOR    X20, X5, X10";
    iname[18] = "ORRI   X19, X14, 9024";
    iname[19] = "ORRI   X18, X6, 0000";
    iname[20] = "AND    X17, X3, X4";
    iname[21] = "ANDI   X21, X6, 6721";
    iname[22] = "ANDI   X22, X7, AABB";
    iname[23] = "ADDI   X23, X13, CCDD";
    iname[24] = "SUBI   X30, X12, 0010";
    iname[25] = "ADDI   X29, X0, 4389";
    iname[26] = "SUBI   X28, X16, 0C10";
    iname[27] = "EORI   X27, X9, F5B8";
    iname[28] = "ENORI  X26, X7, FEDC";
    iname[29] = "EORI   X25, X20, 09B6";
    iname[30] = "ENORI  X24, X22, 6A21";
    iname[31] = "ADD    X0, X6, X7";
    iname[32] = "ADD    X8, X13, X14";
    iname[33] = "ADD    X9, X29, X16";
    iname[34] = "AND    X1, X20, X23";
    iname[35] = "AND    X2, X15, X18";
    iname[36] = "AND    X4, X24, X27";
    iname[37] = "EOR    X6, X3, X10";
    iname[38] = "EOR    X10, X14, X19";
    iname[39] = "ENOR   X11, X21, X25";
    iname[40] = "ENOR   X12, X20, X27";
    iname[41] = "EOR    X5, X7, X22";
    iname[42] = "ENOR   X13, X23, X30";
    iname[43] = "LSL    X3, X7, #5";
    iname[44] = "LSL    X7, X14, #0";
    iname[45] = "LSL    X14, X17, #2";
    iname[46] = "LSR    X15, X15, #8";
    iname[47] = "LSR    X18, X6, #4";
    iname[48] = "LSL    X16, X4, #7";
    iname[49] = "LSR    X19, X3, #2";
    iname[50] = "LSL    X17, X1, #4";
    iname[51] = "LSR    X20, X9, #0";
    iname[52] = "ORR    X22, X26, X4";
    iname[53] = "ORR    X23, X5, X8";
    iname[54] = "ORR    X24, X9, X10";
    iname[55] = "SUBI   X25, X1, 0044";
    iname[56] = "SUBI   X26, X8, 0FCB";
    iname[57] = "ENORI  X21, X14, #56CB";
    iname[58] = "ENORI  X27, X11, #710A";
    iname[59] = "EORI   X28, X0, #BAED";
    iname[60] = "LDUR   X29, [X12, #F94A]";
    iname[61] = "LDUR   X30, [X4, #7821]";
    iname[62] = "LDUR   X0, [X1, #FA90]";
    iname[63] = "STUR   X1, [X2, #7C51]";
    iname[64] = "STUR   X2, [X4, #FFAE]";
    iname[65] = "STUR   X4, [X5, #109D]";
    iname[66] = "ANDI   X5, X7, #872F";
    iname[67] = "ANDI   X3, X19, #3E51";
    iname[68] = "LSR    X6, X7, #1";
    iname[69] = "ADD    X7, X14, X9";
    iname[70] = "SUB    X8, X24, X25";
    iname[71] = "SUB    X9, X13, X18";
    iname[72] = "ENOR   X10, X30, X29";
    iname[73] = "ORR    X11, X30, X29";
    iname[74] = "EORI   X12, X24, #00FF";
    iname[75] = "ENORI  X13, X23, #FF00";
    iname[76] = "ORRI   X14, X18, #1002";
    iname[77] = "ORRI   X15, X20, #34BE";
    iname[78] = "SUBI   X16, X19, #8106";
    iname[79] = "ANDI   X17, X27, #FFFF";
    iname[80] = "ADD    X18, X0, X1";
    iname[81] = "ADD    X19, X2, X3";
    iname[82] = "AND    X20, X30, X29";
    iname[83] = "AND    X21, X29, X5";
    iname[84] = "EOR    X22, X7, X8";
    iname[85] = "EOR    X23, X9, X9";
    iname[86] = "ENOR   X24, X10, X15";
    iname[87] = "ENOR   X25, X11, X12";
    iname[88] = "LSL    X26, X6, #2";
    iname[89] = "LSL    X27, X5, #4";
    iname[90] = "LSR    X28, X0, #6";
    iname[91] = "LSR    X29, X2, #10";
    iname[92] = "ORR    X30, X14, X16";
    iname[93] = "ORR    X0, X10, X12";
    iname[94] = "SUB    X1, X16, X17";
    iname[95] = "SUB    X2, X18, X19";
    iname[96] = "ADDI   X3, X9, #0A25";
    iname[97] = "ADDI   X4, X10, #19E3";
    iname[98] = "EORI   X5, X11, #9087";
    iname[99] = "EORI   X6, X25, #0ABE";
    iname[100] = "ENORI X7, X26, #1BCF";
    iname[101] = "ENORI X8, X27, #2345";
    iname[102] = "ORRI  X9, X28, #FEDC";
    iname[103] = "ORRI  X10, X29, #0246";
    iname[104] = "SUBI  X11, X30, #BBAA";
    iname[105] = "SUBI  X12, X16, #9876";
    iname[106] = "LDUR  X13, [X15, #540A]";
    iname[107] = "LDUR  X14, [X2, #20FD]";
    iname[108] = "STUR  X15, [X3, #459B]";
    iname[109] = "STUR  X16, [X4, #78C2]";
    iname[110] = "ANDI  X17, X5, #9840";
    iname[111] = "ANDI  X18, X6, #FFEE";
    iname[112] = "";
    iname[113] = "";
    iname[114] = "";
    iname[115] = "";
    iname[116] = "";
    iname[117] = "";
    iname[118] = "";
    iname[119] = "";
    iname[120] = "";
    iname[121] = "";
    iname[122] = "";
    iname[123] = "";
    iname[124] = "";
    iname[125] = "";
    iname[126] = "";
    iname[127] = "";
    iname[128] = "";
    iname[129] = "";
    iname[130] = "";
    iname[131] = "";
    iname[132] = "";
    iname[133] = "";
    iname[134] = "";
    iname[135] = "";
    iname[136] = "";
    iname[137] = "";
    iname[138] = "";
    iname[139] = "";
    iname[140] = "";
    iname[141] = "";
    iname[142] = "";
    iname[143] = "";
    iname[144] = "";
    iname[145] = "";
    iname[146] = "";
    iname[147] = "";
    iname[148] = "";
    iname[149] = "";
    iname[150] = "";
    iname[151] = "";
    iname[152] = "";
    iname[153] = "";
    iname[154] = "";
    iname[155] = "";
    iname[156] = "";
    iname[157] = "";
    iname[158] = "";
    iname[159] = "";
    iname[160] = "";
    iname[161] = "";
    iname[162] = "";
    iname[163] = "";
    iname[164] = "";
    iname[165] = "";
    iname[166] = "";
    iname[167] = "";
    iname[168] = "";
    iname[169] = "";
    iname[170] = "";
    iname[171] = "";
    iname[172] = "";
    iname[173] = "";
    iname[174] = "";
    iname[175] = "";
    iname[176] = "";
    iname[177] = "";
    iname[178] = "";
    iname[179] = "";
    iname[180] = "";
    iname[181] = "";
    iname[182] = "";
    iname[183] = "";
    iname[184] = "";
    iname[185] = "";
    iname[186] = "";
    iname[187] = "";
    iname[188] = "";
    iname[189] = "";
    iname[190] = "";
    iname[191] = "";
    iname[192] = "";
    iname[193] = "";
    iname[194] = "";
    iname[195] = "";
    iname[196] = "";
    iname[197] = "";
    iname[198] = "";
    iname[199] = "";
    iname[200] = "";
    iname[201] = "";
    iname[202] = "";
    iname[203] = "";
    iname[204] = "";
    iname[205] = "";
    iname[206] = "";
    iname[207] = "";
    iname[208] = "";
    iname[209] = "";
    
    //* ADDI   X5, XZR, #-1
    iaddrbusout[0] = 64'h0000000000000000;
    //            opcode source1   dest      Immediate...
    instrbusin[0]={ADDI, XZR, X5, 16'hFFFF};
    
    daddrbusout[0] = dontcare;
    databusin[0] = activez;
    databusout[0] = dontcare;
    
    
    
    dontcare = 64'hx;
    activez = 64'hz;
    
    //ntests = ;

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
    
    for (k=0; k<= 209; k=k+1) begin
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
