//==================== MONITOR ====================
class chacha20_monitor extends uvm_monitor;
    `uvm_component_utils(chacha20_monitor)
    virtual chacha20_if vif;
    uvm_analysis_port#(chacha20_transaction) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual chacha20_if)::get(this,"","vif",vif))
            `uvm_fatal("MON","No VIF Found")
    endfunction

    task run_phase(uvm_phase phase);
        chacha20_transaction tx;
        forever begin
            @(posedge vif.done);
            tx = new();
            tx.ciphertext = vif.ciphertext;
            ap.write(tx);
        end
    endtask
endclass
