:- begin_tests(hybrid).

:- use_module('../prolog/quantum/hybrid_planner').

test(select_plan) :-
    select_hybrid_plan([classical_pre], [gate(x, [0])], [classical_post], [fallback(true)], Plan),
    assertion(Plan.fallback == true).

:- end_tests(hybrid).
