//==================== SCOREBOARD ====================
class chacha20_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(chacha20_scoreboard)
    uvm_analysis_imp#(chacha20_transaction, chacha20_scoreboard) sb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        sb = new("sb", this);
    endfunction

    function void write(chacha20_transaction tx);
        $display("\n================ CIPHERTEXT RESULT ================");
        $display(" Ciphertext : %h", tx.ciphertext);
        $display("===================================================\n");
    endfunction
endclass
