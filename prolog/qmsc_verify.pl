:- module(qmsc_verify, [
    classify_transformation/3,
    verify_equivalence/4
]).

classify_transformation(proved, safe, proved).
classify_transformation(verified_bounded, safe, verified_bounded).
classify_transformation(tested, safe, tested).
classify_transformation(claimed, warning, claimed).
classify_transformation(heuristic, warning, heuristic).
classify_transformation(unsafe, error, unsafe).
classify_transformation(rejected, error, rejected).

verify_equivalence(OriginalTerms, GeneratedTerms, verify(none), verification(skipped)) :-
    !,
    OriginalTerms = GeneratedTerms.
verify_equivalence(OriginalTerms, GeneratedTerms, _Mode, verification(equal)) :-
    sort(OriginalTerms, A),
    sort(GeneratedTerms, A), !.
verify_equivalence(_OriginalTerms, _GeneratedTerms, _Mode, verification(fallback_required)).
