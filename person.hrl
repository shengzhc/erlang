-record(person, {name, age, phone = [], dict = []}).
-module(person).
-include("person.hrl").
-compile(export_all).

make_hacker_without_phone(Name, Age) ->
  #person{name = Name, age = Age, 
    dict = [{computer_knowledge, excellent}, {drinks, coke}]}.

print(#person{name = Name, age = Age, phone = Phone, dict = Dict}) ->
  io:format("Name: ~s, Age: ~w, Phone: ~w ~n"
            "Dictionary: ~w.~n", [Name, Age, Phone, Dict]).

birthday(P) when is_record(P, person) ->
  P#person{age = P#person.age + 1}.

register_two_hackers() ->
  Hacker1 = make_hacker_without_phone("Joe", 29),
  OldHacker = birthday(Hacker1),
  central_register_server ! {register_person, Hacker1},
  central_register_server ! {register_person, OldHacker#person{name = "Robert",
                                                               phone = [0, 8, 3, 2, 4, 5, 3, 1]}}.