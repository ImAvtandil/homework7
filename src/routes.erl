-module(routes).

-export([getRoutes/0]).

getRoutes() ->
    [{"/", toppage_h, []}, {"/api/cache_server", cache_server, []}].
