:- module(benchmark_utils, [
    benchmark_call/2
]).

benchmark_call(Goal, report{goal: Goal, elapsed_ms: Elapsed}) :-
    get_time(T0),
    call(Goal),
    get_time(T1),
    Elapsed is round((T1 - T0) * 1000).
