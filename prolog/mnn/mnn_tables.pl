:- module(mnn_tables, [
    build_lookup_table/2
]).

build_lookup_table(Clauses, table(Pairs)) :-
    findall(Key-Value,
        (member(clause(Head, Body, _Meta), Clauses),
         Head =.. [_|Args],
         Key = Args,
         Value = Body),
        Pairs).
