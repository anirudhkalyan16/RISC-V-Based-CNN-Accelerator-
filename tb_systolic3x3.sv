module test;

logic clk;
logic reset;

logic [7:0] p1,p2,p3,p4,p5,p6,p7,p8,p9;

logic signed [7:0] w1,w2,w3,w4,w5,w6,w7,w8,w9;

logic signed [31:0] sum;


top dut (
    .clk(clk),
    .reset(reset),

    .p1(p1), .p2(p2), .p3(p3),
    .p4(p4), .p5(p5), .p6(p6),
    .p7(p7), .p8(p8), .p9(p9),

    .w1(w1), .w2(w2), .w3(w3),
    .w4(w4), .w5(w5), .w6(w6),
    .w7(w7), .w8(w8), .w9(w9),

    .sum(sum)
);


initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    reset = 1;

    p1 = 8'd1;  p2 = 8'd2;  p3 = 8'd3;
    p4 = 8'd4;  p5 = 8'd5;  p6 = 8'd6;
    p7 = 8'd7;  p8 = 8'd8;  p9 = 8'd9;

    w1 = 8'sd1; w2 = 8'sd1; w3 = 8'sd1;
    w4 = 8'sd1; w5 = 8'sd1; w6 = 8'sd1;
    w7 = 8'sd1; w8 = 8'sd1; w9 = 8'sd1;

    // Hold reset for 2 clocks
    repeat(2) @(posedge clk);

    reset = 0;


    repeat(5) begin
        @(posedge clk);
        $display("Time = %0t   Sum = %0d", $time, sum);
    end

    if(sum == 32'sd45)
        $display("PASS");
    else
        $display("FAIL");

    $stop;

end

endmodule