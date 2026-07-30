:- module(mnn_decision_tree, [
    build_decision_tree/2
]).

build_decision_tree(Clauses, tree(Branches)) :-
    findall(branch(Index, Head),
        nth1(Index, Clauses, clause(Head, _Body, _Meta)),
        Branches).
