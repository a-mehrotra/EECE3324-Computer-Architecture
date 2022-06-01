`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: Opcode Decoder
// Project Name: Assignment 6
//////////////////////////////////////////////////////////////////////////////////


module opcode_decoder(ibus, ImmID, SID, CinID, SWID);
    input[31:0] ibus;
    output reg [2:0] SID;
    output reg ImmID, CinID, SWID;
    
    wire[5:0] opcode = ibus[31:26];
    wire[5:0] funct = ibus[5:0];
    
    always@(ibus) begin
        case(opcode) 
            // ADDI Operation
            6'b000011: begin
               assign SID = 3'b010;
               assign CinID = 1'b0;
               assign ImmID = 1; 
               assign SWID = 0;
            end
            //SUBI Operation
            6'b000010: begin
               assign SID = 3'b011;
               assign CinID = 1'b1;
               assign ImmID = 1; 
               assign SWID = 0;
            end
            //XORI Operation
            6'b000001: begin
               assign SID = 3'b000;
               assign CinID = 1'b0;
               assign ImmID = 1; 
               assign SWID = 0;
            end
            //ANDI Operation
            6'b001111: begin
               assign SID = 3'b110;
               assign CinID = 1'b0;
               assign ImmID = 1; 
               assign SWID = 0;
            end
            //ORI Operation
            6'b001100: begin
               assign SID = 3'b100;
               assign CinID = 1'b0;
               assign ImmID = 1; 
               assign SWID = 0;
            end
            //LW Operation
            6'b011110: begin
               assign SID = 3'b101;
               assign CinID = 1'b0;
               assign ImmID = 1; 
               assign SWID = 0;
            end
            //SW Operation
            6'b011111: begin
               assign SID = 3'b101;
               assign CinID = 1'b0;
               assign ImmID = 1; 
               assign SWID = 1;
            end
            //Default
            6'b000000: begin
               assign ImmID = 0; 
               case(funct) 
                    //Add Operation
                    6'b000011: begin
                        assign SID = 3'b010;
                        assign CinID = 1'b0;
                        assign SWID = 0;
                    end
                    //Sub Operation
                    6'b000010: begin
                        assign SID = 3'b011;
                        assign CinID = 1'b1;
                        assign SWID = 0;
                    end
                    //XOR Operation
                    6'b000001: begin
                        assign SID = 3'b000;
                        assign CinID = 1'b0;
                        assign SWID = 0;
                    end
                    //And Operation
                    6'b000111: begin
                        assign SID = 3'b110;
                        assign CinID = 1'b0;
                        assign SWID = 0;
                    end
                    //OR Operation
                    6'b000100: begin
                        assign SID = 3'b100;
                        assign CinID = 1'b0;
                        assign SWID = 0;
                    end
                endcase
            end
        endcase
    end
    
endmodule
