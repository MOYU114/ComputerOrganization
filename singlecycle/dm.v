
// data memory
module dm(clk, DMOp, DMWr, addr, din, dout);
   input          clk;
   input  [2:0]   DMOp;
   input          DMWr;
   input  [8:0]   addr;
   input  [31:0]  din;
   output [31:0]  dout;
     
   reg  [7:0] dmem[511:0];
   wire [8:0] addrHword;
   wire [8:0] addrWord;
   wire signext;
   
   // DM_W   3'b000
   // DM_H   3'b001
   // DM_B   3'b010
   // DM_Uhb 3'b1xx
   
   
   assign addrHword = {addr[8:1], 1'b0};
   assign addrWord  = {addr[8:2], 2'b0};
   assign signext = DMOp[1] ? dmem[addr][7] : dmem[addrHword + 1][7]; 
  
   assign dout = DMOp[1] ? (~DMOp[2] & signext ? {24'hffffff, dmem[addr]} : {24'b0, dmem[addr]})
                 : (DMOp[0] ? (~DMOp[2] & signext ? {16'hffff, dmem[addrHword + 1], dmem[addrHword]}
                        : {16'b0, dmem[addrHword + 1], dmem[addrHword]})
                    : {dmem[addrWord + 3], dmem[addrWord + 2], dmem[addrWord + 1], dmem[addrWord]});
   
   always @(posedge clk)
      if (DMWr) begin
      case (DMOp[1:0])
           2'b00:   {dmem[addrWord + 3], dmem[addrWord + 2], dmem[addrWord + 1], dmem[addrWord]} = din;
           2'b01:   {dmem[addrHword + 1], dmem[addrHword]} = din[15:0];
           2'b10:   dmem[addr] = din[7:0];
           default: dmem[addr] = din[7:0];
      endcase
        $display("dmem[0x%8X] = 0x%8X,", {23'b0, addrWord}, 
          {dmem[addrWord + 3], dmem[addrWord + 2], dmem[addrWord + 1], dmem[addrWord]}); 
      end
   
endmodule    

