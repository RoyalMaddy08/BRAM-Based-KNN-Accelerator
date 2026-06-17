`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 16.06.2026 08:34:56
// Design Name: 
// Module Name: unpacker
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


module unpacker(
input  [31:0] data,

output [7:0] y0,
output [7:0] y1,
output [7:0] y2,
output [7:0] y3
    );
 
 assign y0 = data[31:24];
 assign y1 = data[23:16];
 assign y2 = data[15:8];
 assign y3 = data[7:0];
endmodule
