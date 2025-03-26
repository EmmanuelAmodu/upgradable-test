// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/**
 * @title TestUpgradable
 * @dev An example of an upgradeable contract using UUPS.
 */
contract TestUpgradable is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    // A simple state variable.
    uint256 public value;

    /**
     * @notice Initializer function instead of a constructor.
     * @param _initialValue The initial value to store.
     * @param initialowner The owner address.
     */
    function initialize(uint256 _initialValue, address initialowner) public initializer {
        __UUPSUpgradeable_init();
        __Ownable_init(initialowner);
        value = _initialValue;
    }

    /**
     * @notice Sets a new value.
     * Only the owner can call this function.
     * @param _value The new value.
     */
    function setValue(uint256 _value) public onlyOwner {
        value = _value;
    }

    /**
     * @notice Authorization function required by UUPS upgradeable pattern.
     * @param newImplementation The address of the new implementation.
     */
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
