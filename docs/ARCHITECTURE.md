# Architecture

`qmsc.pl` reexports `prolog/qmsc_api.pl`.

Pipeline:
1. Read source terms and metadata.
2. Parse into shared IR.
3. Run analyses and adapter diagnostics.
4. Apply compression and optional circuit/hybrid planning.
5. Emit generated terms and reports.
