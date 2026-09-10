// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {Telephone} from "../src/lv4-original.sol";
import {Attacker} from "../src/lv4-attacker.sol";

contract SimulationTest is Test {
    Telephone public telephone;
    Attacker public attacker;

    function setUp() public {
        vm.roll(100);
        telephone = new Telephone();
        attacker = new Attacker();
    }

    function test_telephone() public {
        //this is likely crash because tx.origin= address(this)
        console.log("Owner before attack: %s", telephone.owner());
        assertEq(telephone.owner(), address(this));
        attacker.attack(address(telephone));
        console.log("Owner changed to: %s", telephone.owner());
        assertEq(telephone.owner(), tx.origin);
    }
}
