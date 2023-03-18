//SPDX-License-Identifier: MIT
pragma solidity  0.8.17;

contract Transfer {

    function send(address payable _to) public payable {
        (bool sent,) = _to.call{value: getBalance()}("");
        require(sent, "Cannot send ether.");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    receive() external payable {}

}