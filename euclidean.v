`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 15.06.2026 18:38:56
// Design Name: 
// Module Name: euclidean
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


module euclidean(

    input clk,

    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,

    input [7:0] y0,
    input [7:0] y1,
    input [7:0] y2,
    input [7:0] y3,

    output reg [17:0] distance

);

//
// Stage 1 : Differences
//

reg signed [8:0] diff0;
reg signed [8:0] diff1;
reg signed [8:0] diff2;
reg signed [8:0] diff3;

//
// Stage 2 : Squares
//

reg [15:0] sq0;
reg [15:0] sq1;
reg [15:0] sq2;
reg [15:0] sq3;

//
// Stage 3 : Pair Sums
//

reg [16:0] sum0;
reg [16:0] sum1;

//
// Initialization
//

initial begin

    diff0 = 9'd0;
    diff1 = 9'd0;
    diff2 = 9'd0;
    diff3 = 9'd0;

    sq0 = 16'd0;
    sq1 = 16'd0;
    sq2 = 16'd0;
    sq3 = 16'd0;

    sum0 = 17'd0;
    sum1 = 17'd0;

    distance = 18'd0;

end

//
// Stage 1
//

always @(posedge clk)
begin

    diff0 <= {1'b0,x0} - {1'b0,y0};
    diff1 <= {1'b0,x1} - {1'b0,y1};
    diff2 <= {1'b0,x2} - {1'b0,y2};
    diff3 <= {1'b0,x3} - {1'b0,y3};

end

//
// Stage 2
//

always @(posedge clk)
begin

    sq0 <= diff0 * diff0;
    sq1 <= diff1 * diff1;
    sq2 <= diff2 * diff2;
    sq3 <= diff3 * diff3;

end

//
// Stage 3
//

always @(posedge clk)
begin

    sum0 <= sq0 + sq1;
    sum1 <= sq2 + sq3;

end

//
// Stage 4
//

always @(posedge clk)
begin

    distance <= sum0 + sum1;

end

endmodule
