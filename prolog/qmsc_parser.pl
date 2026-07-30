:- module(qmsc_parser, [
    parse_terms/2,
    parse_file/2,
    parse_circuit/2
]).

:- use_module(qmsc_reader).
:- use_module(qmsc_ir).
:- use_module(library(error)).

parse_terms(TermsWithMeta, IR) :-
    safe_terms(TermsWithMeta, Filtered),
    terms_to_ir(Filtered, IR).

parse_file(File, IR) :-
    read_source_terms(File, TermsWithMeta),
    parse_terms(TermsWithMeta, IR).

parse_circuit(CircuitTerm, circuit(Gates)) :-
    ( CircuitTerm = circuit(Gates0) -> Gates = Gates0 ; Gates = CircuitTerm ),
    must_be(list, Gates),
    maplist(valid_gate, Gates).

safe_terms(TermsWithMeta, Filtered) :-
    exclude(unsupported_term, TermsWithMeta, Filtered).

unsupported_term(term((:- Directive), _)) :-
    unsupported_directive(Directive).
unsupported_term(_Term) :- fail.

unsupported_directive(use_module(_)).
unsupported_directive(include(_)).

valid_gate(gate(Name, Qubits)) :-
    atom(Name),
    is_list(Qubits).
valid_gate(gate(Name, Qubits, Params)) :-
    atom(Name),
    is_list(Qubits),
    is_list(Params).
