-module(cache_server).

-export([init/2, allowed_methods/2, content_types_accepted/2]).
-export([json_request/2]).

-define(table, my_cache).

-include_lib("stdlib/include/ms_transform.hrl").

init(Req, Opts) ->
    {cowboy_rest, Req, Opts}.

allowed_methods(Req, State) ->
    {[<<"POST">>], Req, State}.

content_types_accepted(Req, State) ->
    {[{<<"application/json">>, json_request}], Req, State}.

json_request(Req, State) ->
    {ok, Data, _Req0} = cowboy_req:read_body(Req),
    DataMap = jsone:decode(Data),
    Result = cache(DataMap),
    Resp = cowboy_req:set_resp_body(Result, Req),
    cowboy_req:reply(201, Resp),
    {ok, Resp, State}.

cache(#{<<"action">> := <<"insert">>,
        <<"key">> := Key,
        <<"value">> := Value}) ->
    Res = homework6:insert(?table, Key, {Value, time_helper:getLocalTime()}),
    jsone:encode(#{result => Res});
cache(#{<<"action">> := <<"lookup">>, <<"key">> := Key}) ->
    case homework6:lookup(?table, Key) of
        {Value, _} ->
            jsone:encode(#{result => Value});
        _ ->
            jsone:encode(#{result => <<"Valye for key not found">>})
    end;
cache(#{<<"action">> := <<"lookup_by_date">>,
        <<"date_from">> := DateFrom,
        <<"date_to">> := DateTo}) ->
    FromTimestemp = time_helper:getTimestamp(DateFrom),
    ToTimestemp = time_helper:getTimestamp(DateTo),
    Select =
        ets:fun2ms(fun({Key, _, {Value, InsertDate}}) when InsertDate >= FromTimestemp, InsertDate =< ToTimestemp ->
                      [{key, Key}, {value, Value}]
                   end),
    Result = ets:select(?table, Select),
    jsone:encode(#{result => Result});
cache(_) ->
    jsone:encode(#{result => error, message => <<"Unknown action">>}).
