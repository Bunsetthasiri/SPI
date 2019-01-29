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
module spi_slave(scl,miso,mosi,ss);


    input scl;
    input [0:0]mosi;
    input ss;
    output reg[0:0]miso;
    reg [7:0] address,data;
    reg x1;
    reg [6:0] i=0;
    
    initial begin
    end
    always @(mosi or ss)begin
        if(i==0 && ss==0)begin
        x1 <= mosi;
    end
    end
    always @(posedge scl or mosi)begin
        if(ss==0)begin
        
        //******ADDRESS READ***//
        if(i>0 && i<9)begin
        address <= {address,mosi};
        end
        
        //******DATA READING****//
        if(i>8 && i<17 )begin
        data <= {data,mosi};
        end
        
        //*********DATA SENDING TO MASTER MISO***//
        else if(i > 17 && x1==0)begin
        miso <= address[7];
        address<=address<<1;
        end

  
        //******DATA RECEIVED WRITTEN IN TO THE ADDRESS***//
        i<=i+1;
        //if(i>16 && x1==1)
        //arr[address]<=data;
        end
        
    end
endmodule

