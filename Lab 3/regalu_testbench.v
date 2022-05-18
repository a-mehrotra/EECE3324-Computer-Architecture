//Property of Prof. J. Marpaung and Northeastern University
//Not to be distributed elsewhere without a written consent from Prof. J. Marpaung
//All Rights Reserved


`timescale 1ns/10ps
module regalu_testbench();

//------ Ports Declaration-----//
reg [31:0] Aselect, Bselect, Dselect;
reg [2:0] S, stm_S[0:29];
reg Cin, clk, stm_CL[0:29], stm_Cin[0:29];
wire [31:0] abus;
wire [31:0] bbus;
wire [31:0] dbus;
reg [31:0] dontcare, ref_abus[0:29], ref_bbus[0:29], ref_dbus[0:29], asel[0:29], bsel[0:29], dsel[0:29]; 
integer error, i, k, ntests;


regalu dut(.Aselect(Aselect), .Bselect(Bselect), .Dselect(Dselect), .clk(clk), .abus(abus), .bbus(bbus), .dbus(dbus), .S(S), .Cin(Cin));


initial begin


// ---------- NO TEST 1a ---------- //
stm_CL[0]=0;
stm_Cin[0]=0;
stm_S[0] =3'b001;
asel[0]= 32'h00000001;
bsel[0]=32'h00000001;
dsel[0]=32'h00000001;
ref_abus[0]=32'h00000000;
ref_bbus[0]=32'h00000000; // Reading R0 for 00000000 in abus and bbus for input to alu.(XNOR R0,R0 )
ref_dbus[0]=32'hxxxxxxxx;

stm_CL[1]=1;
stm_Cin[1]=0;
stm_S[1]=3'b001;
asel[1]= 32'h00000001;
bsel[1]=32'h00000001;
dsel[1]=32'h00000001;
ref_abus[1]=32'hxxxxxxxx;
ref_bbus[1]=32'hxxxxxxxx;
ref_dbus[1]=32'hxxxxxxxx; //Doing nothing with the register

// ----------  XNOR TEST 1b ----------//
stm_CL[2]=0;
stm_Cin[2]=0;
stm_S[2]=3'b001;
asel[2]= 32'h00000001;
bsel[2]=32'h00000001;
dsel[2]=32'h00000001;
ref_abus[2]=32'h00000000;
ref_bbus[2]=32'h00000000; // Reading R0 in abus and bbus for input to alu.(XNOR R0,R0)
ref_dbus[2]=32'hxxxxxxxx;

stm_CL[3]=1;
stm_Cin[3]=0;
stm_S[3]=3'b110;
asel[3]= 32'h00000001;
bsel[3]= 32'h00000001;
dsel[3]=32'h00000002;
ref_abus[3]=32'hxxxxxxxx;
ref_bbus[3]=32'hxxxxxxxx;
ref_dbus[3]=32'hFFFFFFFF; // Writing R1 with FFFFFFFF (Result of XNOR R0,R0) From alu.


// ----------  XNOR TEST 2 ---------- //

stm_CL[4]=0;
stm_Cin[4]=0;
stm_S[4]=3'b001;
asel[4]=32'h00000001;
bsel[4]=32'h00000002;
dsel[4]=32'h00000001;
ref_abus[4]=32'h00000000;
ref_bbus[4]=32'hFFFFFFFF; //Reading R0 and R1 for input to alu (OR R0,R1)
ref_dbus[4]=32'hxxxxxxxx;

stm_CL[5]=1;
stm_Cin[5]=0;
stm_S[5]=3'b100;
asel[5]=32'h00000001;
bsel[5]=32'h00000001;
dsel[5]=32'h00000004;
ref_abus[5]=32'hxxxxxxxx;
ref_bbus[5]=32'hxxxxxxxx;
ref_dbus[5]=32'hFFFFFFFF; // Writing R2 with FFFFFFFF (Result of XNOR R0,R1) From alu. 


// ---------- OR TEST 3 ---------- //
stm_CL[6]=0;
stm_Cin[6]=0;
stm_S[6]=3'b100;
asel[6]=32'h00000004;
bsel[6]=32'h00000002;
dsel[6]=32'h00000001;
ref_abus[6]=32'hFFFFFFFF; 
ref_bbus[6]=32'hFFFFFFFF; //Reading R1 and R2 for input to alu (XOR R1,R2) 
ref_dbus[6]=32'hxxxxxxxx;

stm_CL[7]=1;
stm_Cin[7]=0;
stm_S[7]=3'b000;
asel[7]=32'h00000001;
bsel[7]=32'h00000001;
dsel[7]=32'h00000008; 
ref_abus[7]=32'hxxxxxxxx;
ref_bbus[7]=32'hxxxxxxxx;
ref_dbus[7]=32'hFFFFFFFF; // Writing R3 with FFFFFFFF ( Result of OR R0,R1) from alu.


// ---------- XOR TEST 4 ---------- //
stm_CL[8]=0;
stm_Cin[8]=0;
stm_S[8]=3'b000;
asel[8]=32'h00000008;
bsel[8]=32'h00000004;
dsel[8]=32'h00000000;
ref_abus[8]=32'hFFFFFFFF; 
ref_bbus[8]=32'hFFFFFFFF; //Reading R3 and R2 for input to alu (XNOR R3,R2)
ref_dbus[8]=32'hxxxxxxxx;

stm_CL[9]=1;
stm_Cin[9]=0;
stm_S[9]=3'b001;
asel[9]=32'h00000001;
bsel[9]=32'h00000001;
dsel[9]=32'h00000010;
ref_abus[9]=32'hxxxxxxxx;
ref_bbus[9]=32'hxxxxxxxx;
ref_dbus[9]=32'h00000000; // Writing R4 With 00000000 (Result of XOR R1,R2) from alu



// ------------ XNOR NOT TEST ------------ //
stm_CL[10]=0;
stm_Cin[10]=0;
stm_S[10]=3'b001;
asel[10]=32'h00000008; 
bsel[10]=32'h00000010; 
dsel[10]=32'h00000000; 
ref_abus[10]=32'hFFFFFFFF; 
ref_bbus[10]=32'h00000000; // Reading R3 and R4 for input to alu (NOR R3,R4)
ref_dbus[10]=32'hxxxxxxxx;

stm_CL[11]=1;
stm_Cin[11]=0;
stm_S[11]=3'b101;
asel[11]=32'h00000001;
bsel[11]=32'h00000001;
dsel[11]=32'h00000020;
ref_abus[11]=32'hxxxxxxxx;
ref_bbus[11]=32'hxxxxxxxx;
ref_dbus[11]=32'hFFFFFFFF; // Writing R5 with FFFFFFFF (Result of XNOR R3,R2) from alu

// ------------ NOR TEST  ---------------- //

stm_CL[12]=0;
stm_Cin[12]=0;
stm_S[12]=3'b101;
asel[12]=32'h00000010;
bsel[12]=32'h00000020;
dsel[12]=32'h00000000;
ref_abus[12]=32'h00000000; 
ref_bbus[12]=32'hFFFFFFFF; //Reading R4,R5 for input to alu (ADD R4,R5)
ref_dbus[12]=32'hxxxxxxxx;

stm_CL[13]=1;
stm_Cin[13]=0;
stm_S[13]=3'b010;
asel[13]=32'h00000001;
bsel[13]=32'h00000001;
dsel[13]=32'h00000040;
ref_abus[13]=32'hxxxxxxxx;
ref_bbus[13]=32'hxxxxxxxx;
ref_dbus[13]=32'h00000000; // Writing R6 with 00000000 (Result of NOR R3,R4) From alu.

// ------------- ADD TEST --------------//
stm_CL[14]=0;
stm_Cin[14]=0;
stm_S[14]=3'b010;
asel[14]=32'h00000020;
bsel[14]=32'h00000040;
dsel[14]=32'h00000000;
ref_abus[14]=32'hFFFFFFFF;
ref_bbus[14]=32'h00000000; // Reading R5, R6 for input to alu (XOR R5,R6)
ref_dbus[14]=32'hxxxxxxxx;

stm_CL[15]=1;
stm_Cin[15]=0;
stm_S[15]=3'b000;
asel[15]=32'h00000001;
bsel[15]=32'h00000001;
dsel[15]=32'h00000080;
ref_abus[15]=32'hxxxxxxxx;
ref_bbus[15]=32'hxxxxxxxx;
ref_dbus[15]=32'hFFFFFFFF; // Writing R7 with FFFFFFFF (Result of ADD R4,R5)

// ------------ XOR TEST ---------------//

stm_CL[16]=0;
stm_Cin[16]=0;
stm_S[16]=3'b000;
asel[16]=32'h00000040;
bsel[16]=32'h00000080;
dsel[16]=32'h00000000;
ref_abus[16]=32'h00000000;  
ref_bbus[16]=32'hFFFFFFFF; // Reading R6,R7 for input to alu (XNOR R6,R7)
ref_dbus[16]=32'hxxxxxxxx;

stm_CL[17]=1;
stm_Cin[17]=0;
stm_S[17]=3'b001;
asel[17]=32'h00000001;
bsel[17]=32'h00000001;
dsel[17]=32'h00000100;
ref_abus[17]=32'hxxxxxxxx;
ref_bbus[17]=32'hxxxxxxxx;
ref_dbus[17]=32'hFFFFFFFF; // Writing R8 with FFFFFFFF (Result of XOR R5,R6)


// ------------ XNOR TEST -------------//

stm_CL[18]=0;
stm_Cin[18]=0;
stm_S[18]=3'b001;
asel[18]=32'h00000080;
bsel[18]=32'h00000100;
dsel[18]=32'h00000100;
ref_abus[18]=32'hFFFFFFFF; 
ref_bbus[18]=32'hFFFFFFFF; // Reading R7,R8 for input to alu (OR R7,R8)
ref_dbus[18]=32'hxxxxxxxx;

stm_CL[19]=1;
stm_Cin[19]=0;
stm_S[19]=3'b100;
asel[19]=32'h00000001;
bsel[19]=32'h00000001;
dsel[19]=32'h00000200;
ref_abus[19]=32'hxxxxxxxx;
ref_bbus[19]=32'hxxxxxxxx;
ref_dbus[19]=32'h00000000; // Writing R9 with 00000000 (Result of XNOR R6,R7)

// ------------- OR TEST ------------//

stm_CL[20]=0;
stm_Cin[20]=0;
stm_S[20]=3'b100;
asel[20]=32'h00000100;
bsel[20]=32'h00000200;
dsel[20]=32'h00000000;
ref_abus[20]=32'hFFFFFFFF; 
ref_bbus[20]=32'h00000000; // Reading R8,R9 for input to alu (NOR R8,R9)
ref_dbus[20]=32'hxxxxxxxx;

stm_CL[21]=1;
stm_Cin[21]=0;
stm_S[21]=3'b101;
asel[21]=32'h00000001;
bsel[21]=32'h00000001;
dsel[21]=32'h00000400;
ref_abus[21]=32'hxxxxxxxx;
ref_bbus[21]=32'hxxxxxxxx;
ref_dbus[21]=32'hFFFFFFFF; //Writing R10 with FFFFFFFF (Result of OR R7,R8)

// ------------ NOR TEST -------------//

stm_CL[22]=0;
stm_Cin[22]=0;
stm_S[22]=3'b101;
asel[22]=32'h00000200;
bsel[22]=32'h00000400;
dsel[22]=32'h00000000;
ref_abus[22]=32'h00000000;
ref_bbus[22]=32'hFFFFFFFF; //Reading R9,R10 for input to alu (AND R9,R10)
ref_dbus[22]=32'hxxxxxxxx;

stm_CL[23]=1;
stm_Cin[23]=0;
stm_S[23]=3'b110;
asel[23]=32'h0000001;
bsel[23]=32'h0000001;
dsel[23]=32'h0000800;
ref_abus[23]=32'hxxxxxxxx;
ref_bbus[23]=32'hxxxxxxxx;
ref_dbus[23]=32'h00000000; // Writing R11 with 00000000 (Result of NOR R8,R9)

// ------------ AND TEST ---------------//

stm_CL[24]=0;
stm_Cin[24]=0;
stm_S[24]=3'b110;
asel[24]=32'h00000400;
bsel[24]=32'h00000800;
dsel[24]=32'h00000000;
ref_abus[24]=32'hFFFFFFFF;
ref_bbus[24]=32'h00000000; // Reading R10,R11 for input to alu (XOR R10,R11)
ref_dbus[24]=32'hxxxxxxxx;

stm_CL[25]=1;
stm_Cin[25]=0;
stm_S[25]=3'b000;
asel[25]=32'h00000001;
bsel[25]=32'h00000001;
dsel[25]=32'h00001000;
ref_abus[25]=32'hxxxxxxxx;
ref_bbus[25]=32'hxxxxxxxx;
ref_dbus[25]=32'h00000000; //Writing R12 with 00000000 (Result of AND R9,R10)


// ------------ XOR TEST --------------//

stm_CL[26]=0;
stm_Cin[26]=0;
stm_S[26]=3'b000;
asel[26]=32'h00000800;
bsel[26]=32'h00001000;
dsel[26]=32'h00000000;
ref_abus[26]=32'h00000000;
ref_bbus[26]=32'h00000000; //Reading R11,R12  for input to alu (XNOR R11,R12)
ref_dbus[26]=32'hxxxxxxxx;

stm_CL[27]=1;
stm_Cin[27]=0;
stm_S[27]=3'b001;
asel[27]=32'h00000001;
bsel[27]=32'h00000001;
dsel[27]=32'h00002000;
ref_abus[27]=32'hxxxxxxxx;
ref_bbus[27]=32'hxxxxxxxx;
ref_dbus[27]=32'hFFFFFFFF; // Writing R13 with FFFFFFFF (Result of XOR R10,R11)


// ------------ XNOR TEST ---------------//
stm_CL[28]=0;
stm_Cin[28]=0;
stm_S[28]=3'b001;
asel[28]=32'h00001000;
bsel[28]=32'h00002000;
dsel[28]=32'h00000000;
ref_abus[28]=32'h00000000;
ref_bbus[28]=32'hFFFFFFFF; // Reading R12,R13 for input to alu (OR R12,R13)
ref_dbus[28]=32'hxxxxxxxx;

stm_CL[29]=1;
stm_Cin[29]=1;
stm_S[29]=3'b110;
asel[29]=32'h00000001;
bsel[29]=32'h00000001;
dsel[29]=32'h00004000;
ref_abus[29]=32'hxxxxxxxx;
ref_bbus[29]=32'hxxxxxxxx;
ref_dbus[29]=32'hFFFFFFFF; //Writing R14 with FFFFFFFF (Result of XNOR R11,R12)

dontcare = 32'hxxxxxxxx;
ntests = 30;

$timeformat(-9,1,"ns",12); 

end


initial begin
    error = 0;
    
    for (k=0; k<= 29; k=k+1)
    begin
    
    Aselect=asel[k]; Bselect=bsel[k]; Dselect=dsel[k]; clk=stm_CL[k]; S=stm_S[k]; Cin=stm_Cin[k];
    #25

  if ( k >= 3) begin
     if ( stm_S[k-2] == 3'b000 && (k== 3 || k== 5 || k== 7 || k== 9 || k== 11 || k== 13 || k== 15 || k== 17 || k== 19 || k== 21 || k== 23 || k== 25 || k== 27 || k== 29))
       $display ("-----  TEST FOR A XOR B  -----");
     if ( stm_S[k-2] == 3'b001  && (k== 3 || k== 5 || k== 7 || k== 9 || k== 11 || k== 13 || k== 15 || k== 17 || k== 19 || k== 21 || k== 23 || k== 25 || k== 27 || k== 29))
       $display ("-----  TEST FOR A XNOR B  -----");
     if ( stm_S[k-2] == 3'b010  && (k== 3 || k== 5 || k== 7 || k== 9 || k== 11 || k== 13 || k== 15 || k== 17 || k== 19 || k== 21 || k== 23 || k== 25 || k== 27 || k== 29))
       $display ("-----  TEST FOR A + B // CARRY CHAIN  -----");
     if ( stm_S[k-2] == 3'b100  && (k== 3 || k== 5 || k== 7 || k== 9 || k== 11 || k== 13 || k== 15 || k== 17 || k== 19 || k== 21 || k== 23 || k== 25 || k== 27 || k== 29))
       $display ("-----  TEST FOR A OR B  -----");
     if ( stm_S[k-2] == 3'b011  && (k== 3 || k== 5 || k== 7 || k== 9 || k== 11 || k== 13 || k== 15 || k== 17 || k== 19 || k== 21 || k== 23 || k== 25 || k== 27 || k== 29))
       $display ("-----  TEST FOR A - B  -----");
     if ( stm_S[k-2] == 3'b101  && (k== 3 || k== 5 || k== 7 || k== 9 || k== 11 || k== 13 || k== 15 || k== 17 || k== 19 || k== 21 || k== 23 || k== 25 || k== 27 || k== 29))
       $display ("-----  TEST FOR A NOR  B  -----");
     if ( stm_S[k-2] == 3'b110  && (k== 3 || k== 5 || k== 7 || k== 9 || k== 11 || k== 13 || k== 15 || k== 17 || k== 19 || k== 21 || k== 23 || k== 25 || k== 27 || k== 29))
       $display ("-----  TEST FOR A AND  B  -----");
   
   end
  
  $display ("Test=%d \n Time=%t \n Clk=%b \n S=%b \n Cin=%b \n Aselect=%b \n  Bselect=%b \n Dselect=%b \n abus=%b \n ref_abus=%b \n bbus=%b \n ref_bbus=%b \n dbus=%b \n ref_dbus=%b \n ", k, $realtime, clk, S, Cin, Aselect, Bselect, Dselect, abus, ref_abus[k], bbus, ref_bbus[k], dbus, ref_dbus[k]);
 
 
  if  ( ( (ref_bbus[k] !== bbus) && (ref_bbus[k] !== dontcare) ) || ( (ref_abus[k] !== abus) && (ref_abus[k] !== dontcare)) || ( (ref_dbus[k] !== dbus) && (ref_dbus[k] !== dontcare)) )
  begin
   $display ("-------------ERROR. A Mismatch Has Occured-----------");
   error = error + 1;
  end
  
 end
  
   if ( error !== 0)
   begin 
   $display("--------- SIMULATION UNSUCCESFUL - MISMATCHES HAVE OCCURED ----------");
   $display(" No. Of Errors = %d", error);
   end
if ( error == 0) 
   $display("---------YOU DID IT!! SIMULATION SUCCESFULLY FINISHED----------");

end
        
endmodule
         
