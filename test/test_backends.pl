:- begin_tests(backends).

:- use_module('../prolog/quantum/quantum_backend').
:- use_module('../prolog/qmsc_api').

test(select_dense_backend) :-
    select_backend(3, [dense_max_qubits(20)], dense_state_vector, _).

test(simulate_reversible_backend) :-
    qmsc_simulate([gate(x, [0])], state([0]), [backend(reversible)], Result),
    assertion(Result.backend == reversible).

:- end_tests(backends).
