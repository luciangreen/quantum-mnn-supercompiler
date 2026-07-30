:- module(quantum_measure, [
    measure_state/4
]).

measure_state(state(Qubits), deterministic, _Seed, measurement(Qubits, 1.0)).
measure_state(State, seeded, Seed, measurement(State, Probability)) :-
    set_random(seed(Seed)),
    random_float(Probability).
