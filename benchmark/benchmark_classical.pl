:- module(benchmark_classical, [run_benchmark/1]).

:- use_module(benchmark_utils).

run_benchmark(Report) :-
    benchmark_call(member(3, [1,2,3,4]), Report).
