:- module(qmsc_modes, [
    infer_modes/2
]).

infer_modes(program(Predicates), Modes) :-
    findall(mode(Name/Arity, Signature),
        (member(predicate(Name/Arity, Clauses), Predicates),
         mode_signature(Clauses, Signature)),
        Modes).

mode_signature([clause(Head, _Body, _)|_], Signature) :-
    Head =.. [_|Args],
    maplist(arg_mode, Args, Signature).
mode_signature([], []).

arg_mode(Arg, in) :-
    nonvar(Arg), !.
arg_mode(_Arg, out).
