module flopenr #(parameter WIDTH = 8)//使能寄存器 在多周期处理器中用于存储PC和指令。
              (clk, rst, en, d, q);

   input              clk;
   input              rst;
   input              en;
   input  [WIDTH-1:0] d;
   output reg [WIDTH-1:0] q;

 
   always @(posedge clk, posedge rst)
      if (rst)
         q <= 0;
      else if (en)
         q <= d;

endmodule
