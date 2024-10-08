const PromisifiedPengine = require('./lib/promisified-pengine');

async function main() {
  const pengine = new PromisifiedPengine({
    server: "http://localhost:5000/pengine",
    format: 'json',
    src: 'attach_db(\'users.pl\').',
  });

  try {
    const result_user = await pengine.ask('user(A, B)');
    console.log("Result:", result_user);

    const result_not_user = await pengine.ask('not(user(A, B))');
    console.log("Result:", result_not_user);

    const result_assert_user = await pengine.ask('db:assert_user_db("Bob", 51)');
    console.log("Result:", result_assert_user);
  } catch (error) {
    console.error("An error occurred:", error);
  }
}

main().catch(error => console.error("Unhandled error:", error));