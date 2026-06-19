`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
//
// Create Date: 18.06.2026
// Design Name:
// Module Name: magnitude
// Description:
// Pipelined Magnitude Squared Calculator
//
// Computes:
// magnitude_sq = x0² + x1² + x2² + x3²
//
// Pipeline:
// Stage 1 -> Square each element
// Stage 2 -> Sum all squares
//////////////////////////////////////////////////////////////////////////////////

module magnitude(

    input clk,

    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,

    output reg [17:0] magnitude_sq

);

/////////////////////////////////////////////////////
// Stage 1 Registers
/////////////////////////////////////////////////////

reg [15:0] p0_reg;
reg [15:0] p1_reg;
reg [15:0] p2_reg;
reg [15:0] p3_reg;

/////////////////////////////////////////////////////
// Initialization
/////////////////////////////////////////////////////

initial
begin

    p0_reg      = 16'd0;
    p1_reg      = 16'd0;
    p2_reg      = 16'd0;
    p3_reg      = 16'd0;

    magnitude_sq = 18'd0;

end

/////////////////////////////////////////////////////
// Stage 1 : Squares
/////////////////////////////////////////////////////

always @(posedge clk)
begin

    p0_reg <= x0 * x0;
    p1_reg <= x1 * x1;
    p2_reg <= x2 * x2;
    p3_reg <= x3 * x3;

end

/////////////////////////////////////////////////////
// Stage 2 : Sum of Squares
/////////////////////////////////////////////////////

always @(posedge clk)
begin

    magnitude_sq <=
        p0_reg +
        p1_reg +
        p2_reg +
        p3_reg;

end

endmodule
