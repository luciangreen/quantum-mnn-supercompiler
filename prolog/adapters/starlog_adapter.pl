:- module(starlog_adapter, [
    starlog_status/2,
    starlog_eval/2,
    starlog_to_ir/2,
    starlog_from_ir/2
]).

starlog_status(Options, diagnostic(Status, Message)) :-
    ( memberchk(starlog(false), Options) ->
        Status = disabled,
        Message = 'Starlog adapter disabled by option'
    ; Status = available,
      Message = 'Starlog adapter available'
    ).

starlog_eval(Result is no_eval(Expression), Result is no_eval(Expression)) :- !.
starlog_eval(Result is eval(Expression), Result = Value) :-
    Value is Expression, !.
starlog_eval(Result is Expression, Result = Expression).

starlog_to_ir(Expression, starlog(Expression)).
starlog_from_ir(starlog(Expression), Expression).
