// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

/**
 * @title TestUpgradableProxy
 * @dev A simple proxy contract for TestUpgradable.
 */
contract TestUpgradableProxy is ERC1967Proxy {
    /**
     * @notice Deploys the proxy.
     * @param _logic The address of the TestUpgradable implementation contract.
     * @param _data The encoded initializer call.
     */
    constructor(address _logic, bytes memory _data) ERC1967Proxy(_logic, _data) {}
}
