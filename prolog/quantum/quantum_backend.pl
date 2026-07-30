:- module(quantum_backend, [
    select_backend/4
]).

select_backend(_QubitCount, Options, reversible, backend_report(reversible, ok)) :-
    memberchk(backend(reversible), Options), !.
select_backend(QubitCount, Options, stabilizer, backend_report(stabilizer, ok)) :-
    memberchk(backend(stabilizer), Options), !,
    QubitCount =< 64.
select_backend(QubitCount, Options, sparse, backend_report(sparse, ok)) :-
    memberchk(backend(sparse), Options), !,
    option_or_default(max_qubits, Options, 24, Max),
    QubitCount =< Max.
select_backend(QubitCount, Options, dense_state_vector, backend_report(dense_state_vector, ok)) :-
    option_or_default(dense_max_qubits, Options, 20, MaxDense),
    QubitCount =< MaxDense,
    !.
select_backend(QubitCount, Options, sparse, backend_report(sparse, memory_safeguard)) :-
    option_or_default(max_qubits, Options, 24, MaxQ),
    QubitCount =< MaxQ,
    !.
select_backend(_QubitCount, _Options, reversible, backend_report(reversible, fallback)).

option_or_default(Key, Options, _Default, Value) :-
    Term =.. [Key, Value],
    memberchk(Term, Options), !.
option_or_default(_Key, _Options, Default, Default).
