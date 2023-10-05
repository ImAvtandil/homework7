-module(time_helper).

-export([parse_date/1, getTimestamp/1, getLocalTime/0]).

% 2015/1/1 00:00:00
-define(year, Y1 / utf8, Y2 / utf8, Y3 / utf8, Y4 / utf8, "/").
-define(month1, M1 / utf8, "/").
-define(month2, M1 / utf8, M2 / utf8, "/").
-define(day1, D1 / utf8, " ").
-define(day2, D1 / utf8, D2 / utf8, " ").
-define(h, H1 / utf8, H2 / utf8, ":").
-define(i, I1 / utf8, I2 / utf8, ":").
-define(s, S1 / utf8, S2 / utf8).
-define(prepereY, erlang:binary_to_integer(<<Y1/utf8, Y2/utf8, Y3/utf8, Y4/utf8>>)).
-define(prepereM1, erlang:binary_to_integer(<<M1/utf8>>)).
-define(prepereM2, erlang:binary_to_integer(<<M1/utf8, M2/utf8>>)).
-define(prepereD1, erlang:binary_to_integer(<<D1/utf8>>)).
-define(prepereD2, erlang:binary_to_integer(<<D1/utf8, D2/utf8>>)).
-define(prepereH, erlang:binary_to_integer(<<H1/utf8, H2/utf8>>)).
-define(prepereI, erlang:binary_to_integer(<<I1/utf8, I2/utf8>>)).
-define(prepereS, erlang:binary_to_integer(<<S1/utf8, S2/utf8>>)).

parse_date(<<?year, ?month1, ?day1, ?h, ?i, ?s, _/binary>>) ->
    {{?prepereY, ?prepereM1, ?prepereD1}, {?prepereH, ?prepereI, ?prepereS}};
parse_date(<<?year, ?month2, ?day1, ?h, ?i, ?s>>) ->
    {{?prepereY, ?prepereM2, ?prepereD1}, {?prepereH, ?prepereI, ?prepereS}};
parse_date(<<?year, ?month2, ?day2, ?h, ?i, ?s>>) ->
    {{?prepereY, ?prepereM2, ?prepereD2}, {?prepereH, ?prepereI, ?prepereS}}.

getTimestamp(DateTime) when is_binary(DateTime) ->
    calendar:datetime_to_gregorian_seconds(parse_date(DateTime));
getTimestamp(DateTime) ->
    calendar:datetime_to_gregorian_seconds(DateTime).

getLocalTime() ->
    calendar:datetime_to_gregorian_seconds(
        calendar:local_time()).
