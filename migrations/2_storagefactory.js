const StorageFactory = artifacts.require('StorageFactory');
const Storage = artifacts.require('Storage');

module.exports = async function(deployer) {
    await deployer.deploy(Storage);
    const storage = await Storage.deployed();
    await deployer.deploy(StorageFactory, storage.address);
}