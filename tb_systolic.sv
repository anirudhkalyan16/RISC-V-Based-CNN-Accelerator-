module tb_array_sys;

    logic clock;
    logic reset;
    logic [7:0] a1, a2, b1, b2;
    logic [15:0] c1, c2, c3, c4;

    array_sys dut (
        .clock(clock),
        .reset(reset),
        .a1(a1),
        .a2(a2),
        .b1(b1),
        .b2(b2),
        .c1(c1),
        .c2(c2),
        .c3(c3),
        .c4(c4)
    );

    always #5 clock = ~clock;

    initial begin
        $dumpfile("array_sys.vcd");
        $dumpvars(0, tb_array_sys);

        clock = 0;
        reset = 1;
        a1 = 0;
        a2 = 0;
        b1 = 0;
        b2 = 0;

        #10 reset = 0;

        a1 = 8'd1;
        a2 = 8'd3;
        b1 = 8'd5;
        b2 = 8'd7;

        #10;

        a1 = 8'd2;
        a2 = 8'd4;
        b1 = 8'd6;
        b2 = 8'd8;

        #10;

        a1 = 0;
        a2 = 0;
        b1 = 0;
        b2 = 0;

        #50;

        $display("c1=%0d c2=%0d c3=%0d c4=%0d", c1, c2, c3, c4);

        $finish;
    end

endmodule