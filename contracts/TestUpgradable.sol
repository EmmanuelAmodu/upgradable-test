// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/**
 * @title TestUpgradable
 * @dev An improved upgradeable contract using UUPS pattern
 */
contract TestUpgradable is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    // A simple state variable
    uint256 public value;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /**
     * @notice Initializer function instead of a constructor
     * @param _initialValue The initial value to store
     * @param initialOwner The owner address
     */
    function initialize(uint256 _initialValue, address initialOwner) 
        public 
        initializer 
    {
        // Ensure all parent initializers are called
        __UUPSUpgradeable_init();
        __Ownable_init(initialOwner);
        
        // Add validation
        require(initialOwner != address(0), "Invalid owner address");
        require(_initialValue > 0, "Initial value must be positive");
        
        value = _initialValue;
    }

    /**
     * @notice Sets a new value
     * @param _value The new value to set
     */
    function setValue(uint256 _value) public onlyOwner {
        require(_value > 0, "Value must be positive");
        value = _value;
    }

    /**
     * @notice Authorization function for upgrades
     * @param newImplementation Address of the new implementation
     */
    function _authorizeUpgrade(address newImplementation) 
        internal 
        override 
        onlyOwner 
    {
        // Additional upgrade authorization logic can be added here
        require(newImplementation != address(0), "Invalid implementation address");
    }

    /**
     * @notice Retrieve the current value
     * @return The current stored value
     */
    function getValue() public view returns (uint256) {
        return value;
    }
}
