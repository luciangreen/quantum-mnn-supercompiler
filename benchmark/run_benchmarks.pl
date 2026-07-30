:- module(run_benchmarks, [run_benchmarks/0]).

:- use_module(benchmark_classical, []).
:- use_module(benchmark_quantum, []).
:- use_module(benchmark_hybrid, []).

run_benchmarks :-
    benchmark_classical:run_benchmark(Classical),
    benchmark_quantum:run_benchmark(Quantum),
    benchmark_hybrid:run_benchmark(Hybrid),
    Reports = [Classical, Quantum, Hybrid],
    forall(member(Report, Reports), format("~q~n", [Report])).
