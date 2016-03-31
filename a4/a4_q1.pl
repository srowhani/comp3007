/**
 * Name:            Seena Rowhani
 * Student Number:  100945353
 * Course:          COMP3007
 */

%database
person(tom, wang).
person(betty, wang).
person(jonny, wang).
person(alex, lee).
person(wendy, lee).
person(betty, wang).
person(susan, lee).
person(fred, lee).

male(person(tom, wang)).
male(person(jonny, wang)).
male(person(fred, lee)).
male(person(alex,lee)).

female(person(betty, wang)).
female(person(wendy, lee)).
female(person(betty, wang)).
female(person(susan, lee)).

parent(person(tom, wang), person(jonny, wang)).
parent(person(betty, wang), person(jonny, wang)).
parent(person(alex, lee), person(betty, wang)).
parent(person(wendy, lee), person(betty, wang)).
parent(person(alex, lee), person(susan, lee)).
parent(person(wendy, lee), person(susan, lee)).
parent(person(alex, lee), person(fred, lee)).
parent(person(wendy, lee), person(fred, lee)).

father(person(tom, wang), person(jonny, wang)).
father(person(alex, lee), person(betty, wang)).
father(person(alex, lee), person(susan, lee)).
father(person(alex, lee), person(fred, lee)).

mother(person(betty, wang), person(jonny, wang)).
mother(person(wendy, lee), person(betty, wang)).
mother(person(wendy, lee), person(susan, lee)).
mother(person(wendy, lee), person(fred, lee)).

married(person(tom, wang), person(betty, wang)).
married(person(alex, lee), person(wendy, lee)).

/**
 * Checks if X is different from Y
 * @param  {[person]} X
 * @param  {[person]} Y
 * @return {[bool]}
 */
different(X,Y) :-
  not(X = Y).
%different(person(jonny, wang), person(jonny, wang)).
%different(person(betty, wang), person(jonny, wang)).

/**
 * Checks if there exists a value where mother(X, value) is a fact.
 * @param  {[person]}  X
 * @return {Boolean}
 */
is_mother(X) :-
  mother(X,_).
%is_mother(person(betty, wang)).

/**
 * Checks if there exists a value where father(X, value) is a fact.
 * @param  {[Person]}  X
 * @return {Boolean}
 */
is_father(X) :-
  father(X,_).
%is_father(person(tom, wang)).
%is_father(person(jonny, wang)).

/**
 * Determines if X is an aunt of Y
 * P being a parent to X, and Q would imply
 * that X and Q are siblings (X != Q)
 * If Q has a child, and X is female,
 * X is said to be an aunt of Y.
 * @param  {[person]} X [Potential aunt of Y]
 * @param  {[person]} Y [Subject of aunthood]
 * @return {[bool, person]}
 */
aunt(X,Y) :-
  female(X),
  parent(P,X),
  parent(P,Q),
  different(X,Q),
  parent(Q,Y).
%aunt(person(susan, lee), person(jonny, wang)).
%aunt(person(susan, lee), person(fred, wang)).
%aunt(person(fred, lee), person(jonny, wang)).

/**
 * Determines if X is an uncle of Y
 * P being a parent to X, and Q would imply
 * that X and Q are siblings (X != Q)
 * If Q has a child, and X is male,
 * X is said to be an uncle of Y.
 * @param  {[person]} X [Potential uncle of Y]
 * @param  {[person]} Y [Subject of uncle X]
 * @return {[bool, person]}
 */
uncle(X,Y) :-
  male(X),
  parent(P,X),
  parent(P,Q),
  different(X,Q),
  parent(Q,Y).
%uncle(person(susan, lee), person(jonny, wang)).
%uncle(person(susan, lee), person(fred, wang)).
%uncle(person(fred, lee), person(jonny, wang)).

/**
 * X is said to be a sister of Y iff
 * - X is a female
 * - They share parent P
 * - X is not the same as Y, their potential sibling.
 * @param  {[person]} X
 * @param  {[person]} Y
 * @return {[bool, person]}
 */
sister(X,Y) :-
  female(X),
  parent(P,X),
  parent(P,Y),
  different(X,Y).
%sister(person(susan, lee), X).

/**
 * X is said to be a brother of Y iff
 * - X is a male
 * - They share parent P
 * - X is not the same as Y, their potential sibling.
 * @param  {[person]} X
 * @param  {[person]} Y
 * @return {[bool, person]}
 */
brother(X,Y) :-
  male(X),
  parent(P,X),
  parent(P,Y),
  different(X,Y).
%brother(person(fred,lee), person(susan, lee)).
%brother(person(susan,lee), person(fred, lee)).
%brother(person(fred,lee), person(jonny, wang)).

/**
 * X is said to be grandfather of y iff
 * - If there exists a Z such that X is their father
 * - Z exists as a parent to any given Y.
 * @param  {[person]} X [Grandfather]
 * @param  {[person]} Y [Grandchild]
 * @return {[bool, person]}
 */
grandfather(X,Y) :-
  father(X,Z),
  parent(Z,Y).
%grandfather(person(alex, lee), person(jonny, wang)).
%grandfather(person(alex, lee), person(betty, wang)).
%grandfather(person(alex, lee), person(tom, wang)).

/**
 * X is said to be mother of y iff
 * - If there exists a Z such that X is their mother
 * - Z exists as a parent to any given Y.
 * @param  {[person]} X [grandmother]
 * @param  {[person]} Y [Grandchild]
 * @return {[bool, person]}
 */
grandmother(X,Y) :-
  mother(X,Z),
  parent(Z,Y).
%grandmother(person(wendy, lee), person(jonny, wang)).
%grandmother(person(wendy, lee), person(betty, wang)).
%grandmother(person(wendy, lee), person(tom, wang)).


/**
 * X ancestor of Y if there recursively exists a parent Z to
 * target Y. (inductive reasoning)...
 * @param  {[person]} X
 * @param  {[person]} Y
 * @return {[bool, person]}
 */
ancestor(X,Y) :-
  parent(X,Y).

ancestor(X,Y) :-
  parent(X,Z),
  ancestor(Z,Y).
%ancestor(person(wendy, lee), person(jonny, wang)).
%ancestor(person(alex,lee), X).
