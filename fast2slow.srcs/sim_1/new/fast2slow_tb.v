`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/21 16:46:01
// Design Name: 
// Module Name: fast2slow_tb
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


module fast2slow_tb();
 reg clk_fast;
 reg clk_slow;
 reg rst_n;
 reg data_from_fast;
 wire data_from_slow;
 
 parameter clk_slow_cycle = 10;
 parameter clk_fast_cycle = 3;


fast2slow_top U0(
    .clk_fast(clk_fast),
    .clk_slow(clk_slow),
    .rst_n(rst_n),
    .data_fast(data_from_fast),
    .data_slow(data_from_slow)
    );
 
 initial begin 
        rst_n = 1'b0;
        clk_slow = 1'b1;
        clk_fast = 1'b1;
        data_from_fast = 1'b0;
    end
    
    initial begin 
        forever #clk_slow_cycle clk_slow = ~clk_slow;
    end
    
    initial begin 
        forever #clk_fast_cycle clk_fast = ~clk_fast;
    end
    
 initial begin 
     #100
     rst_n = 1'b1;
     #100
     data_from_fast = 1'b0;
 
     //当输入脉冲间隔小于两个慢时钟周期
    /* @(posedge clk_fast)
     data_from_fast = 1'b1;
     repeat(2)@(posedge clk_fast)
     data_from_fast = 1'b0;
     @(posedge clk_fast)
     data_from_fast = 1'b1;
     repeat(20)@(posedge clk_fast)
     data_from_fast = 1'b0;*/
 
     //当输入脉冲间隔大于两个慢时钟周期
     @(posedge clk_fast)
     data_from_fast = 1'b1;
     repeat(7)@(posedge clk_fast)
     data_from_fast = 1'b0;
     @(posedge clk_fast)
     data_from_fast = 1'b1;
     repeat(20)@(posedge clk_fast)
     data_from_fast = 1'b0;
 end

endmodule
