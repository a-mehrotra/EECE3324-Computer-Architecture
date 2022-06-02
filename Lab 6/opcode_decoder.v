`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sam Bolduc and Aryan Mehrotra
// 
// Module Name: Opcode Decoder
// Project Name: Assignment 6
//////////////////////////////////////////////////////////////////////////////////


module opcode_decoder(ibus, ImmID, SID, CinID, SWID, LWID);
    input[31:0] ibus;
    output reg [2:0] SID;
    output reg ImmID, CinID, SWID, LWID;
    
    wire[5:0] opcode = ibus[31:26];
    wire[5:0] funct = ibus[5:0];
    
    always@(ibus) begin
        case(opcode) 
            // ADDI Operation
            6'b000011: begin
               SID = 3'b010;
               CinID = 1'b0;
               ImmID = 1; 
               SWID = 0;
               LWID = 0;
            end
            //SUBI Operation
            6'b000010: begin
               SID = 3'b011;
               CinID = 1'b1;
               ImmID = 1; 
               SWID = 0;
               LWID = 0;
            end
            //XORI Operation
            6'b000001: begin
               SID = 3'b000;
                CinID = 1'b0;
                ImmID = 1; 
                SWID = 0;
                LWID = 0;
            end
            //ANDI Operation
            6'b001111: begin
                SID = 3'b110;
                CinID = 1'b0;
                ImmID = 1; 
                SWID = 0;
                LWID = 0;
            end
            //ORI Operation
            6'b001100: begin
                SID = 3'b100;
                CinID = 1'b0;
                ImmID = 1; 
                SWID = 0;
                LWID = 0;
            end
            //LW Operation
            6'b011110: begin
                SID = 3'b010;
                CinID = 1'b0;
                ImmID = 1; 
                SWID = 0;
                LWID = 1;
            end
            //SW Operation
            6'b011111: begin
                SID = 3'b010;
                CinID = 1'b0;
                ImmID = 1; 
                SWID = 1;
                LWID = 0;
            end
            //Default
            6'b000000: begin
                ImmID = 0; 
               case(funct) 
                    //Add Operation
                    6'b000011: begin
                         SID = 3'b010;
                         CinID = 1'b0;
                         SWID = 0;
                         LWID = 0;
                    end
                    //Sub Operation
                    6'b000010: begin
                         SID = 3'b011;
                         CinID = 1'b1;
                         SWID = 0;
                         LWID = 0;
                    end
                    //XOR Operation
                    6'b000001: begin
                         SID = 3'b000;
                         CinID = 1'b0;
                         SWID = 0;
                         LWID = 0;
                    end
                    //And Operation
                    6'b000111: begin
                         SID = 3'b110;
                         CinID = 1'b0;
                         SWID = 0;
                         LWID = 0;
                    end
                    //OR Operation
                    6'b000100: begin
                         SID = 3'b100;
                         CinID = 1'b0;
                         SWID = 0;
                         LWID = 0;
                    end
                endcase
            end
        endcase
    end
    
endmodule
