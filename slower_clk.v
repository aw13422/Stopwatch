`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2021 10:46:37 PM
// Design Name: 
// Module Name: slower_clk
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


module slower_clk
    #(parameter FINAL_VALUE = 500_000)(
    input clk,
    input reset_n,
    output reg out
    );
    reg [26:0] Q_reg;  
    
    always @ (posedge clk)
    begin
	   if (reset_n)
	   begin
           Q_reg = 0;
		   out = 0;
	   end
	   
	   else
       begin
	       Q_reg = Q_reg +1;
	       if (Q_reg == FINAL_VALUE) 
	       begin
	           out = ~out;
		       Q_reg = 0;
	       end
        end
   end
endmodule

