`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology, Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 16.06.2026 10:14:02
// Design Name: 
// Module Name: tb_knn_bram_top
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

module tb_knn_bram_top;

reg clk;

reg [7:0] x0;
reg [7:0] x1;
reg [7:0] x2;
reg [7:0] x3;

wire done;
wire [3:0] nearest_index;
wire [17:0] min_distance;

knn_bram_top uut(

    .clk(clk),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .done(done),
    .nearest_index(nearest_index),
    .min_distance(min_distance)

);

always #5 clk = ~clk;

initial
begin

    clk = 0;

    // Query Vector
    x0 = 8'd10;
    x1 = 8'd10;
    x2 = 8'd10;
    x3 = 8'd11;

    wait(done);

    #20;

    $display("====================================");
    $display("KNN SEARCH COMPLETED");
    $display("Query Vector     = (%0d,%0d,%0d,%0d)",
             x0,x1,x2,x3);
    $display("Nearest Index    = %0d", nearest_index);
    $display("Minimum Distance = %0d", min_distance);
    $display("====================================");

    #20;
    $finish;

end

endmodule
