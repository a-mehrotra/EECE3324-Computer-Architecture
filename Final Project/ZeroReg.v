`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: ZeroReg
// Description: Designated Zero Register for RegFile 
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////


module ZeroReg(Asel, Bsel, clk, Dselect, abus, bbus);
    // Declare input and output variables
    input clk, Dselect, Asel, Bsel;
    reg[63:0] Q;
    output[63:0] abus, bbus;
    // Set-up modified clk to assign to Q
    always @(negedge clk) begin
        Q = 64'b0;
    end
    // Set-up tri-state buffer
    assign abus = Asel ? Q : 64'bz;
    assign bbus = Bsel ? Q : 64'bz;
endmodule
