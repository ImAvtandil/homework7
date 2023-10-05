-module(homework7_app).

-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([{'_', routes:getRoutes()}]),
    {ok, _} = cowboy:start_clear(http, [{port, 8080}], #{env => #{dispatch => Dispatch}}),
    homework6:create(my_cache),
    homework7_sup:start_link().

stop(_State) ->
    ok = cowboy:stop_listener(http).
