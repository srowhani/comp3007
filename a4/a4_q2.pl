/**
 * Name:            Seena Rowhani
 * Student Number:  100945353
 * Course:          COMP3007
 */

%facts
actor(jonny, depp, gender(male)).
actor(bruce, willis, gender(male)).
actor(glenn, close, gender(female)).
actor(orlando, bloom, gender(male)).
actor(jennifer, lawrence, gender(female)).
actor(sean, bean, gender(male)).
actor(angelina, jolie, gender(female)).
actor(keira, knightley, gender(female)).
actor(benedict, cumberbatch, gender(male)).

movie(year(2003), title([pirates,of,the,carribean]), cast([actor(jonny, depp), actor(keira, knightley), actor(orlando, bloom)])).
movie(year(2001), title([lord,of,the,rings]), cast([actor(orlando, bloom), actor(sean, bean)])).
movie(year(1988), title([die,hard]), cast([actor(bruce, willis)])).
movie(year(2014), title([the,imitation,game]), cast([actor(benedict, cumberbatch), actor(keira, knightley)])).
movie(year(2012), title([the,hunger,games]), cast([actor(jennifer,lawrence)])).

%  [1 mark] What movies were released in or after 2003?

/**
 * Movies released after 2003.
 * @param  {[type]} R [Output param]
 * @return Movies released after 2003.
 */
after2003(R) :-
   movie(year(Year), title(Title), _),
   Year >= 2003,
   R = [Title, Year].
%after2003(R).

%  [1 mark] What movie(s) contain the word "of" in the title?

/**
 * Movies that contain the word 'of'
 * @param  {[type]} R [Output param]
 * @return Movies that contain of.
 */
containsOf(R) :-
  movie(_, title(Title), _),
  member(of, Title),
  R = Title.
%containsOf(R).

%  [2 marks] What movies share one or more common words in their titles?

/**
 * Movies that share common words in their titles.
 * @param  {[type]} R [Output]
 * @return {[type]}   [description]
 */
commonTitle(R) :-
  movie(_, title(L1), _),
  movie(_, title(L2),_),
  not(L1 = L2),
  intersection(L1,L2,X),
  not(X = []),
  R = [L1,L2,X].
%commonTitle(R).

%  [1 mark] What are the names of the female actors?

/**
 * Female actors
 * @param  {[type]} R [output]
 * @return {[type]}   [description]
 */
getActresses(R) :-
  actor(Fname, Lname, gender(female)),
  R = actor(Fname, Lname).
%getActresses(R).

%  [2 marks] In what movies were female actors members of the cast?

/**
 * Female actors that star in movies.
 * @param  {[type]} R [output]
 * @return {[type]}   [description]
 */
getActressesFromFilms(R) :-
  actor(Fname,Lname, gender(female)),
  movie(_,Title, cast(L)),
  member(actor(Fname,Lname), L),
  R = [Title, actor(Fname,Lname)].
%getActressesFromFilms(R).

%  [2 marks] In what movies is Orlando Bloom a member of the cast?

/**
 * Movies that feature bloom.
 * @param  {[type]} R [output]
 * @return {[type]}   [description]
 */
orlandoBloomFilms(R) :-
  movie(_,Title, cast(L)),
  member(actor(orlando, bloom), L),
  R = Title.
%orlandoBloomFilms(R).

%  [3 marks] What actor(s) are in the cast of more than 1 movie?

/**
 * Actors that appear in more than one movie.
 * @param  {[type]} R [output]
 * @return {[type]}   [description]
 */
dupeactors(R) :-
  movie(_,T1, cast(L1)),
  movie(_,T2, cast(L2)),
  not(T1 = T2),
  intersection(L1,L2,Intersection),
  not(Intersection = []),
  R = [T1, Intersection].
%dupeactors(R).

%  [3 marks] What actor(s) are not in the cast of any movie?

/**
 * Actors / Actresses that appear in no movies.
 * @param  {[type]} R [output]
 * @return {[type]}   [description]
 */
nomovies(R) :-
  actor(Fname, Lname, _),
  forall(
    movie(_,_, cast(L)),
    not(member(actor(Fname, Lname), L))),
  R = actor(Fname, Lname).
%nomovies(R).
