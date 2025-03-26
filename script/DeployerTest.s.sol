// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../contracts/TestUpgradable.sol";
import "../contracts/TestUpgradableProxy.sol";

contract DeployTestUpgradable is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy the implementation contract.
        TestUpgradable implementation = new TestUpgradable();
        console.log("TestUpgradable implementation deployed at:", address(implementation));

        // Encode the initializer call with both parameters: initial value and owner.
        bytes memory initData = abi.encodeWithSignature("initialize(uint256,address)", uint256(42), msg.sender);

        // Deploy the proxy, passing the implementation address and initializer data.
        TestUpgradableProxy proxy = new TestUpgradableProxy(address(implementation), initData);
        console.log("TestUpgradable proxy deployed at:", address(proxy));

        vm.stopBroadcast();
    }
}
