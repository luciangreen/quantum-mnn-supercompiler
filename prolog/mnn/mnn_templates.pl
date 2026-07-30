:- module(mnn_templates, [
    extract_templates/2
]).

extract_templates(Clauses, templates(Templates)) :-
    findall(template(F/A),
        (member(clause(Head, _Body, _Meta), Clauses),
         functor(Head, F, A)),
        Raw),
    sort(Raw, Templates).
