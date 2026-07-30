:- begin_tests(concurrency).

:- use_module('../prolog/adapters/piglog2_adapter').

test(concurrency_group_safe) :-
    piglog2_group_safe([member(X, [1]), nonvar(X)], concurrent(_)).

:- end_tests(concurrency).
