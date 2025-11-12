//==================== RANDOMIZED SEQUENCE (10 TESTS) ====================
class chacha20_sequence extends uvm_sequence#(chacha20_transaction);
    `uvm_object_utils(chacha20_sequence)

    function new(string name = "chacha20_sequence");
        super.new(name);
    endfunction

    task body();
        chacha20_transaction tx;
        repeat (10) begin
            tx = chacha20_transaction::type_id::create("tx");
            start_item(tx);
            assert(tx.randomize());
            finish_item(tx);
            `uvm_info("SEQ", $sformatf("Random Test Completed"), UVM_LOW)
        end
        `uvm_info("SEQ", "All 10 randomized tests completed.", UVM_LOW)
    endtask
endclass
