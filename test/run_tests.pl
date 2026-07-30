:- module(run_tests, [run_tests/0]).

:- use_module(library(plunit), []).
:- ensure_loaded(test_ir).
:- ensure_loaded(test_adapters).
:- ensure_loaded(test_mnn).
:- ensure_loaded(test_loop_conversion).
:- ensure_loaded(test_determinism).
:- ensure_loaded(test_quantum_gates).
:- ensure_loaded(test_quantum_rewrite).
:- ensure_loaded(test_backends).
:- ensure_loaded(test_hybrid).
:- ensure_loaded(test_concurrency).

run_tests :-
    plunit:run_tests([ir, adapters, mnn, loop_conversion, determinism, quantum_gates,
                      quantum_rewrite, backends, hybrid, concurrency]).
