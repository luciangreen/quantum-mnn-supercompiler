:- module(showcase, [
    run_showcase/0,
    run_showcase/1
]).

:- use_module(boolean_constraints, []).
:- use_module(travelling_salesperson, []).
:- use_module(symbolic_algebra, []).
:- use_module(academy_scheduler, []).
:- use_module(argument_mapper, []).
:- use_module(music_patterns, []).
:- use_module(query_planner, []).
:- use_module(circuit_simplifier, []).
:- use_module(grover_demo, []).
:- use_module(hot_query_demo, []).

run_showcase :-
    forall(showcase_name(Name), run_showcase(Name)).

run_showcase(Name) :-
    showcase_report(Name, Report),
    format("~w: ~q~n", [Name, Report]).

showcase_name(boolean_constraints).
showcase_name(travelling_salesperson).
showcase_name(symbolic_algebra).
showcase_name(academy_scheduler).
showcase_name(argument_mapper).
showcase_name(music_patterns).
showcase_name(query_planner).
showcase_name(circuit_simplifier).
showcase_name(grover_demo).
showcase_name(hot_query_demo).

showcase_report(boolean_constraints, Report) :-
    showcase_boolean_constraints:showcase_case(boolean_constraints, Report).
showcase_report(travelling_salesperson, Report) :-
    showcase_tsp:showcase_case(travelling_salesperson, Report).
showcase_report(symbolic_algebra, Report) :-
    showcase_symbolic_algebra:showcase_case(symbolic_algebra, Report).
showcase_report(academy_scheduler, Report) :-
    showcase_academy_scheduler:showcase_case(academy_scheduler, Report).
showcase_report(argument_mapper, Report) :-
    showcase_argument_mapper:showcase_case(argument_mapper, Report).
showcase_report(music_patterns, Report) :-
    showcase_music_patterns:showcase_case(music_patterns, Report).
showcase_report(query_planner, Report) :-
    showcase_query_planner:showcase_case(query_planner, Report).
showcase_report(circuit_simplifier, Report) :-
    showcase_circuit_simplifier:showcase_case(circuit_simplifier, Report).
showcase_report(grover_demo, Report) :-
    showcase_grover_demo:showcase_case(grover_demo, Report).
showcase_report(hot_query_demo, Report) :-
    showcase_hot_query_demo:showcase_case(hot_query_demo, Report).
