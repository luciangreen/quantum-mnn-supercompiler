# IR Specification

Program IR shape:

```prolog
program([
  predicate(Name/Arity, [
    clause(Head, Body, Meta)
  ])
]).
```

Source mapping metadata is retained in `Meta` entries such as `file/1` and `line/1`.
