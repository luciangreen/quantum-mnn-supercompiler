:- module(quantum_gates, [
    apply_gate/3,
    inverse_gate/2
]).

apply_gate(gate(x, [Q]), State0, State) :-
    flip_qubit(State0, Q, State), !.
apply_gate(gate(h, [Q]), State0, superposed(Q, State0)) :- !.
apply_gate(gate(z, [Q]), State0, phased(Q, State0)) :- !.
apply_gate(gate(cnot, [C, T]), State0, State) :-
    ( qubit_one(State0, C) -> flip_qubit(State0, T, State) ; State = State0 ),
    !.
apply_gate(gate(rx, [Q], [Theta]), State0, rotated(rx, Q, Theta, State0)) :- !.
apply_gate(gate(rz, [Q], [Theta]), State0, rotated(rz, Q, Theta, State0)) :- !.
apply_gate(_Gate, State, State).

inverse_gate(gate(x, Q), gate(x, Q)).
inverse_gate(gate(h, Q), gate(h, Q)).
inverse_gate(gate(z, Q), gate(z, Q)).
inverse_gate(gate(cnot, Q), gate(cnot, Q)).
inverse_gate(gate(rx, Q, [Theta]), gate(rx, Q, [NegTheta])) :- NegTheta is -Theta.
inverse_gate(gate(rz, Q, [Theta]), gate(rz, Q, [NegTheta])) :- NegTheta is -Theta.

flip_qubit(state(Qubits), Q, state(NewQubits)) :-
    same_length(Qubits, NewQubits),
    nth0(Q, Qubits, Old, Rest),
    toggle_bit(Old, New),
    nth0(Q, NewQubits, New, Rest).
flip_qubit(State, _Q, State).

toggle_bit(0, 1).
toggle_bit(1, 0).
toggle_bit(X, X).

qubit_one(state(Qubits), Q) :-
    nth0(Q, Qubits, 1), !.
qubit_one(_State, _Q) :- fail.
