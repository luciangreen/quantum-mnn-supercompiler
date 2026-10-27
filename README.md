# quantum-mnn-supercompiler

Quantum-MNN Supercompiler is a SWI-Prolog source-to-source compiler and optimisation framework that integrates:

- MNN-style supercompression,
- S2A/Starlog/Loop2/PLOP/Detlog/Piglog2 adapter surfaces,
- restricted quantum-circuit simulation and rewriting,
- hybrid classical/quantum planning,
- verification, benchmarking, and showcase runners.

## Features

The system includes a source reader and parser with source metadata, a shared IR,
six adapter surfaces, static analyses, MNN-style compression passes, quantum
circuit compilation and rewrite passes, bounded backend selection, hybrid
planning, verification/fallback reports, benchmarks, and ten showcase
applications. See [Feature guide](docs/FEATURES.md) for a feature-by-feature
overview, module references, current boundaries, and a status of remaining work.

The public predicates exported by `qmsc.pl` are documented in the
[API reference](docs/API_REFERENCE.md).

## Requirements and tests

Install SWI-Prolog (the repository is tested with its `swipl` command), then
run the complete PlUnit suite:

```bash
swipl -q -s test/run_tests.pl -g run_tests -t halt
```

Individual test groups can be run by replacing `run_tests` with
`run_tests([ir])`, using one of: `ir`, `adapters`, `mnn`, `loop_conversion`,
`determinism`, `quantum_gates`, `quantum_rewrite`, `backends`, `hybrid`, or
`concurrency`.

The other executable checks are:

```bash
swipl -q -s benchmark/run_benchmarks.pl -g run_benchmarks -t halt
swipl -q -s showcase/run_showcase.pl -g run_showcase -t halt
swipl -q -s prolog/qmsc_loader.pl -g load_qmsc_modules -t halt
```

See [Testing and benchmarks](docs/BENCHMARKING.md) and
[Troubleshooting](docs/TROUBLESHOOTING.md) for further guidance. No build
system or third-party Prolog libraries are required beyond SWI-Prolog.
