:- begin_tests(adapters).

:- use_module('../prolog/adapters/s2a_adapter').
:- use_module('../prolog/adapters/starlog_adapter').
:- use_module('../prolog/adapters/loop2_adapter').
:- use_module('../prolog/adapters/plop_adapter').
:- use_module('../prolog/adapters/detlog_adapter').
:- use_module('../prolog/adapters/piglog2_adapter').

test(s2a_status_available) :-
    s2a_status([s2a(true)], diagnostic(available, _)).

test(starlog_eval) :-
    starlog_eval(X is 2+3, X=Expr),
    assertion(Expr == 2+3).

test(loop2_conversion) :-
    loop2_convert(findall(X, member(X, [1,2]), Out), loop_member([1,2], Out)).

test(plop_optimise) :-
    plop_optimise((R is 0 + A), (R is A)).

test(detlog_choice_packet) :-
    detlog_choice_packet([a,b], Packet),
    detlog_splice(Packet, 2, b).

test(piglog2_grouping) :-
    piglog2_group_safe([true, fail], concurrent([true, fail])).

:- end_tests(adapters).
