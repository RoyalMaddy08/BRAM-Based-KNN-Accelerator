`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 18.06.2026 11:23:06
// Design Name: 
// Module Name: tb_dot_product
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

module tb_dot_product;

reg clk;

reg [7:0] x0;
reg [7:0] x1;
reg [7:0] x2;
reg [7:0] x3;

reg [7:0] y0;
reg [7:0] y1;
reg [7:0] y2;
reg [7:0] y3;

wire [17:0] score;

dot_product uut(

    .clk(clk),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .y0(y0),
    .y1(y1),
    .y2(y2),
    .y3(y3),

    .score(score)

);

always #5 clk = ~clk;

initial
begin

    clk = 0;

    //
    // Test Case 1
    // (1,2,3,4) · (1,2,3,4)
    //
    // Expected = 30
    //

    x0 = 8'd1;
    x1 = 8'd2;
    x2 = 8'd3;
    x3 = 8'd4;

    y0 = 8'd1;
    y1 = 8'd2;
    y2 = 8'd3;
    y3 = 8'd4;

    #50;

    $display("--------------------------------");
    $display("Dot Product Score = %0d", score);
    $display("Expected Score    = 30");
    $display("--------------------------------");

    #20;

    $finish;

end

endmodule
