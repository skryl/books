-module(power).
-export([for/3, sum/1, map/2, qsort/1, pythag/1, perms/1]).
-import(lists, [seq/2]).

%% for loop

for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I)|for(I+1, Max, F)].

sum([H|T]) -> H + sum(T);
sum([])    -> 0.

map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

%% more list comprehensions

qsort([]) -> [];
qsort([Pivot|T]) ->
  qsort([X || X <- T, X < Pivot]) 
  ++ [Pivot] ++ 
  qsort([X || X <- T, X >= Pivot]).

pythag(N) ->
  [ {A,B,C} || 
    A <- seq(1,N),
    B <- seq(1,N),
    C <- seq(1,N),
    A+B+C =< N,
    A*A+B*B =:= C*C
  ].

perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].

%% guards

max(X, Y) when X > Y -> X;
max(X, Y) -> Y.
