#!/usr/bin/env escript

%% -*- erlang -*-
%%!



%% main/1
%% main program function called from the command line
main(Args) when length(Args) =:= 2 ->
  code:add_path("_build/default/lib/jiffy/ebin"),
  http_reqs:start_inet_sll(),  
  FilmIdList = sw_data:get_film_list_for_chars(Args),
  IdTitleMap = sw_data:get_film_map_list(),
  OutList = [maps:get(F,IdTitleMap) || F <- FilmIdList],
  OutStringList = [binary_to_list(X) || X <- OutList ],  
  [io:format("~s~n",[X]) || X <- OutStringList];  

main(_Args) ->
  usage().

usage() ->
  io:format("usage: swapi Character AnotherCharacter~n"),
  io:format("ie: swapi luke leia~n"),
  io:format("    swapi \"luke sky\" leia~n").


