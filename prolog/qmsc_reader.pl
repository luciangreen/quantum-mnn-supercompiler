:- module(qmsc_reader, [
    read_source_terms/2
]).

:- use_module(library(readutil)).

read_source_terms(File, TermsWithMeta) :-
    setup_call_cleanup(
        open(File, read, Stream),
        read_terms(Stream, File, 1, TermsWithMeta),
        close(Stream)
    ).

read_terms(Stream, File, ClauseIndex, TermsWithMeta) :-
    read_term(Stream, Term, [comments(_Comments), term_position(Pos)]),
    ( Term == end_of_file ->
        TermsWithMeta = []
    ; term_position_line(Pos, Line),
      Meta = [file(File), line(Line), clause_index(ClauseIndex)],
      TermsWithMeta = [term(Term, Meta)|Rest],
      Next is ClauseIndex + 1,
      read_terms(Stream, File, Next, Rest)
    ).

term_position_line(term_position(Line, _, _, _, _), Line) :- !.
term_position_line('$stream_position'(Line, _, _, _), Line) :- !.
term_position_line(_, 0).
