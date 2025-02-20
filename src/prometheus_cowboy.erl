-module(prometheus_cowboy).

-behaviour(application).
-export([start/2, stop/1]).

-behaviour(supervisor).
-export([init/1]).

-export([to_cowboy_headers/1]).

-spec start(application:start_type(), term()) -> supervisor:startlink_ret().
start(_, _) ->
    case code:ensure_loaded(cowboy_metrics_h) of
        {module, _} -> prometheus_cowboy2_instrumenter:setup();
        _ -> ok
    end,
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

-spec stop(term()) -> ok.
stop(_) -> ok.

-spec init([]) -> {ok, {supervisor:sup_flags(), [supervisor:child_spec()]}}.
init([]) ->
    {ok, {{one_for_one, 0, 1}, []}}.

%% ===================================================================
%% API
%% ===================================================================

-spec to_cowboy_headers([{atom(), binary()}]) -> [{binary(), binary()}].
to_cowboy_headers(RespHeaders) ->
    lists:map(fun to_cowboy_headers_/1, RespHeaders).

%% ===================================================================
%% Private functions
%% ===================================================================

to_cowboy_headers_({Name, Value}) ->
    {to_cowboy_name(Name), Value}.

to_cowboy_name(Name) ->
    binary:replace(atom_to_binary(Name, utf8), <<"_">>, <<"-">>).
