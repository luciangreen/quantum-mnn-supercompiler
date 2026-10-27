:- begin_tests(backends).

:- use_module('../prolog/quantum/quantum_backend').
:- use_module('../prolog/qmsc_api').

test(select_dense_backend) :-
    select_backend(3, [dense_max_qubits(20)], dense_state_vector, _).

test(simulate_reversible_backend) :-
    once(qmsc_simulate([gate(x, [0])], state([0]), [backend(reversible)], Result)),
    assertion(Result.backend == reversible),
    assertion(Result.state == state([1])),
    assertion(Result.measurement == measurement([1], 1.0)).

test(deterministic_measurement_supports_backend_results) :-
    once(qmsc_simulate([gate(x, [0])], state([0]), [backend(dense_state_vector)],
                       Result)),
    assertion(Result.measurement ==
              measurement(result(dense_state_vector,
                                [gate(x, [0])],
                                state([0])), 1.0)).

:- end_tests(backends).
