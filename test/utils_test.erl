-module(utils_test).

-include_lib("eunit/include/eunit.hrl").


escape_spaces_test() -> 
  FlattenedA = lists:flatten("escape%20spaces"),  
  ?assertEqual(FlattenedA, lists:flatten(utils:escape_spaces("escape spaces"))).

