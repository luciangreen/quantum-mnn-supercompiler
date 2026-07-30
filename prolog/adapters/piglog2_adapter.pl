:- module(piglog2_adapter, [
    piglog2_status/2,
    piglog2_group_safe/2,
    piglog2_to_ir/2,
    piglog2_from_ir/2
]).

piglog2_status(Options, diagnostic(Status, Message)) :-
    ( memberchk(piglog2(false), Options) ->
        Status = disabled,
        Message = 'Piglog2 adapter disabled by option'
    ; Status = available,
      Message = 'Piglog2 adapter available'
    ).

piglog2_group_safe(Goals, concurrent(Goals)) :-
    is_list(Goals),
    maplist(callable, Goals).

piglog2_to_ir(Term, piglog2(Term)).
piglog2_from_ir(piglog2(Term), Term).
