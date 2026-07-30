:- module(qmsc_report, [
    make_stage_report/5,
    response_target_status/3
]).

make_stage_report(IR, Modes, Determinism, Backend, report{
    ir: IR,
    modes: Modes,
    determinism: Determinism,
    backend: Backend
}).

response_target_status(TargetMs, WarmMs, benchmark_confirmed) :-
    WarmMs =< TargetMs, !.
response_target_status(_TargetMs, _WarmMs, not_confirmed).
