//Property of Prof. J. Marpaung and Northeastern University
//Not to be distributed elsewhere without a written consent from Prof. J. Marpaung
//All Rights Reserved


`timescale 1ns/10ps
module cpu3_testbench();

reg [31:0] ibustm[0:30], ibus;
wire [31:0] abus;
wire [31:0] bbus;
wire [31:0] dbus;
reg clk;

reg [31:0] dontcare, abusin[0:30], bbusin[0:30], dbusout[0:30];
integer error, k, ntests;

parameter ADDI = 6'b000011;
parameter SUBI = 6'b000010;
parameter XORI = 6'b000001;
parameter ANDI = 6'b001111;
parameter ORI = 6'b001100;
parameter Rformat = 6'b000000;
parameter ADD = 6'b000011;
parameter SUB = 6'b000010;
parameter XOR = 6'b000001;
parameter AND = 6'b000111;
parameter OR = 6'b000100;


cpu3 dut(.ibus(ibus), .clk(clk), .abus(abus), .bbus(bbus), .dbus(dbus));


initial begin


// ---------- 
// 1. Begin test clear SUB R1, R0, R0
// ----------

//         opcode   source1   source2   dest      shift     Function...
ibustm[0]={Rformat, 5'b00000, 5'b00000, 5'b00001, 5'b00000, SUB};
abusin[0]=32'h00000000;
bbusin[0]=32'h00000000;
dbusout[0]=32'h00000000;


// ----------
//  2. ADDI R2, R1, 0x3A7F
// ----------

ibustm[1] = {ADDI, 5'b00001, 5'b00010, 16'h3A7F};
abusin[1]=32'h00000000;
bbusin[1]=32'h00000000;
dbusout[1]=32'h00000000;



// ---------- 
// 3. SUBI R3, R1, 0x9876
// ----------

ibustm[2] = {SUBI, 5'b00001, 5'b00011, 16'h9876}; 
abusin[2]=32'h00000000;
bbusin[2]=32'hFFFFFFFF;
dbusout[2]=32'hFFFFFFFF;

// ---------- 
// 4. XORI R4, R3, 0xABCD
// ----------

ibustm[3] = {XORI, 5'b00011, 5'b00100, 16'hABCD};
abusin[3]=32'h00000000;
bbusin[3]=32'hFFFFAFC0;
dbusout[3]=32'hFFFFAFC0;


// ---------- 
// 5. ANDI R5, R4, 0xF0F0
// ----------

ibustm[4] = {ANDI, 5'b00100, 5'b00101, 16'hF0F0};
abusin[4]=32'h00000000;
bbusin[4]=32'h00000000;
dbusout[4]=32'h00000000;

// ---------- 
// 6. ORI R6, R5, 0x5555
// ----------

ibustm[5] = {ORI,  5'b00101, 5'b00110, 16'h5555};
abusin[5]=32'h00000000;
bbusin[5]=32'h00007334;
dbusout[5]=32'h00007334;


// ---------- 
// 7. ADD R7, R6, R5
// ----------

ibustm[6]={Rformat, 5'b00110, 5'b00101, 5'b00111, 5'b00000, ADD};
abusin[6]=32'h00000000;
bbusin[6]=32'hFFFFF98B;
dbusout[6]=32'hFFFFF98B;


// ---------- 
// 8. Begin SUB R8, R7, R6
// ----------

ibustm[7]={Rformat, 5'b00111, 5'b00110, 5'b01000, 5'b00000, SUB};
abusin[7]=32'h00000000;
bbusin[7]=32'h00007334;
dbusout[7]=32'h00007334;



// ---------- 
// 9. XOR R9, R8, R7
// ----------

ibustm[8]={Rformat, 5'b01000, 5'b00111, 5'b01001, 5'b00000, XOR};
abusin[8]=32'hFFFFF98B;
bbusin[8]=32'h00000030;
dbusout[8]=32'hFFFFF95B;

// ---------- 
// 10. AND R10 R9 R8
// ----------

ibustm[9]={Rformat, 5'b01001, 5'b01000, 5'b01010, 5'b00000, AND};
abusin[9]=32'h00000000;
bbusin[9]=32'hFFFF8ABF;
dbusout[9]=32'hFFFF8ABF;

// ------------ 
// 11. OR R11, R10, R9
// ------------

ibustm[10]={Rformat, 5'b01010, 5'b01001, 5'b01011, 5'b00000, OR};
abusin[10]=32'h00000000;
bbusin[10]=32'h000034FB;
dbusout[10]=32'h000034FB;


// ------------ 
// 12. ADDI R12, R11, 0x42F1
// ------------

ibustm[11] = {ADDI, 5'b01011, 5'b01100, 16'h42F1};
abusin[11]=32'h00000000;
bbusin[11]=32'h00000B31;
dbusout[11]=32'h00000B31;


// --------- 
// 13. XORI R13, R12, 0x2B12
// ---------

ibustm[12] = {XORI, 5'b01100, 5'b01101, 16'h2B12};
abusin[12]=32'h00007334;
bbusin[12]=32'h00007334;
dbusout[12]=32'h0000E668;

// --------- 
// 14.  ORI R14, R13, 0x7E8C
// ---------

ibustm[13] = {ORI,  5'b01101, 5'b01110, 16'h7E8C};
abusin[13]=32'h000034FB;
bbusin[13]=32'h000034FB;
dbusout[13]=32'h000034FB;

// --------- 
// 15. SUBI R15, R14, 0x1234
// ---------

ibustm[14] = {SUBI, 5'b01110, 5'b01111, 16'h0000};
abusin[14]=32'hFFFFF98B;
bbusin[14]=32'h000000F0;
dbusout[14]=32'hFFFFF97B;

// --------- 
// 16. ADD R16, R15, R14
// ---------

ibustm[15]={Rformat, 5'b01111, 5'b01110, 5'b10000, 5'b00000, ADD};
abusin[15]=32'hFFFFF95B;
bbusin[15]=32'h00000111;
dbusout[15]=32'hFFFFF84A;



// --------- 
// 17. AND R17, R16, R15
// ---------

ibustm[16]={Rformat, 5'b10000, 5'b01111, 5'b10001, 5'b00000, AND};
abusin[16]=32'h00007334;
bbusin[16]=32'hFFFFF98B;
dbusout[16]=32'h00006CBF;

// ---------- 
// 18. SUB R18, R17, R16
// ----------

ibustm[17]={Rformat, 5'b10001, 5'b10000, 5'b10010, 5'b00000, SUB};
abusin[17]=32'h00000000;
bbusin[17]=32'h0000328F;
dbusout[17]=32'h0000328F;


// --------- 
// 19. XOR R19, R18, R17
// ---------

ibustm[18]={Rformat, 5'b10001, 5'b10010, 5'b10011, 5'b00000, XOR};
abusin[18]=32'h00000000;
bbusin[18]=32'hFFFFFFFF;
dbusout[18]=32'hFFFFFFFF;

// --------- 
// 20. OR R20, R19, R18
// ---------
 
ibustm[19]={Rformat, 5'b10011, 5'b10001, 5'b10100, 5'b00000, OR};
abusin[19]=32'h00000000;
bbusin[19]=32'hFFFFAFC0;
dbusout[19]=32'hFFFFAFC0;

// --------- 
// 21.  XORI R23, R30, 0xA1B2
// ---------

ibustm[20] = {XORI, 5'b10111, 5'b11110, 16'hA1B2};  
abusin[20]=32'h00000000;
bbusin[20]=32'h00000000;
dbusout[20]=32'h00000000;


// ---------- 
// 22. ADDI R24, R31, 0x5F13
// ----------

ibustm[21] = {ADDI, 5'b11000, 5'b11111, 16'h5F13};
abusin[21]=32'h00000000;
bbusin[21]=32'h00007334;
dbusout[21]=32'h00007334;


// -------- 
// 23. ADDI R24, R31, 0x5F13
// --------

ibustm[22] = {ANDI, 5'b11001, 5'b10000, 16'hC0DE};
abusin[22]=32'hFFFFFFFF;
bbusin[22]=32'hFFFFF98B;
dbusout[22]=32'hFFFFFFFF;

// -------- 
// 24. ORI R26, R17, 0xBEEF
// --------

ibustm[23] = {ORI,  5'b11010, 5'b10001, 16'hBEEF};
abusin[23]=32'hFFFFFFFF;
bbusin[23]=32'h00007334;
dbusout[23]=32'hFFFF8CCB;


// -------- 
// 25. SUB R27, R18, R4
// --------

ibustm[24] = {Rformat, 5'b11011, 5'b10010, 5'b00100, 5'b00000, SUB};
abusin[24]=32'hFFFFFFFF;
bbusin[24]=32'h00000030;
dbusout[24]=32'hFFFFFFCF;


// -------- 
// 26. XOR R28, R19, R14
// --------

ibustm[25] = {Rformat, 5'b11100, 5'b10011, 5'b01110, 5'b00000, XOR};
abusin[25]=32'h00000000;
bbusin[25]=32'hFFFF8ABF;
dbusout[25]=32'hFFFF8ABF;


// -------- 
// 27. AND R29, R20, R24
// --------

ibustm[26]={Rformat, 5'b11101, 5'b10100, 5'b10100, 5'b00000, AND};
abusin[26]=32'hFFFFFFFF;
bbusin[26]=32'h000034FB;
dbusout[26]=32'hFFFFFFFF;

// -------- 
// 28. SUBI R30, R21, 0xFFFF
// --------

ibustm[27] = {SUBI, 5'b11110, 5'b10101, 16'hFFFF};
abusin[27]=32'hFFFFFFFF;
bbusin[27]=32'h00000B31;
dbusout[27]=32'hFFFFF4CE;


// -------- 
// 29. Begin TEST # 26 ADD R14, R2, R19
// --------

ibustm[28]={Rformat, 5'b11111, 5'b10110, 5'b01010, 5'b00000, ADD};
abusin[28]=32'hFFFF8CCB;
bbusin[28]=32'h00007334;
dbusout[28]=32'hFFFFFFFF;

// -------- 
// 30. ANDI R16, R23, 0x0F0F
// --------

ibustm[29]={Rformat, 5'b10000, 5'b10111, 5'b00100, 5'b00000, ANDI};
abusin[29]=32'hFFFFFFFF;
bbusin[29]=32'hFFFFFFFF;
dbusout[29]=32'hFFFFFFFF;


// -------- 
// 31. ORI R17, R24, 0x1234
// --------

ibustm[30] = {ORI,  5'b10001, 5'b11000, 16'h1234};
abusin[30]=32'hFFFFF98B;
bbusin[30]=32'h00005555;
dbusout[30]=32'hFFFFACDE;

// -------- 
// 32. XORI R18, R25, 0x5678
// --------

ibustm[31] = {XORI, 5'b10010, 5'b11001, 16'h5678};
abusin[31]=32'hFFFFF98B;
bbusin[31]=32'h00005555;
dbusout[31]=32'hFFFFACDE;

// 31*2
ntests = 62;

$timeformat(-9,1,"ns",12); 

end


initial begin
  error = 0;
  clk=0;
  for (k=0; k<= 31s; k=k+1) begin
    
    //check input operands from 2nd previous instruction
    
    $display ("Time=%t\n  clk=%b", $realtime, clk);
    if (k >= 3) begin
      $display ("  Testing input operands for instruction %d", k-3);
      $display ("    Your abus =    %b", abus);
      $display ("    Correct abus = %b", abusin[k-3]);
      $display ("    Your bbus =    %b", bbus);
      $display ("    Correct bbus = %b", bbusin[k-3]);
     
      if ((abusin[k-3] !== abus) ||(bbusin[k-3] !== bbus)) begin
        $display ("    -------------ERROR. A Mismatch Has Occured-----------");
        error = error + 1;
      end
    
    end

    clk=1;
    #25	
    
    //check output operand from 3rd previous instruction on bbus
    
    $display ("Time=%t\n  clk=%b", $realtime, clk);
    if (k >= 3) begin
      $display ("  Testing output operand for instruction %d", k-3);
      $display ("    Your dbus =    %b", dbus);
      $display ("    Correct dbus = %b", dbusout[k-3]);
      
      if (dbusout[k-3] !== dbus) begin
        $display ("    -------------ERROR. A Mismatch Has Occured-----------");
        error = error + 1;
      end
      
    end

    //put next instruction on ibus
    ibus=ibustm[k];
    $display ("  ibus=%b %b %b %b %b for instruction %d", ibus[31:26], ibus[25:21], ibus[20:16], ibus[15:11], ibus[10:0], k);
    clk = 0;
    #25
    error = error;
  
  end
 
  if ( error !== 0) begin 
    $display("--------- SIMULATION UNSUCCESFUL - MISMATCHES HAVE OCCURED----------");
    $display(" No. Of Errors = %d", error);
  end
  if ( error == 0) 
    $display("---------YOU DID IT!! SIMULATION SUCCESFULLY FINISHED----------");

end

endmodule
