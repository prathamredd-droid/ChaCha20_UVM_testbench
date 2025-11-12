//==================== TOP MODULE ====================
module top;
    logic clk = 0;
    logic reset = 1;
    always #5 clk = ~clk;
    initial #20 reset = 0;

    chacha20_if ch_if(clk, reset);

    chacha20_ENCRYPTION dut(
        .clk(clk), .reset(reset),
        .key(ch_if.key), .nonce(ch_if.nonce),
        .counter(ch_if.counter), .plaintext(ch_if.plaintext),
        .ciphertext(ch_if.ciphertext), .done(ch_if.done)
    );

    initial begin
        uvm_config_db#(virtual chacha20_if)::set(null,"*","vif",ch_if);
        run_test("chacha20_test");
    end
endmodule
