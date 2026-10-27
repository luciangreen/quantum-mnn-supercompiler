# Quantum Simulation

## Backends and behavior

The backend selector exposes:
- reversible
- dense state vector (restricted)
- sparse
- stabilizer

The reversible backend applies the gates currently implemented in
`quantum_gates.pl` to the lightweight state representation. Dense, sparse, and
stabilizer backends currently return tagged result structures; they are API
scaffolding, not full physical simulators. Selection is bounded by the
`dense_max_qubits` and `max_qubits` options, with a reversible fallback when a
requested resource bound is exceeded.

`qmsc_simulate/4` returns a dict containing `backend`, `backend_report`,
`state`, and `measurement`. Measurement is taken from the backend's returned
state. The default `deterministic` policy preserves that state with probability
`1.0`; `seeded` currently attaches a seeded pseudo-random probability rather
than sampling a physical measurement distribution.

Simulation is classical and intentionally lightweight. There is no claim of
physical quantum advantage, full state-vector fidelity, or hardware execution.
