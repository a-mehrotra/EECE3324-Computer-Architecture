`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: RegFile
// Description: Thirty-two 64-bit registers to make-up the register file
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module RegFile(Aselect, Bselect, DSelect, abus, bbus, dbus, clk);
    // Declare input and output variables
    input[31:0] Aselect, Bselect, DSelect;
    input[63:0] dbus;
    input clk;
    output[63:0] abus, bbus;
    
   // instantiate zero register
   ZeroReg zeroreg(Aselect[31], Bselect[31], clk, DSelect[31], abus, bbus);
   
   // generate the other 31 registers using RegDFF32 and ith bits of inputs
   genvar i; // <-- genvar to use in iteration
   generate
    for (i = 0; i < 31; i = i + 1) begin
        RegFile_DFF reg64(Aselect[i], Bselect[i], DSelect[i], clk, abus, bbus, dbus);
        end
   endgenerate 

endmodule
