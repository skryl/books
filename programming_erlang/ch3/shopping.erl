-module(shopping).
-export([cost/1, total/1]).

cost(oranges)   -> 5;
cost(newspaper) -> 8;
cost(apples)    -> 2;
cost(pears)     -> 9;
cost(milk)      -> 7.

total([{What, N}|Rest]) -> (cost(What) * N) + total(Rest);
total([]) -> 0.
