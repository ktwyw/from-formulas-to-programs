module counter4 (
    input  wire       clk,      // clock
    input  wire       reset,    // synchronous reset
    output reg  [3:0] count     // 4-bit output: 0 ... 15
);
    always @(posedge clk) begin // on every rising edge of the clock
        if (reset)
            count <= 4'b0000;
        else
            count <= count + 1; // wraps from 15 back to 0
    end
endmodule
