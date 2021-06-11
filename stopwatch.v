`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2021 09:45:48 PM
// Design Name: 
// Module Name: stopwatch
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


module stopwatch(
    input clk,
    input start,
    input reset_n,
    output [0:7]AN,
    output [6:0]sseg,
    output DP
    );
    wire start1;
    wire reset_n1;
    wire slow_clk;
    wire [3:0]f0;
    wire [3:0]f1;
    wire [3:0]s0;
    wire [3:0]s1;
    wire [3:0]m0;
    wire [3:0]m1;
    wire done0;
    wire done1;
    reg en = 0;
    
    button B0(
        .clk(clk),
        .in(start),
        .out(start1)
    );
    button B1(
        .clk(clk),
        .in(reset_n),
        .out(reset_n1)
    );

    always @(posedge start1)
    begin
        en = ~en;
    end
    
    slower_clk SC0(
        .clk(clk),
        .reset_n(reset_n1),
        .out(slow_clk)
    );
    multi_decade_counter MDC0(
        .clk(slow_clk),
        .reset_n(~reset_n1),
        .enable(en),
        .max0(9),
        .max1(9),
        .max2(9),
        .done(done0),
        .ones(f0),
        .tens(f1),
        .hundreds(s0)
    );    
    multi_decade_counter MDC1(
        .clk(slow_clk),
        .reset_n(~reset_n1),
        .enable(done0),
        .max0(5),
        .max1(9),
        .max2(5),
        .done(done1),
        .ones(s1),
        .tens(m0),
        .hundreds(m1)
    );
    sseg_driver SD0(
        .clk(clk),
        .I7({1'b1, f0, 1'b1}),
        .I6({1'b1, f1, 1'b1}),
        .I5({1'b1, s0, 1'b0}),
        .I4({1'b1, s1, 1'b1}),
        .I3({1'b1, m0, 1'b0}),
        .I2({1'b1, m1, 1'b1}),
        .I1({1'b0, 4'b0000, 1'b1}),
        .I0({1'b0, 4'b0000, 1'b1}),
        .AN(AN),
        .sseg(sseg),
        .DP(DP)
    );
    
endmodule
