:- module(safe_predicates, []).

:- use_module(library(pengines)).
:- use_module(library(sandbox)).

% Define safe predicates through the pengines_sandbox:safe_primitive/1 hook
:- multifile pengines_sandbox:safe_primitive/1.
:- multifile pengines_sandbox:safe_meta/2.

% Declare with_mutex/2 as a safe meta-predicate
pengines_sandbox:safe_meta(db:with_mutex(G,_), [G]).

% Declare other database predicates as safe
pengines_sandbox:safe_primitive(db:get_all_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
pengines_sandbox:safe_primitive(db:add_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
pengines_sandbox:safe_primitive(db:remove_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
