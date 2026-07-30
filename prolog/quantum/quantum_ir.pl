:- module(quantum_ir, [
    circuit_ir/2,
    validate_circuit/1
]).

circuit_ir(Circuit, circuit_ir(Circuit)) :-
    validate_circuit(Circuit).

validate_circuit(Circuit) :-
    is_list(Circuit),
    maplist(valid_gate, Circuit).

valid_gate(gate(Name, Qubits)) :-
    atom(Name),
    is_list(Qubits).
valid_gate(gate(Name, Qubits, Params)) :-
    atom(Name),
    is_list(Qubits),
    is_list(Params).
