:- module(mnn_hotlist, [
    hot_query_specialise/3
]).

hot_query_specialise(ProgramIR, HotQueries, hot_program(ProgramIR, HotQueries)).
