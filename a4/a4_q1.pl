person(name(tom, wang),
  gender(male),
  parents([]),
  so(name(betty, wang)),
  sibling(name(fred, wang))).

person(name(betty, wang),
  gender(female),
  parents([name(alex, lee), name(wendy, lee)]),
  so(name(tom, wang)),
  sibling(name(susan, lee))).

person(name(alex, lee),
  gender(male),
  parents([]),
  so(name(wendy, lee)),
  sibling()).

person(name(wendy, lee),
  gender(female),
  parents([]),
  so(name(alex, lee)),
  sibling()).

person(
  name(jonny, wang),
  gender(male),
  parents([name(tom, wang), name(betty, wang)]),
  so([]),
  sibling()).

person(
  name(fred, wang),
  gender(male),
  parents([]),
  so([]),
  sibling(name(tom, wang))).

person(name(susan, lee),
  gender(female),
  parents([]),
  so([]),
  sibling(name(betty, wang))).
%facts
male(person(_,gender(male),_,_,_)).
female(person(_,gender(female),_,_,_)).
parent(person(Name,_,_,_,_), person(_,_,parents([Dad, Mom]),_,_)) :-
  Name = Dad; Name = Mom.
father(X,Y) :- male(X), parent(X,Y).
mother(X,Y) :- female(X), parent(X,Y).
married(person(N1,_,_,so(N2),_),person(N2,_,_,so(N1),_)).

name(person(R, _,_,_), R)
%rules
% different(X,Y) X and Y are different
different(X,Y) :- not(X = Y).
% is_mother(X) X is a mother
is_mother(X) :-
  mother(X,Y).
% is_father(X)  X is a father
is_father(X) :-
  father(X,Y).

% sister(X,Y)  X is a sister of Y
sister(person(Name, gender(female),_,_,_), person(_,_,_,_, sibling(Name))) :- !.
% brother(X,Y)  X is a brother of Y
brother(person(Name, gender(male),_,_,_), person(_,_,_,_, sibling(Name))) :- !.

% aunt(X,Y)  X is an aunt of Y
aunt(X,Y) :-
  sister(X,Z),
  parent(Z,Y),!.
% uncle(X,Y)  X is an uncle of Y
uncle(X,Y) :-
  brother(X,Z),
  parent(Z,Y),!.
% grandfather(X,Y)  X is a grandfather of Y
grandfather(X,Y) :-
  male(X),
  parent(X,Z),
  parent(Z,Y),!.
% grandmother(X,Y)  X is a grandmother of Y
grandmother(X,Y) :-
  female(X),
  parent(X,Z),
  parent(Z,Y),!.
% ancestor(X,Y)  X is an ancestor of Y
ancestor(X,Y) :- parent(X,Y), !.
ancestor(X,Y) :-
  parent(X,Z), % x is a parent of z,
  ancestor(Z, Y). %move close to y.
