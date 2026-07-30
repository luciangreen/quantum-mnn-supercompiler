:- begin_tests(quantum_rewrite).

:- use_module('../prolog/quantum/quantum_rewrite').

test(cancel_inverse_gates) :-
    Circuit = [gate(x, [0]), gate(x, [0]), gate(h, [1])],
    optimise_circuit(Circuit, Out, Trace),
    assertion(Out == [gate(h, [1])]),
    assertion(Trace \== []).

test(merge_rotations) :-
    Circuit = [gate(rx, [0], [1.0]), gate(rx, [0], [2.0])],
    optimise_circuit(Circuit, Out, _Trace),
    assertion(Out == [gate(rx, [0], [3.0])]).

:- end_tests(quantum_rewrite).
