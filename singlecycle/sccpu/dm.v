`include "ctrl_encode_def.v"
// data memory
module dm(clk, DMWr, addr, din, dout, LD, SV);
   input          clk;
   input          DMWr;
   input  [8:2]   addr;
   input  [31:0]  din;
   input  [2:0]   LD;
   input  [1:0]   SV;
   output reg [31:0]  dout;
     
   reg [31:0] dmem[127:0];
   wire [31:0] addrByte;

   assign addrByte = addr<<2;

    always @( * ) begin
        case(LD)
            `LB:  dout = {{24{dmem[addrByte[8:2]][7]}}, dmem[addrByte[8:2]][7:0]};   // LB
            `LBU: dout = {24'b0, dmem[addrByte[8:2]][7:0]};                          // LBU
            `LH:  dout = {{16{dmem[addrByte[8:2]][15]}}, dmem[addrByte[8:2]][15:0]}; // LH
            `LHU: dout = {16'b0, dmem[addrByte[8:2]][15:0]};                         // LHU
            `LW:  dout = dmem[addrByte[8:2]];                                        // LW
            default: dout = dmem[addrByte[8:2]];                                     // undefined
        endcase
   end
   always @(posedge clk)
      if (DMWr) begin
        case(SV)
            `SB: dmem[addrByte[8:2]][7:0] <= din[7:0];
            `SH: dmem[addrByte[8:2]][15:0] <= din[15:0];
            `SW: dmem[addrByte[8:2]] <= din;
            default: dmem[addrByte[8:2]] <= din;
        endcase
        $display("dmem[0x%8X] = 0x%8X,", addrByte, din); 
      end
   
endmodule  
