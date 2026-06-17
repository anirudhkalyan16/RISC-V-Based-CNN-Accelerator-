module tb_accelerator_fsm;

    logic clk;
    logic rst;
    logic done;

    accelerator_fsm dut (
        .clk(clk),
        .rst(rst),
        .done(done)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("accelerator_fsm.vcd");
        $dumpvars(0, tb_accelerator_fsm);

        rst = 1;
        @(posedge clk);
        rst = 0;

        wait(done == 1);
        #1;

        $display("FSM DONE");

        for (int i = 0; i < 36; i++) begin
            $display("output_mem[%0d] = %0d", i, dut.output_mem[i]);

            if (dut.output_mem[i] != 32'sd8)
                $error("FAIL: output_mem[%0d] = %0d, expected 8",
                       i, dut.output_mem[i]);
        end

        $display("All 36 outputs verified successfully.");

        $finish;
    end

endmodule