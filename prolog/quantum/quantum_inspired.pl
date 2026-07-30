:- module(quantum_inspired, [
    reorder_goals/2
]).

reorder_goals(Goals, Ordered) :-
    predsort(goal_compare, Goals, Ordered).

goal_compare(Order, A, B) :-
    term_score(A, SA),
    term_score(B, SB),
    compare(Order, SA, SB).

term_score(Term, Score) :-
    with_output_to(string(S), write_term(Term, [quoted(true)])),
    string_length(S, Score).
