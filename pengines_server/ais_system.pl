% preamble - loading persistency module and code to attach database
:- module(db,
[
  attach_db/1, % +File  - attach's database file
  get_ais_ping/26,
  get_all_ais_ping/27,
  add_ais_ping/26,
  remove_ais_ping/26
]
).

% import persistency module
:- use_module(library(persistency)).

hello_world('Hello, World!').

% define predicate rule to attach database file used to store persisted facts (data)
attach_db(File) :-
db_attach(File, []).

validate_required(Var, FieldName) :-
    (var(Var) ->
        format(atom(Msg), 'Missing required field "~w"', [FieldName]),
        throw(error(Msg))
    ; true
    ).

validate_type_number(Var, ValidVar, FieldName) :-
    ( nonvar(Var) ->
        ( number(Var) ->
            ValidVar = Var
        ; format(atom(Msg), 'Invalid type for ~w: "~w"', [FieldName, Var]),
          throw(error(Msg))
        )
    ; ValidVar = _
    ).

validate_type_integer(Var, ValidVar, FieldName) :-
    ( nonvar(Var) ->
        ( integer(Var) ->
            ValidVar = Var
        ; format(atom(Msg), 'Invalid type for ~w: "~w"', [FieldName, Var]),
          throw(error(Msg))
        )
    ; ValidVar = _
    ).

validate_type_string(Var, ValidVar, FieldName) :-
    ( nonvar(Var) ->
        ( string(Var) ->
            ValidVar = Var
        ; format(atom(Msg), 'Invalid type for ~w: "~w"', [FieldName, Var]),
          throw(error(Msg))
        )
    ; ValidVar = _
    ).

validate_type_boolean(Var, ValidVar, FieldName) :-
    ( nonvar(Var) ->
        ( atom(Var) ->
            ( Var = true ; Var = false ->
                ValidVar = Var
            ; format(atom(Msg), 'Invalid value for ~w: "~w" (must be "true" or "false")', [FieldName, Var]),
              throw(error(Msg))
            )
        ; format(atom(Msg), 'Invalid type for ~w: "~w" (must be a string)', [FieldName, Var]),
          throw(error(Msg))
        )
    ; ValidVar = _
    ).


% type definitions and get, add, remove function definitions generated from schema claims

:- persistent
  ais_ping(_A, _B, _C, _Callsign, _CargoType, _Cog, _D, _DataSourceType, _Destination, _Draught, _Eta, _Heading, _Imo, _Latitude, _Length, _Longitude, _Mmsi, _Name, _NavigationalStatus, _Rot, _ShipType, _Sog, _Timestamp, _TypeOfMobile, _TypeOfPositionFixingDevice, _Width).

get_ais_ping(A, B, C, Callsign, CargoType, Cog, D, DataSourceType, Destination, Draught, Eta, Heading, Imo, Latitude, Length, Longitude, Mmsi, Name, NavigationalStatus, Rot, ShipType, Sog, Timestamp, TypeOfMobile, TypeOfPositionFixingDevice, Width) :-
  with_mutex(db, ais_ping(A, B, C, Callsign, CargoType, Cog, D, DataSourceType, Destination, Draught, Eta, Heading, Imo, Latitude, Length, Longitude, Mmsi, Name, NavigationalStatus, Rot, ShipType, Sog, Timestamp, TypeOfMobile, TypeOfPositionFixingDevice, Width)).

get_all_ais_ping(A, B, C, Callsign, CargoType, Cog, D, DataSourceType, Destination, Draught, Eta, Heading, Imo, Latitude, Length, Longitude, Mmsi, Name, NavigationalStatus, Rot, ShipType, Sog, Timestamp, TypeOfMobile, TypeOfPositionFixingDevice, Width, Matches) :- 
 with_mutex(db, 
    findall(ais_ping(A, B, C, Callsign, CargoType, Cog, D, DataSourceType, Destination, Draught, Eta, Heading, Imo, Latitude, Length, Longitude, Mmsi, Name, NavigationalStatus, Rot, ShipType, Sog, Timestamp, TypeOfMobile, TypeOfPositionFixingDevice, Width),
            ais_ping(A, B, C, Callsign, CargoType, Cog, D, DataSourceType, Destination, Draught, Eta, Heading, Imo, Latitude, Length, Longitude, Mmsi, Name, NavigationalStatus, Rot, ShipType, Sog, Timestamp, TypeOfMobile, TypeOfPositionFixingDevice, Width),
            Matches)
).

