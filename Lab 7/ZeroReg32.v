`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: ZeroReg32
// Project Name: Assignment 7
//////////////////////////////////////////////////////////////////////////////////


module ZeroReg32(Asel, Bsel, clk, Dselect, abus, bbus);
    // Declare input and output variables
    input clk, Dselect, Asel, Bsel;
    reg[31:0] Q;
    output[31:0] abus, bbus;
    // Set-up modified clk to assign to Q
    always @(negedge clk) begin
        Q = 32'b0;
    end
    // Set-up tri-state buffer
    assign abus = Asel ? Q : 32'bz;
    assign bbus = Bsel ? Q : 32'bz;
endmodule
