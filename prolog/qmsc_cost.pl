:- module(qmsc_cost, [
    estimate_cost/3
]).

estimate_cost(program(Predicates), Options, cost_report(Cost, Memory, Cardinality)) :-
    length(Predicates, PredCount),
    option_or_default(target_ms, Options, 50, TargetMs),
    option_or_default(memory_limit_mb, Options, 2048, Memory),
    Cost is PredCount * 10 + max(1, TargetMs // 10),
    Cardinality is PredCount * 100.

option_or_default(Key, Options, _Default, Value) :-
    Term =.. [Key, Value],
    memberchk(Term, Options), !.
option_or_default(_Key, _Options, Default, Default).
