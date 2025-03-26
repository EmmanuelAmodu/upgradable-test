// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

/**
 * @title TestUpgradableProxy
 * @dev Enhanced proxy contract with additional safety checks
 */
contract TestUpgradableProxy is ERC1967Proxy {
    /**
     * @notice Deploys the proxy with implementation and initialization data
     * @param _logic Address of the implementation contract
     * @param _data Encoded initialization call data
     */
    constructor(address _logic, bytes memory _data) ERC1967Proxy(_logic, _data) {
        // Additional validation
        require(_logic != address(0), "Invalid implementation address");
        require(_data.length > 0, "Initialization data cannot be empty");
    }
}
