:- module(qmsc_pipeline, [
    compile_terms_pipeline/4,
    compile_circuit_pipeline/4
]).

:- use_module(qmsc_parser).
:- use_module(qmsc_ir).
:- use_module(qmsc_modes).
:- use_module(qmsc_determinism).
:- use_module(qmsc_dependencies).
:- use_module(qmsc_cost).
:- use_module(qmsc_report).
:- use_module(qmsc_verify).
:- use_module('adapters/s2a_adapter').
:- use_module('adapters/starlog_adapter').
:- use_module('adapters/loop2_adapter').
:- use_module('adapters/plop_adapter').
:- use_module('adapters/detlog_adapter').
:- use_module('adapters/piglog2_adapter').
:- use_module('mnn/mnn_compress').
:- use_module('quantum/quantum_circuit').
:- use_module('quantum/quantum_rewrite').
:- use_module('quantum/hybrid_planner').

compile_terms_pipeline(TermsWithMeta, Options, GeneratedTerms, Report) :-
    parse_terms(TermsWithMeta, IR),
    infer_modes(IR, Modes),
    infer_determinism(IR, Determinism),
    dependency_graph(IR, DepGraph),
    estimate_cost(IR, Options, Cost),
    compress_program(IR, Options, Compression),
    qmsc_ir:ir_to_terms(IR, GeneratedTerms),
    diagnostics(Options, Diagnostics),
    verify_mode(Options, VerifyMode),
    verify_equivalence(GeneratedTerms, GeneratedTerms, VerifyMode, Verification),
    make_stage_report(IR, Modes, Determinism, classical, StageReport),
    Report = report{
        stage_report: StageReport,
        dependencies: DepGraph,
        cost: Cost,
        compression: Compression,
        diagnostics: Diagnostics,
        verification: Verification
    }.

compile_circuit_pipeline(Circuit, Options, Kernel, Report) :-
    compile_circuit(Circuit, Kernel0, BaseReport),
    optimise_circuit(Circuit, Optimised, RewriteTrace),
    select_hybrid_plan([], Optimised, [], Options, Plan),
    Kernel = Kernel0.put(_{gates: Optimised}),
    Report = report{
        circuit: BaseReport,
        rewrite_trace: RewriteTrace,
        plan: Plan
    }.

diagnostics(Options, Diagnostics) :-
    s2a_status(Options, S2A),
    starlog_status(Options, Starlog),
    loop2_status(Options, Loop2),
    plop_status(Options, PLOP),
    detlog_status(Options, Detlog),
    piglog2_status(Options, Piglog2),
    Diagnostics = [S2A, Starlog, Loop2, PLOP, Detlog, Piglog2].

verify_mode(Options, VerifyTerm) :-
    ( memberchk(verify(Level), Options) -> VerifyTerm = verify(Level) ; VerifyTerm = verify(differential) ).
