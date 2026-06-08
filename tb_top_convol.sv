module tb_top_convol;
     logic [2:0] row;
     logic [2:0] col;
     logic signed [7:0] w1, w2, w3;
     logic signed [7:0] w4, w5, w6;
     logic signed [7:0] w7, w8, w9;
     logic clk;
     logic rst;
     logic signed [31:0] sum;

top_convol dut(
    .row(row),
    .col(col),
    .w1(w1), .w2(w2), .w3(w3),
    .w4(w4), .w5(w5), .w6(w6),
    .w7(w7), .w8(w8), .w9(w9),

        .clk(clk),
        .rst(rst),
        .sum(sum)
);  
initial clk=0;
always #5 clk=~clk;

initial begin
    $dumpfile("top_convol.vcd");
    $dumpvars(0, tb_top_convol);
    w1 = -8'sd1;
    w2 =  8'sd0;
    w3 =  8'sd1;
    w4 = -8'sd2;
    w5 =  8'sd0;
    w6 =  8'sd2;
    w7 = -8'sd1;
    w8 =  8'sd0;
    w9 =  8'sd1;
    rst =1;
    row = 0;
    col = 0;
    @(posedge clk);   
    rst = 0;
    @(posedge clk);  
    #1;
    $display("sum = %0d", sum);
    if (sum == 32'sd8)
        $display("PASS");
    else
        $error("FAIL: sum=%0d expected=8", sum);
    $finish;

end
endmodule