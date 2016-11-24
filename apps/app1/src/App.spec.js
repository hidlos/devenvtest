var App = require("./App");
var expect = require('expect.js');

describe('App', function () {

    var app;

    beforeEach(function () {
        app = new App();
    });

    describe('application', function () {
        it('should have start function', function () {
            expect(app.start).to.be.function;
        });
    });
});