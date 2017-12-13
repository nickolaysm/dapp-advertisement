var SimpleStorage = artifacts.require("./SimpleStorage.sol");

contract('SimpleStorage', function(accounts) {

    it("...test set value throw constructor.", async () => {

        var storage = await SimpleStorage.new("str value");
        var str = await storage.getStr();
        assert.equal(str, "str value", "The str value was not stored.");

    });

});
