`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 18.06.2026 23:43:30
// Design Name: 
// Module Name: tb_euclidean_knn_top
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

module tb_euclidean_knn_top;

//====================================================
// Ports
//====================================================
reg clk;
reg reset;
reg start;

reg [7:0] x0;
reg [7:0] x1;
reg [7:0] x2;
reg [7:0] x3;

wire done;
wire [6:0]  nearest_neighbor_index;
wire [17:0] minimum_distance;

//====================================================
// Performance Counters
//====================================================
integer cycle_count;
integer query_number;

//====================================================
// DUT
//====================================================
euclidean_knn_top uut (
    .clk   (clk),
    .reset (reset),
    .start (start),
    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),
    .done                  (done),
    .nearest_neighbor_index(nearest_neighbor_index),
    .minimum_distance      (minimum_distance)
);

//====================================================
// Clock Generation  (10 ns period)
//====================================================
always #5 clk = ~clk;

//====================================================
// Cycle Counter - counts only while not done
//====================================================
always @(posedge clk)
begin
    if (!done)
        cycle_count = cycle_count + 1;
end

//====================================================
// run_query Task
//====================================================
task run_query;
    input [7:0] a, b, c, d;
    begin
        //-- Set inputs ---------------------------------
        x0 = a;
        x1 = b;
        x2 = c;
        x3 = d;

        //-- One-clock start pulse ----------------------
        @(posedge clk);
        start <= 1'b1;

        @(posedge clk);
        start <= 1'b0;

        //-- Wait for accelerator to finish -------------
        wait (done);
        #1;

        //-- Per-query report ---------------------------
        $display("=========================================");
        $display("EUCLIDEAN SEARCH COMPLETED");
        $display("=========================================");
        $display("Query Vector         = (%0d,%0d,%0d,%0d)", a, b, c, d);
        $display("Nearest Window Index = %0d", nearest_neighbor_index);
        $display("Minimum Distance     = %0d", minimum_distance);
        $display("=========================================");

        query_number = query_number + 1;

        //-- Reset counter for next query ---------------
        cycle_count = 0;

        #10;
    end
endtask

initial
begin
    //-- Initialise ------------------------------------
    clk          = 0;
    reset        = 1;
    start        = 0;
    cycle_count  = 0;
    query_number = 1;

    x0 = 0;
    x1 = 0;
    x2 = 0;
    x3 = 0;

    #20;
    reset = 0;

    //-- Stimulus --------------------------------------
    run_query(0,0,0,0);

    #20;
    $finish;
end

endmodule
