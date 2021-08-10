// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Storage.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

/// @title Factory for creating storage contract clones
/// @notice This contract will create a storage clone and map its address to clone creator 
/// @dev Cloning is done with OpenZeppelin's Clones contract and clones are initialized by an intitializer function instead of a constructor upon creation
contract StorageFactory {
    event StorageCloneCreated(
        address _storageCloneAddress,
        uint creationTime
    );

    mapping (address => address) public StorageCloneAddresses;
    address public implementationAddress;

    /// @param _implementationAddress Address of implementation storage contract to be cloned
    constructor(address _implementationAddress) {
        implementationAddress = _implementationAddress;
    }

    /// @notice Create clone of storage contract and initialize it with some data
    /// @dev Clone method returns address of created clone and maps with caller of createStorage function
    /// @param _initializationData Data to initialize clone with
    function createStorage(string calldata _initializationData) external {
        address storageCloneAddress = Clones.clone(implementationAddress);
        Storage(storageCloneAddress).initialize(_initializationData);
        StorageCloneAddresses[msg.sender] = storageCloneAddress;
        emit StorageCloneCreated(storageCloneAddress, block.timestamp);
    }
}