`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2019 11:24:14 AM
// Design Name: 
// Module Name: spi_master_test
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


module spi_master_test(CLK_3_33_MHZ, sck, mosi, miso, ssel, leds);

input wire CLK_3_33_MHZ;
  input wire sck;
  input wire mosi;
  output wire miso;
  input wire ssel;
  output wire[7:0] leds;
  
  wire byteReceived;
  wire[7:0] receivedData;
  wire dataNeeded;
  reg[7:0] dataToSend;
  reg[7:0] receivedDataBuffer;
  
  spi_slave spi_slave(CLK_3_33_MHZ, sck, mosi, miso, ssel, byteReceived, receivedData, dataNeeded, dataToSend);

  always @(posedge CLK_3_33_MHZ) begin
    if(byteReceived)
      receivedDataBuffer <= receivedData;
  end
  
  always @(posedge CLK_3_33_MHZ) begin
    if(dataNeeded)
      dataToSend <= receivedDataBuffer;
  end
  
  assign leds = receivedDataBuffer;
    
endmodule
