`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2024 21:18:16
// Design Name: 
// Module Name: vending_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module vending_machine(
    input clock,
    input reset,
    input [7:0] cash,
    input [2:0] product,
    output reg [7:0] change,
    output reg trans_sucess
    );
    //Machine can only have case amounts 10,20,50 or 100
    reg [3:0] present_state,next_state;
    parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101;
    
    //determining the present state of the machine 
    always@(posedge clock or posedge reset)begin
        if(reset)begin
            present_state<=S0;
        end
        else begin
            present_state<=next_state;
        end
    end
    
    //Calculating the next state of the machine 
    always@(*)begin
        if(reset)begin
            next_state=S0;
        end
        else if(present_state==S0 && cash!=0)begin
            next_state=S1;
        end
        else if(present_state==S1)begin
            case(product)
               0:next_state=S0;
               1:if(cash>=10) next_state=S2; //cost price of product is 10
               2:if(cash>=20) next_state=S3; //cost price of product is 20
               3:if(cash>=50) next_state=S4; //cost price of product is 50
               4:if(cash>=100) next_state=S5; //cost price of product is 100
               default: next_state=S0;
            endcase
        end
        else begin
            next_state=S0;
        end
    end
    
    //change calculation
    always@(*)begin
        if(reset)begin
            change=0;
            trans_sucess=0;
        end
        else begin
            case(product)
                1:begin change=cash-10; trans_sucess=1; end
                2:begin change=cash-20; trans_sucess=1; end
                3:begin change=cash-50; trans_sucess=1; end
                4:begin change=cash-100; trans_sucess=1; end
                default:begin change=0; trans_sucess=0; end
            endcase
        end
    end
          
endmodule
