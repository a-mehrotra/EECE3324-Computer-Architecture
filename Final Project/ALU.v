`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: ALU
// Description: Arithmetic Logic Unit with 64-bit support and ARM flags
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module ALU(ALU_abus, ALU_bbus, Cin, S, ALU_Out, N, Z, V, C, SetFlag);

    input[63:0] ALU_abus, ALU_bbus;
    input Cin, SetFlag;
    input [2:0] S;
    output [63:0] ALU_Out;
    output reg N, Z;
    output V, C; 
    
    wire [63:0] c_1, g, p;
    wire gout, pout;
    
   alu_cell alucell[63:0] (
      .d(ALU_Out),
      .g(g),
      .p(p),
      .a(ALU_abus),
      .b(ALU_bbus),
      .c_1(c_1),
      .S(S)
   );
   
   lac6 laclevel6(
      .c_1(c_1),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(g),
      .p(p)
   );

   overflow over(
      .c_1(c_1),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .Cout(C),
      .V(V)
   );   
   
   always@(SetFlag) begin
       if(SetFlag) begin
            N = ALU_Out[63];
            Z = (ALU_Out == 0) ? 1:0;
       end
   end 
endmodule

module alu_cell (d, g, p, a, b, c_1, S);
   output d, g, p;
   input a, b, c_1;
   input [2:0] S;      
   reg g,p,d,cint,bint;
     
   always @(a,b,c_1,S,p,g) begin 
     bint = S[0] ^ b;
     g = a & bint;
     p = a ^ bint;
     cint = S[1] & c_1;
    
	 //expand this module to handle S[2]
     if(S[2] == 0) 
        begin 
            d = p ^ cint;
        end
     else if (S[2] == 1)
        begin
            if(S[1] == 0 && S[0] == 0) 
                begin 
                    d = a | b;
                end
            else if(S[1] == 0 && S[0] == 1) 
                begin 
                    d = a << b; 
                end
            else if(S[1] == 1 && S[0] == 0) 
                begin 
                    d = a & b;
                end 
            else if(S[1] == 1 && S[0] == 1)
                begin
                    d = a >> b; 
                end
         end
    end 
    
endmodule

module overflow (c_1, SetFlag, gout, pout, Cin, Cout, V);
    input[63:0] c_1; 
    input gout, pout, Cin, SetFlag; 
    output reg Cout, V; 
    
    always@(SetFlag) begin
        if (SetFlag) begin
             Cout = gout | (pout & Cin); 
             V = Cout ^ c_1[63]; 
        end 
    end
endmodule

module lac(c_1, gout, pout, Cin, g, p);

   output [1:0] c_1;
   output gout;
   output pout;
   input Cin;
   input [1:0] g;
   input [1:0] p;

   assign c_1[0] = Cin;
   assign c_1[1] = g[0] | ( p[0] & Cin );
   assign gout = g[1] | ( p[1] & g[0] );
   assign pout = p[1] & p[0];
	
endmodule

module lac2 (c_1, gout, pout, Cin, g, p);
   output [3:0] c_1;
   output gout, pout;
   input Cin;
   input [3:0] g, p;
   
   wire [1:0] cint, gint, pint;
   
   lac leaf0(
      .c_1(c_1[1:0]),
      .gout(gint[0]),
      .pout(pint[0]),
      .Cin(cint[0]),
      .g(g[1:0]),
      .p(p[1:0])
   );
   
   lac leaf1(
      .c_1(c_1[3:2]),
      .gout(gint[1]),
      .pout(pint[1]),
      .Cin(cint[1]),
      .g(g[3:2]),
      .p(p[3:2])
   );
   
   lac root(
      .c_1(cint),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(gint),
      .p(pint)
   );
endmodule   


module lac3 (c_1, gout, pout, Cin, g, p);
   output [7:0] c_1;
   output gout, pout;
   input Cin;
   input [7:0] g, p;
   
   wire [1:0] cint, gint, pint;
   
   lac2 leaf0(
      .c_1(c_1[3:0]),
      .gout(gint[0]),
      .pout(pint[0]),
      .Cin(cint[0]),
      .g(g[3:0]),
      .p(p[3:0])
   );
   
   lac2 leaf1(
      .c_1(c_1[7:4]),
      .gout(gint[1]),
      .pout(pint[1]),
      .Cin(cint[1]),
      .g(g[7:4]),
      .p(p[7:4])
   );
   
   lac root(
      .c_1(cint),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(gint),
      .p(pint)
   );
endmodule


module lac4 (c_1, gout, pout, Cin, g, p);
    output [15:0] c_1;
    output gout, pout;
    input Cin;
    input [15:0] g, p;
    
    wire [1:0] cint, gint, pint;
    
    lac3 leaf0(
      .c_1(c_1[7:0]),
      .gout(gint[0]),
      .pout(pint[0]),
      .Cin(cint[0]),
      .g(g[7:0]),
      .p(p[7:0])
      );
      
    lac3 leaf1(
      .c_1(c_1[15:8]),
      .gout(gint[1]),
      .pout(pint[1]),
      .Cin(cint[1]),
      .g(g[15:8]),
      .p(p[15:8])
      );
      
    lac root(
      .c_1(cint),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(gint),
      .p(pint)
      ); 

endmodule


module lac5 (c_1, gout, pout, Cin, g, p);
    output [31:0] c_1;
    output gout, pout;
    input Cin;
    input [31:0] g, p;
    
    wire [1:0] cint, gint, pint;
    
    lac4 leaf0(
      .c_1(c_1[15:0]),
      .gout(gint[0]),
      .pout(pint[0]),
      .Cin(cint[0]),
      .g(g[15:0]),
      .p(p[15:0])
    );
    
    lac4 leaf1(
      .c_1(c_1[31:16]),
      .gout(gint[1]),
      .pout(pint[1]),
      .Cin(cint[1]),
      .g(g[31:16]),
      .p(p[31:16])
    );
    
    lac root(
      .c_1(cint),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(gint),
      .p(pint)
      ); 
endmodule

module lac6 (c_1, gout, pout, Cin, g, p);
    output [63:0] c_1;
    output gout, pout;
    input Cin;
    input [63:0] g, p;
    
    wire [1:0] cint, gint, pint;
    
    lac5 leaf0(
      .c_1(c_1[31:0]),
      .gout(gint[0]),
      .pout(pint[0]),
      .Cin(cint[0]),
      .g(g[31:0]),
      .p(p[31:0])
    );
    
    lac5 leaf1(
      .c_1(c_1[63:32]),
      .gout(gint[1]),
      .pout(pint[1]),
      .Cin(cint[1]),
      .g(g[63:32]),
      .p(p[63:32])
    );
    
    lac root(
      .c_1(cint),
      .gout(gout),
      .pout(pout),
      .Cin(Cin),
      .g(gint),
      .p(pint)
      ); 
endmodule

