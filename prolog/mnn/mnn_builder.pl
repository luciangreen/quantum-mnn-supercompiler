:- module(mnn_builder, [
    build_mnn_rules/2
]).

build_mnn_rules(program(Predicates), Rules) :-
    findall(rule(Name/Arity, clause_count(Count)),
        (member(predicate(Name/Arity, Clauses), Predicates),
         length(Clauses, Count)),
        Rules).
