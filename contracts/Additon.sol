//SPDX-License-Identifier: MIT
pragma solidity  0.8.17;

// import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Addition {
    using SafeMath for uint;
    uint public num = 0;

    function addOne() external {
       num = num.add(1);
    }
}