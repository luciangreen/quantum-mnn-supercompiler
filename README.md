# quantum-mnn-supercompiler

Quantum-MNN Supercompiler is a SWI-Prolog source-to-source compiler and optimisation framework that integrates:

- MNN-style supercompression,
- S2A/Starlog/Loop2/PLOP/Detlog/Piglog2 adapter surfaces,
- restricted quantum-circuit simulation and rewriting,
- hybrid classical/quantum planning,
- verification, benchmarking, and showcase runners.

## Public API

The main API is exported from `qmsc.pl` via `prolog/qmsc_api.pl`:

- `qmsc_compile/2`, `qmsc_compile/3`
- `qmsc_compile_terms/3`
- `qmsc_run/2`, `qmsc_run/4`
- `qmsc_output_run/2`
- `qmsc_synthesise/5`
- `qmsc_compile_circuit/3`
- `qmsc_simulate/4`
- `qmsc_optimise_circuit/3`
- `qmsc_explain/3`
- `qmsc_benchmark/2`, `qmsc_benchmark_suite/2`
- `qmsc_showcase/0`, `qmsc_showcase/1`

## Commands

```bash
swipl -q -s test/run_tests.pl -g run_tests -t halt
swipl -q -s benchmark/run_benchmarks.pl -g run_benchmarks -t halt
swipl -q -s showcase/run_showcase.pl -g run_showcase -t halt
```
