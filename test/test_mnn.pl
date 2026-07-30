:- begin_tests(mnn).

:- use_module('../prolog/mnn/mnn_builder').
:- use_module('../prolog/mnn/mnn_compress').
:- use_module('../prolog/mnn/mnn_dependency_slice').

program_ir(program([
    predicate(p/1, [clause(p(a), true, [])]),
    predicate(q/1, [clause(q(X), p(X), [])])
])).

test(build_rules) :-
    program_ir(IR),
    build_mnn_rules(IR, Rules),
    assertion(member(rule(p/1, clause_count(1)), Rules)).

test(compression_report) :-
    program_ir(IR),
    compress_program(IR, [], compression(_Rules, Classes)),
    assertion(member(exact_constant_result, Classes)).

test(backward_slice) :-
    Graph = graph([edge(p/1, q/1), edge(r/1, q/1)]),
    backward_slice(Graph, [q/1], Slice),
    assertion(member(p/1, Slice)).

:- end_tests(mnn).
