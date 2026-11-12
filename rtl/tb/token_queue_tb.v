`timescale 1ns/1ps

module tb_token_queue;

    reg clk;
    reg reset;
    reg btnU;
    reg btnR;
    wire [7:0] led;

    token_queue dut (
        .clk(clk),
        .reset(reset),
        .btnU(btnU),
        .btnR(btnR),
        .led(led)
    );

    // 100 MHz clock: 10 ns period.
    always #5 clk = ~clk;

    task press_generate;
        begin
            btnU = 1'b1;
            @(posedge clk);
            @(posedge clk);
            btnU = 1'b0;
            @(posedge clk);
        end
    endtask

    task press_next;
        begin
            btnR = 1'b1;
            @(posedge clk);
            @(posedge clk);
            btnR = 1'b0;
            @(posedge clk);
        end
    endtask

    task check_state;
        input [3:0] expected_last;
        input [3:0] expected_serving;
        begin
            if (dut.last_token !== expected_last ||
                dut.serving_token !== expected_serving ||
                led !== {expected_last, expected_serving}) begin

                $display("FAIL: last=%0d serving=%0d led=%b",
                         dut.last_token, dut.serving_token, led);

                $fatal(1, "Unexpected queue state");
            end
        end
    endtask

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        btnU = 1'b0;
        btnR = 1'b0;

        repeat (2) @(posedge clk);
        reset = 1'b0;
        @(posedge clk);

        check_state(4'd0, 4'd0);

        // Generate three tokens.
        press_generate();
        press_generate();
        press_generate();

        check_state(4'd3, 4'd0);

        // Serve two customers.
        press_next();
        press_next();

        check_state(4'd3, 4'd2);

        // One additional token is generated.
        press_generate();

        check_state(4'd4, 4'd2);

        // Complete service.
        press_next();
        press_next();

        check_state(4'd4, 4'd4);

        // Calling again must not advance serving_token.
        press_next();

        check_state(4'd4, 4'd4);

        // Generate until the token limit is reached.
        repeat (20) press_generate();

        check_state(4'd15, 4'd4);

        $display("PASS: all token queue checks completed");
        $display("Final last_token = %0d", dut.last_token);
        $display("Final serving_token = %0d", dut.serving_token);
        $display("LED output = %b", led);

        $finish;
    end

endmodule
