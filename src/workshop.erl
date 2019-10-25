% @doc workshop public API.
% @end
-module(workshop).

-behavior(application).

% Callbacks
-export([start/2]).
-export([stop/1]).

% New functions
-export([temperature_range/2]).

%--- Callbacks -----------------------------------------------------------------

start(_Type, _Args) -> 
    {ok, Supervisor} = workshop_sup:start_link(),
    initiate_sensors(),
    spawn(workshop, temperature_range, [20, 25]),
    {ok, Supervisor}.

stop(_State) -> ok.

initiate_sensors() ->
    grisp:add_device(spi1, pmod_nav),
    grisp:add_device(spi2, pmod_als).

temperature_range(Min, Max) ->
        Temp = pmod_nav:read(acc, [out_temp]),
        if
            Temp > Max -> [grisp_led:color(L, red) || L <- [1,2]];
            Temp < Min -> [grisp_led:color(L, blue) || L <- [1,2]];            
            true -> [grisp_led:color(L, green) || L <-[1,2]]
        end,
        timer:sleep(2500),
        [grisp_led:color(L, yellow) || L <- [1,2]],
        timer:sleep(2500),
        temperature_range(Min, Max).