:- module(qmsc_source_map, [
    source_map_from_clauses/2,
    source_location/4
]).

source_map_from_clauses(Clauses, Map) :-
    findall(source(Index, File, Line),
        (nth1(Index, Clauses, clause(_, _, Meta)),
         source_location(Meta, File, Line, _Column)),
        Map).

source_location(Meta, File, Line, Column) :-
    memberchk(file(File), Meta), !,
    ( memberchk(line(Line), Meta) -> true ; Line = 0 ),
    ( memberchk(column(Column), Meta) -> true ; Column = 0 ).
source_location(_Meta, '<memory>', 0, 0).
