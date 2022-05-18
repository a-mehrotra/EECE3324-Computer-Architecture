`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: regalu
// Project Name: Assignment 3
//////////////////////////////////////////////////////////////////////////////////

module regalu(Aselect, Bselect, Dselect, clk, abus, bbus, dbus, S, Cin);
    input[31:0] Aselect, Bselect, Dselect, dbus;
    input clk, Cin;
    input[2:0] S;
    output[31:0] abus, bbus;
    
    // Instantiate RegFile
    RegFile32x32 regfile(Aselect, Bselect, Dselect, abus, bbus, dbus, clk);
    // Instantiate ALUPipe
    ALUPipe alupipe(abus, bbus, clk, S, Cin, dbus);
    
endmodule
