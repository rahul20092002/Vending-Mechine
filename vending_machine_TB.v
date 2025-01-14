`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2024 23:03:44
// Design Name: 
// Module Name: vending_machine_TB
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


module vending_machine_TB(
);
    reg clock;
    reg reset;
    reg [7:0] cash;
    reg [2:0] product;
    wire [7:0] change;
    wire trans_sucess;

    vending_machine uut(
        .clock(clock),
        .reset(reset),
        .cash(cash),
        .product(product),
        .change(change),
        .trans_sucess(trans_sucess)
    );
    
    initial begin
        clock=0;
    end
    
    always #5 clock=~clock;
    
    initial begin
        reset=1;
        cash=0;
        product=0;
        
        #5 reset=0;
        @(posedge clock) cash=20;
        @(posedge clock) product=1;
        @(posedge clock) product=0;
        
        #10 
        @(posedge clock) cash=100;
        @(posedge clock) product=3;
        @(posedge clock) product=0;
        
        #10
        @(posedge clock) cash=50;
        @(posedge clock) product=1; 
        @(posedge clock) product=0;
        
        #10
        @(posedge clock) cash=10;
        @(posedge clock) product=1; 
        @(posedge clock) product=0;
                 
        #10 reset=1;
        #50 $stop;
    end
    
    
endmodule
