//==================== TRANSACTION ====================
class chacha20_transaction extends uvm_sequence_item;
    rand bit [255:0] key;
    rand bit [95:0] nonce;
    rand bit [31:0] counter;
    rand bit [511:0] plaintext;
    bit [511:0] ciphertext;

    constraint key_not_zero { key != 0; }           
    constraint nonce_not_zero { nonce != 0; }
    constraint plaintext_not_zero { plaintext != 0; }

    function new(string name = "chacha20_transaction");
        super.new(name);
    endfunction

    `uvm_object_utils(chacha20_transaction)
endclass
