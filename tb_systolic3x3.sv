module test;


 reg clk;
 reg reset;
 reg [7:0] a1;
 reg [7:0] a2;
 reg [7:0] a3;
 reg [7:0] b1;
 reg [7:0] b2;
 reg [7:0] b3;


 wire [16:0] c1;
 wire [16:0] c2;
 wire [16:0] c3;
 wire [16:0] c4;
 wire [16:0] c5;
 wire [16:0] c6;
 wire [16:0] c7;
 wire [16:0] c8;
 wire [16:0] c9;

 top uut (
  .clk(clk), 
  .reset(reset), 
  .a1(a1), 
  .a2(a2), 
  .a3(a3), 
  .b1(b1), 
  .b2(b2), 
  .b3(b3), 
  .c1(c1), 
  .c2(c2), 
  .c3(c3), 
  .c4(c4), 
  .c5(c5), 
  .c6(c6), 
  .c7(c7), 
  .c8(c8), 
  .c9(c9)
 );

 initial begin

  clk = 0;
  reset = 0;
  a1 = 0;
  a2 = 0;
  a3 = 0;
  b1 = 0;
  b2 = 0;
  b3 = 0;


  #5 reset = 1;
  #5 reset = 0;
  #5;  a1 = 1; a2 = 0; a3 = 0; b1 = 2; b2 = 0; b3 = 0;
  #10; a1 = 2; a2 = 4; a3 = 0; b1 = 4; b2 = 1; b3 = 0;
  #10; a1 = 3; a2 = 5; a3 = 7; b1 = 6; b2 = 5; b3 = 3;
  #10; a1 = 0; a2 = 6; a3 = 8; b1 = 0; b2 = 9; b3 = 7;
  #10; a1 = 0; a2 = 0; a3 = 9; b1 = 0; b2 = 0; b3 = 8;
  #10; a1 = 0; a2 = 0; a3 = 0; b1 = 0; b2 = 0; b3 = 0;
  #100;
  $stop;

 end
 
 initial begin
  forever #5 clk = ~clk;
 end
      
endmodule