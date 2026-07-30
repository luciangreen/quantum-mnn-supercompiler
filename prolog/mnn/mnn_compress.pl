:- module(mnn_compress, [
    compress_program/3,
    explain_compression/3
]).

:- use_module(mnn_builder).
:- use_module(mnn_rules).

compress_program(ProgramIR, _Options, compression(Rules, Classifications)) :-
    build_mnn_rules(ProgramIR, Rules),
    findall(Class,
        (member(Rule, Rules), classify_rule(Rule, Class)),
        Classifications).

explain_compression(PredicateIndicator, compression(_Rules, Classes), explanation(PredicateIndicator, Classes)).
