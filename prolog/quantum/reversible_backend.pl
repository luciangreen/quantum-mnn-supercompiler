:- module(reversible_backend, [
    simulate_reversible/3
]).

:- use_module(quantum_gates).

simulate_reversible(Circuit, State0, State) :-
    foldl(apply_gate, Circuit, State0, State).
