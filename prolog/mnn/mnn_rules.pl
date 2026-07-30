:- module(mnn_rules, [
    classify_rule/2
]).

classify_rule(rule(_PI, clause_count(1)), exact_constant_result).
classify_rule(rule(_PI, clause_count(Count)), decision_tree) :-
    Count > 1.
