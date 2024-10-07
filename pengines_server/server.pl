:- use_module(library(pengines)).
:- use_module(library(http/http_server)).
:- use_module(library(sandbox)).
:- use_module(safe_predicates).  % Load sandbox permissions

% Load your Prolog files
:- consult('ais_system.pl').
attach_db('facts.pl').

% Start the HTTP server on port 5000
server(Port) :-
    http_server(http_dispatch, [port(Port)]),
    format('Pengines server running at http://localhost:~d/~n', [Port]).

:- initialization(server(5000)).