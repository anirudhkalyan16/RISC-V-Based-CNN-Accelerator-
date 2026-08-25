module tb_accelerator;

    logic clk;

    logic rst;

    logic start;

    logic done;

    accelerator_fsm dut(

        .clk(clk),

        .rst(rst),

        .start(start),

        .done(done)

    );

    initial clk = 0;

    always #5 clk = ~clk;

    initial begin

        $dumpfile("accelerator.vcd");

        $dumpvars(0, tb_accelerator);

    end

    initial begin

        rst = 1;

        start = 0;

        #20;

        rst = 0;

        #10;

        start = 1;

        wait(done);

        #10;

        start = 0;

        #20;

        for (int i = 0; i < 36; i++)

            $display("output_mem[%0d] = %0d",

                     i, dut.output_mem[i]);

        for (int i = 0; i < 9; i++)

            $display("pool_mem[%0d] = %0d",

                     i, dut.pool_mem[i]);

        $finish;

    end

endmodule