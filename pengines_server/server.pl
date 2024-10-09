:- use_module(library(pengines)).
:- use_module(library(http/http_server)).
:- use_module(library(sandbox)).

:- consult('ais_system.pl').

% Start the HTTP server on port 5000
server(Port) :-
    http_server(http_dispatch, [port(Port)]),
    attach_db("facts.pl"), % attach database in pengines server
    format('Pengines server running at http://localhost:~d/~n', [Port]).

:- initialization(server(5000)).