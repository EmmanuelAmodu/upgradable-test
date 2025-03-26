// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../contracts/TestUpgradable.sol";
import "../contracts/TestUpgradableProxy.sol";

contract DeployTestUpgradable is Script {
    function run() external {
        // Ensure a valid deployer address
        address deployerAddress = msg.sender;
        require(deployerAddress != address(0), "Invalid deployer address");

        vm.startBroadcast();

        try new TestUpgradable() returns (TestUpgradable implementation) {
            console.log("TestUpgradable implementation deployed at:", address(implementation));

            // Encode initialization with initial value and owner
            bytes memory initData = abi.encodeWithSignature(
                "initialize(uint256,address)", 
                uint256(42),    // Initial value
                deployerAddress // Owner address
            );

            try new TestUpgradableProxy(address(implementation), initData) returns (TestUpgradableProxy proxy) {
                console.log("TestUpgradable proxy deployed at:", address(proxy));
                
                // Optional: Verify initialization by calling getValue
                (bool success, bytes memory result) = address(proxy).call(
                    abi.encodeWithSignature("getValue()")
                );
                
                if (success) {
                    uint256 initialValue = abi.decode(result, (uint256));
                    console.log("Initial value set:", initialValue);
                }
            } catch Error(string memory reason) {
                console.log("Proxy deployment failed:", reason);
                revert(reason);
            }
        } catch Error(string memory reason) {
            console.log("Implementation deployment failed:", reason);
            revert(reason);
        }

        vm.stopBroadcast();
    }
}
