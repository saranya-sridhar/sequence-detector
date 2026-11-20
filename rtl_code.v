module sequence_detector(
    input wire clk,
    input wire reset,
    input wire stream_in,
    input wire [3:0] target_pattern,
    output reg detected
);
    reg [3:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0000;
            detected <= 1'b0;
        end else begin
            // Shift in the new bit from the right
            shift_reg <= {shift_reg[2:0], stream_in};
            
            // Compare shifted data with target pattern
            if ({shift_reg[2:0], stream_in} == target_pattern)
                detected <= 1'b1;
            else
                detected <= 1'b0;
        end
    end
endmodule
