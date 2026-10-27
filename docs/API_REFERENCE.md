# API Reference

Load the public API with `qmsc.pl`:

```prolog
:- use_module(qmsc).
```

`qmsc.pl` reexports the predicates from `prolog/qmsc_api.pl`. The exported
surface is:

| Predicate | Purpose |
|---|---|
| `qmsc_compile/2`, `qmsc_compile/3` | Read a Prolog source file, compile it through the pipeline, and write generated terms. The `/3` form accepts an options list. |
| `qmsc_compile_terms/3` | Compile an in-memory list of terms; returns generated terms and a report. |
| `qmsc_run/2`, `qmsc_run/4` | Compile a source file and call a goal; `/4` also accepts options and returns a run report. |
| `qmsc_output_run/2` | Run a source goal and print `done` after the run. |
| `qmsc_synthesise/5` | Generate an S2A synthesis candidate from a predicate name, examples, and options. |
| `qmsc_compile_circuit/3` | Compile a circuit to a kernel and compilation report. |
| `qmsc_simulate/4` | Select a bounded backend, simulate a circuit, and return backend, state, and measurement data. |
| `qmsc_optimise_circuit/3` | Optimise a circuit and return a rewrite trace. |
| `qmsc_explain/3` | Return the compression explanation for a predicate indicator. |
| `qmsc_benchmark/2`, `qmsc_benchmark_suite/2` | Time one callable scenario or a list of scenarios. |
| `qmsc_showcase/0`, `qmsc_showcase/1` | Run all showcase applications or one named application. |
| `qmsc_default_options/1` | Return the default compiler and backend option list. |

Example:

```prolog
?- qmsc_compile_terms([p(a)], Generated, Report).
```

Compiler options are Prolog terms such as `s2a(false)`,
`mnn_compression(false)`, `max_qubits(24)`, `dense_max_qubits(20)`,
`backend(sparse)`, `verify(differential)`, and `fallback(true)`. The default
list is defined by `qmsc_default_options/1`. Backend and simulation boundaries
are described in [Quantum simulation](QUANTUM_SIMULATION.md), and the
compilation stages in [Architecture](ARCHITECTURE.md).
