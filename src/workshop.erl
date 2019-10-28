% @doc workshop public API.
% @end
-module(workshop).

-behavior(application).

% Callbacks
-export([start/2]).
-export([stop/1]).

% New functions
-export([temperature_range/2]).
-export([light_percentage/0]).
-export([directionX/0, directionY/0, directionZ/0]).
-export([rotationX/0, rotationY/0, rotationZ/0]).

%--- Callbacks -----------------------------------------------------------------

start(_Type, _Args) -> 
    {ok, Supervisor} = workshop_sup:start_link(),
    initiate_sensors(),
    spawn(workshop, rotationZ, []),
    {ok, Supervisor}.

stop(_State) -> ok.

initiate_sensors() ->
    grisp:add_device(spi1, pmod_nav),
    grisp:add_device(spi2, pmod_als).

temperature_range(Min, Max) ->
        [Temp] = pmod_nav:read(alt, [out_temp]),
        if
            Temp > Max -> [grisp_led:color(L, red) || L <- [1,2]];
            Temp < Min -> [grisp_led:color(L, blue) || L <- [1,2]];            
            true -> [grisp_led:color(L, green) || L <-[1,2]]
        end,
        timer:sleep(2500),
        [grisp_led:color(L, yellow) || L <- [1,2]],
        timer:sleep(2500),
        temperature_range(Min, Max).

light_percentage() ->
    Percentage = pmod_als:percentage(),
    if
        Percentage < 20 -> [grisp_led:color(L, blue) || L <- [1,2]];
        Percentage < 40 -> [grisp_led:color(L, magenta) || L <- [1,2]];
        Percentage < 60 -> [grisp_led:color(L, aqua) || L <- [1,2]];
        Percentage < 80 -> [grisp_led:color(L, yellow) || L <- [1,2]];
        true -> [grisp_led:color(L, white) || L <- [1,2]]
    end,
    timer:sleep(2500),
    [grisp_led:color(L, red) || L <- [1,2]],
    timer:sleep(2500),
    light_percentage().

directionX() ->
    [X, _Y, _Z] = pmod_nav:read(acc, [out_x_xl, out_y_xl, out_z_xl]),
    if
        X > 0 -> grisp_led:color(1, red);
        X < 0 -> grisp_led:color(1, blue)
    end, 
    directionX().

directionY() ->
        [_X, Y, _Z] = pmod_nav:read(acc, [out_x_xl, out_y_xl, out_z_xl]),
        if
            Y > 0 -> grisp_led:color(2, red);
            Y < 0 -> grisp_led:color(2, blue)
        end, 
        directionY().

directionZ() ->
    [_X, _Y, Z] = pmod_nav:read(acc, [out_x_xl, out_y_xl, out_z_xl]),
    if
        Z > 0 -> [grisp_led:color(L, red) || L <- [1,2]];
        Z < 0 -> [grisp_led:color(L, blue) || L <- [1,2]]
    end,
    directionZ().

rotationX() ->
    [X, _, _] = pmod_nav:read(acc, [out_x_g, out_y_g, out_z_g]),
    if
        X > 0 -> grisp_led:color(1, red);
        X < 0 -> grisp_led:color(1, blue)            
    end,
    rotationX().

rotationY() ->
    [_, Y, _] = pmod_nav:read(acc, [out_x_g, out_y_g, out_z_g]),
    if
        Y > 0 -> grisp_led:color(2, red);
        Y < 0 -> grisp_led:color(2, blue)            
    end,
    rotationY().

rotationZ() ->
    [_, _, Z] = pmod_nav:read(acc, [out_x_g, out_y_g, out_z_g]),
    if
        Z > 0 -> [grisp_led:color(L, red) || L <- [1,2]];
        Z < 0 -> [grisp_led:color(L, blue) || L <- [1,2]]            
    end,
    rotationZ().