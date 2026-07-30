:- begin_tests(determinism).

:- use_module('../prolog/qmsc_determinism').

test(deterministic_clause) :-
    IR = program([predicate(p/1, [clause(p(X), X=1, [])])]),
    infer_determinism(IR, [det(p/1, det)]).

test(nondeterministic_clause) :-
    IR = program([predicate(p/1, [clause(p(X), (X=1;X=2), [])])]),
    infer_determinism(IR, [det(p/1, nondet)]).

:- end_tests(determinism).
