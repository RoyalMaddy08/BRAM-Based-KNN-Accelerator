`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 18.06.2026 23:50:05
// Design Name: 
// Module Name: tb_bram_euclidean_top
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

module tb_bram_euclidean_top;

reg clk;

reg [3:0] addr;

reg [7:0] x0;
reg [7:0] x1;
reg [7:0] x2;
reg [7:0] x3;

wire [17:0] distance;

bram_euclidean_top uut(

    .clk(clk),
    .addr(addr),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .distance(distance)

);

always #5 clk = ~clk;

initial
begin

    clk = 0;

    //--------------------------------
    // BRAM Address 0
    // Vector = (1,2,3,4)
    //--------------------------------

    addr = 4'd0;

    x0 = 8'd1;
    x1 = 8'd2;
    x2 = 8'd3;
    x3 = 8'd4;

    // BRAM + Euclidean pipeline latency
    #120;

    $display("--------------------------------");
    $display("BRAM EUCLIDEAN TEST");
    $display("Address      = %0d", addr);
    $display("Distance     = %0d", distance);
    $display("Expected     = 0");
    $display("--------------------------------");

    //--------------------------------
    // BRAM Address 1
    // Vector = (5,6,7,8)
    //--------------------------------

    addr = 4'd1;

    #120;

    $display("--------------------------------");
    $display("BRAM EUCLIDEAN TEST");
    $display("Address      = %0d", addr);
    $display("Distance     = %0d", distance);
    $display("Expected     = 64");
    $display("--------------------------------");

    #20;
    $finish;

end

endmodule
