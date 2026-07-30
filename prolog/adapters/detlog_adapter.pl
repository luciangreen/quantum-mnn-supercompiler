:- module(detlog_adapter, [
    detlog_status/2,
    detlog_choice_packet/2,
    detlog_splice/3,
    detlog_to_ir/2,
    detlog_from_ir/2
]).

detlog_status(Options, diagnostic(Status, Message)) :-
    ( memberchk(detlog(false), Options) ->
        Status = disabled,
        Message = 'Detlog adapter disabled by option'
    ; Status = available,
      Message = 'Detlog adapter available'
    ).

detlog_choice_packet(Choices, choice_packet(Choices)) :-
    is_list(Choices).

detlog_splice(choice_packet(Choices), Index, Choice) :-
    nth1(Index, Choices, Choice).

detlog_to_ir(Term, detlog(Term)).
detlog_from_ir(detlog(Term), Term).
