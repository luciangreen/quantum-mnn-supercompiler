:- module(benchmark_quantum, [run_benchmark/1]).

:- use_module('../prolog/qmsc_api').

run_benchmark(Report) :-
    Circuit = [gate(x, [0]), gate(x, [0])],
    qmsc_simulate(Circuit, state([0]), [backend(reversible)], Sim),
    Report = report{kind: quantum, simulation: Sim}.
