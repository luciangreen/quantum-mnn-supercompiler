:- module(qmsc_dependencies, [
    dependency_graph/2,
    variable_flow_graph/2
]).

dependency_graph(program(Predicates), graph(Edges)) :-
    findall(edge(From, To),
        (member(predicate(From, Clauses), Predicates),
         member(clause(_Head, Body, _), Clauses),
         body_call_pi(Body, To)),
        RawEdges),
    sort(RawEdges, Edges).

variable_flow_graph(program(Predicates), flow(Links)) :-
    findall(var_link(PI, Var),
        (member(predicate(PI, Clauses), Predicates),
         member(clause(Head, Body, _), Clauses),
         term_variables((Head :- Body), Vars),
         member(Var, Vars)),
        RawLinks),
    sort(RawLinks, Links).

body_call_pi((A, _), PI) :- !, body_call_pi(A, PI).
body_call_pi((_ ; B), PI) :- !, body_call_pi(B, PI).
body_call_pi(Goal, Name/Arity) :-
    callable(Goal),
    Goal \= true,
    functor(Goal, Name, Arity).
