//==================== DRIVER ====================
class chacha20_driver extends uvm_driver#(chacha20_transaction);
    `uvm_component_utils(chacha20_driver)
    virtual chacha20_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual chacha20_if)::get(this,"","vif",vif))
            `uvm_fatal("DRV","No VIF Found")
    endfunction

    task run_phase(uvm_phase phase);
        chacha20_transaction tx;
        forever begin
            seq_item_port.get_next_item(tx);
            @(posedge vif.clk);
            wait(vif.done == 0);
            vif.key       = tx.key;
            vif.nonce     = tx.nonce;
            vif.counter   = tx.counter;
            vif.plaintext = tx.plaintext;
            wait(vif.done == 1);
            @(posedge vif.clk);
            tx.ciphertext = vif.ciphertext;
            seq_item_port.item_done();
        end
    endtask
endclass
