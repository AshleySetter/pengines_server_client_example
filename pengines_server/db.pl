:- module(db,
          [ user/2,
            attach_db/1 % +File  - attach's database file
          ]).
:- use_module(library(persistency)).

% define predicate rule to attach database file used to store persisted facts (data)
attach_db(File) :-
db_attach(File, []).

:- persistent
    user_db(name:string,
            age:nonneg).

user(Name, Age) :-
    with_mutex(db, user_db(Name, Age)).

:- multifile
    sandbox:safe_primitive/1.

sandbox:safe_meta(with_mutex(G,_), [G]).
sandbox:safe_primitive(db:user(_,_)).
