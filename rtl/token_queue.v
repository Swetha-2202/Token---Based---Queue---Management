module token_queue (
    input  wire       clk,
    input  wire       reset,
    input  wire       btnU,
    input  wire       btnR,
    output wire [7:0] led
);
 
    reg [3:0] last_token;
    reg [3:0] serving_token;
 
    reg btnU_prev;
    reg btnR_prev;
 
    always @(posedge clk) begin
        if (reset) begin
            last_token    <= 4'd0;
            serving_token <= 4'd0;
            btnU_prev     <= 1'b0;
            btnR_prev     <= 1'b0;
        end
        else begin
            btnU_prev <= btnU;
            btnR_prev <= btnR;
 
            // Generate a token on a new BTNU press.
            if (btnU && !btnU_prev && (last_token < 4'd15))
                last_token <= last_token + 1'b1;
 
            // Call the next customer only if one is waiting.
            if (btnR && !btnR_prev &&
                (serving_token < last_token))
                serving_token <= serving_token + 1'b1;
        end
    end
 
    // Upper nibble: last generated token.
    // Lower nibble: current serving token.
    assign led = {last_token, serving_token};
 
endmodule
