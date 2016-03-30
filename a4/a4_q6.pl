% [15 marks total] Suppose we represent a directed graph by an edge relation:
%
% edge(X,Y,L) %the edge from X to Y is of length L.
% Therefore, a graph that looks like a square of size 2 can be defined as follows:
edge(a,b,2).
edge(b,c,2).
edge(c,d,2).
edge(a,d,2).


% [3 marks] Write and test the clauses for the relation:
% connected(X,Y) %there is a path from X to Y in the graph
% E.g.,
% ?- connected(a,c).
% True
connected(X,Y) :- edge(X,Y,_).
connected(X,Y) :-
  edge(X,Z,_),
  connected(Z,Y).

% [4 marks] Write and test the clauses for the relation:
% pathLength(X,Y,R) %the length of the path from X to Y is R
% E.g.,
% ?- pathLength(a,d,R).
% R = 6;
% R = 2;

pathLength(X,Y,R) :-
  edge(X,Z,R1),
  pathLength(Z,Y,R2),
  R is R1 + R2.

pathLength(X,Y,R) :-
  edge(X,Y,R).

% [4 marks] Write and test the clauses for the relation:
% listForPath(X,Y,L) %the path between X and Y is the list L.
% E.g.,
% ?- listForPath(a,d,L).
% L = [edge(a,d,2)];
% L = [edge(a,b,2),edge(b,c,2),edge(c,d,2)];

listForPath(X,Y,L) :-
  edge(X,Y,D),
  L = [edge(X,Y,D)].

listForPath(X,Y,L) :-
  edge(X,Z,D),
  listForPath(Z,Y,L2),
  append([edge(X,Z,D)], L2, L).

% [4 marks] Write and test the clauses for the relation:
% onPath(X,Y,E) % the edge E is on the path between X and Y
% E.g.,
% ?- onPath(a,c,edge(b,c,_)).
% True
% ?- onPath(a,c,X).
% X = edge(a,b,2);
% X = edge(b,c,2);

onPath(X,Y,E) :-
  edge(X,Y,D),
  E = edge(X,Y,D).

onPath(X,Y,E) :-
  connected(Q,Y),
  onPath(X,Q,E).

onPath(X,Y,E) :-
  connected(X,Z),
  onPath(Z,Y,E).
