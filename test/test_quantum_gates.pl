:- begin_tests(quantum_gates).

:- use_module('../prolog/quantum/quantum_gates').

test(gate_inverse_property) :-
    State0 = state([0,1]),
    Gate = gate(x, [0]),
    inverse_gate(Gate, Inv),
    apply_gate(Gate, State0, State1),
    apply_gate(Inv, State1, State2),
    assertion(State2 == State0).

test(cnot_controlled_flip) :-
    apply_gate(gate(cnot, [0,1]), state([1,0]), state([1,1])).

:- end_tests(quantum_gates).
