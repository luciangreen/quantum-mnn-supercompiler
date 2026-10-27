# Feature guide and implementation status

This repository is an early, staged SWI-Prolog implementation. “Available” below
means the surface is present and wired into the project; it does not imply
production-grade compiler optimisations, a full external-system integration, or
physical quantum simulation.

## Implemented surfaces

| Feature | What is available | Details |
|---|---|---|
| Source input and IR | File/in-memory term input, source file/line metadata, shared predicate/clause IR, and IR-to-term emission. | [Architecture](ARCHITECTURE.md), [IR](IR.md) |
| Adapters | Status/diagnostic modules for S2A, Starlog, Loop2, PLOP, Detlog, and Piglog2, including selected helper surfaces and safe grouping. | `prolog/adapters/`; covered by `test_adapters` and `test_concurrency` |
| Static analysis | Mode, determinism, effects, dependency, and cost analysis modules. | `prolog/qmsc_modes.pl`, `qmsc_determinism.pl`, `qmsc_effects.pl`, `qmsc_dependencies.pl`, `qmsc_cost.pl` |
| MNN compression | Compression entry points, rule extraction, labels, dependency slicing, tables, decision trees, templates, hotlists, and explanations. These are conservative scaffolding rather than a mature optimiser. | [MNN supercompression](MNN_SUPERCOMPRESSION.md) |
| Circuit compilation and rewrites | Circuit/kernel representation, gate helpers, inverse cancellation and rotation merging, and rewrite traces. | [Quantum simulation](QUANTUM_SIMULATION.md); `test_quantum_gates`, `test_quantum_rewrite` |
| Simulation and backend choice | Reversible gate application plus tagged result placeholders for dense, sparse, and stabilizer choices; backend selection uses qubit thresholds and supports a reversible fallback. | [Quantum simulation](QUANTUM_SIMULATION.md); `test_backends` |
| Hybrid planning | Plan structure with classical prefix/suffix, a selected backend, and fallback option. It does not yet partition a general program into executable hybrid stages. | `prolog/quantum/hybrid_planner.pl`; `test_hybrid` |
| Verification and reporting | Transformation classifications, identity/equality checking, and visible fallback-required results when terms differ. | `prolog/qmsc_verify.pl`; [Safety](SAFETY.md) |
| Benchmark and showcase runners | Benchmark scenarios and ten runnable classical, symbolic, and quantum-inspired demonstrations. | [Benchmarking](BENCHMARKING.md), [Showcase](SHOWCASE.md) |

The public entry points are listed in the [API reference](API_REFERENCE.md).
The main test suite is described in the [repository README](../README.md).

## Remaining work, in priority order

1. **Parser and compiler correctness:** broaden supported Prolog syntax, preserve
   directives/comments and richer source constructs, and add tests that compare
   compiled behavior against source behavior. The current pipeline is primarily
   wiring and analysis; it does not yet perform a general source-to-source
   supercompilation.
2. **Real adapter integrations:** replace status/helper scaffolding with
   transformations for the source systems and verify their fallback behavior
   against representative inputs.
3. **MNN optimisation quality:** implement and measure useful compression and
   specialisation rules; expand provenance and explanations beyond current
   labels/hooks.
4. **Quantum fidelity and resource handling:** implement actual dense/sparse/
   stabilizer semantics, probability distributions and measurement policies,
   plus memory-aware backend selection. Current non-reversible backends return
   tagged placeholders; `memory_limit_mb` is not yet enforced.
5. **Hybrid execution and verification:** derive executable partitions,
   strengthen equivalence checking beyond term equality, and test the reported
   fallback path end to end.
6. **Evidence and scale:** grow showcase coverage, benchmark workloads, and
   regression tests so performance and correctness claims are supported by
   repeatable measurements.

These remaining items are also tracked at a higher level in [Roadmap](../ROADMAP.md).
