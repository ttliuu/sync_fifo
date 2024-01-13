module sync_fifo #(parameter DEPTH=8, WIDTH=8) (
    input                       clk, rst,
    input                       write, read,
    input           [WIDTH-1:0] data_in,
    output logic    [WIDTH-1:0] data_out,
    output logic                full, empty
)

    logic [$clog2(DEPTH)-1:0]       head, tail;
    logic [DEPTH-1:0][WIDTH-1:0]    data;

    always_ff@(posedge clk) begin
        if (rst) begin
            data_out    <= 0;
            full        <= 0;
            empty       <= 1;
            head        <= 0;
            tail        <= 0;
        end else begin
            if (write & !full) begin
                data[head]  <= data_in;
                head        <= head + 1;
                empty       <= 0;
                full        <= (head == tail) ? 1 : 0;
            end
            if (read & !empty) begin
                data_out    <= data[tail];
                tail        <= tail + 1;
                full        <= 0;
                empty       <= (head == tail) ? 1 : 0;
            end
        end
    end
endmodule