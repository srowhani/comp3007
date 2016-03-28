% [3 marks] Write a predicate to find the last element of a list. You may not use the built in last predicate in your answer.
mylast(X, [X]).
mylast(X, [ _ | Y ]) :- mylast(X, Y), !.
% [3 marks] Write a predicate after(X,List,Result) that returns everything in a list after any occurrence of the given element
after(X, [X | Y], R) :- R = Y, !.
after(Query, [Current | Rest], Result) :-
  after(Query, Rest, Result).

% [4 marks] Write a predicate nextto(X, Y, L), that succeeds when elements X and Y are immediately consecutive elements of a list L.
nextto(X,Y,[X,Y|R]).
nextto(X,Y,[_|R]) :- nextto(X,Y,R).
% [5 marks] Write the predicate occurs_at_position(Element, List, Position), that allows access to the nth element in a list.
occurs_at_position(E,[X | Y],0) :- E = X.
occurs_at_position(E, [X | Y], I) :-
  I_1 is I-1,
  occurs_at_position(E, Y, I_1).
