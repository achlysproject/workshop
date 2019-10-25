% @doc workshop public API.
% @end
-module(workshop).

-behavior(application).

% Callbacks
-export([start/2]).
-export([stop/1]).

%--- Callbacks -----------------------------------------------------------------

start(_Type, _Args) -> workshop_sup:start_link().

stop(_State) -> ok.
