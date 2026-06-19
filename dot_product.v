`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 18.06.2026 11:17:46
// Design Name: 
// Module Name: dot_product
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

module dot_product(

    input clk,

    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,

    input [7:0] y0,
    input [7:0] y1,
    input [7:0] y2,
    input [7:0] y3,

    output reg [17:0] score

);

//
// Stage 1 : Multiplication
//

reg [15:0] p0;
reg [15:0] p1;
reg [15:0] p2;
reg [15:0] p3;

always @(posedge clk)
begin
    p0 <= x0 * y0;
    p1 <= x1 * y1;
    p2 <= x2 * y2;
    p3 <= x3 * y3;
end

//
// Stage 2 : Pairwise Add
//

reg [16:0] sum0;
reg [16:0] sum1;

always @(posedge clk)
begin
    sum0 <= p0 + p1;
    sum1 <= p2 + p3;
end

//
// Stage 3: Final Add
//

always @(posedge clk)
begin
    score <= sum0 + sum1;
end

endmodule
