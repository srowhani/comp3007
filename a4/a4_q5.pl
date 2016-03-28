% [2 marks] Write a predicate myAppend(L1,L2,L3) to append 2 lists (order is important, you may not use the built in append)
myAppend([],X,X).
myAppend([X|Y],Z,[X|W]) :-
  myAppend(Y,Z,W).
% [2 marks] Rewrite the predicate myLast(X,L) from the previous question using append.
myLast( X, L ) :-
  append(_, [X], L).
% [3 marks] Rewrite the predicate nextto(X,Y,L) from the previous question using append.
nextto( X, Y, L ) :-
  append(_, [_|X,Y|_], L).
% [3 marks] Write a predicate myReverse(L1,L2) that succeeds when the result of reversing the elements of list L1 is the list L2. Your answer should use append, and may not make use of the built in reverse predicate.
myReverse([], L2) :- writeln()
myReverse([X|Y],L2) :-
  append(L2, X, L3).
  myReverse(Y, L3).
