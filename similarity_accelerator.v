`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
//
// Create Date: 18.06.2026
// Design Name:
// Module Name: similarity_accelerator
// Description:
// Unified Similarity Search Accelerator
//
// Mode:
// 00 -> Euclidean Distance Search
// 01 -> Dot Product Search
// 10 -> Cosine Similarity Search
//////////////////////////////////////////////////////////////////////////////////

module similarity_accelerator(

    input clk,

    input [1:0] mode,

    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,

    output done,

    output [3:0] nearest_neighbor_index,

    output [31:0] similarity_score

);

//--------------------------------------------------
// Euclidean Search Engine
//--------------------------------------------------

wire done_euc;
wire [3:0] idx_euc;
wire [17:0] min_distance;

euclidean_knn_top EUC(

    .clk(clk),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .done(done_euc),

    .nearest_neighbor_index(idx_euc),

    .minimum_distance(min_distance)

);

//--------------------------------------------------
// Dot Product Search Engine
//--------------------------------------------------

wire done_dot;
wire [3:0] idx_dot;
wire [17:0] max_dot_score;

dot_product_knn_top DOT(

    .clk(clk),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .done(done_dot),

    .nearest_neighbor_index(idx_dot),

    .max_dot_score(max_dot_score)

);

//--------------------------------------------------
// Cosine Similarity Search Engine
//--------------------------------------------------

wire done_cos;
wire [3:0] idx_cos;
wire [31:0] max_cosine_score;

cosine_knn_top COS(

    .clk(clk),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .done(done_cos),

    .nearest_neighbor_index(idx_cos),

    .max_similarity_score(max_cosine_score)

);

//--------------------------------------------------
// Output Multiplexing
//--------------------------------------------------

assign done =
       (mode == 2'b00) ? done_euc :
       (mode == 2'b01) ? done_dot :
       (mode == 2'b10) ? done_cos :
       1'b0;

assign nearest_neighbor_index =
       (mode == 2'b00) ? idx_euc :
       (mode == 2'b01) ? idx_dot :
       (mode == 2'b10) ? idx_cos :
       4'd0;

//--------------------------------------------------
// Unified Metric Output
//--------------------------------------------------

assign similarity_score =
       (mode == 2'b00) ? {14'd0, min_distance} :
       (mode == 2'b01) ? {14'd0, max_dot_score} :
       (mode == 2'b10) ? max_cosine_score :
       32'd0;

endmodule
