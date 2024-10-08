:- module(db,
          [ user/2,
            attach_db/1,
            assert_user/2
          ]).
:- use_module(library(persistency)).

:- persistent
    user_db(name:string,
            age:nonneg
            ).

attach_db(File) :-
    db_attach(File, []).

user(Name, Age) :-
    with_mutex(db, user_db(Name, Age)).

assert_user(Name, Age) :-
    with_mutex(db, assert_user_db(Name, Age)).

get_all_users(Name, Age, Matches) :- 
 with_mutex(db, 
    findall(user_db(Name, Age),
            user_db(Name, Age),
            Matches)
).

hello_world('Hello, World!').

:- multifile
    sandbox:safe_primitive/1.

% predicates called on the client need to be marked as safe
sandbox:safe_primitive(db:user(_,_)).
sandbox:safe_primitive(db:assert_user(_,_)).
sandbox:safe_primitive(db:get_all_users(_,_,_)).