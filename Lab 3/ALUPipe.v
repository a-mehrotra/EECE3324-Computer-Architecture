// Sam Bolduc and Aryan Mehrotra
`timescale 1ns / 1ps

// ALU Pipe top module
module ALUPipe(abus, bbus, clk, S, Cin, dbus);
    input[31:0] abus, bbus;
    input[2:0] S;
    input clk, Cin;
    wire[31:0] AbusDFFOutput, BbusDFFOutput, ALUOutput;
    wire Cout, V; 
    output[31:0] dbus; 
    
    // D Flip-Flop which takes in abus and outputs ALUInputA
    DFF32 AbusToALUInputADFF(abus, AbusDFFOutput, clk);
    // D Flip-Flop which takes in bbus and outputs ALUInputB
    DFF32 BbusToALUInputBDFF(bbus, BbusDFFOutput, clk);
    // ALU which takes in ALUInputA, ALUInputB, S, Cin and outputs an ALUOutput
    alu32 ALU(ALUOutput, Cout, V, AbusDFFOutput, BbusDFFOutput, Cin, S);
    // D Flip-Flop which takes in ALUOutput and outputs to dbus
    DFF32 ALUOuputToDbusDFF(ALUOutput, dbus, clk);
    
endmodule
