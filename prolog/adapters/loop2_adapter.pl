:- module(loop2_adapter, [
    loop2_status/2,
    loop2_convert/2,
    loop2_to_ir/2,
    loop2_from_ir/2
]).

loop2_status(Options, diagnostic(Status, Message)) :-
    ( memberchk(loop2(false), Options) ->
        Status = disabled,
        Message = 'Loop2 adapter disabled by option'
    ; Status = available,
      Message = 'Loop2 adapter available'
    ).

loop2_convert(findall(X, member(X, List), Out), loop_member(List, Out)) :- !.
loop2_convert(Term, Term).

loop2_to_ir(Term, loop2(Term)).
loop2_from_ir(loop2(Term), Term).
