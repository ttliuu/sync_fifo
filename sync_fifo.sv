module sync_fifo #(parameter WIDTH = 32, DEPTH = 16) (
    output logic [WIDTH-1:0] rdata,
    output logic             wfull,
    output logic             rempty,

    input [WIDTH-1:0] wdata,
    input             winc,
    input             rinc,
    input             clk, rst_n
);

    logic [DEPTH-1:0][WIDTH-1:0] ram;

    logic [$clog2(DEPTH)-1:0]    rptr, wptr;
    logic [$clog2(DEPTH):0]      cnt;


    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ram    <= '0;
            rptr   <= '0;
            wptr   <= '0;
            rdata  <= '0;
            cnt    <= '0;
        end else begin
            rdata <= ram[rptr];
            if (rinc && !rempty) begin
                rptr <= rptr + 1;
            end

            if (winc && !wfull) begin
                ram[wptr] <= wdata;
                wptr      <= wptr + 1;
            end

            case ({winc, rinc})
            2'b01: begin
                cnt <= cnt == 0 ? cnt : cnt - 1;
            end
            2'b10: begin
                cnt <= cnt == DEPTH ? cnt : cnt + 1;
            end
            default: begin
                cnt <= cnt;
            end
            endcase
        end
    end

    assign wfull  = (cnt == DEPTH) ? 1 : 0;
    assign rempty = (cnt == 0) ? 1 : 0;


endmodule