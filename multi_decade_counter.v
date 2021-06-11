`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2021 09:50:46 PM
// Design Name: 
// Module Name: multi_decade_counter
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


module multi_decade_counter (
    input clk,
    input reset_n,
    input enable,
    input [3:0] max0, max1, max2,
    output done, // to cascade it even more
    output [3:0] ones, tens, hundreds
    );
    
    wire done0, done1, done2;
    wire a0, a1, a2;
    
    BCD_counter D0(
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .max(max0),
        .done(done0),
        .Q(ones)
    );
    assign a0 = enable & done0;
    
    BCD_counter D1(
        .clk(clk),
        .reset_n(reset_n),
        .enable(a0),
        .max(max1),
        .done(done1),
        .Q(tens)
    );
    assign a1 = a0 & done1;
    
    BCD_counter D2(
        .clk(clk),
        .reset_n(reset_n),
        .enable(a1),
        .max(max2),
        .done(done2),
        .Q(hundreds)
    );    
    assign a2 = a1 & done2;
    
    assign done = a2;
endmodule
