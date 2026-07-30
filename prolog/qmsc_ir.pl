:- module(qmsc_ir, [
    terms_to_ir/2,
    ir_to_terms/2,
    pretty_ir/2
]).

terms_to_ir(TermsWithMeta, program(Predicates)) :-
    findall(predicate(Name/Arity, Clauses),
        predicate_group(TermsWithMeta, Name, Arity, Clauses),
        Predicates).

predicate_group(TermsWithMeta, Name, Arity, Clauses) :-
    member(term(Term, _), TermsWithMeta),
    clause_head(Term, Head),
    functor(Head, Name, Arity),
    findall(clause(Head1, Body1, Meta1),
        (member(term(Term1, Meta1), TermsWithMeta),
         decompose_clause(Term1, Head1, Body1),
         functor(Head1, Name, Arity)),
        Clauses).

clause_head((Head :- _Body), Head) :- !.
clause_head(Head, Head).

decompose_clause((Head :- Body), Head, Body) :- !.
decompose_clause(Head, Head, true).

ir_to_terms(program(Predicates), Terms) :-
    findall(Term,
        (member(predicate(_PI, Clauses), Predicates),
         member(clause(Head, Body, _Meta), Clauses),
         clause_term(Head, Body, Term)),
        Terms).

clause_term(Head, true, Head) :- !.
clause_term(Head, Body, (Head :- Body)).

pretty_ir(IR, String) :-
    with_output_to(string(String), portray_clause(IR)).
