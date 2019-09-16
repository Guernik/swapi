-module(http_reqs).

-export([
  do_swapi_co_search/2,
  do_swapi_co_get_all_films/0,
  start_inet_sll/0 
]).



%% Exported %%

%% do_swapi_co_search/2
%% request sw api for the specified person Who
do_swapi_co_search(people,Who) ->
  EscapedWho = utils:escape_spaces(Who),
  do_http_get_request([swapi_co_base_url(), <<"people/">>, <<"?search=">>, EscapedWho]).

%% More search functions can be added as needed, ie: do_swapi_co_search(films,WhichOne) ...

%% do_swapi_co_get_all_films/0
%% Return binary string of full films collection from sw api
do_swapi_co_get_all_films() ->
  do_http_get_request([swapi_co_base_url(), <<"films/">>]).

%% start_inet_sll/0
start_inet_sll() -> 
  inets:start(),
  ssl:start().




%% Not exported %%

%% Make a syncronous http request and returns the 
%% resulting Body as a binary string.
do_http_get_request(Uri) ->
  Res = httpc:request(get, {Uri, []}, [], []),
    case Res of 
      {ok, {{_HttpVersion,200,_ReasonPhrase}, _Headers, Body}} ->
        {ok, list_to_binary(Body)};
    {error, Reason} -> 
        {error, Reason};
    _Else ->
        {error,<<"Invalid response from internal http client performing request.">>}
  end.

swapi_co_base_url() ->
  <<"http://swapi.co/api/">>.