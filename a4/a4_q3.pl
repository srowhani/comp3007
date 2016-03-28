%Write and test a program to solve the Towers of Hanoi problem.
%The problem is to move N disks from the left peg to the right peg using the center peg as an auxiliary holding peg.
%At no time can a larger disk be placed upon a smaller disk. The following diagram depicts the setup for N=3 disks.
%The tower problem can be solved recursively using the following strategy.
%To move n disks from one peg to another,
%using a 3rd peg as a holding peg, move n-1 disks to the holding peg,
%then move the last disk to the destination peg, then move all n-1 disks from the holding peg to the desination peg.

hanoi(0, _, _, _) :- !.

hanoi(N,Left,Right,Center) :-
  N_1 is N-1,
  hanoi(N_1, Left, Center, Right),
  writeln([Left, ->, Right]),
  hanoi(N_1, Center, Right, Left).

%hanoi(3,a,b,c).
