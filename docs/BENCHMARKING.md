# Benchmarking

Run:

```bash
swipl -q -s benchmark/run_benchmarks.pl -g run_benchmarks -t halt
```

Reports include elapsed timing and backend/hybrid planning snapshots.

The repository's test suite is separate from benchmarks. Run all tests with:

```bash
swipl -q -s test/run_tests.pl -g run_tests -t halt
```

To run a single PlUnit group, pass its unit name, for example:

```bash
swipl -q -s test/run_tests.pl -g "run_tests([backends])" -t halt
```

Available groups are `ir`, `adapters`, `mnn`, `loop_conversion`,
`determinism`, `quantum_gates`, `quantum_rewrite`, `backends`, `hybrid`, and
`concurrency`. Timing results are environment-dependent and are not correctness
assertions.
