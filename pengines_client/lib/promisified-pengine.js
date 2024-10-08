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
          if (this.defaultOptions.verbose) {
            console.log(`Pengine created for query: ${query}`);
          }
        },
        onsuccess: (success) => {
          if (this.defaultOptions.verbose) {
            console.log(`Query success: ${query}`);
          }
          resolve(success.data);
        },
        onfailure: (failure) => {
          if (this.defaultOptions.verbose) {
            console.log(`Query failure: ${query}`, failure);
          }
          resolve(failure.event);
        },
        onerror: (error) => {
          if (this.defaultOptions.verbose) {
            console.log(`Query error: ${query}`, error);
          }
          reject(error);
        },
        ondestroy: () => {
          if (this.defaultOptions.verbose) {
            console.log(`Pengine destroyed for query: ${query}`);
          }
        },
      });
    });
  }
}

module.exports = PromisifiedPengine;