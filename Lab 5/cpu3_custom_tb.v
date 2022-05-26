//Property of Prof. J. Marpaung and Northeastern University
//Edits by Sam Bolduc and Aryan Mehrotra
//Not to be distributed elsewhere without a written consent from Prof. J. Marpaung
//All Rights Reserved


`timescale 1ns/10ps
module cpu3_custom_tb();

reg [31:0] ibustm[0:32], ibus;
wire [31:0] abus;
wire [31:0] bbus;
wire [31:0] dbus;
reg clk;

reg [31:0] dontcare, abusin[0:32], bbusin[0:32], dbusout[0:32];
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
// 1. Begin test clear Add R12, R0, R0
// ----------

//         opcode   source1   source2   dest      shift     Function...
ibustm[0]={Rformat, 5'b00000, 5'b00000, 5'b01100, 5'b00000, ADD};
abusin[0]=32'h00000000;
bbusin[0]=32'h00000000;
dbusout[0]=32'h00000000;


// ----------
//  2. SUBI R1, R0, #0000
// ----------

//        opcode source1   dest      Immediate... 
ibustm[1]={SUBI, 5'b00000, 5'b00001, 16'h0000};
abusin[1]=32'h00000000;
bbusin[1]=32'h00000000;
dbusout[1]=32'h00000000;



// ---------- 
// 3. Begin TEST # 0 ADDI R0, R0, #FABC
// ----------

//        opcode source1   dest      Immediate... 
ibustm[2]={ADDI, 5'b00000, 5'b00000, 16'hFABC};
abusin[2]=32'h00000000;
bbusin[2]=32'hFFFFFABC;
dbusout[2]=32'hFFFFFABC;

// ---------- 
// 4. Begin TEST # 1  ADDI R26, R1,#A4B9
// ----------

//        opcode source1   dest      Immediate... 
ibustm[3]={ADDI, 5'b00001, 5'b11010, 16'hA4B9};
abusin[3]=32'h00000000;
bbusin[3]=32'hFFFFA4B9;
dbusout[3]=32'hFFFFA4B9;


// ---------- 
// 5. Begin TEST # 2 XOR R0, R0, R0
// ----------

//         opcode   source1   source2   dest      shift     Function...
ibustm[4]={Rformat, 5'b00000, 5'b00000, 5'b00000, 5'b00000, XOR};
abusin[4]=32'h00000000;
bbusin[4]=32'h00000000;
dbusout[4]=32'h00000000;

// ---------- 
// 6. Begin TEST # 3  ADDI R3, R1, #7245
// ----------

//        opcode source1   dest      Immediate... 
ibustm[5]={ADDI, 5'b00001, 5'b00011, 16'h7245};
abusin[5]=32'h00000000;
bbusin[5]=32'h00007245;
dbusout[5]=32'h00007245;


// ---------- 
// 7. Begin TEST # 4 ORI R21, R1, #F876 
// ----------

//        opcode source1   dest      Immediate... 
ibustm[6]={ORI, 5'b00001, 5'b10101, 16'hF876};
abusin[6]=32'h00000000;
bbusin[6]=32'hFFFFF876;
dbusout[6]=32'hFFFFF876;


// ---------- 
// 8. Begin TEST # 5 OR R16, R1, R3
// ----------

//         opcode   source1   source2   dest      shift     Function...
ibustm[7]={Rformat, 5'b00001, 5'b00011, 5'b10000, 5'b00000, OR};
abusin[7]=32'h00000000;
bbusin[7]=32'h00007245;
dbusout[7]=32'h00007245;



// ---------- 
// 9. Begin TEST # 6 ADDI R31, R21, #0053
// ----------

//        opcode source1   dest      Immediate... 
ibustm[8]={ADDI, 5'b10101, 5'b11111, 16'h0053};
abusin[8]=32'hFFFFF876;
bbusin[8]=32'h00000053;
dbusout[8]=32'hFFFFF8C9;

// ---------- 
// 10. Begin TEST # 7 XORI R5, R1, #8ABF
// ----------

//        opcode source1   dest      Immediate... 
ibustm[9]={XORI, 5'b00001, 5'b00101, 16'h8ABF};
abusin[9]=32'h00000000;
bbusin[9]=32'hFFFF8ABF;
dbusout[9]=32'hFFFF8ABF;

// ------------ 
// 11. Begin TEST # 8 ORI R10, R1, #4206  
// ------------

//        opcode source1   dest      Immediate... 
ibustm[10]={ORI, 5'b00001, 5'b01010, 16'h4206};
abusin[10]=32'h00000000;
bbusin[10]=32'h00004206;
dbusout[10]=32'h00004206;


// ------------ 
// 12. Begin TEST # 9  ADDI R18, R1, #0C61
// ------------

//         opcode source1   dest      Immediate... 
ibustm[11]={ADDI, 5'b00001, 5'b10010, 16'h0C61};
abusin[11]=32'h00000000;
bbusin[11]=32'h00000C61;
dbusout[11]=32'h00000C61;


// --------- 
// 13. Begin TEST # 10  ADD R24, R16, R3
// ---------

//          opcode   source1   source2   dest      shift     Function...
ibustm[12]={Rformat, 5'b10000, 5'b00011, 5'b11000, 5'b00000, ADD};
abusin[12]=32'h00007245;
bbusin[12]=32'h00007245;
dbusout[12]=32'h000E48A;

// --------- 
// 14. Begin TEST # 11 AND R7, R10, R10
// ---------

//          opcode   source1   source2   dest      shift     Function...
ibustm[13]={Rformat, 5'b01010, 5'b01010, 5'b00111, 5'b00000, AND};
abusin[13]=32'h00004206;
bbusin[13]=32'h00004206;
dbusout[13]=32'h00004206;

// --------- 
// 15. Begin TEST # 12 XORI R12, R21, #90D9
// ---------

//         opcode source1   dest      Immediate... 
ibustm[14]={XORI, 5'b10101, 5'b01100, 16'h90D9};
abusin[14]=32'hFFFFF876;
bbusin[14]=32'hFFFF90D9;
dbusout[14]=32'h000068AF;

// --------- 
// 16. Begin TEST # 13 ADDI R28, R31, #0234
// ---------

//         opcode source1   dest      Immediate... 
ibustm[15]={ADDI, 5'b11111, 5'b11100, 16'h0234};
abusin[15]=32'hFFFFF8C9;
bbusin[15]=32'h00000234;
dbusout[15]=32'hFFFFFAFD;



// --------- 
// 17. Begin TEST # 14 SUB R17, R3, R21
// ---------

//          opcode   source1   source2   dest      shift     Function...
ibustm[16]={Rformat, 5'b00011, 5'b10101, 5'b10001, 5'b00000, SUB};
abusin[16]=32'h00007245;
bbusin[16]=32'hFFFFF876;
dbusout[16]=32'h000079CF;

// ---------- 
// 18. Begin TEST # 15 ADDI R15, R1, #417E
// ----------

//         opcode source1   dest      Immediate... 
ibustm[17]={ADDI, 5'b00001, 5'b01111, 16'h417E};
abusin[17]=32'h00000000;
bbusin[17]=32'h0000417E;
dbusout[17]=32'h0000417E;


// --------- 
// 19. Begin TEST # 16 ADDI R13, R13, #FEDC
// ---------

//         opcode source1   dest      Immediate... 
ibustm[18]={ADDI, 5'b00001, 5'b01101, 16'hFEDC};
abusin[18]=32'h00000000;
bbusin[18]=32'hFFFFFEDC;
dbusout[18]=32'hFFFFFEDC;

// --------- 
// 20. Begin TEST # 17 ORI R23, R1, #ABD2
// ---------

//         opcode source1   dest      Immediate... 
ibustm[19]={ORI, 5'b00001, 5'b10111, 16'hABD2};
abusin[19]=32'h00000000;
bbusin[19]=32'hFFFFABD2;
dbusout[19]=32'hFFFFABD2;

// --------- 
// 21. Begin TEST # 18 OR R20, R1, R1
// ---------

//          opcode   source1   source2   dest      shift     Function...
ibustm[20]={Rformat, 5'b00001, 5'b00001, 5'b10100, 5'b00000, OR};
abusin[20]=32'h00000000;
bbusin[20]=32'h00000000;
dbusout[20]=32'h00000000;


// ---------- 
// 22. Begin TEST # 19 ORI R19, R1, #6228
// ----------

//         opcode source1   dest      Immediate... 
ibustm[21]={ORI, 5'b00001, 5'b10011, 16'h6228};
abusin[21]=32'h00000000;
bbusin[21]=32'h00006228;
dbusout[21]=32'h00006228;


// -------- 
// 23. Begin TEST # 20 SUBI R9, R13, #3654
// --------

//         opcode source1   dest      Immediate... 
ibustm[22]={SUBI, 5'b01101, 5'b01001, 16'h3654};
abusin[22]=32'hFFFFFEDC;
bbusin[22]=32'h00003654;
dbusout[22]=32'hFFFFC888;

// -------- 
// 24. Begin TEST # 21 OR R2, R13, R19
// --------

//          opcode   source1   source2   dest      shift     Function...
ibustm[23]={Rformat, 5'b01101, 5'b10011, 5'b00010, 5'b00000, OR};
abusin[23]=32'hFFFFFEDC;
bbusin[23]=32'h00006228;
dbusout[23]=32'hFFFFFEFC;


// -------- 
// 25. Begin TEST # 22 SUBI R26, R9, #0450
// --------

//         opcode source1   dest      Immediate... 
ibustm[24]={SUBI, 5'b01001, 5'b11010, 16'h0450};
abusin[24]=32'hFFFFC888;
bbusin[24]=32'h00000450;
dbusout[24]=32'hFFFFC438;


// -------- 
// 26. Begin TEST # 23 ORI R25, R1, #ABAE
// --------

//         opcode source1   dest      Immediate... 
ibustm[25]={ORI, 5'b00001, 5'b11001, 16'hABAE};
abusin[25]=32'h00000000;
bbusin[25]=32'hFFFFABAE;
dbusout[25]=32'hFFFFABAE;


// -------- 
// 27. Begin TEST # 24 ORI R8, R13, #6942
// --------

//         opcode source1   dest      Immediate... 
ibustm[26]={ORI, 5'b01101, 5'b01000, 16'h6942};
abusin[26]=32'hFFFFFEDC;
bbusin[26]=32'h00006942;
dbusout[26]=32'hFFFFFFDE;

// -------- 
// 28. Begin TEST # 25 XORI R27, R13, #0846
// --------

//         opcode source1   dest      Immediate... 
ibustm[27]={XORI, 5'b01101, 5'b11011, 16'h0846};
abusin[27]=32'hFFFFFEDC;
bbusin[27]=32'h00000846;
dbusout[27]=32'hFFFFF69A;


// -------- 
// 29. Begin TEST # 26 SUB R14, R2, R19
// --------

//          opcode   source1   source2   dest      shift     Function...
ibustm[28]={Rformat, 5'b00010, 5'b10011, 5'b01110, 5'b00000, SUB};
abusin[28]=32'hFFFFFEFC;
bbusin[28]=32'h00006228;
dbusout[28]=32'hFFFF9CD4;

// -------- 
// 30. Begin TEST # 27 AND R4, R8, R8 
// --------

//          opcode   source1   source2   dest      shift     Function...
ibustm[29]={Rformat, 5'b01000, 5'b01000, 5'b00100, 5'b00000, AND};
abusin[29]=32'hFFFFFFDE;
bbusin[29]=32'hFFFFFFDE;
dbusout[29]=32'hFFFFFFDE;


// -------- 
// 31. Begin TEST # 28 SUBI R12, R21, #5432
// --------

//         opcode source1   dest      Immediate... 
ibustm[30]={SUBI, 5'b10101, 5'b01100, 16'h5432};
abusin[30]=32'hFFFFF876;
bbusin[30]=32'h00005432;
dbusout[30]=32'hFFFFA444;
  
// -------- 
// 32. Begin TEST # 29 ORI R11, R10, #0112
// --------

//         opcode source1   dest      Immediate... 
ibustm[31]={ORI, 5'b01010, 5'b01011, 16'h0112};
abusin[31]=32'h00004206;
bbusin[31]=32'h00000112;
dbusout[31]=32'h00004316;
  
// -------- 
// 33. Begin TEST # 30 SUBI R29, R25, #1212
// --------

//         opcode source1   dest      Immediate... 
ibustm[32]={SUBI, 5'b11001, 5'b11101, 16'h1212};
abusin[32]=32'hFFFFABAE;
bbusin[32]=32'h00001212;
dbusout[32]=32'h00000202;

// 33*2
ntests = 66;

$timeformat(-9,1,"ns",12); 

end


initial begin
  error = 0;
  clk=0;
  for (k=0; k<= 32; k=k+1) begin
    
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
