-module(utils).

-export([escape_spaces/1]).

%% escape_spaces/1
%% escape a string containing spaces, into a string usable in http get requests
escape_spaces(String) ->
  string:replace(String," ", "%20").