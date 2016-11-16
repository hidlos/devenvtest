var DevEnvTest = require("./DevEnvTest");
var expect = require('expect.js');

describe('DevEnvTest', function () {

    var devEnvTest;

    beforeEach(function () {
        devEnvTest = new DevEnvTest();
    });

    describe('when asked to run tests', function () {
        it('should execute tests', function () {
            expect(devEnvTest.doSomething).to.be.defined;
        });
    });
});