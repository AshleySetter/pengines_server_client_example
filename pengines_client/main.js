const PromisifiedPengine = require('./lib/promisified-pengine');

async function main() {
  const pengine = new PromisifiedPengine({
    server: "http://localhost:5000/pengine",
    format: 'json',
  });

  try {
    console.log("Running first ask call");
    const result1 = await pengine.ask('db:hello_world(M)');
    console.log("Hello World Call Result:", result1);

    console.log("Running  queries");
    let results = await Promise.all([
      pengine.ask('db:hello_world(Message1)'),
      pengine.ask('db:hello_world(Message2)'),
      pengine.ask('db:hello_world(Message3)'),
      pengine.ask('db:hello_world(Message4)'),
      pengine.ask('db:hello_world(Message5)')
    ]);
    console.log("Results of multiple parallel queries:", results);

    console.log("Running second ask call on data");
    const result2 = await pengine.ask('db:get_all_ais_ping(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,"Under way using engine",_,_,_,_,_,_,_,Matches)');
    console.log("AIS Matches:", result2);

  } catch (error) {
    console.error("An error occurred:", error);
  }
}

main().catch(error => console.error("Unhandled error:", error));