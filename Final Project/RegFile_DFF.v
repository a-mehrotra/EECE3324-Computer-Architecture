`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Aryan Mehrotra
// 
// Module Name: RegFile_DFF
// Description: Designated neg-edge D Flip-Flops for RegFile 
// Project Name: Final Project
//////////////////////////////////////////////////////////////////////////////////

module RegFile_DFF(Asel, Bsel, Dselect, clk, abus, bbus, dbus);
    // Declare input and output variables
    input[63:0] dbus;
    input clk, Dselect, Asel, Bsel;
    reg[63:0] Q;
    output[63:0] abus, bbus;
    assign newclk = clk & Dselect;
    /*
    always @(negedge newclk) begin
        Q = dbus;
    end
    */
    // Set-up modified clk to assign to Q
    always @(negedge clk) begin
        if (Dselect==1'b1)  
            Q = dbus;
    end

    // Set-up tri-state buffer
    assign abus = Asel ? Q : 64'bz;
    assign bbus = Bsel ? Q : 64'bz;
endmodule
