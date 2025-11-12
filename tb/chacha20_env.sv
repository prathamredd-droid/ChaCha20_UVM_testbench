//==================== ENVIRONMENT ====================
class chacha20_env extends uvm_env;
    `uvm_component_utils(chacha20_env)
    chacha20_driver d;
    chacha20_monitor m;
    chacha20_scoreboard s;
    uvm_sequencer#(chacha20_transaction) q;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        d = chacha20_driver::type_id::create("d", this);
        m = chacha20_monitor::type_id::create("m", this);
        s = chacha20_scoreboard::type_id::create("s", this);
        q = uvm_sequencer#(chacha20_transaction)::type_id::create("q", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        d.seq_item_port.connect(q.seq_item_export);
        m.ap.connect(s.sb);
    endfunction
endclass
