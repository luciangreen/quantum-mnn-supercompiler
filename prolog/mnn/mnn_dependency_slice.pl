:- module(mnn_dependency_slice, [
    backward_slice/3
]).

backward_slice(graph(Edges), Targets, Slice) :-
    backward_slice_(Edges, Targets, [], Slice0),
    sort(Slice0, Slice).

backward_slice_(_Edges, [], Seen, Seen).
backward_slice_(Edges, [Target|Rest], Seen, Slice) :-
    ( memberchk(Target, Seen) ->
        backward_slice_(Edges, Rest, Seen, Slice)
    ; findall(From, member(edge(From, Target), Edges), Preds),
      append(Preds, Rest, Next),
      backward_slice_(Edges, Next, [Target|Seen], Slice)
    ).
