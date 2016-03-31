/**
 * Name:            Seena Rowhani
 * Student Number:  100945353
 * Course:          COMP3007
 */

% [3 marks] Write a predicate to find the last element of a list. You may not use the built in last predicate in your answer.

%Base Case: X is last element.
mylast(X, [X]).
/**
 * Returns that last element of a given list L.
 * Recursively reduces L to be the tail of F, and calls itself
 * until X has only 1 element.
 * @param  {[var]} X [Current el]
 * @param  {[list]} L [list]
 * @return {[bool, var]}
 */
mylast(X, [ _ | Y ]) :- mylast(X, Y).
%mylast(E,[1,2,3]).
%mylast(3, [1,2,3]).

% [3 marks] Write a predicate after(X,List,Result) that returns everything in a list after any occurrence of the given element

%Base Case: X is the head of list L, R is the tail. Meaning R is also result.
after(X, [X | R], R).
/**
 * List subset of all elements after element Query
 * @param  {[symbol]} Query  [description]
 * @param  {[list]} L
 * @param  {[list]} Result [output]
 * @return {[bool, symbol, list]}
 *  - bool if Query L Result given
 *  - symbol if Result is given
 *     - after(Query, [1,2,3,4,5], [3,4,5]). Query = 2
 *  - list if Query is given
 *     - after(2, [1,2,3,4,5], Result). Result = [3,4,5]
 */
after(Query, [_ | Rest], Result) :-
  after(Query, Rest, Result).
%after(Query, [1,2,3,4,5], [3,4,5]).
%after(2,[1,2,3,4,5], [3,4,5]).
%after(2, [1,2,3,4,5], Result).

% [4 marks] Write a predicate nextto(X, Y, L), that succeeds when elements X and Y are immediately consecutive elements of a list L.

%Base Case: Elements X, and Y such that X is next to Y in given list.
nextto(X,Y,[X,Y|_]).
/**
 * Determines if X is next to Y by reducing the list
 * being compared by one element at time.
 * @param  {[symbol]} X
 * @param  {[symbol]} Y
 * @param  {[list]} [_|R] L
 * @return {[bool, X,Y]}
 *  - X,Y,L -> bool
 *  - given X, L -> finds all Y
 *  - given Y, L -> finds all X
 *  - given X,Y -> infinite L's
 */
nextto(X,Y,[_|R]) :- nextto(X,Y,R).
%nextto(1,2,[1,2,3,4,5]).
%nextto(X,2,[1,2,1,3,5,4]).
%nextto(1,Y,[1,2,1,3,5,4]).

% [5 marks] Write the predicate occurs_at_position(Element, List, Position), that allows access to the nth element in a list.

%Base Case: Element E from L if I = 0.
occurs_at_position(E,[E | _],0).

/**
 * Finds element E at position I from list L
 * @param  {[symbol]} E element
 * @param  {[list]} L
 * @param  {[number]} I index
 */
occurs_at_position(E, [_ | Y], I) :-
  I_1 is I-1,
  occurs_at_position(E, Y, I_1).
%occurs_at_position(E,[1,2,3,4],3).
