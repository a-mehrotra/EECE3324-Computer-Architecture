`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: RegDFF32
// Project Name: Assignment 5
//////////////////////////////////////////////////////////////////////////////////


module RegDFF32(dbus, Asel, Bsel, clk, Dselect, abus, bbus);
    // Declare input and output variables
    input[31:0] dbus;
    input clk, Dselect, Asel, Bsel;
    reg[31:0] Q;
    output[31:0] abus, bbus;
    // Set-up modified clk to assign to Q
    always @(negedge clk) begin
        if (Dselect==1'b1)  
            Q = dbus;
    end
    // Set-up tri-state buffer
    assign abus = Asel ? Q : 32'bz;
    assign bbus = Bsel ? Q : 32'bz;

endmodule
