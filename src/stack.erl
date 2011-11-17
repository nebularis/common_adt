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
%% @doc A ludicrously simple stack interface on top of vanilla lists.
%% -----------------------------------------------------------------------------
-module(stack).

-export([new/0, new/1]).
-export([push/2, empty/1, peek/1, size/1]).

-opaque stack() :: list().
-export_type([stack/0]).

-spec new() -> stack:stack().
new() -> [].

-spec new(list()) -> stack:stack().
new(L) -> L.

-spec empty(stack:stack()) -> boolean().
empty([]) -> true;
empty([_|_]) -> false.

-spec size(stack:stack()) -> integer().
size([]) -> 0;
size(S) -> length(S).

-spec peek(stack:stack()) -> term() | no_return().
peek(S) -> erlang:hd(S).

-spec push(stack(), any()) -> stack().
push(S, Item) ->
    [Item|S].
