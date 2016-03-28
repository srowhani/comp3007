%db
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

after2003() :-
   movie(year(Year), title(Title), _),
   Year >= 2003,
   writeln((Title,Year)).
%after2003().
%  [1 mark] What movie(s) contain the word "of" in the title?
containsOf() :-
  movie(_, title(Title), _),
  member(of, Title),
  writeln(Title).
%containsOf().
%  [2 marks] What movies share one or more common words in their titles?
commonTitle() :-
  movie(_, title(L1), _),
  movie(_, title(L2),_),
  not(L1 = L2),
  intersection(L1,L2,X),
  not(X = []),
  writeln((L1,L2,X)).
%commonTitle().
%  [1 mark] What are the names of the female actors?
getActresses() :-
  actor(Fname, Lname, gender(female)),
  writeln((Fname,Lname)).
%getActresses().
%  [2 marks] In what movies were female actors members of the cast?
getActressesFromFilms() :-
  actor(Fname,Lname, gender(female)),
  movie(_,Title, cast(L)),
  member(actor(Fname,Lname), L),
  writeln((Title, actor(Fname,Lname))).
%getActressesFromFilms().
%  [2 marks] In what movies is Orlando Bloom a member of the cast?
orlandoBloomFilms() :-
  movie(_,Title, cast(L)),
  member(actor(orlando, bloom), L),
  writeln(Title).
%orlandoBloomFilms().
%  [3 marks] What actor(s) are in the cast of more than 1 movie?

%  [3 marks] What actor(s) are not in the cast of any movie?
