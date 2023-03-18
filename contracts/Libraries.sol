//SPDX-License-Identifier: MIT
pragma solidity  0.8.17;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Libraries is Ownable {
    uint public number = 0;
    function set(uint _number) external onlyOwner {
        number = _number;
    }
} 