add_ais_ping(A, B, C, Callsign, CargoType, Cog, D, DataSourceType, Destination, Draught, Eta, Heading, Imo, Latitude, Length, Longitude, Mmsi, Name, NavigationalStatus, Rot, ShipType, Sog, Timestamp, TypeOfMobile, TypeOfPositionFixingDevice, Width) :-
  % Validate required fields
  validate_required(Timestamp, "Timestamp"),
  validate_required(TypeOfMobile, "TypeOfMobile"),
  validate_required(Mmsi, "Mmsi"),
  validate_required(Latitude, "Latitude"),
  validate_required(Longitude, "Longitude"),
  validate_required(NavigationalStatus, "NavigationalStatus"),
  validate_required(Imo, "Imo"),
  validate_required(Callsign, "Callsign"),
  validate_required(ShipType, "ShipType"),
  validate_required(TypeOfPositionFixingDevice, "TypeOfPositionFixingDevice"),
  validate_required(Destination, "Destination"),
  validate_required(DataSourceType, "DataSourceType"),
  % Check unique fields are unique
  % Validate and assert A
  validate_type_number(A, ValidA, "A"),
  % Validate and assert B
  validate_type_number(B, ValidB, "B"),
  % Validate and assert C
  validate_type_number(C, ValidC, "C"),
  % Validate and assert Callsign
  validate_type_string(Callsign, ValidCallsign, "Callsign"),
  % Validate and assert CargoType
  validate_type_string(CargoType, ValidCargoType, "CargoType"),
  % Validate and assert Cog
  validate_type_string(Cog, ValidCog, "Cog"),
  % Validate and assert D
  validate_type_number(D, ValidD, "D"),
  % Validate and assert DataSourceType
  validate_type_string(DataSourceType, ValidDataSourceType, "DataSourceType"),
  % Validate and assert Destination
  validate_type_string(Destination, ValidDestination, "Destination"),
  % Validate and assert Draught
  validate_type_number(Draught, ValidDraught, "Draught"),
  % Validate and assert Eta
  validate_type_string(Eta, ValidEta, "Eta"),
  % Validate and assert Heading
  validate_type_string(Heading, ValidHeading, "Heading"),
  % Validate and assert Imo
  validate_type_string(Imo, ValidImo, "Imo"),
  % Validate and assert Latitude
  validate_type_number(Latitude, ValidLatitude, "Latitude"),
  % Validate and assert Length
  validate_type_number(Length, ValidLength, "Length"),
  % Validate and assert Longitude
  validate_type_number(Longitude, ValidLongitude, "Longitude"),
  % Validate and assert Mmsi
  validate_type_integer(Mmsi, ValidMmsi, "Mmsi"),
  % Validate and assert Name
  validate_type_string(Name, ValidName, "Name"),
  % Validate and assert NavigationalStatus
  validate_type_string(NavigationalStatus, ValidNavigationalStatus, "NavigationalStatus"),
  % Validate and assert Rot
  validate_type_string(Rot, ValidRot, "Rot"),
  % Validate and assert ShipType
  validate_type_string(ShipType, ValidShipType, "ShipType"),
  % Validate and assert Sog
  validate_type_string(Sog, ValidSog, "Sog"),
  % Validate and assert Timestamp
  validate_type_string(Timestamp, ValidTimestamp, "Timestamp"),
  % Validate and assert TypeOfMobile
  validate_type_string(TypeOfMobile, ValidTypeOfMobile, "TypeOfMobile"),
  % Validate and assert TypeOfPositionFixingDevice
  validate_type_string(TypeOfPositionFixingDevice, ValidTypeOfPositionFixingDevice, "TypeOfPositionFixingDevice"),
  % Validate and assert Width
  validate_type_number(Width, ValidWidth, "Width"),
  with_mutex(db, 
    assert_ais_ping(ValidA, ValidB, ValidC, ValidCallsign, ValidCargoType, ValidCog, ValidD, ValidDataSourceType, ValidDestination, ValidDraught, ValidEta, ValidHeading, ValidImo, ValidLatitude, ValidLength, ValidLongitude, ValidMmsi, ValidName, ValidNavigationalStatus, ValidRot, ValidShipType, ValidSog, ValidTimestamp, ValidTypeOfMobile, ValidTypeOfPositionFixingDevice, ValidWidth)
  ).

remove_ais_ping(A, B, C, Callsign, CargoType, Cog, D, DataSourceType, Destination, Draught, Eta, Heading, Imo, Latitude, Length, Longitude, Mmsi, Name, NavigationalStatus, Rot, ShipType, Sog, Timestamp, TypeOfMobile, TypeOfPositionFixingDevice, Width) :-
  ais_ping(A, B, C, Callsign, CargoType, Cog, D, DataSourceType, Destination, Draught, Eta, Heading, Imo, Latitude, Length, Longitude, Mmsi, Name, NavigationalStatus, Rot, ShipType, Sog, Timestamp, TypeOfMobile, TypeOfPositionFixingDevice, Width),
  with_mutex(db, (
    retractall_ais_ping(A, B, C, Callsign, CargoType, Cog, D, DataSourceType, Destination, Draught, Eta, Heading, Imo, Latitude, Length, Longitude, Mmsi, Name, NavigationalStatus, Rot, ShipType, Sog, Timestamp, TypeOfMobile, TypeOfPositionFixingDevice, Width)
  )).

:- multifile
    sandbox:safe_primitive/1.

% predicates called on the client need to be marked as safe
sandbox:safe_primitive(db:get_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
sandbox:safe_primitive(db:get_all_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
sandbox:safe_primitive(db:add_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
sandbox:safe_primitive(db:remove_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).

% rules from rule claims
