const StorageFactory = artifacts.require("StorageFactory");
const Storage = artifacts.require("Storage");

contract("StorageFactory", async accounts => {
    var storage;
    var storageFactory;
    var data;
    var storageClone;
    var storageCloneAddress;

    before(async () => {
        storage = await Storage.deployed();
        storageFactory = await StorageFactory.deployed();
        await storageFactory.createStorage('Some initialization data', { from: accounts[0]});
        storageCloneAddress = await storageFactory.StorageCloneAddresses(accounts[0], { from: accounts[0]});
        storageClone = await Storage.at(storageCloneAddress);
    });

    it("Data in storage implementation before setData on clone is called is empty", async () => {
        data = await storage.data({ from: accounts[0]});
        assert.equal(data, '');
    });

    it("Initialization data of storage implementation is empty", async () => {
        data = await storage.initializationData({ from: accounts[0]});
        assert.equal(data, '');
    });

    it("Data in storage clone before setData is called is set in initialization function", async () => {
        data = await storageClone.data({ from: accounts[0]});
        assert.equal(data, 'Not set by setData function yet');
    });

    it("Initialization data of storage clone is string passed in creation", async () => {
        data = await storageClone.initializationData({ from: accounts[0]});
        assert.equal(data, 'Some initialization data');
    });

    it("setData called on clone doesn't change data in implementation", async () => {
        await storageClone.setData('Set by setData function', { from: accounts[0]});
        data = await storage.data({ from: accounts[0]});
        assert.equal(data, '');
    });

    it("setData called on clone had correctly set the data in the clone", async () => {
        data = await storageClone.data({ from: accounts[0]});
        assert.equal(data, 'Set by setData function');
    });
});