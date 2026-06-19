`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
//
// Create Date: 19.06.2026
// Design Name:
// Module Name: euclidean_knn_top
// Description:
// BRAM-Based Euclidean Distance KNN Accelerator
//////////////////////////////////////////////////////////////////////////////////

module euclidean_knn_top(

input clk,

input [7:0] x0,
input [7:0] x1,
input [7:0] x2,
input [7:0] x3,

output done,
output [3:0] nearest_neighbor_index,
output [17:0] minimum_distance


);

reg [3:0] addr;
reg [3:0] index;

wire [17:0] distance;
wire [3:0] nearest_index_internal;

reg [17:0] distance_mem [0:15];

reg [2:0] state;
reg [2:0] done_count;

integer i;

localparam S_ADDR  = 3'd0;
localparam S_WAIT1 = 3'd1;
localparam S_WAIT2 = 3'd2;
localparam S_WAIT3 = 3'd3;
localparam S_WAIT4 = 3'd4;
localparam S_WAIT5 = 3'd5;
localparam S_STORE = 3'd6;
localparam S_DONE  = 3'd7;

assign done =
(state == S_DONE) &&
(done_count == 3'd6);

assign nearest_neighbor_index =
(done) ? nearest_index_internal : 4'd0;

initial
begin


state      = S_ADDR;
addr       = 4'd0;
index      = 4'd0;
done_count = 3'd0;

for(i = 0; i < 16; i = i + 1)
    distance_mem[i] = 18'd0;


end

//----------------------------------------------------
// Euclidean Distance Engine
//----------------------------------------------------

bram_euclidean_top DIST_ENGINE(

    .clk(clk),
    .addr(addr),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .distance(distance)

);

//----------------------------------------------------
// Minimum Distance Finder
//----------------------------------------------------

min_finder_pipe_16 MIN(


.clk(clk),

.d0(distance_mem[0]),
.d1(distance_mem[1]),
.d2(distance_mem[2]),
.d3(distance_mem[3]),
.d4(distance_mem[4]),
.d5(distance_mem[5]),
.d6(distance_mem[6]),
.d7(distance_mem[7]),
.d8(distance_mem[8]),
.d9(distance_mem[9]),
.d10(distance_mem[10]),
.d11(distance_mem[11]),
.d12(distance_mem[12]),
.d13(distance_mem[13]),
.d14(distance_mem[14]),
.d15(distance_mem[15]),

.min_distance(minimum_distance),
.nearest_index(nearest_index_internal)


);

//----------------------------------------------------
// FSM
//----------------------------------------------------

always @(posedge clk)
begin


case(state)

    S_ADDR:
    begin
        addr  <= index;
        state <= S_WAIT1;
    end

    S_WAIT1: state <= S_WAIT2;
    S_WAIT2: state <= S_WAIT3;
    S_WAIT3: state <= S_WAIT4;
    S_WAIT4: state <= S_WAIT5;
    S_WAIT5: state <= S_STORE;

    S_STORE:
    begin

        distance_mem[index] <= distance;

        if(index == 4'd15)
        begin
            state <= S_DONE;
        end
        else
        begin
            index <= index + 1'b1;
            state <= S_ADDR;
        end

    end

    S_DONE:
    begin

        if(done_count < 3'd6)
            done_count <= done_count + 1'b1;

        state <= S_DONE;

    end

    default:
    begin
        state <= S_ADDR;
    end

endcase

end

endmodule
