`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 18.06.2026 13:10:46
// Design Name: 
// Module Name: inv_sqrt_lut
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

module inv_sqrt_lut(

    input  [9:0] mag_sq,
    output reg [15:0] inv_sqrt

);

always @(*)
begin

    case(mag_sq)

10'd4   : inv_sqrt = 16'd128;
10'd16  : inv_sqrt = 16'd64;
10'd30  : inv_sqrt = 16'd47;
10'd36  : inv_sqrt = 16'd43;
10'd54  : inv_sqrt = 16'd35;
10'd64  : inv_sqrt = 16'd32;
10'd95  : inv_sqrt = 16'd26;
10'd100 : inv_sqrt = 16'd25;
10'd144 : inv_sqrt = 16'd21;
10'd174 : inv_sqrt = 16'd19;
10'd196 : inv_sqrt = 16'd18;
10'd256 : inv_sqrt = 16'd16;
10'd324 : inv_sqrt = 16'd14;
10'd400 : inv_sqrt = 16'd13;
10'd421 : inv_sqrt = 16'd12;
10'd484 : inv_sqrt = 16'd12;
10'd576 : inv_sqrt = 16'd11;

        default:
            inv_sqrt = 16'd0;

    endcase

end

endmodule
