`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
//
// Create Date: 18.06.2026
// Design Name:
// Module Name: cosine_score
// Description:
// Pipelined Cosine Similarity Score Engine
//////////////////////////////////////////////////////////////////////////////////

module cosine_score(

    input clk,

    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,

    input [7:0] y0,
    input [7:0] y1,
    input [7:0] y2,
    input [7:0] y3,

    output reg [31:0] cosine_score

);

//--------------------------------------------------
// Dot Product
//--------------------------------------------------

wire [17:0] dot_score;

//--------------------------------------------------
// Magnitudes
//--------------------------------------------------

wire [17:0] mx_sq;
wire [17:0] my_sq;

//--------------------------------------------------
// Inverse Square Root LUT Outputs
//--------------------------------------------------

wire [15:0] inv_x;
wire [15:0] inv_y;

//--------------------------------------------------
// Pipeline Registers
//--------------------------------------------------

reg [17:0] dot_score_reg;
reg [31:0] norm_factor_reg;

//--------------------------------------------------
// Internal
//--------------------------------------------------

wire [31:0] norm_factor;

//--------------------------------------------------
// Dot Product
//--------------------------------------------------

dot_product DOT(

    .clk(clk),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .y0(y0),
    .y1(y1),
    .y2(y2),
    .y3(y3),

    .score(dot_score)

);

//--------------------------------------------------
// Magnitude of X
//--------------------------------------------------

magnitude MAG_X(

    .clk(clk),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .magnitude_sq(mx_sq)

);

//--------------------------------------------------
// Magnitude of Y
//--------------------------------------------------

magnitude MAG_Y(

    .clk(clk),

    .x0(y0),
    .x1(y1),
    .x2(y2),
    .x3(y3),

    .magnitude_sq(my_sq)

);

//--------------------------------------------------
// Inverse Square Root LUTs
//--------------------------------------------------

inv_sqrt_lut LUT_X(

    .mag_sq(mx_sq[9:0]),
    .inv_sqrt(inv_x)

);

inv_sqrt_lut LUT_Y(

    .mag_sq(my_sq[9:0]),
    .inv_sqrt(inv_y)

);

//--------------------------------------------------
// Norm Factor
//--------------------------------------------------

assign norm_factor = inv_x * inv_y;

//--------------------------------------------------
// Pipeline Stage
//--------------------------------------------------

always @(posedge clk)
begin

    dot_score_reg   <= dot_score;
    norm_factor_reg <= norm_factor;

end

//--------------------------------------------------
// Final Cosine Score
//--------------------------------------------------

always @(posedge clk)
begin

    cosine_score <= dot_score_reg * norm_factor_reg;

end

endmodule
