-module(epgsql_pool_tests).

-include("epgsql_pool.hrl").
-include_lib("eunit/include/eunit.hrl").


get_set_settings_test() ->
    epgsql_pool_settings:start_link(),

    ?assertEqual(#{connection_timeout => 10000,
                   keep_alive_timeout => 60000,
                   max_reconnect_timeout => 5000,
                   min_reconnect_timeout => 100,
                   pooler_get_worker_timeout => 10000,
                   pooler_max_queue => 100,
                   query_timeout => 10000},
                 epgsql_pool:get_settings()),

    ok = epgsql_pool:set_settings(#{aa => bb,
                                    pooler_max_queue => 500,
                                    cc => dd,
                                    max_reconnect_timeout => 777,
                                    min_reconnect_timeout => 42,
                                    dd => 42,
                                    query_timeout => 555}),

    ?assertEqual(#{connection_timeout => 10000,
                   keep_alive_timeout => 60000,
                   max_reconnect_timeout => 777,
                   min_reconnect_timeout => 42,
                   pooler_get_worker_timeout => 10000,
                   pooler_max_queue => 500,
                   query_timeout => 555},
                 epgsql_pool:get_settings()),

    epgsql_pool_settings ! stop,
    ok.
