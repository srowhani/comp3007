% [2 marks] Write a predicate myAppend(L1,L2,L3) to append 2 lists (order is important, you may not use the built in append)
myAppend([],X,X).
%reduce L1, put el X into L3. Recurse until L1 empty.
myAppend([X|Y],Z,[X|W]) :-
  myAppend(Y,Z,W).
% [2 marks] Rewrite the predicate myLast(X,L) from the previous question using append.
myLast( X, L ) :-
  append(_, [X], L). %append an array x to result L working backwords. X has the be last el, because [X] is only 1 el long.
% [3 marks] Rewrite the predicate nextto(X,Y,L) from the previous question using append.
nextto( X, Y, L ) :-
  append(_, [_|X,Y|_], L). %works backwords a bit. L already result, so is there a match X,Y that can be appended to result in L
% [3 marks] Write a predicate myReverse(L1,L2) that succeeds when the result of reversing the elements of list L1 is the list L2. Your answer should use append, and may not make use of the built in reverse predicate.
rev([],[]). % base case -> l1 empty implies reverse also empty
rev([H|T],Z):- %split head tail, Z return var
  rev(T,R),  %call reverse with just tail, R is the the list Z from prev iterations after append.
  append(R,[H],Z). %Z is return of append of old Z with list with car of our cdr.

myReverse(L1, L2) :-
  rev(L1, R),
  R == L2.
