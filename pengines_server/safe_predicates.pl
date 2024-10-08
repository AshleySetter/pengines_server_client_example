:- module(safe_predicates, []).

:- use_module(library(pengines)).
:- use_module(library(sandbox)).

% Define safe predicates through the sandbox:safe_primitive/1 hook
:- multifile sandbox:safe_primitive/1.
:- multifile sandbox:safe_meta/2.

% Declare with_mutex/2 as a safe meta-predicate
sandbox:safe_meta(with_mutex(G,_), [G]).
sandbox:safe_meta(findall(G,_), [G]).

% Declare other database predicates as safe
sandbox:safe_meta(get_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
sandbox:safe_meta(get_all_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
sandbox:safe_meta(add_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
sandbox:safe_meta(remove_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
