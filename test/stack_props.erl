%% -----------------------------------------------------------------------------
%% Copyright (c) 2002-2011 Tim Watson (watson.timothy@gmail.com)
%%
%% Permission is hereby granted, free of charge, to any person obtaining a copy
%% of this software and associated documentation files (the "Software"), to deal
%% in the Software without restriction, including without limitation the rights
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%% copies of the Software, and to permit persons to whom the Software is
%% furnished to do so, subject to the following conditions:
%%
%% The above copyright notice and this permission notice shall be included in
%% all copies or substantial portions of the Software.
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
%% THE SOFTWARE.
%% -----------------------------------------------------------------------------
-module(stack_props).
-compile(export_all).

-include_lib("proper/include/proper.hrl").
-include_lib("hamcrest/include/hamcrest.hrl").

prop_new_0_creates_an_empty_stack() ->
    ?FORALL(S, new_stack(),
          ?assertThat(S, is(empty_stack()))).

prop_empty_stack() ->
    ?FORALL(S, new_stack(),
    ?IMPLIES(stack:empty(S) == true,
        ?assertThat(S, is_sized(0)))).

prop_non_empty_stack() ->
    ?FORALL({S, I}, {new_stack(), any()},
        ?assertThat(stack:push(I, S), is_not(empty_stack()))).

prop_peek_should_return_the_last_item_pushed() ->
    ?FORALL({S, I}, {non_empty_stack(), any()},
    ?IMPLIES(not stack:empty(S),
        ?assertThat(stack:peek(stack:push(I, S)), equal_to(I)))).

prop_size_always_increments() ->
    ?FORALL(I, small_int(),
        ?assertThat(lists:foldl(fun increment/2, stack:new(),
            make_a_list_of(I)), is_sized(I + 1))).

%% custom generators

small_int() ->
    ?SUCHTHAT(X, integer(), is_within_range(X)).

is_within_range(X) -> X < 10000 andalso X > 1.

non_empty_stack() ->
    ?LET(L, non_empty(list()), stack:new(L)).

new_stack() ->
    stack:new().

%% custom hamcrest matchers

is_sized(N) ->
    fun(S) ->
        stack:size(S) == N
    end.

empty_stack() ->
    match_mfa(stack, empty, []).

%% helpers
increment(I, S) ->
    stack:push(I, S).

make_a_list_of(I) ->
    lists:seq(0, I).
