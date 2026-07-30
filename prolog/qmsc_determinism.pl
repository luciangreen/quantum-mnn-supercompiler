:- module(qmsc_determinism, [
    infer_determinism/2
]).

infer_determinism(program(Predicates), Determinism) :-
    findall(det(Name/Arity, Class),
        (member(predicate(Name/Arity, Clauses), Predicates),
         classify_clauses(Clauses, Class)),
        Determinism).

classify_clauses([clause(_Head, Body, _)], det) :-
    deterministic_body(Body), !.
classify_clauses(_Clauses, nondet).

deterministic_body(true) :- !.
deterministic_body((A, B)) :- !,
    deterministic_body(A),
    deterministic_body(B).
deterministic_body((_A ; _B)) :- !, fail.
deterministic_body((_A -> _B ; _C)) :- !, fail.
deterministic_body(Goal) :-
    callable(Goal),
    \+ predicate_property(Goal, nondet).
