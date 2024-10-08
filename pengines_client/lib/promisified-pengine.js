const Pengine = require('pengines');

class PromisifiedPengine {
  constructor(options) {
    this.defaultOptions = options;
  }

  ask(query) {
    return new Promise((resolve, reject) => {
      const pengine = new Pengine({
        ...this.defaultOptions,
        ask: query,
        oncreate: (pengine) => {
          console.log(`Pengine created for query: ${query}`);
        },
        onsuccess: (success) => {
          console.log(`Query success: ${query}`);
          resolve(success.data);
        },
        onfailure: (failure) => {
          console.log(`Query failure: ${query}`, failure);
          resolve(failure);
        },
        onerror: (error) => {
          console.log(`Query error: ${query}`, error);
          reject(error);
        },
        ondestroy: () => {
          console.log(`Pengine destroyed for query: ${query}`);
        },
      });
    });
  }
}

module.exports = PromisifiedPengine;