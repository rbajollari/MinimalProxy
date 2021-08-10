// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

/// @title Example of Storage contract implementation to be cloned
/// @dev This contract is meant to be deployed once and then cloned with a minimal proxy contract for clones to point to and be able to use the logic in this contract with their own storage through delegate call
contract Storage is Initializable {
    string public data;
    string public initializationData;

    /// @notice Initialize clone of this contract with string and set data variable to a string literal
    /// @dev This function is used in place of a constructor in proxy contracts
    /// @param _initializationData Data to initialize clone with
    function initialize(string calldata _initializationData) external initializer {
        initializationData = _initializationData;
        data = 'Not set by setData function yet';
    }

    /// @notice Sets the data variable in the contract
    /// @param _data value for data to be set to 
    function setData (string calldata _data) external {
        data = _data;
    }
}