:- module(db,
          [ user/2,
            attach_db/1,
            assert_user/2
          ]).
:- use_module(library(persistency)).

:- persistent
    user_db(name:string,
            age:nonneg).

attach_db(File) :-
    db_attach(File, []).

user(Name, Age) :-
    with_mutex(db, user_db(Name, Age)).

assert_user(Name, Age) :-
    with_mutex(db, assert_user_db(Name, Age)).


:- multifile
    sandbox:safe_primitive/1.

% predicates called on the client need to be marked as safe
sandbox:safe_primitive(db:user(_,_)).
sandbox:safe_primitive(db:assert_user(_,_)).