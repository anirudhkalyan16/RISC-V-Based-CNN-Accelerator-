module PE(
    input  logic clk,
    input  logic rst,
    input  logic [7:0] in_a,in_b,
    output logic [15:0] sum,
    output logic [7:0] out_a,out_b
);

always @(posedge clk) begin
    if (rst) begin
        out_a<=8'd0;
        out_b<=8'd0;
        sum<=16'd0;
    end
    else begin
        sum <=sum+(in_a*in_b);
        out_a<=in_a;
        out_b<=in_b;
    end
end

endmodule


module array_sys(
    input logic clock,
    input logic reset,
    input logic [7:0] a1,a2,b1,b2,
    output logic [15:0] c1,c2,c3,c4
);
    logic [7:0] a12,a34,b13,b24;
    PE pe1(.clk(clock),.rst(reset),.in_a(a1),.in_b(b1),.sum(c1),.out_a(a12),.out_b(b13));
    PE pe2(.clk(clock),.rst(reset),.in_a(a12),.in_b(b2),.sum(c2),.out_a(),.out_b(b24));
    PE pe3(.clk(clock),.rst(reset),.in_a(a2),.in_b(b13),.sum(c3),.out_a(a34),.out_b());
    PE pe4(.clk(clock),.rst(reset),.in_a(a34),.in_b(b24),.sum(c4),.out_a(),.out_b());
endmodule