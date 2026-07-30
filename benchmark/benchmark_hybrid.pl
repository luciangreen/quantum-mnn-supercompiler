:- module(benchmark_hybrid, [run_benchmark/1]).

:- use_module('../prolog/quantum/hybrid_planner').

run_benchmark(Report) :-
    select_hybrid_plan([pre], [gate(x, [0])], [post], [fallback(true)], Plan),
    Report = report{kind: hybrid, plan: Plan}.
