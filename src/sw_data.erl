-module(sw_data).

-export([
  get_film_list_for_chars/1,  
  get_film_map_list/0 
]).


%% Exported %%

get_film_list_for_chars([CharA,CharB]) ->
  FilmIdListA = case get_character(CharA) of 
    {ok,CharacterMapA} -> get_films_id_from_character_map(CharacterMapA);
    {error,_} -> [] %do nothing, but match the error
  end,
  FilmIdListB = case get_character(CharB) of 
    {ok,CharacterMapB} -> get_films_id_from_character_map(CharacterMapB);
    {error,_} -> [] %do nothing, but match the error
  end,  
  SetA = ordsets:from_list(FilmIdListA),
  SetB = ordsets:from_list(FilmIdListB),
  SetC = ordsets:intersection(SetA,SetB),
  ordsets:to_list(SetC).

  
get_film_map_list() ->
      {ok,Films} = http_reqs:do_swapi_co_get_all_films(),
      SearchResult = jiffy:decode(Films,[return_maps]),
      JsonFilms = maps:get(<<"results">>,SearchResult),
      L = [get_title_id_map(X) || X <- JsonFilms],
      maps:from_list(L).




%% Not exported %%

get_films_id_from_character_map(CharacterMap) ->
  FilmUriList = maps:get(<<"films">>,CharacterMap),
  lists:map( fun(FilmUri) -> get_id_from_film_uri(FilmUri) end, FilmUriList).
  
  
get_id_from_film_uri(FilmUri) ->
  <<"https://swapi.co/api/films/",FullId/binary>> = FilmUri,  
  Id = lists:droplast(binary_to_list(FullId)),
  Id. 



get_character(CharacterName) ->
  {ok, Character} = http_reqs:do_swapi_co_search(people,CharacterName),
  JsonSearchResult = jiffy:decode(Character,[return_maps]),  
  Count = maps:get(<<"count">>,JsonSearchResult),
  treat_result(Count,JsonSearchResult,CharacterName).

treat_result(Count,JsonSearchResult,_CharName) when Count =:= 1 ->
  ResultList = maps:get(<<"results">>,JsonSearchResult),
  {ok,hd(ResultList)};
  
treat_result(Count,_JsonSearchResult, CharName) when Count > 1 ->
  io:format("More than one posible character for the input ~p~n",[CharName]),
  {error,{}};

treat_result(Count,_JsonSearchResult, CharName) when Count =:=  0 ->  
  io:format("No Star Wars character found for ~p~n",[CharName]),
  {error,{}}.




get_title_id_map(Film) ->
    FilmUri = maps:get(<<"url">>,Film),    
    Id = get_id_from_film_uri(FilmUri),
    FilmTitle = maps:get(<<"title">>,Film),
    {Id,FilmTitle}.