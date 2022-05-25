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
// 1. Begin test clear SUB R13, R0, R0
// ----------

//         opcode   source1   source2   dest      shift     Function...
ibustm[0]={Rformat, 5'b00000, 5'b00000, 5'b01101, 5'b00000, SUB};
abusin[0]=32'h00000000;
bbusin[0]=32'h00000000;
dbusout[0]=32'h00000000;


// ----------
//  2. ADDI R1, R0, #0000
// ----------

//        opcode source1   dest      Immediate... 
ibustm[1]={ADDI, 5'b00000, 5'b00001, 16'h0000};
abusin[1]=32'h00000000;
bbusin[1]=32'h00000000;
dbusout[1]=32'h00000000;



// ---------- 
// 3. Begin TEST # 0 ADDI R0, R0, #FFFF
// ----------

//        opcode source1   dest      Immediate... 
ibustm[2]={ADDI, 5'b00000, 5'b00000, 16'hFFFF};
abusin[2]=32'h00000000;
bbusin[2]=32'hFFFFFFFF;
dbusout[2]=32'hFFFFFFFF;

// ---------- 
// 4. Begin TEST # 1  ADDI R30, R1,#AFC0
// ----------

//        opcode source1   dest      Immediate... 
ibustm[3]={ADDI, 5'b00001, 5'b11110, 16'hAFC0};
abusin[3]=32'h00000000;
bbusin[3]=32'hFFFFAFC0;
dbusout[3]=32'hFFFFAFC0;


// ---------- 
// 5. Begin TEST # 2 SUB R0, R0, R0
// ----------

//         opcode   source1   source2   dest      shift     Function...
ibustm[4]={Rformat, 5'b00000, 5'b00000, 5'b00000, 5'b00000, SUB};
abusin[4]=32'h00000000;
bbusin[4]=32'h00000000;
dbusout[4]=32'h00000000;

// ---------- 
// 6. Begin TEST # 3  ORI R3, R1, #7334 
// ----------

//        opcode source1   dest      Immediate... 
ibustm[5]={ORI, 5'b00001, 5'b00011, 16'h7334};
abusin[5]=32'h00000000;
bbusin[5]=32'h00007334;
dbusout[5]=32'h00007334;


// ---------- 
// 7. Begin TEST # 4 ORI R21, R1, #F98B 
// ----------

//        opcode source1   dest      Immediate... 
ibustm[6]={ORI, 5'b00001, 5'b10101, 16'hF98B};
abusin[6]=32'h00000000;
bbusin[6]=32'hFFFFF98B;
dbusout[6]=32'hFFFFF98B;


// ---------- 
// 8. Begin TEST # 5 XOR R16, R1, R3
// ----------

//         opcode   source1   source2   dest      shift     Function...
ibustm[7]={Rformat, 5'b00001, 5'b00011, 5'b10000, 5'b00000, XOR};
abusin[7]=32'h00000000;
bbusin[7]=32'h00007334;
dbusout[7]=32'h00007334;



// ---------- 
// 9. Begin TEST # 6 SUBI R31, R21, #0030
// ----------

//        opcode source1   dest      Immediate... 
ibustm[8]={SUBI, 5'b10101, 5'b11111, 16'h0030};
abusin[8]=32'hFFFFF98B;
bbusin[8]=32'h00000030;
dbusout[8]=32'hFFFFF95B;

// ---------- 
// 10. Begin TEST # 7 ORI R5, R1, #8ABF
// ----------

//        opcode source1   dest      Immediate... 
ibustm[9]={ORI, 5'b00001, 5'b00101, 16'h8ABF};
abusin[9]=32'h00000000;
bbusin[9]=32'hFFFF8ABF;
dbusout[9]=32'hFFFF8ABF;

// ------------ 
// 11. Begin TEST # 8 ORI R10, R1, #34FB  
// ------------

//        opcode source1   dest      Immediate... 
ibustm[10]={ORI, 5'b00001, 5'b01010, 16'h34FB};
abusin[10]=32'h00000000;
bbusin[10]=32'h000034FB;
dbusout[10]=32'h000034FB;


// ------------ 
// 12. Begin TEST # 9  XORI R18, R1, #0B31
// ------------

//         opcode source1   dest      Immediate... 
ibustm[11]={XORI, 5'b00001, 5'b10010, 16'h0B31};
abusin[11]=32'h00000000;
bbusin[11]=32'h00000B31;
dbusout[11]=32'h00000B31;


// --------- 
// 13. Begin TEST # 10  ADD R24, R16, R3
// ---------

//          opcode   source1   source2   dest      shift     Function...
ibustm[12]={Rformat, 5'b10000, 5'b00011, 5'b11000, 5'b00000, ADD};
abusin[12]=32'h00007334;
bbusin[12]=32'h00007334;
dbusout[12]=32'h0000E668;

// --------- 
// 14. Begin TEST # 11 OR R7, R10, R10
// ---------

//          opcode   source1   source2   dest      shift     Function...
ibustm[13]={Rformat, 5'b01010, 5'b01010, 5'b00111, 5'b00000, OR};
abusin[13]=32'h000034FB;
bbusin[13]=32'h000034FB;
dbusout[13]=32'h000034FB;

// --------- 
// 15. Begin TEST # 12 XORI R12, R21, #00F0
// ---------

//         opcode source1   dest      Immediate... 
ibustm[14]={XORI, 5'b10101, 5'b01100, 16'h00F0};
abusin[14]=32'hFFFFF98B;
bbusin[14]=32'h000000F0;
dbusout[14]=32'hFFFFF97B;

// --------- 
// 16. Begin TEST # 13 SUBI R28, R31, #0111 
// ---------

//         opcode source1   dest      Immediate... 
ibustm[15]={SUBI, 5'b11111, 5'b11100, 16'h0111};
abusin[15]=32'hFFFFF95B;
bbusin[15]=32'h00000111;
dbusout[15]=32'hFFFFF84A;



// --------- 
// 17. Begin TEST # 14 ADD R17, R3, R21
// ---------

//          opcode   source1   source2   dest      shift     Function...
ibustm[16]={Rformat, 5'b00011, 5'b10101, 5'b10001, 5'b00000, ADD};
abusin[16]=32'h00007334;
bbusin[16]=32'hFFFFF98B;
dbusout[16]=32'h00006CBF;

// ---------- 
// 18. Begin TEST # 15 ORI R15, R1, #328F
// ----------

//         opcode source1   dest      Immediate... 
ibustm[17]={ORI, 5'b00001, 5'b01111, 16'h328F};
abusin[17]=32'h00000000;
bbusin[17]=32'h0000328F;
dbusout[17]=32'h0000328F;


// --------- 
// 19. Begin TEST # 16 ADDI R13, R13, #FFFF
// ---------

//         opcode source1   dest      Immediate... 
ibustm[18]={ADDI, 5'b01101, 5'b01101, 16'hFFFF};
abusin[18]=32'h00000000;
bbusin[18]=32'hFFFFFFFF;
dbusout[18]=32'hFFFFFFFF;

// --------- 
// 20. Begin TEST # 17 ADDI R23, R1, #AFC0
// ---------

//         opcode source1   dest      Immediate... 
ibustm[19]={ADDI, 5'b00001, 5'b10111, 16'hAFC0};
abusin[19]=32'h00000000;
bbusin[19]=32'hFFFFAFC0;
dbusout[19]=32'hFFFFAFC0;

// --------- 
// 21. Begin TEST # 18 SUB R20, R1, R1
// ---------

//          opcode   source1   source2   dest      shift     Function...
ibustm[20]={Rformat, 5'b00001, 5'b00001, 5'b10100, 5'b00000, SUB};
abusin[20]=32'h00000000;
bbusin[20]=32'h00000000;
dbusout[20]=32'h00000000;


// ---------- 
// 22. Begin TEST # 19 ORI R19, R1, #7334
// ----------

//         opcode source1   dest      Immediate... 
ibustm[21]={ORI, 5'b00001, 5'b10011, 16'h7334};
abusin[21]=32'h00000000;
bbusin[21]=32'h00007334;
dbusout[21]=32'h00007334;


// -------- 
// 23. Begin TEST # 20 ORI R9, R13, #F98B
// --------

//         opcode source1   dest      Immediate... 
ibustm[22]={ORI, 5'b01101, 5'b01001, 16'hF98B};
abusin[22]=32'hFFFFFFFF;
bbusin[22]=32'hFFFFF98B;
dbusout[22]=32'hFFFFFFFF;

// -------- 
// 24. Begin TEST # 21 XOR R2, R13, R19
// --------

//          opcode   source1   source2   dest      shift     Function...
ibustm[23]={Rformat, 5'b01101, 5'b10011, 5'b00010, 5'b00000, XOR};
abusin[23]=32'hFFFFFFFF;
bbusin[23]=32'h00007334;
dbusout[23]=32'hFFFF8CCB;


// -------- 
// 25. Begin TEST # 22 SUBI R26, R9, #0030
// --------

//         opcode source1   dest      Immediate... 
ibustm[24]={SUBI, 5'b01001, 5'b11010, 16'h0030};
abusin[24]=32'hFFFFFFFF;
bbusin[24]=32'h00000030;
dbusout[24]=32'hFFFFFFCF;


// -------- 
// 26. Begin TEST # 23 ORI R25, R1, #8ABF
// --------

//         opcode source1   dest      Immediate... 
ibustm[25]={ORI, 5'b00001, 5'b11001, 16'h8ABF};
abusin[25]=32'h00000000;
bbusin[25]=32'hFFFF8ABF;
dbusout[25]=32'hFFFF8ABF;


// -------- 
// 27. Begin TEST # 24 ORI R8, R13, #34FB
// --------

//         opcode source1   dest      Immediate... 
ibustm[26]={ORI, 5'b01101, 5'b01000, 16'h34FB};
abusin[26]=32'hFFFFFFFF;
bbusin[26]=32'h000034FB;
dbusout[26]=32'hFFFFFFFF;

// -------- 
// 28. Begin TEST # 25 XORI R27, R13, #0B31
// --------

//         opcode source1   dest      Immediate... 
ibustm[27]={XORI, 5'b01101, 5'b11011, 16'h0B31};
abusin[27]=32'hFFFFFFFF;
bbusin[27]=32'h00000B31;
dbusout[27]=32'hFFFFF4CE;


// -------- 
// 29. Begin TEST # 26 ADD R14, R2, R19
// --------

//          opcode   source1   source2   dest      shift     Function...
ibustm[28]={Rformat, 5'b00010, 5'b10011, 5'b01110, 5'b00000, ADD};
abusin[28]=32'hFFFF8CCB;
bbusin[28]=32'h00007334;
dbusout[28]=32'hFFFFFFFF;

// -------- 
// 30. Begin TEST # 27 OR R4, R8, R8 
// --------

//          opcode   source1   source2   dest      shift     Function...
ibustm[29]={Rformat, 5'b01000, 5'b01000, 5'b00100, 5'b00000, OR};
abusin[29]=32'hFFFFFFFF;
bbusin[29]=32'hFFFFFFFF;
dbusout[29]=32'hFFFFFFFF;


// -------- 
// 31. Begin TEST # 28 XORI R12, R21, #5555 
// --------

//         opcode source1   dest      Immediate... 
ibustm[30]={XORI, 5'b10101, 5'b01100, 16'h5555};
abusin[30]=32'hFFFFF98B;
bbusin[30]=32'h00005555;
dbusout[30]=32'hFFFFACDE;

// 31*2
ntests = 62;

$timeformat(-9,1,"ns",12); 

end


initial begin
  error = 0;
  clk=0;
  for (k=0; k<= 30; k=k+1) begin
    
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