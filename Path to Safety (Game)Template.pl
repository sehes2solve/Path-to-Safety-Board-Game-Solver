get_dim(D1,D2):-   dim(D1,D2).
get_start(Start):- start([X,Y]), Start = sq(X,Y).
get_end(End):-     end([X,Y]), End = sq(X,Y).
is_star(sq(X,Y)):- star([X,Y]).

is_member(Mem,[H|T]):-
(Mem = H,!);
is_member(Mem,T).

%posi down
posi(sq(X,Y),sq(X1,Y),Direction):-
X1 is X + 1,
Direction = down.

%posi up
posi(sq(X,Y),sq(X1,Y),Direction):-
X1 is X - 1,
Direction = up.

%posi left
posi(sq(X,Y),sq(X,Y1),Direction):-
Y1 is Y - 1,
Direction = left.

%posi right
posi(sq(X,Y),sq(X,Y1),Direction):-
Y1 is Y + 1,
Direction = right.

%can go to
is_posi(sq(X,Y)):-
X >= 0,
Y >= 0,
get_dim(D1,D2),
X < D1,
Y < D2,
not(bomb([X,Y])).

get_path(Sq,_,[],Stars):-
get_end(End),
Sq = End,
Stars is 0.

get_path(Sq,Visited,Moves,Stars):-
posi(Sq,Nsq,Direction),
is_posi(Nsq),
not(is_member(Nsq,Visited)),
get_path(Nsq,[Nsq|Visited],NMoves,NStars),
Moves = [Direction|NMoves],
(is_star(Nsq) -> Stars is NStars + 1 ; Stars is NStars).

play(Moves,Stars):-
get_start(Start),
get_path(Start,[Start],Moves,Stars).

