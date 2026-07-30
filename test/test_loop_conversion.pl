:- begin_tests(loop_conversion).

:- use_module('../prolog/adapters/loop2_adapter').

test(findall_member_converts) :-
    loop2_convert(findall(X, member(X, [a,b]), Out), loop_member([a,b], Out)).

:- end_tests(loop_conversion).
