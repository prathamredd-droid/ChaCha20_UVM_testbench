//==================== INTERFACE ====================
interface chacha20_if(input logic clk, input logic reset);
    logic [255:0] key;
    logic [95:0] nonce;
    logic [31:0] counter;
    logic [511:0] plaintext;
    logic [511:0] ciphertext;
    logic done;
endinterface
