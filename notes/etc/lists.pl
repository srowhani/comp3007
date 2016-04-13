(mysort([],[]).
mysort([H|T], R) :-
  mysort(T, SortedTail),
  insert(H, SortedTail, R).

insert(X, [], [X]).
insert(X, [H|T], [X,H]) :- X =< H.
insert(X, [H|T], [H|R]) :-
  X>H,
  insert(X,T,R).

max([H|T], R) :- %max/2
  max(T,H,R). %max/3
%max/3
max([], R,R).
max([H|T], X, R) :- H =< X, max(T, X, R).
max([H|T], X, R) :- H > X,  max(T,H,R).

factorial(0,1).
factorial(N,F) :- %recursive
  N > 0,
  N_1 is N-1,
  factorial(N_1, F1),
  F is N * F1.

factorial_iter(N,N,R,R).
/**
 * [factorial_iter /2]
 * @param  {[type]} N [description]
 * @param  {[type]} R [description]
 * @return {[type]}   [description]
 */
factorial_iter(N,R) :-
  factorial_iter(0,N,1,R).
/**
 * [factorial_iter /4]
 * @param  {[type]} Index      [description]
 * @param  {[type]} N          [description]
 * @param  {[type]} Cumulative [description]
 * @param  {[type]} Result     [description]
 * @return {[type]}            [description]
 */
factorial_iter(Index,N,Cumulative,Result) :-
  Index < N,
  I is Index + 1,
  C is Cumulative * I,
  factorial_iter(I,N,C,Result).
