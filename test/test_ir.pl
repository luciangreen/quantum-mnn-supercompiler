:- begin_tests(ir).

:- use_module('../prolog/qmsc_ir').
:- use_module('../prolog/qmsc_source_map').

test(round_trip) :-
    Terms = [
        term((p(a) :- q(a)), [file('x.pl'), line(1)]),
        term(q(a), [file('x.pl'), line(2)])
    ],
    terms_to_ir(Terms, IR),
    ir_to_terms(IR, Out),
    assertion(Out == [(p(a):-q(a)), q(a)]).

test(source_map_retained) :-
    Clauses = [
        clause(p(a), true, [file('x.pl'), line(10)]),
        clause(q(a), true, [file('x.pl'), line(11)])
    ],
    source_map_from_clauses(Clauses, Map),
    assertion(Map == [source(1, 'x.pl', 10), source(2, 'x.pl', 11)]).

:- end_tests(ir).
