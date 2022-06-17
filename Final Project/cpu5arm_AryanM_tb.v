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
    
    reg [63:0] dontcare;
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
    parameter R0    = 5'b00000;
    parameter R1    = 5'b00001;
    parameter R2    = 5'b00010;
    parameter R3    = 5'b00011;
    parameter R4    = 5'b00100;
    parameter R5    = 5'b00101;
    parameter R6    = 5'b00110;
    parameter R7    = 5'b00111;
    parameter R8    = 5'b01000;
    parameter R9    = 5'b01001;
    parameter R10   = 5'b01010;
    parameter R11   = 5'b01011;
    parameter R12   = 5'b01100;
    parameter R13   = 5'b01101;
    parameter R14   = 5'b01110;
    parameter R15   = 5'b01111;
    parameter R16   = 5'b10000;
    parameter R17   = 5'b10001;
    parameter R18   = 5'b10010;
    parameter R19   = 5'b10011;
    parameter R20   = 5'b10100;
    parameter R21   = 5'b10101;
    parameter R22   = 5'b10110;
    parameter R23   = 5'b10111;
    parameter R24   = 5'b11000;
    parameter R25   = 5'b11001;
    parameter R26   = 5'b11010;
    parameter R27   = 5'b11011;
    parameter R28   = 5'b11100;
    parameter R29   = 5'b11101;
    parameter R30   = 5'b11110;
    parameter R31   = 5'b11111;
    
    cpu5arm dut(.ibus(instrbus), 
                .clk(clk), 
                .reset(reset), 
                .iaddrbus(iaddrbus), 
                .daddrbus(daddrbus), 
                .databus(databus));
        
    initial begin
    // This test file runs the following program.
    iname[0] = "";
    iname[1] = "";
    iname[2] = "";
    iname[3] = "";
    iname[4] = "";
    iname[5] = "";
    iname[6] = "";
    iname[7] = "";
    iname[8] = "";
    iname[9] = "";
    iname[10] = "";
    iname[11] = "";
    iname[12] = "";
    iname[13] = "";
    iname[14] = "";
    iname[15] = "";
    iname[16] = "";
    iname[17] = "";
    iname[18] = "";
    iname[19] = "";
    iname[20] = "";
    iname[21] = "";
    iname[22] = "";
    iname[23] = "";
    iname[24] = "";
    iname[25] = "";
    iname[26] = "";
    iname[27] = "";
    iname[28] = "";
    iname[29] = "";
    iname[30] = "";
    iname[31] = "";
    iname[32] = "";
    iname[33] = "";
    iname[34] = "";
    iname[35] = "";
    iname[36] = "";
    iname[37] = "";
    iname[38] = "";
    iname[39] = "";
    iname[40] = "";
    iname[41] = "";
    iname[42] = "";
    iname[43] = "";
    iname[44] = "";
    iname[45] = "";
    iname[46] = "";
    iname[47] = "";
    iname[48] = "";
    iname[49] = "";
    iname[50] = "";
    iname[51] = "";
    iname[52] = "";
    iname[53] = "";
    iname[54] = "";
    iname[55] = "";
    iname[56] = "";
    iname[57] = "";
    iname[58] = "";
    iname[59] = "";
    iname[60] = "";
    iname[61] = "";
    iname[62] = "";
    iname[63] = "";
    iname[64] = "";
    iname[65] = "";
    iname[66] = "";
    iname[67] = "";
    iname[68] = "";
    iname[69] = "";
    iname[70] = "";
    iname[71] = "";
    iname[72] = "";
    iname[73] = "";
    iname[74] = "";
    iname[75] = "";
    iname[76] = "";
    iname[77] = "";
    iname[78] = "";
    iname[79] = "";
    iname[80] = "";
    iname[81] = "";
    iname[82] = "";
    iname[83] = "";
    iname[84] = "";
    iname[85] = "";
    iname[86] = "";
    iname[87] = "";
    iname[88] = "";
    iname[89] = "";
    iname[90] = "";
    iname[91] = "";
    iname[92] = "";
    iname[93] = "";
    iname[94] = "";
    iname[95] = "";
    iname[96] = "";
    iname[97] = "";
    iname[98] = "";
    iname[99] = "";
    iname[100] = "";
    iname[101] = "";
    iname[102] = "";
    iname[103] = "";
    iname[104] = "";
    iname[105] = "";
    iname[106] = "";
    iname[107] = "";
    iname[108] = "";
    iname[109] = "";
    iname[110] = "";
    iname[111] = "";
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
    
    dontcare = 64'hx;
    
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
