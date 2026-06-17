module accelerator_fsm (
    input  logic clk,
    input  logic rst,
    output logic done
);

    logic [2:0] state;

    localparam IDLE    = 3'd0;
    localparam COMPUTE = 3'd1;
    localparam STORE   = 3'd2;
    localparam NEXT    = 3'd3;
    localparam DONE    = 3'd4;

    logic [2:0] row;
    logic [2:0] col;
    logic [5:0] out_index;

    logic signed [31:0] sum;
    logic signed [31:0] output_mem [0:35];

    logic signed [7:0] w1, w2, w3;
    logic signed [7:0] w4, w5, w6;
    logic signed [7:0] w7, w8, w9;

    assign w1 = -8'sd1;
    assign w2 =  8'sd0;
    assign w3 =  8'sd1;

    assign w4 = -8'sd2;
    assign w5 =  8'sd0;
    assign w6 =  8'sd2;

    assign w7 = -8'sd1;
    assign w8 =  8'sd0;
    assign w9 =  8'sd1;

    top_convol datapath (
        .row(row),
        .col(col),

        .w1(w1), .w2(w2), .w3(w3),
        .w4(w4), .w5(w5), .w6(w6),
        .w7(w7), .w8(w8), .w9(w9),

        .clk(clk),
        .rst(rst),
        .sum(sum)
    );

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            state     <= IDLE;
            row       <= 3'd0;
            col       <= 3'd0;
            out_index <= 6'd0;
            done      <= 1'b0;

        end

        else begin

            case (state)

                IDLE: begin

                    row       <= 3'd0;
                    col       <= 3'd0;
                    out_index <= 6'd0;
                    done      <= 1'b0;

                    state <= COMPUTE;

                end

                COMPUTE: begin

                    state <= STORE;

                end

                STORE: begin

                    output_mem[out_index] <= sum;

                    state <= NEXT;

                end

                NEXT: begin

                    if (out_index == 6'd35) begin

                        done  <= 1'b1;
                        state <= DONE;

                    end

                    else begin

                        out_index <= out_index + 1;

                        if (col == 3'd5) begin

                            col <= 3'd0;
                            row <= row + 1;

                        end

                        else begin

                            col <= col + 1;

                        end

                        state <= COMPUTE;

                    end

                end

                DONE: begin

                    done <= 1'b1;
                    state <= DONE;

                end

                default: begin

                    state <= IDLE;

                end

            endcase

        end

    end

endmodule