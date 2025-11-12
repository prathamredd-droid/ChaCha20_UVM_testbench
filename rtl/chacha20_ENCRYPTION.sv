`timescale 1ns/1ps

module chacha20_ENCRYPTION (
    input wire clk,
    input wire reset,
    input wire [255:0] key,
    input wire [95:0] nonce,
    input wire [31:0] counter,
    input wire [511:0] plaintext,
    output reg [511:0] ciphertext,
    output reg done
);

    reg [31:0] state [0:15];
    reg [4:0] round_counter;
    reg busy;

    localparam [31:0] C0 = 32'h61707865;
    localparam [31:0] C1 = 32'h3320646e;
    localparam [31:0] C2 = 32'h79622d32;
    localparam [31:0] C3 = 32'h6b206574;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
            busy <= 0;
            round_counter <= 0;
            ciphertext <= 0;
        end else begin
            if (done)
                done <= 0;

            if (!busy && !done) begin
                state[0]  <= C0;
                state[1]  <= C1;
                state[2]  <= C2;
                state[3]  <= C3;
                state[4]  <= key[255:224];
                state[5]  <= key[223:192];
                state[6]  <= key[191:160];
                state[7]  <= key[159:128];
                state[8]  <= key[127:96];
                state[9]  <= key[95:64];
                state[10] <= key[63:32];
                state[11] <= key[31:0];
                state[12] <= counter;
                state[13] <= nonce[95:64];
                state[14] <= nonce[63:32];
                state[15] <= nonce[31:0];
                busy <= 1;
                round_counter <= 0;
            end else if (busy) begin
                round_counter <= round_counter + 1;

                state[0]  <= state[0] + state[4];
                state[12] <= state[12] ^ state[0];
                state[8]  <= state[8] + state[12];
                state[4]  <= state[4] ^ state[8];

                if (round_counter >= 20) begin
                    ciphertext <= plaintext ^ {state[0],state[1],state[2],state[3],
                                               state[4],state[5],state[6],state[7],
                                               state[8],state[9],state[10],state[11],
                                               state[12],state[13],state[14],state[15]};
                    done <= 1;
                    busy <= 0;
                end
            end
        end
    end
endmodule
