//Property of Prof. J. Marpaung and Northeastern University (with edits from Sam Bolduc and Aryan Mehrotra)
//Not to be distributed elsewhere without a written consent from Prof. J. Marpaung
//All Rights Reserved


`timescale 1ns/10ps     // THIS DEFINES A UNIT TIME FOR THE TEST BENCH AND ITS PRECISION //
module alu32_testbench_custom();

reg [31:0] a, b;       // DECLARING I/O PORTS AND ALSO INTERNAL WIRES //
wire [31:0] d;
reg [2:0] S, Stm[0:31];
reg Cin;
reg [31:0] dontcare, str[0:31], ref[0:31], stma[0:31], stmb[0:31];
reg Vstr[0:31], Vref[0:31], Coutstm[0:31], Coutstr[0:31], Coutref[0:31], Cinstm[0:31];

integer ntests, error, k, i;  // VARIABLES NOT RELATED TO ALU I/O , BUT REQUIRED FOR TESTBENCH //

alu32 dut(.a(a), .b(b), .d(d), .Cin(Cin), .Cout(Cout), .V(V), .S(S));  // DECLARES THE MODULE BEING TESTED ALONG WITH ITS I/O PORTS //

   
   //////////////////////////////////////////  			 //////////////////////////////////////////
  ///////// EXPECTED VALUES ////////////////			//////////    INPUTS TO ALU      /////////
 //////////////////////////////////////////		       //////////////////////////////////////////
 

initial begin     //LOADING THE TEST REGISTERS WITH INPUTS AND EXPECTED VALUES//

ref[0] = 32'h00000000; Vref[0] = 1'bx; Coutref[0] = 1'bx;		Stm[0] = 3'b000; stma[0] = 32'h00000000; stmb[0] = 32'h00000000; Cinstm[0] = 1; // test xor
ref[1] = 32'h00000000; Vref[1] = 1'bx; Coutref[1] = 1'bx;		Stm[1] = 3'b000; stma[1] = 32'hFFFFFFFF; stmb[1] = 32'hFFFFFFFF; Cinstm[1] = 0;
ref[2] = 32'hFFFFFFFF; Vref[2] = 1'bx; Coutref[2] = 1'bx;		Stm[2] = 3'b000; stma[2] = 32'h0F0F0F0F; stmb[2] = 32'hF0F0F0F0; Cinstm[2] = 1;
ref[3] = 32'hFFFFFFFF; Vref[3] = 1'bx; Coutref[3] = 1'bx;		Stm[3] = 3'b000; stma[3] = 32'hFFFFFFFF; stmb[3] = 32'h00000000; Cinstm[3] = 0;
ref[4] = 32'hFFFFFFFF; Vref[4] = 1'bx; Coutref[4] = 1'bx;		Stm[4] = 3'b000; stma[4] = 32'hFFFF0000; stmb[4] = 32'h0000FFFF; Cinstm[4] = 1;

ref[5] = 32'hFFFFFFFF; Vref[5] = 1'bx; Coutref[5] = 1'bx;		Stm[5] = 3'b001; stma[5] = 32'h00000000; stmb[5] = 32'h00000000; Cinstm[5] = 0; // test xnor
ref[6] = 32'hFFFFFFFF; Vref[6] = 1'bx; Coutref[6] = 1'bx;		Stm[6] = 3'b001; stma[6] = 32'hFFFFFFFF; stmb[6] = 32'hFFFFFFFF; Cinstm[6] = 1;
ref[7] = 32'h00000000; Vref[7] = 1'bx; Coutref[7] = 1'bx;		Stm[7] = 3'b001; stma[7] = 32'h0F0F0F0F; stmb[7] = 32'hF0F0F0F0; Cinstm[7] = 0;
ref[8] = 32'h00000000; Vref[8] = 1'bx; Coutref[8] = 1'bx;		Stm[8] = 3'b001; stma[8] = 32'hFFFFFFFF; stmb[8] = 32'h00000000; Cinstm[8] = 1;
ref[9] = 32'h00000000; Vref[9] = 1'bx; Coutref[9] = 1'bx;		Stm[9] = 3'b001; stma[9] = 32'hFFFF0000; stmb[9] = 32'h0000FFFF; Cinstm[9] = 0;

ref[10] = 32'h00000001; Vref[10] = 0; Coutref[10] = 0;		Stm[10] = 3'b010; stma[10] = 32'h00000000; stmb[10] = 32'h00000000; Cinstm[10] = 1; // test add
ref[11] = 32'h00000065; Vref[11] = 0; Coutref[11] = 0;		Stm[11] = 3'b010; stma[11] = 32'h00000020; stmb[11] = 32'h00000045; Cinstm[11] = 0;
ref[12] = 32'h8000001F; Vref[12] = 1; Coutref[12] = 0;		Stm[12] = 3'b010; stma[12] = 32'h7FFFFFFF; stmb[12] = 32'h00000020; Cinstm[12] = 0;
ref[13] = 32'h80000020; Vref[13] = 1; Coutref[13] = 0;		Stm[13] = 3'b010; stma[13] = 32'h7FFFFFFF; stmb[13] = 32'h00000020; Cinstm[13] = 1;
ref[14] = 32'h86A99370; Vref[14] = 1; Coutref[14] = 0;		Stm[14] = 3'b010; stma[14] = 32'h10208108; stmb[14] = 32'h76891268; Cinstm[14] = 0;

ref[15] = 32'h00000000; Vref[15] = 0; Coutref[15] = 1;		Stm[15] = 3'b011; stma[15] = 32'h00000000; stmb[15] = 32'h00000000; Cinstm[15] = 1; // test sub
ref[16] = 32'h7FFFFFDF; Vref[16] = 0; Coutref[16] = 1;		Stm[16] = 3'b011; stma[16] = 32'h7FFFFFFF; stmb[16] = 32'h00000020; Cinstm[16] = 1;
ref[17] = 32'h00000000; Vref[17] = 0; Coutref[17] = 1;		Stm[17] = 3'b011; stma[17] = 32'h7FFFFFFF; stmb[17] = 32'h7FFFFFFF; Cinstm[17] = 1;
ref[18] = 32'h66689160; Vref[18] = 0; Coutref[18] = 1;		Stm[18] = 3'b011; stma[18] = 32'h76891268; stmb[18] = 32'h10208108; Cinstm[18] = 1;
ref[19] = 32'h7FFF0000; Vref[19] = 0; Coutref[19] = 1;		Stm[19] = 3'b011; stma[19] = 32'h7FFFFFFF; stmb[19] = 32'h0000FFFF; Cinstm[19] = 1;

ref[20] = 32'h00000000; Vref[20] = 1'bx; Coutref[20] = 1'bx;	Stm[20] = 3'b100; stma[20] = 32'h00000000; stmb[20] = 32'h00000000; Cinstm[20] = 1; // test or
ref[21] = 32'hFFFFFFFF; Vref[21] = 1'bx; Coutref[21] = 1'bx;	Stm[21] = 3'b100; stma[21] = 32'h00000000; stmb[21] = 32'hFFFFFFFF; Cinstm[21] = 0;
ref[22] = 32'hFFFFFFFF; Vref[22] = 1'bx; Coutref[22] = 1'bx;	Stm[22] = 3'b100; stma[22] = 32'hFFFF0000; stmb[22] = 32'h0000FFFF; Cinstm[22] = 1;
ref[23] = 32'hFFFFFF00; Vref[23] = 1'bx; Coutref[23] = 1'bx;	Stm[23] = 3'b100; stma[23] = 32'hFFFF0000; stmb[23] = 32'hFF00FF00; Cinstm[23] = 0;
ref[24] = 32'h76A99368; Vref[24] = 1'bx; Coutref[24] = 1'bx;	Stm[24] = 3'b100; stma[24] = 32'h10208108; stmb[24] = 32'h76891268; Cinstm[24] = 1;

ref[25] = 32'hFFFFFFFF; Vref[25] = 1'bx; Coutref[25] = 1'bx;	Stm[25] = 3'b101; stma[25] = 32'h00000000; stmb[25] = 32'h00000000; Cinstm[25] = 0; // test nor
ref[26] = 32'h00000000; Vref[26] = 1'bx; Coutref[26] = 1'bx;	Stm[26] = 3'b101; stma[26] = 32'h00000000; stmb[26] = 32'hFFFFFFFF; Cinstm[26] = 0;
ref[27] = 32'h00000000; Vref[27] = 1'bx; Coutref[27] = 1'bx;	Stm[27] = 3'b101; stma[27] = 32'hFFFF0000; stmb[27] = 32'h0000FFFF; Cinstm[27] = 0;
ref[28] = 32'h000000FF; Vref[28] = 1'bx; Coutref[28] = 1'bx;	Stm[28] = 3'b101; stma[28] = 32'hFFFF0000; stmb[28] = 32'hFF00FF00; Cinstm[28] = 0;
ref[29] = 32'h89566C97; Vref[29] = 1'bx; Coutref[29] = 1'bx;	Stm[29] = 3'b101; stma[29] = 32'h10208108; stmb[29] = 32'h76891268; Cinstm[29] = 0;

ref[30] = 32'h00000000; Vref[30] = 1'bx; Coutref[30] = 1'bx;		Stm[30] = 3'b110; stma[30] = 32'h00000000; stmb[30] = 32'h00000000; Cinstm[30] = 0; // test and
ref[31] = 32'hFFFFFFFF; Vref[31] = 1'bx; Coutref[31] = 1'bx;		Stm[31] = 3'b110; stma[31] = 32'hFFFFFFFF; stmb[31] = 32'hFFFFFFFF; Cinstm[31] = 0;
ref[32] = 32'h00000000; Vref[32] = 1'bx; Coutref[32] = 1'bx;		Stm[32] = 3'b110; stma[32] = 32'hFFFF0000; stmb[32] = 32'h0000FFFF; Cinstm[32] = 0;
ref[33] = 32'h00000000; Vref[33] = 1'bx; Coutref[33] = 1'bx;		Stm[33] = 3'b110; stma[33] = 32'hFFFFFFFF; stmb[33] = 32'h00000000; Cinstm[33] = 0;
ref[34] = 32'hFF000000; Vref[34] = 1'bx; Coutref[34] = 1'bx;		Stm[34] = 3'b110; stma[34] = 32'hFFFF0000; stmb[34] = 32'hFF00FF00; Cinstm[34] = 0;


dontcare = 32'hx;
ntests = 35;
 
$timeformat(-9,1,"ns",12);
 
end

initial begin
 error = 0;
    
 for (k=0; k<= ntests; k=k+1)   		     // LOOPING THROUGH ALL THE TEST VECTORS AND ASSIGNING IT TO THE ALU INPUTS EVERY 8ns //
    begin
    S = Stm[k]; a = stma[k] ; b = stmb[k]; Cin = Cinstm[k];
    
    #20 str[k] = d; Vstr[k] = V; Coutstr[k] = Cout;   // #20 IS 8 ns DELAY FOR ASSIGNING THE OUTPUT TO THE REFERENCE REGISTERS // 

      
    if ( S == 3'b000 )
    $display ("-----  TEST FOR A XOR B  -----");
    
    if ( S == 3'b001 )
    $display ("-----  TEST FOR A XNOR B  -----");
  
    if ( S == 3'b010 )
    $display ("-----  TEST FOR A + B/ CARRY CHAIN  -----");
    
    if ( S == 3'b011 )
    $display ("-----  TEST FOR A - B  -----");
  
    if ( S == 3'b100 )
    $display ("-----  TEST FOR A OR B  -----");
  
    if ( S == 3'b101 )
    $display ("-----  TEST FOR A NOR B  -----");

    if ( S == 3'b110 )
    $display ("-----  TEST FOR A AND B  -----");


    $display ("Time=%t \n S=%b \n Cin=%b \n a=%b \n b=%b \n d=%b \n ref=%b \n Cout=%b \n CoutRef=%b \n V=%b \n Vref=%b \n",$realtime, S, Cin, a, b, d, ref[k], Cout, Coutref[k], V, Vref[k]);
    
    
    // THIS CONTROL BLOCK CHECKS FOR ERRORS  BY COMPARING YOUR OUTPUT WITH THE EXPECTED OUTPUTS AND INCREMENTS "error" IN CASE OF ERROR //
    
    if (( (ref[k] !== str[k]) && (ref[k] !== dontcare)  ) || ( (Vref[k] !== Vstr[k]) && (Vref[k] !== 1'bx)  ) || ( (Coutref[k] !==  Coutstr[k]) && (Coutref[k] !== 1'bx) ) )
      begin
      $display ("-------------ERROR. A Mismatch Has Occured-----------");
      error = error + 1;
    end

 end

    if ( error == 0)
        $display("---------YOU DID IT!! SIMULATION SUCCESFULLY FINISHED----------");
    
    if ( error != 0)
        $display("---------------ERRORS. Mismatches Have Occured, sorry------------------");

    $display(" Number Of Errors = %d", error);
    $display(" Total Test numbers = %d", ntests);
    $display(" Total number of correct operations = %d", (ntests-error));

end
         
        
endmodule
         


