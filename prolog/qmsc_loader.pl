:- module(qmsc_loader, [
    load_qmsc_modules/0
]).

:- use_module(qmsc_api).
:- use_module(qmsc_reader).
:- use_module(qmsc_parser).
:- use_module(qmsc_ir).
:- use_module(qmsc_source_map).
:- use_module(qmsc_modes).
:- use_module(qmsc_determinism).
:- use_module(qmsc_effects).
:- use_module(qmsc_dependencies).
:- use_module(qmsc_cost).
:- use_module(qmsc_pipeline).
:- use_module(qmsc_report).
:- use_module(qmsc_verify).

load_qmsc_modules.
