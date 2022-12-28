`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/21 16:14:37
// Design Name: 
// Module Name: fast2slow_top
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


module fast2slow_top( 
   input clk_fast,
   input clk_slow,
   input rst_n,
   input data_fast,
   output data_slow
   );
   reg  toggle;
   reg  data_d;
   reg  data_d1;
   reg  data_d2;
   
   always@(posedge clk_fast or negedge rst_n)
   begin
   if (!rst_n) begin
   toggle<=1'b0;
     end
   else begin
   toggle<=data_fast?  ~toggle:toggle;
     end
   end
   
   always @ (posedge clk_slow or negedge rst_n)
   begin
   if (!rst_n) begin
   data_d<=1'b0;
   data_d1<=1'b0;
   data_d2<=1'b0;
     end
   else begin
   data_d<=toggle;
   data_d1<=data_d;
   data_d2<=data_d1;
     end
   end
   
   assign data_slow = data_d1^data_d2;
   
   endmodule
   
 
   



