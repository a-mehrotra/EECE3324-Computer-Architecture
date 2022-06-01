`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: RegFile32x32
// Project Name: Assignment 5
//////////////////////////////////////////////////////////////////////////////////


module RegFile32x32(Aselect, Bselect, Dselect, abus, bbus, dbus, clk);
    // Declare input and output variables
    input[31:0] Aselect, Bselect, Dselect, dbus;
    input clk;
    output[31:0] abus, bbus;
    
   // instantiate zero register with 0th bits of inputs
   ZeroReg32 zeroreg(Aselect[0], Bselect[0], clk, Dselect[0], abus, bbus);
   
   // generate the other 31 registers using RegDFF32 and ith bits of inputs
   genvar i; // <-- genvar to use in iteration
   generate
    for (i = 1; i < 32; i = i + 1) begin
        RegDFF32 reg32(dbus, Aselect[i], Bselect[i], clk, Dselect[i], abus, bbus);
        end
   endgenerate 
    

endmodule
