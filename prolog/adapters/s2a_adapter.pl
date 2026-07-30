:- module(s2a_adapter, [
    s2a_status/2,
    s2a_synthesise/4,
    s2a_to_ir/2,
    s2a_from_ir/2
]).

s2a_status(Options, diagnostic(Status, Message)) :-
    ( memberchk(s2a(false), Options) ->
        Status = disabled,
        Message = 'S2A adapter disabled by option'
    ; Status = available,
      Message = 'S2A adapter running in built-in mode'
    ).

s2a_synthesise(PredicateName, Examples, _Options, [Clause]) :-
    Clause =.. [PredicateName, input(Examples), output(generated)].

s2a_to_ir(Examples, s2a_examples(Examples)).
s2a_from_ir(s2a_examples(Examples), Examples).
