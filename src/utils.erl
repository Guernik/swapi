-module(utils).

-export([escape_spaces/1]).

escape_spaces(String) ->
  string:replace(String," ", "%20").