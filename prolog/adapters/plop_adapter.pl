:- module(plop_adapter, [
    plop_status/2,
    plop_optimise/2,
    plop_to_ir/2,
    plop_from_ir/2
]).

plop_status(Options, diagnostic(Status, Message)) :-
    ( memberchk(plop(false), Options) ->
        Status = disabled,
        Message = 'PLOP adapter disabled by option'
    ; Status = available,
      Message = 'PLOP adapter available'
    ).

plop_optimise((X is A + 0), (X is A)) :- !.
plop_optimise((X is 0 + A), (X is A)) :- !.
plop_optimise(Term, Term).

plop_to_ir(Term, plop(Term)).
plop_from_ir(plop(Term), Term).
