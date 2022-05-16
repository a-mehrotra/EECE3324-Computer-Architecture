//Property of Prof. J. Marpaung and Northeastern University
//Not to be distributed elsewhere without a written consent from Prof. J. Marpaung
//All Rights Reserved


`timescale 1ns/10ps     // THIS DEFINES A UNIT TIME FOR THE TEST BENCH AND ITS PRECISION //
module alupipe_testbench();

reg [31:0] a, b;       // DECLARING I/O PORTS AND ALSO INTERNAL WIRES //
wire [31:0] d;
reg [2:0] S, Stm[0:33];
reg Cin, clk;
reg [31:0] dontcare, str[0:33], ref[0:33], stma[0:33], stmb[0:33];
reg Vstr[0:33], Vref[0:33], Coutstr[0:33], Coutref[0:33], Cinstm[0:33];

integer ntests, error, k, i;  // VARIABLES NOT RELATED TO ALU I/O , BUT REQUIRED FOR TESTBENCH //

ALUPipe dut(.abus(a), .bbus(b), .dbus(d), .Cin(Cin), .S(S), .clk(clk));  // DECLARES THE MODULE BEING TESTED ALONG WITH ITS I/O PORTS //

   
   //////////////////////////////////////////  			 //////////////////////////////////////////
  ///////// EXPECTED VALUES ////////////////			//////////    INPUTS TO ALU      /////////
 //////////////////////////////////////////		       //////////////////////////////////////////
 

initial begin     //LOADING THE TEST REGISTERS WITH INPUTS AND EXPECTED VALUES//

ref[0] = 32'h00000000; Vref[0] = 0; Coutref[0] = 0;		Stm[0] = 3'b100; stma[0] = 32'h00000000; stmb[0] = 32'h00000000; Cinstm[0] = 0;      // Test or     //
ref[1] = 32'h00000000; Vref[1] = 0; Coutref[1] = 0;		Stm[1] = 3'b100; stma[1] = 32'h00000000; stmb[1] = 32'h00000000; Cinstm[1] = 0;
ref[2] = 32'hFFFFFFFF; Vref[2] = 0; Coutref[2] = 0;		Stm[2] = 3'b010; stma[2] = 32'hFFFFFFFF; stmb[2] = 32'h00000000; Cinstm[2] = 0;      // Test Carry  //
ref[3] = 32'h00000000; Vref[3] = 0; Coutref[3] = 1;     	Stm[3] = 3'b010; stma[3] = 32'hFFFFFFFF; stmb[3] = 32'h00000000; Cinstm[3] = 1;
ref[4] = 32'h7FFFFFFF; Vref[4] = 0; Coutref[4] = 0;     	Stm[4] = 3'b010; stma[4] = 32'h7FFFFFFF; stmb[4] = 32'h00000000; Cinstm[4] = 0;
ref[5] = 32'h80000000; Vref[5] = 1; Coutref[5] = 0;   		Stm[5] = 3'b010; stma[5] = 32'h7FFFFFFF; stmb[5] = 32'h00000000; Cinstm[5] = 1;
ref[6] = 32'h00100166; Vref[6] = 1'bx; Coutref[6] = 1'bx;	Stm[6] = 3'b000; stma[6] = 32'hF01010CA; stmb[6] = 32'hF00011AC; Cinstm[6] = 0;      //  Test xor   //
ref[7] = 32'h0EEF9997; Vref[7] = 1'bx; Coutref[7] = 1'bx;	Stm[7] = 3'b001; stma[7] = 32'hF101CBA9; stmb[7] = 32'h0011ADC1; Cinstm[7] = 0;      //  Test xnor  //
ref[8] = 32'h0000FFFF; Vref[8] = 1'bx; Coutref[8] = 1'bx;	Stm[8] = 3'b110; stma[8] = 32'hFFFFFFFF; stmb[8] = 32'h0000FFFF; Cinstm[8] = 0;      //  Test and   //
ref[9] = 32'hF111EFE9; Vref[9] = 1'bx; Coutref[9] = 1'bx;	Stm[9] = 3'b100; stma[9] = 32'hF101CBA9; stmb[9] = 32'h0011ADC1; Cinstm[9] = 0;      //  Test or    //
ref[10] = 32'h64424220;	Vref[10] = 1'bx; Coutref[10] = 1'bx;	Stm[10] = 3'b010; stma[10] = 32'h31312020; stmb[10] = 32'h33112200; Cinstm[10] = 0;  //  Test add   //
ref[11] = 32'h64424221;	Vref[11] = 1'bx; Coutref[11] = 1'bx;	Stm[11] = 3'b011; stma[11] = 32'h31312020; stmb[11] = 32'hCCEEDDFF; Cinstm[11] = 1;  //  Test sub   //
ref[12] = 32'h00000001;	Vref[12] = 1'bx; Coutref[12] = 1'bx;	Stm[12] = 3'b010; stma[12] = 32'h00000000; stmb[12] = 32'h00000000; Cinstm[12] = 1;  //  Test Carry //
ref[13] = 32'h0000000F;	Vref[13] = 1'bx; Coutref[13] = 1'bx;	Stm[13] = 3'b010; stma[13] = 32'h0000000F; stmb[13] = 32'h00000000; Cinstm[13] = 0;
ref[14] = 32'h00000010;	Vref[14] = 1'bx; Coutref[14] = 1'bx;	Stm[14] = 3'b010; stma[14] = 32'h0000000F; stmb[14] = 32'h00000000; Cinstm[14] = 1;
ref[15] = 32'h000000FF;	Vref[15] = 1'bx; Coutref[15] = 1'bx;	Stm[15] = 3'b010; stma[15] = 32'h000000FF; stmb[15] = 32'h00000000; Cinstm[15] = 0;
ref[16] = 32'h00000100;	Vref[16] = 1'bx; Coutref[16] = 1'bx;	Stm[16] = 3'b010; stma[16] = 32'h000000FF; stmb[16] = 32'h00000000; Cinstm[16] = 1;
ref[17] = 32'h00000FFF;	Vref[17] = 1'bx; Coutref[17] = 1'bx;	Stm[17] = 3'b010; stma[17] = 32'h00000FFF; stmb[17] = 32'h00000000; Cinstm[17] = 0;
ref[18] = 32'h00001000;	Vref[18] = 1'bx; Coutref[18] = 1'bx;	Stm[18] = 3'b010; stma[18] = 32'h00000FFF; stmb[18] = 32'h00000000; Cinstm[18] = 1;
ref[19] = 32'h0000FFFF;	Vref[19] = 1'bx; Coutref[19] = 1'bx;	Stm[19] = 3'b010; stma[19] = 32'h0000FFFF; stmb[19] = 32'h00000000; Cinstm[19] = 0;
ref[20] = 32'h00010000; Vref[20] = 1'bx; Coutref[20] = 1'bx;	Stm[20] = 3'b010; stma[20] = 32'h0000FFFF; stmb[20] = 32'h00000000; Cinstm[20] = 1;
ref[21] = 32'h000FFFFF; Vref[21] = 1'bx; Coutref[21] = 1'bx;	Stm[21] = 3'b010; stma[21] = 32'h000FFFFF; stmb[21] = 32'h00000000; Cinstm[21] = 0;
ref[22] = 32'h00100000;	Vref[22] = 1'bx; Coutref[22] = 1'bx;	Stm[22] = 3'b010; stma[22] = 32'h000FFFFF; stmb[22] = 32'h00000000; Cinstm[22] = 1;
ref[23] = 32'h00FFFFFF;	Vref[23] = 1'bx; Coutref[23] = 1'bx;	Stm[23] = 3'b010; stma[23] = 32'h00FFFFFF; stmb[23] = 32'h00000000; Cinstm[23] = 0;
ref[24] = 32'h01000000;	Vref[24] = 1'bx; Coutref[24] = 1'bx;	Stm[24] = 3'b010; stma[24] = 32'h00FFFFFF; stmb[24] = 32'h00000000; Cinstm[24] = 1;
ref[25] = 32'h0FFFFFFF;	Vref[25] = 1'bx; Coutref[25] = 1'bx;	Stm[25] = 3'b010; stma[25] = 32'h0FFFFFFF; stmb[25] = 32'h00000000; Cinstm[25] = 0;
ref[26] = 32'h10000000;	Vref[26] = 1'bx; Coutref[26] = 1'bx;	Stm[26] = 3'b010; stma[26] = 32'h0FFFFFFF; stmb[26] = 32'h00000000; Cinstm[26] = 1;
ref[27] = 32'h00000000; Vref[27] = 1'bx; Coutref[27] = 1'bx;	Stm[27] = 3'b101; stma[27] = 32'hFFFFFFFF; stmb[27] = 32'h0000FFFF; Cinstm[27] = 0;  //  Test nor  //
ref[28] = 32'hx; Vref[28] = 0; Coutref[28] = 0;			Stm[28] = 3'b010; stma[28] = 32'h00000000; stmb[28] = 32'h00000000; Cinstm[28] = 0;  //  Test Cout, V // 
ref[29] = 32'hx; Vref[29] = 0; Coutref[29] = 1;			Stm[29] = 3'b010; stma[29] = 32'hFFFFFFFF; stmb[29] = 32'hFFFFFFFF; Cinstm[29] = 0;
ref[30] = 32'hx; Vref[30] = 1; Coutref[30] = 1;			Stm[30] = 3'b010; stma[30] = 32'h80000000; stmb[30] = 32'h80000000; Cinstm[30] = 0;
ref[31] = 32'hx; Vref[31] = 1; Coutref[31] = 0;			Stm[31] = 3'b010; stma[31] = 32'h40000000; stmb[31] = 32'h40000000; Cinstm[31] = 0;
ref[32] = 32'hx; Vref[32] = 1'bx; Coutref[32] =1'bx;			Stm[32] = 3'hx; stma[32] = 32'hx; stmb[32] = 32'hx; Cinstm[32] =1'bx;
ref[33] = 32'hx; Vref[33] =1'bx; Coutref[33] =1'bx;			Stm[33] = 3'hx; stma[33] = 32'hx; stmb[33] = 32'hx; Cinstm[33] =1'bx;
dontcare = 32'hx;
ntests = 32;
 
$timeformat(-9,1,"ns",12);
 
end

//assumes positive edge FF.
//Change inputs in middle of period (falling edge).
initial begin
 error = 0;
    
 for (k=0; k<= ntests+1; k=k+1)   		     // LOOPING THROUGH ALL THE TEST VECTORS AND ASSIGNING IT TO THE ALU INPUTS EVERY 25ns //
    begin
    clk=1;
    $display ("Time=%t\n  clk=%b", $realtime, clk);
    #12.5
    clk=0;
    $display ("Time=%t\n  clk=%b", $realtime, clk);
    a = stma[k] ; b = stmb[k];
    if (k >= 1) begin
      S = Stm[k-1]; Cin = Cinstm[k-1];
    end
    
    if (k >=2) begin
      if ( Stm[k-2] == 3'b000 )
      $display ("-----  TEST FOR A XOR B  -----");
    
      if ( Stm[k-2] == 3'b001 )
      $display ("-----  TEST FOR A XNOR B  -----");
  
      if ( Stm[k-2] == 3'b010 )
      $display ("-----  TEST FOR A + B/ CARRY CHAIN  -----");
    
      if ( Stm[k-2] == 3'b011 )
      $display ("-----  TEST FOR A - B  -----");
  
      if ( Stm[k-2] == 3'b100 )
      $display ("-----  TEST FOR A OR B  -----");
  
      if ( Stm[k-2] == 3'b101 )
      $display ("-----  TEST FOR A NOR B  -----");

      if ( Stm[k-2] == 3'b110 )
      $display ("-----  TEST FOR A AND B  -----");


      $display ("Time=%t \n S=%b \n Cin=%b \n a=%b \n b=%b \n d=%b \n ref=%b \n",$realtime, Stm[k-2], Cinstm[k-2], stma[k-2], stmb[k-2], d, ref[k-2]);
    
    
      // THIS CONTROL BLOCK CHECKS FOR ERRORS  BY COMPARING YOUR OUTPUT WITH THE EXPECTED OUTPUTS AND INCREMENTS "error" IN CASE OF ERROR //
    
      if (( (ref[k-2] !== d) && (ref[k-2] !== dontcare)  ) )
        begin
        $display ("-------------ERROR. A Mismatch Has Occured-----------");
        error = error + 1;
      end

    end
    #12.5 ;
 end

    if ( error == 0)
        $display("---------YOU DID IT!! SIMULATION SUCCESFULLY FINISHED----------");
    
    if ( error != 0)
        $display("---------------ERRORS. Mismatches Have Occured------------------");

end
         
        
endmodule
         


