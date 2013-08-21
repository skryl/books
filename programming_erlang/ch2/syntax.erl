%% shell

% Ctrl-C %% quit
q().           %% quit
c(mod).        %% compile module
cd().          %% change dir
pwd().         %% pwd

%% numbers
1 + 1.
4 / 2.   % 2.0 (float)
4 div 2. % 2   (int)
4 rem 2. % 0
123456789 * 918273645918273645. % bignum
16#cafe * 32#sugar. % non decimal integers 


%% variables

% single assignment and must be capitalized

X = 1234.
X = 2345. % error

f(X). % unbind the var

%% atoms

abc.
'Abc'.
abc = 'abc'.

%% tuples

Person = {person,
            {name, joe},
            {height, 1.82},
            {footsize, 42},
            {eyecolor, brown}}.

% pattern matching on tuples

Point = {point, 10, 45}.
{point, X, Y} = Point.
X. % 10
Y. % 45

{point, C, C} = Point. % error

{X, Y} = {1, 2, 3} % error


% wildcard

{_, _, 3, 4, A} = {1,2,3,4,5}.
A. % 5

F = {firstname, joe}.
L = {lastname, armstrong}.
Person = {person, F, L}.

{_, {_, Who}, {_, _}} = Person.
Who. % joe

%% lists

Things = [{apples, 10}, {pears, 6}, {milk, 3}].
[1 + 7, hello, 2-2, {a,b,c}].

% cons

MoreThings = [{oranges, 4}, {newspaper, 1} | Things].
[First|Rest] = MoreThings.
First. % {oranges, 4}
Rest.  % [{newspaper,1},{apples,10},{pears,6},{milk,3}]

List = [1,2,3,4,5].
[One, Two | Rest] = List.
One.  % 1
Two.  % 2
Rest. % [3,4,5]

%% strings

Name = "Hello"

% just lists of integers
[1,2,3]. % [1,2,3]
[83, 117, 114, 112, 114, 105, 115, 101]. % "Surprise"

I = $s.
I. % 115

[I - 32, $u, $r, $p, $r, $i, $s, $e]. % "Surprise"

%% lambdas

Z = fun(X) -> 2 * X end.
Z(10).  % 20
Z(1,2). % error

TempConvert = fun({c, C}) -> {f, 32 + C*9/5};
                 ({f, F}) -> {c, (F-32)*5/9}
              end.
TempConvert({c, 100}).
TempConvert({f, 212}).

%% == tests equality, =:= tests equality without autocasting
%% 1 == 1.0 will succeed but 1 =:= 1.0 will fail

Even = fun(X) -> (X rem 2) =:= 0 end. 
lists:filter(Even, [1,2,3,4,5,6,7,8]).

Fruit = [apple, pear, orange].
MakeTest = fun(L) -> (fun(X) -> lists:member(X, L) end) end.
IsFruit = MakeTest(Fruit).
lists:filter(IsFruit, [dog, orange, cat, apple, bear]).

%% list comrehensions
%% [X || Qualifier1, Qualifier2, ...]

L = [1,2,3,4,5].
[2*X || X <- L].
[ {X, Y} || X <- [1,2,3], Y <- [1,2,3] ].
[ X || {a, X} <- [{a,1}, {b,1}]].

map(F, L) -> [F(X) || X <- L].

