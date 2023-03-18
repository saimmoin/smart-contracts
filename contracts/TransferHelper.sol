//SPDX-License-Identifier: MIT
pragma solidity  0.8.17;

interface IERC20 {
    function transfer(address payable _to) external;
}

contract TransferHelper {

    function transfer(address payable _to) external payable {
        (bool sent, ) = _to.call{value: getBalance()}("");
        require(sent, "Cannot send ether");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function send(address _token, address payable _receiver) external {
        IERC20(_token).transfer(_receiver);
    }

}