:- module(qmsc_api, [
    qmsc_compile/2,
    qmsc_compile/3,
    qmsc_compile_terms/3,
    qmsc_run/2,
    qmsc_run/4,
    qmsc_output_run/2,
    qmsc_synthesise/5,
    qmsc_compile_circuit/3,
    qmsc_simulate/4,
    qmsc_optimise_circuit/3,
    qmsc_explain/3,
    qmsc_benchmark/2,
    qmsc_benchmark_suite/2,
    qmsc_showcase/0,
    qmsc_showcase/1,
    qmsc_default_options/1
]).

:- use_module(qmsc_reader).
:- use_module(qmsc_parser).
:- use_module(qmsc_ir).
:- use_module(qmsc_pipeline).
:- use_module(qmsc_report).
:- use_module('adapters/s2a_adapter').
:- use_module('quantum/quantum_backend').
:- use_module('quantum/reversible_backend').
:- use_module('quantum/stabilizer_backend').
:- use_module('quantum/sparse_backend').
:- use_module('quantum/state_vector_backend').
:- use_module('quantum/quantum_measure').
:- use_module('quantum/quantum_rewrite').
:- use_module('mnn/mnn_compress').
:- use_module('../showcase/run_showcase').

qmsc_compile(InputFile, OutputFile) :-
    qmsc_default_options(Options),
    qmsc_compile(InputFile, OutputFile, Options).

qmsc_compile(InputFile, OutputFile, Options) :-
    read_source_terms(InputFile, TermsWithMeta),
    compile_terms_pipeline(TermsWithMeta, Options, GeneratedTerms, Report),
    setup_call_cleanup(
        open(OutputFile, write, Stream),
        write_generated_terms(Stream, GeneratedTerms, Report),
        close(Stream)
    ).

qmsc_compile_terms(Terms, GeneratedTerms, Report) :-
    qmsc_default_options(Options),
    normalise_terms(Terms, TermsWithMeta),
    compile_terms_pipeline(TermsWithMeta, Options, GeneratedTerms, Report).

qmsc_run(SourceFile, Goal) :-
    qmsc_default_options(Options),
    qmsc_run(SourceFile, Goal, Options, _Report).

qmsc_run(SourceFile, Goal, Options, Report) :-
    qmsc_compile(SourceFile, '/tmp/qmsc_generated.pl', Options),
    ensure_loaded('/tmp/qmsc_generated.pl'),
    ( call(Goal) ->
        Report = run_report(success, no_fallback)
    ; Report = run_report(failure, fallback_required)
    ).

qmsc_output_run(SourceFile, Goal) :-
    qmsc_run(SourceFile, Goal),
    writeln(done).

qmsc_synthesise(PredicateName, Examples, Options, Program, Report) :-
    s2a_synthesise(PredicateName, Examples, Options, Program),
    Report = synthesis_report(candidate_generated).

qmsc_compile_circuit(Circuit, Kernel, Report) :-
    qmsc_default_options(Options),
    compile_circuit_pipeline(Circuit, Options, Kernel, Report).

qmsc_simulate(Circuit, InitialState, Options, Result) :-
    circuit_qubits(Circuit, QubitCount),
    select_backend(QubitCount, Options, Backend, BackendReport),
    run_backend(Backend, Circuit, InitialState, Sim),
    measurement_policy(Options, Policy),
    measurement_seed(Options, Seed),
    measure_state(InitialState, Policy, Seed, Measurement),
    Result = simulation{
        backend: Backend,
        backend_report: BackendReport,
        state: Sim,
        measurement: Measurement
    }.

qmsc_optimise_circuit(Circuit, OptimisedCircuit, RewriteTrace) :-
    optimise_circuit(Circuit, OptimisedCircuit, RewriteTrace).

qmsc_explain(_Source, PredicateIndicator, Explanation) :-
    explain_compression(PredicateIndicator, compression([], [claimed]), Explanation).

qmsc_benchmark(Scenario, Report) :-
    get_time(T0),
    call(Scenario),
    get_time(T1),
    ElapsedMs is round((T1 - T0) * 1000),
    response_target_status(50, ElapsedMs, TargetStatus),
    Report = benchmark{
        scenario: Scenario,
        warm_query_ms: ElapsedMs,
        target_status: TargetStatus
    }.

qmsc_benchmark_suite(Suite, Reports) :-
    findall(Report,
        (member(Scenario, Suite), qmsc_benchmark(Scenario, Report)),
        Reports).

qmsc_showcase :-
    showcase:run_showcase.

qmsc_showcase(Application) :-
    showcase:run_showcase(Application).

qmsc_default_options([
    s2a(true),
    starlog(true),
    mnn_compression(true),
    loop2(true),
    plop(true),
    quantum(true),
    detlog(true),
    piglog2(true),
    target_ms(50),
    compile_budget_ms(60000),
    max_qubits(24),
    dense_max_qubits(20),
    sparse_state_limit(100000),
    memory_limit_mb(2048),
    max_threads(4),
    backend(auto),
    verify(differential),
    fallback(true),
    trace(summary),
    emit_ir(false),
    emit_code(true),
    benchmark(true)
]).

normalise_terms([], []).
normalise_terms([term(Term, Meta)|Rest], [term(Term, Meta)|Out]) :- !,
    normalise_terms(Rest, Out).
normalise_terms([Term|Rest], [term(Term, [file('<memory>'), line(0)])|Out]) :-
    normalise_terms(Rest, Out).

write_generated_terms(Stream, GeneratedTerms, Report) :-
    forall(member(Term, GeneratedTerms), portray_clause(Stream, Term)),
    format(Stream, '% report: ~q~n', [Report]).

circuit_qubits(Circuit, Qubits) :-
    findall(Q,
        (member(Gate, Circuit),
         gate_qubits(Gate, Indexes),
         member(Q, Indexes)),
        Idxs),
    ( Idxs = [] -> Qubits = 0 ; max_list(Idxs, Max), Qubits is Max + 1 ).

gate_qubits(gate(_, Indexes), Indexes).
gate_qubits(gate(_, Indexes, _), Indexes).

run_backend(reversible, Circuit, State0, State) :-
    simulate_reversible(Circuit, State0, State), !.
run_backend(stabilizer, Circuit, State0, State) :-
    simulate_stabilizer(Circuit, State0, State), !.
run_backend(sparse, Circuit, State0, State) :-
    simulate_sparse(Circuit, State0, State), !.
run_backend(dense_state_vector, Circuit, State0, State) :-
    simulate_state_vector(Circuit, State0, State), !.
run_backend(_, Circuit, State0, State) :-
    simulate_reversible(Circuit, State0, State).

measurement_policy(Options, Policy) :-
    ( memberchk(measurement(Policy), Options) -> true ; Policy = deterministic ).

measurement_seed(Options, Seed) :-
    ( memberchk(seed(Seed), Options) -> true ; Seed = 12345 ).
