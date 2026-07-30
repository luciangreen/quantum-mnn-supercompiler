:- module(quantum_circuit, [
    compile_circuit/3
]).

:- use_module(quantum_ir).

compile_circuit(Circuit, kernel{
    gates: Circuit,
    gate_count: GateCount,
    depth: Depth
}, report{valid: true}) :-
    validate_circuit(Circuit),
    length(Circuit, GateCount),
    Depth = GateCount.
