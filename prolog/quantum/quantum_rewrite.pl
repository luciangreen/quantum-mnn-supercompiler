:- module(quantum_rewrite, [
    optimise_circuit/3
]).

optimise_circuit(Circuit, Optimised, Trace) :-
    cancel_adjacent_inverses(Circuit, C1, T1),
    merge_rotations(C1, Optimised, T2),
    append(T1, T2, Trace).

cancel_adjacent_inverses([G1, G2|Rest], Out, [cancel(G1, G2)|Trace]) :-
    inverse_pair(G1, G2),
    !,
    cancel_adjacent_inverses(Rest, Out, Trace).
cancel_adjacent_inverses([G|Rest], [G|Out], Trace) :-
    cancel_adjacent_inverses(Rest, Out, Trace).
cancel_adjacent_inverses([], [], []).

inverse_pair(gate(x, Q), gate(x, Q)).
inverse_pair(gate(h, Q), gate(h, Q)).
inverse_pair(gate(z, Q), gate(z, Q)).
inverse_pair(gate(cnot, Q), gate(cnot, Q)).

merge_rotations([gate(rx, Q, [A]), gate(rx, Q, [B])|Rest],
    [gate(rx, Q, [C])|Out], [merge(rx, Q, A, B, C)|Trace]) :-
    C is A + B, !,
    merge_rotations(Rest, Out, Trace).
merge_rotations([gate(rz, Q, [A]), gate(rz, Q, [B])|Rest],
    [gate(rz, Q, [C])|Out], [merge(rz, Q, A, B, C)|Trace]) :-
    C is A + B, !,
    merge_rotations(Rest, Out, Trace).
merge_rotations([G|Rest], [G|Out], Trace) :-
    merge_rotations(Rest, Out, Trace).
merge_rotations([], [], []).
