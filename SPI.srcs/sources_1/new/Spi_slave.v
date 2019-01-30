`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2019 11:22:49 AM
// Design Name: 
// Module Name: spi_slave
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
module Spi_slave(clk,miso,mosi,ss);
    
    input clk;
    input [0:0]mosi;
    input ss;
    output reg[0:0]miso;
    reg [7:0] address,data;
    reg rw;
    reg [7:0] arr [0:309];
    reg [6:0] i=0;
    initial begin
        arr[233]=185;
    end
    
    always @(mosi or ss)begin
           if(i==0 && ss==0)begin
                rw <= mosi;
            end
    end
    
    always @(posedge clk )begin
        if(ss==0)begin
        
            //******ADDRESS READ***//
            if(i>0 && i<9)begin
            address <= {address,mosi};
            end
            
            //******DATA READING****//
            if(i>8 && i<17 && rw==1)begin
            data <= {data,mosi};
            end
            
            //*********DATA SENDING TO MASTER MISO***//
            else if(i>8 && i<17 && rw==0)begin
            miso <= arr[address][7];
            arr[address]<=arr[address]<<1;
            end
            if(i==17)
            miso<=1'b0;
            
            //******DATA RECEIVED WRITTEN IN TO THE ADDRESS***//
            i<=i+1;
            if(i>16 && rw==1)
            arr[address]<=data;
        end
        
    end
endmodule
