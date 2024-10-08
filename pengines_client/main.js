const PromisifiedPengine = require('./lib/promisified-pengine');

async function main() {
  const pengine = new PromisifiedPengine({
    server: "http://localhost:5000/pengine",
    format: 'json',
  });

  try {
    console.log("Running first ask call");
    const result_hello_world = await pengine.ask('db:hello_world(M)');
    console.log("Hello World Call Result:", result_hello_world);

    console.log("Running  queries");
    let results_parallel_hello_worlds = await Promise.all([
      pengine.ask('db:hello_world(Message1)'),
      pengine.ask('db:hello_world(Message2)'),
      pengine.ask('db:hello_world(Message3)'),
      pengine.ask('db:hello_world(Message4)'),
      pengine.ask('db:hello_world(Message5)')
    ]);
    console.log("Results of multiple parallel queries:", results_parallel_hello_worlds);

    console.log("Running second ask call on data");
    const result_get_single_matching_ais_ping = await pengine.ask('db:get_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,"Under way using engine",_,_,_,_,_,_,_)');
    console.log("AIS Matches:", result_get_single_matching_ais_ping);

    console.log("Running second ask call on data");
    const result_get_multiple_matching_ais_pings = await pengine.ask('db:get_all_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,"Under way using engine",_,_,_,_,_,_,_,Matches)');
    console.log("AIS Matches:", result_get_multiple_matching_ais_pings);
    

    console.log("Running third ask call on data to count matching pings");
    const result_count_matching_ais_pings = await pengine.ask('findall(Match,db:get_all_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,"Under way using engine",_,_,_,_,_,_,_,Match), [MatchesList]), length(MatchesList, Count).');
    console.log("AIS Matches:", result_count_matching_ais_pings);

  } catch (error) {
    console.error("An error occurred:", error);
  }
}

main().catch(error => console.error("Unhandled error:", error));