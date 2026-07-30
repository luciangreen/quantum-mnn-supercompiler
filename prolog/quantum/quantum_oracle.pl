:- module(quantum_oracle, [
    build_oracle/3
]).

build_oracle(PredicateName, Examples, oracle(PredicateName, Examples)).
