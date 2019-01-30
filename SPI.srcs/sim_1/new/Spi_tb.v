`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2019 01:11:14 PM
// Design Name: 
// Module Name: spi_tb
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


module Spi_tb;


    reg scl;
    wire miso;
    reg [0:0]mosi;
    reg ss1;
    reg [16:0]data;
    
    initial begin
        scl = 0;
        ss1 = 1;
     
        #10 ss1 = 0;
        //data = 17'b111101001_00011001;  //write00011001 to 11101001
         data = 17'b011101001_00011001; // read addr 11101001 
      
    end

    always @(posedge scl)begin
        mosi = data[16];
        data = data<<1;
    end

    always
      begin
        scl = 1'b0;
        repeat(38)
          #1 scl = ~scl; 
      end
      
      Spi_slave spi_slave(scl,miso,mosi,ss1);
endmodule
