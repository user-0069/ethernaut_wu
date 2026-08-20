// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {CoinFlip} from "../src/lv3-original.sol";
import {Attacker} from "../src/lv3-attacker.sol";

contract SimulationTest is Test {
    CoinFlip public coinFlip;
    Attacker public attacker;

    function setUp() public {
        vm.roll(100);
        coinFlip = new CoinFlip();
        attacker = new Attacker();
    }

    function test_Flip() public {
        for (uint256 i = 0; i < 10; i++) {
            attacker.attack(address(coinFlip));
            vm.roll(block.number + 1);
        }
        assertEq(coinFlip.consecutiveWins(), 10);
    }
}
