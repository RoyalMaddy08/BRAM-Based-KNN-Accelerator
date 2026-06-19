`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
// 
// Create Date: 18.06.2026 13:12:00
// Design Name: 
// Module Name: tb_inv_sqrt_lut
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

module tb_inv_sqrt_lut;

reg [9:0] mag_sq;
wire [15:0] inv_sqrt;

inv_sqrt_lut uut(

    .mag_sq(mag_sq),
    .inv_sqrt(inv_sqrt)

);

initial
begin

    mag_sq = 10'd1;
    #10;
    $display("Input=%0d Output=%0d Expected=256",
             mag_sq, inv_sqrt);

    mag_sq = 10'd4;
    #10;
    $display("Input=%0d Output=%0d Expected=128",
             mag_sq, inv_sqrt);

    mag_sq = 10'd9;
    #10;
    $display("Input=%0d Output=%0d Expected=85",
             mag_sq, inv_sqrt);

    mag_sq = 10'd16;
    #10;
    $display("Input=%0d Output=%0d Expected=64",
             mag_sq, inv_sqrt);

    mag_sq = 10'd25;
    #10;
    $display("Input=%0d Output=%0d Expected=51",
             mag_sq, inv_sqrt);

    mag_sq = 10'd30;
    #10;
    $display("Input=%0d Output=%0d Expected=47",
             mag_sq, inv_sqrt);

    $finish;

end

endmodule
