:- module(qmsc_effects, [
    classify_effects/2,
    goal_effect/2
]).

classify_effects(program(Predicates), Effects) :-
    findall(effect(Name/Arity, Effect),
        (member(predicate(Name/Arity, Clauses), Predicates),
         predicate_effect(Clauses, Effect)),
        Effects).

predicate_effect(Clauses, effectful) :-
    member(clause(_Head, Body, _), Clauses),
    body_goal(Body, Goal),
    goal_effect(Goal, effectful),
    !.
predicate_effect(_Clauses, pure).

body_goal((A, _), Goal) :- !, body_goal(A, Goal).
body_goal((_ ; B), Goal) :- !, body_goal(B, Goal).
body_goal(Goal, Goal).

goal_effect(Goal, effectful) :-
    callable(Goal),
    functor(Goal, F, A),
    memberchk(F/A, [write/1, writeln/1, format/2, assertz/1, retract/1, random/1]), !.
goal_effect(Goal, effectful) :-
    predicate_property(Goal, foreign), !.
goal_effect(_Goal, pure).
