:- module(hybrid_planner, [
    select_hybrid_plan/5
]).

select_hybrid_plan(ClassicalPrefix, QuantumKernel, ClassicalSuffix, Options, plan{
    prefix: ClassicalPrefix,
    kernel: QuantumKernel,
    suffix: ClassicalSuffix,
    backend: Backend,
    fallback: Fallback
}) :-
    option_or_default(fallback, Options, true, Fallback),
    kernel_qubits(QuantumKernel, Qubits),
    quantum_backend:select_backend(Qubits, Options, Backend, _).

kernel_qubits(Kernel, Qubits) :-
    is_list(Kernel),
    findall(Q,
        (member(gate(_, Qs), Kernel), member(Q, Qs)),
        QubitIdxs),
    ( QubitIdxs = [] -> Qubits = 0 ; max_list(QubitIdxs, Max), Qubits is Max + 1 ),
    !.
kernel_qubits(_, 0).

option_or_default(Key, Options, _Default, Value) :-
    Term =.. [Key, Value],
    memberchk(Term, Options), !.
option_or_default(_Key, _Options, Default, Default).

:- use_module(quantum_backend).
