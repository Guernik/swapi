-module(sw_data_test).

-include_lib("eunit/include/eunit.hrl").

%% TODO: implement test suite with meck (or similar framework) to avoid making a real http request.



get_film_list_for_chars_test() ->
  http_reqs:start_inet_sll(),   
  ?assertEqual(["1","2","3","6","7"], sw_data:get_film_list_for_chars(["luke","leia"])).

get_film_map_list_test() ->
  http_reqs:start_inet_sll(),
  FilmMap = #{"1" => <<"A New Hope">>,
    "2" => <<"The Empire Strikes Back">>,"3" => <<"Return of the Jedi">>,
    "4" => <<"The Phantom Menace">>,"5" => <<"Attack of the Clones">>,
    "6" => <<"Revenge of the Sith">>,"7" => <<"The Force Awakens">>},
  ?assertEqual(FilmMap, sw_data:get_film_map_list()).

