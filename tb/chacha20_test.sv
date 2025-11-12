//==================== TEST ====================
class chacha20_test extends uvm_test;
    `uvm_component_utils(chacha20_test)
    chacha20_env env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = chacha20_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        chacha20_sequence seq = new();
        phase.raise_objection(this);
        seq.start(env.q);
        phase.drop_objection(this);
    endtask
endclass
